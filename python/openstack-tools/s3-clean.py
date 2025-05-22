#!/usr/bin/python

import boto
import boto.s3.connection
import time
import datetime
import threading
import sys

access_key = 'LQPD0N6ALXEUH8GEKDI0'
secret_key = 'bqD4BdbCPNpPsBNFUC4MIR4bzTa8CBwVwgkhHOPL'
conn = boto.connect_s3(
    aws_access_key_id = access_key,
    aws_secret_access_key = secret_key,
    host = 's3.fzyun.cn', port = 80,
    is_secure=False, calling_format = boto.s3.connection.OrdinaryCallingFormat(),
    )

clean_list = []
clean_lock = threading.Lock()
clean_add = 0
clean_del = 0

class Collector(threading.Thread):

    def __init__(self, name):
        threading.Thread.__init__(self)
        self.name = name

    def run(self):
        global clean_list, clean_add

        while True:
            print "Trying to open bucket %s..." % self.name
            try:
                bucket = conn.get_bucket(self.name)
                print "Bucket %s is opened." % self.name

                for key in bucket.list():
                    clean_list.append(key)
                    clean_add += 1
                    while len(clean_list) > 30000:
                        time.sleep(0.1)

                print "Delete bucket %s..." % self.name
                bucket.delete()

            except:
                time.sleep(15)


class Cleaner(threading.Thread):

    def run(self):
        global clean_list, clean_lock, clean_del

        while True:
            key = None

            try:
                clean_lock.acquire()
                key = clean_list.pop(0)
            except:
                time.sleep(0.1)
            finally:
                clean_lock.release()

            if key != None:
                try:
                    key.delete()
                    clean_del += 1
                except:
                    time.sleep(0.1)


class Reporter(threading.Thread):

    def run(self):
        global clean_list, clean_add, clean_del
        while True:
            print "{remained} remained, {added} added, {deled} deled.".format(remained = len(clean_list), added = clean_add, deled = clean_del)
            time.sleep(1)


reporter = Reporter()
reporter.start()

for i in range(500):
    cleaner = Cleaner()
    cleaner.start()

name = sys.argv[1]
collector = Collector(name)
collector.start()

reporter.join()

