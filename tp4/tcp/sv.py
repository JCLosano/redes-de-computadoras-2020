# Streaming Server

import socket
import time
from random import randint

HOST = 'localhost'
PORT = 50007
SEND = 4096
 
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(1)

print 'Server initialized, awaiting connection...\n'

while True:
    conn, addr = s.accept()
    print 'Client connection accepted ', addr

    file = open("img.iso","rb")

    data = file.read(SEND)
    while data:
        try:
            conn.send(data)    
            data = file.read(SEND)
        except socket.error, msg:
            print 'Client connection closed', addr
            break
    print 'Data sent.\n'        
#    conn.close()
#    break


