import requests
from bs4 import BeautifulSoup

import unidecode
import json
import os
import subprocess
from subprocess import STDOUT

base_dir = os.path.dirname(os.path.realpath(__file__))
store_json_path = os.path.join(base_dir, "beta.json")

if os.path.isfile(store_json_path):
    file = open(store_json_path, "r")
    store = json.load(file)
else:
    store = [] #[[url, name, hash], ...]

base_url = "https://www.mylittlekaraoke.com/store/beta/"
page = requests.get(base_url + "releases.html")
soup = BeautifulSoup(page.text, 'html.parser')

for a in soup.find_all("a"):
    url = base_url + a["href"]
    already_loaded = False
    for entry in store:
        if entry[0] == url:
            already_loaded = True
            break
    if already_loaded:
        continue
    print("------------\n\n\n\n\n")
    name = a.find("span", attrs={"class": "title"}).find("strong").text
    print(url)
    name = unidecode.unidecode(name)
    name = name.replace("\"", "_").replace("(", " ").replace(")", " ").replace(" ", "_").replace("|", "_").replace("'", "_").replace("!", "_").replace("&", "_").replace(",", "_").replace("?", "_")
    print(name)
    nix_command = "((import <nixpkgs> {}).callPackage ./fetchmlk.nix {}) { url = \""+url+"\"; sha256 = \"\"; name=\""+name+"\"; }"
    print(nix_command)
    output = subprocess.run(["nix-build", "--expr", nix_command], capture_output=True)
    target_hash = output.stderr.split(b"got")[-1].split(b"\n")[0].split(b":")[-1].decode().strip()
    print("\n")
    print(output.stderr)
    print("\n")
    print(target_hash)
    if "AAAAAAAAAAAAAAAAAAAAAAAAAA" in target_hash:
        raise
    store.append([url, name, target_hash])
    f = open(store_json_path, "w")
    json.dump(store, f, indent="\t")
    f.close()
