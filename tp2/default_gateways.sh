#sudo docker exec -ti --privileged %HOST% route add default gw %IP%

docker exec -ti --privileged ospf_h1_1 route add default gw 10.0.2.11
sleep 1
docker exec -ti --privileged ospf_h2_1 route add default gw 10.0.2.11
sleep 1
docker exec -ti --privileged ospf_h3_1 route add default gw 10.0.2.11
sleep 1
docker exec -ti --privileged ospf_h4_1 route add default gw 10.0.4.11
sleep 1
docker exec -ti --privileged ospf_h5_1 route add default gw 10.0.5.11
