#  Streaming Client

import socket
import time

HOST = 'localhost'
PORT = 50007

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST, PORT))

while True:
    data = s.recv(1024)
    time.sleep(0.5)
    print data

s.close()
