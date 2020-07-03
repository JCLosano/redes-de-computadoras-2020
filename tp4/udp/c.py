from socket import *

host_port=("127.0.0.1",9999)

s=socket(AF_INET,SOCK_DGRAM,0)

msg="hi there from the client"
s.sendto(msg.encode('ascii'),host_port)

data,addr=s.recvfrom(1024)

print(data.decode('ascii'))

f = open('rcv.pdf','wb')
data,addr = s.recvfrom(1024)
while(data):
    f.write(data)
    data,addr = s.recvfrom(1024)
print "Received"
s.close()
