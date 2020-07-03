from socket import *

host_port =("127.0.0.1",9999)

s=socket(AF_INET,SOCK_DGRAM,0)
s.bind(host_port)

while(True):

	data,addr=s.recvfrom(1024)
	print("[+]Got connection from ",addr)

	print(data.decode('ascii'))
        
	msg="hi this msg from the server"
	s.sendto(msg.encode('ascii'),addr)

        f = open('./pkg.pdf','rb')
        l = f.read(1024)
        while(l):
            s.sendto(l,addr)
            l = f.read(1024)

        print "over!"
	break

s.close()
