import requests
import sys

print(sys.argv[1])

url = ''

paramJson = {
    "msgtype": "text",
    "text": {
        "content": sys.argv[1]
    }
}

r = requests.post(url, json=paramJson)
print(r)

