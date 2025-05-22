import boto
import boto.s3.connection
import time
import datetime
import threading
import sys

access_key = 'RX5C4FUP58YT2U2Y9Q8I'
secret_key = 'HqtqTAFAHFOOSRFYobEKDVJ1oUIOTrDna8vvhrAd'
conn = boto.connect_s3(
    aws_access_key_id = access_key,
    aws_secret_access_key = secret_key,
    host = '10.10.21.81', port = 80,
    is_secure=False, calling_format = boto.s3.connection.OrdinaryCallingFormat(),
    )
# conn.create_bucket('testbucket-2')
rs = conn.get_all_buckets()

for b in rs:
 print (b.name)