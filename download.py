#!/usr/bin/env python3

import urllib.request
import os
from itertools import chain
from urllib.parse import urlencode
import json

base_url = "http://laserkutter.lab.fablab-nea.de"
file_path = os.path.dirname(__file__)
sd_card_directory = os.path.join(file_path, "sdcard")


def to_local_path(remote_path):
    RRF_PATH_SEPARATOR = '/'
    if remote_path.startswith(RRF_PATH_SEPARATOR):
        remote_path = remote_path[1:]
    return os.path.join(sd_card_directory,
                        *remote_path.split(RRF_PATH_SEPARATOR))


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


download_files_recursively()
