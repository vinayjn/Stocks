import os
import sys

SRCROOT = sys.argv[1]
BUILD_APP_DIR = sys.argv[2]

with open(SRCROOT + "/MyStocks/SupportFiles/config.plist", "r") as f:
    data = f.read()
    data = data.format(**{
        "STOCKS_API_BASE_URL": os.environ.get("STOCKS_API_BASE_URL"),
        "STOCKS_API_KEY": os.environ.get("STOCKS_API_KEY")
    })
    f.close()
if data:
    config_path = BUILD_APP_DIR + "config.plist"
    with open(config_path, "w+") as f:
        f.write(data)
        f.close()
