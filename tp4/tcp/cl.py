#  Streaming Client

import socket
import time

HOST = 'localhost'
PORT = 50007
#WINDOW = 10485760
WINDOW = 4096
TIME = 0.1

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST, PORT))

file = open("recv.iso","wb")    #abre recv.iso, write, binary    
print 'Guardando en recv.iso\n' 

data = s.recv(WINDOW)

while data:
    file.write(data)
    data = s.recv(WINDOW)
    time.sleep(TIME)

file.close()
print 'Img recibida\n'

s.close()
