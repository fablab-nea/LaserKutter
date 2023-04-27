#!/usr/bin/env python3

import urllib.request
import os
from itertools import chain
from urllib.parse import urlencode

base_url = "http://laserkutter.lab.fablab-nea.de"

for directory, _, files in chain.from_iterable(
    os.walk(dir)
    for dir in (
        "sys",
        "macros",
    )
):
    try:
        os.mkdir(directory)
    except FileExistsError:
        pass
    for file in files:
        path = os.path.join(directory, file)
        urllib.request.urlretrieve(
            f"{base_url}/rr_download?" + urlencode({'name': f"0:/{path}"}),
            filename=path
        )
