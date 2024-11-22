from mitmproxy import http
import json
import random
import string
import time
import os

proxybase = "https://proxyconnection.touch.dofus.com"
apibase = os.getenv("API_URL")

installFile = "build/arcanum.js"

manifest = f"{proxybase}/manifest.json"
build = f"{proxybase}/build/script.js"
install = f"{proxybase}/{installFile}"


# Cache busting to avoid any issues related to JSON manipulation
def request(flow: http.HTTPFlow) -> None:
    if "if-none-match" in flow.request.headers:
        del flow.request.headers["if-none-match"]
    if "if-modified-since" in flow.request.headers:
        del flow.request.headers["if-modified-since"]


def response(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_url == manifest:
        onManifest(flow)
    elif flow.request.pretty_url == build:
        onBuild(flow)
    elif flow.request.pretty_url == install:
        onInstall(flow)


# On manifest : add a new "installation" file
def onManifest(flow: http.HTTPFlow) -> None:
    try:
        data = flow.response.json()
        data["files"][installFile] = {
            "filename": installFile,
            "version": "".join(
                random.choices(string.ascii_letters + string.digits, k=8)
            ),
        }
        flow.response.text = json.dumps(data)
    except Exception as e:
        flow.response = http.Response.make(200, str(e), {"Content-Type": "text/plain"})

# TODO On build : add the webpack unbundler, and other things if needed
def onBuild(flow: http.HTTPFlow) -> None:
    try:
        flow.response = http.Response.make(
            200, "Build install redirected", {"Content-Type": "text/plain"}
        )
    except Exception as e:
        flow.response = http.Response.make(200, str(e), {"Content-Type": "text/plain"})

# TODO On "installation" file : download the file from the API and return it
def onInstall(flow: http.HTTPFlow) -> None:
    try:
        flow.response = http.Response.make(
            200, "Mirage install working properly", {"Content-Type": "text/plain"}
        )
    except Exception as e:
        flow.response = http.Response.make(200, str(e), {"Content-Type": "text/plain"})
