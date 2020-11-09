import requests
import sys

print(sys.argv[1])

url = 'https://oapi.dingtalk.com/robot/send?access_token=3da79d2b38772b0c97b0a7e62522ec5b0316eef9073361917e79bcb41d361b04'

paramJson = {
    "msgtype": "text",
    "text": {
        "content": sys.argv[1]
    }
}

r = requests.post(url, json=paramJson)
print(r)

