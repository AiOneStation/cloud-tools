import time
import requests
from oslo_serialization import base64 as base64utils
from oslo_serialization import jsonutils

config_url = "http://10.10.21.98:8500/v1/kv/cloud-config"
req = requests.get(config_url, timeout=8)
if req.status_code == 200:
        #print(req.json().decode('UTF-8'))
        content = req.json()
        if len(content) > 0:
          json_str = jsonutils.dumps(content[0])
          json_data = jsonutils.loads(json_str)
          value = (json_data['Value'])
          user_data = base64utils.decode_as_bytes(value)
          print(user_data)