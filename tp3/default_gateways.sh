docker exec -ti --privileged bgp_h1_1 route del default 
sleep 0.1
docker exec -ti --privileged bgp_h1_1 route add default gw 10.0.3.11
sleep 0.1
docker exec -ti --privileged bgp_h2_1 route del default  
sleep 0.1
docker exec -ti --privileged bgp_h2_1 route add default gw 10.0.4.11
sleep 0.1
docker exec -ti --privileged bgp_h3_1 route del default  
sleep 0.1
docker exec -ti --privileged bgp_h3_1 route add default gw 10.0.5.11
sleep 0.1
docker exec -ti --privileged bgp_web_server_1 route del default 
sleep 0.1
docker exec -ti --privileged bgp_web_server_1 route add default gw 172.10.2.11
sleep 0.1
docker exec -ti --privileged bgp_mail_server_1 route del default
sleep 0.1
docker exec -ti --privileged bgp_mail_server_1 route add default gw 172.10.2.11
sleep 0.1
docker exec -ti --privileged bgp_r2_1 route del default
sleep 0.1
docker exec -ti --privileged bgp_r2_1 route add default gw 192.168.12.11
sleep 0.1
docker exec -ti --privileged bgp_r3_1 route del default
sleep 0.1
docker exec -ti --privileged bgp_r3_1 route add default gw 192.168.13.11
sleep 0.1
docker exec -ti --privileged bgp_h1_1 ip -6 route del default 
sleep 0.1
docker exec -ti --privileged bgp_h1_1 ip -6 route add default via 2003:a:b:3::11
sleep 0.1
docker exec -ti --privileged bgp_h2_1 ip -6 route del default 
sleep 0.1
docker exec -ti --privileged bgp_h2_1 ip -6 route add default via 2004:a:b:4::11
sleep 0.1
docker exec -ti --privileged bgp_r4_1 ip -6 route del default 
sleep 0.1
docker exec -ti --privileged bgp_r1_1 ip -6 route del default
sleep 0.1
docker exec -ti --privileged bgp_r2_1 ip -6 route del default
sleep 0.1
docker exec -ti --privileged bgp_r2_1 ip -6 route add default via 2001:a:b:12::11
sleep 0.1
docker exec -ti --privileged bgp_r3_1 ip -6 route del default
sleep 0.1
docker exec -ti --privileged bgp_r3_1 ip -6 route add default via 2001:a:b:13::11
sleep 0.1
docker exec -ti --privileged bgp_r5_1 ip -6 route del default
sleep 0.1
docker exec -ti --privileged bgp_h3_1 ip -6 route del default  
sleep 0.1
docker exec -ti --privileged bgp_h3_1 ip -6 route add default via 2005:a:b:5::11
sleep 0.1
docker exec -ti --privileged bgp_web_server_1 ip -6 route del default 
sleep 0.1
docker exec -ti --privileged bgp_web_server_1 ip -6 route add default via 2002:a:b:2::11
sleep 0.1
docker exec -ti --privileged bgp_mail_server_1 ip -6 route del default
sleep 0.1
docker exec -ti --privileged bgp_mail_server_1 ip -6 route add default via 2002:a:b:2::11

