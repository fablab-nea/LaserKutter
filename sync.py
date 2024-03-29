#!/usr/bin/env python3

from urllib.parse import urlencode
import binascii
import json
import os
import sys
import urllib.request

base_url = "http://laserkutter.lab.fablab-nea.de"
file_path = os.path.dirname(__file__)
sd_card_directory = os.path.join(file_path, "sdcard")


def to_local_path(remote_path):
    RRF_PATH_SEPARATOR = '/'
    if remote_path.startswith(RRF_PATH_SEPARATOR):
        remote_path = remote_path[1:]
    return os.path.join(sd_card_directory,
                        *remote_path.split(RRF_PATH_SEPARATOR))


def to_remote_path(local_path):
    RRF_PATH_SEPARATOR = '/'
    return RRF_PATH_SEPARATOR.join(local_path.split(os.sep))


def list_remote_files(drive, directory):
    query_string = urlencode({'dir': f"{drive}:/{directory}"})
    with urllib.request.urlopen(
        f"{base_url}/rr_filelist?" + query_string
    ) as req:
        return json.load(req)


def download_file(drive, path):
    if any(path.startswith(prefix) for prefix in (
        '/www/',
        '/gcodes/',
        '/firmware/',
    )):
        return

    print(path)
    try:
        query_string = urlencode({'name': f"{drive}:{path}"})
        urllib.request.urlretrieve(
            f"{base_url}/rr_download?" + query_string,
            filename=to_local_path(path)
        )
    except urllib.error.HTTPError:
        print(f"Failed to download {path}")
        raise


def download_files_recursively(drive="0", directory=""):
    try:
        os.mkdir(to_local_path(directory))
    except FileExistsError:
        pass

    file_list = list_remote_files(drive, directory)

    for file in file_list['files']:
        path = f"{directory}/{file['name']}"
        if file['type'] == 'd':
            download_files_recursively(drive, path)
        elif file['type'] == 'f':
            download_file(drive, path)


def upload_files_recursively(drive="0", directory=""):
    session_key = authenticate()
    for directory, _, files in os.walk(sd_card_directory):
        for file in files:
            rel_path = os.path.join(
                os.path.relpath(directory, sd_card_directory),
                file
            )
            print(rel_path)
            with open(
                os.path.join(directory, file),
                'rb'
            ) as f:
                data = f.read()

            crc = hex(binascii.crc32(data)).split('x')[-1]

            query_string = urlencode({
                'name': f"{drive}:/{to_remote_path(rel_path)}",
                'crc32': crc,
            })

            urllib.request.urlopen(
                urllib.request.Request(
                    f"{base_url}/rr_upload?" + query_string,
                    data=data,
                    headers={
                        'Content-Length': len(data),
                        'X-Session-Key': session_key
                    }
                )
            )


def authenticate():
    return json.load(
        urllib.request.urlopen(
            f"{base_url}/rr_connect?password=&sessionKey=yes"
        )
    )['sessionKey']


def main():
    command = sys.argv[1]
    if command == "download":
        download_files_recursively()
    elif command == "upload":
        upload_files_recursively()


if __name__ == "__main__":
    sys.exit(main())
