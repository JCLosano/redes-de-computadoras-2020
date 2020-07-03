#!/bin/bash
# Usage: Setup TPI Part 2
# Author: Tomas
# -------------------------------------------------
 
#Create networknamespaces
ip netns add h1
sleep 0.1
ip netns add h2
sleep 0.1
ip netns add h3
sleep 0.1
ip netns add dhcp-server
sleep 0.1
ip netns add r1
sleep 0.1
ip link add name veth1 type veth peer name vpeer1
sleep 0.1
ip link add name veth2 type veth peer name vpeer2
sleep 0.1
ip link add name veth3 type veth peer name vpeer3
sleep 0.1
ip link add name veth-dhcp type veth peer name vpeer-dhcp
sleep 0.1
ip link add name veth-router type veth peer name vpeer-router
sleep 0.1
brctl addbr sw1
sleep 0.1

# Set peer link up
ip link set veth1 up
sleep 0.1
ip link set veth2 up
sleep 0.1
ip link set veth3 up
sleep 0.1
ip link set veth-dhcp up
sleep 0.1
ip link set veth-router up
sleep 0.1
ip link set sw1 up
sleep 0.1

# Assign interfaces to namespaces 
ip link set dev vpeer1 netns h1
sleep 0.1
ip link set dev vpeer2 netns h2
sleep 0.1
ip link set dev vpeer3 netns h3
sleep 0.1
ip link set dev vpeer-dhcp netns dhcp-server
sleep 0.1
ip link set dev vpeer-router netns r1
sleep 0.1
ip link set dev veth3 netns r1
sleep 0.1

# Connect veth to bridge
brctl addif sw1 veth1
sleep 0.1
brctl addif sw1 veth2
sleep 0.1
brctl addif sw1 veth-router
sleep 0.1
brctl addif sw1 veth-dhcp #agrego el server al switch
sleep 0.1

#IPv4 forwarding
ip netns exec r1 sysctl -w net.ipv4.ip_forward=1
sleep 0.1

#Assign IPs
ip netns exec r1 ip addr add 192.168.2.12/24 dev vpeer-router
sleep 0.1
ip netns exec r1 ip addr add 192.168.1.11/24 dev veth3
sleep 0.1
ip netns exec h3 ip addr add 192.168.1.10/24 dev vpeer3
sleep 0.1
ip netns exec dhcp-server ip addr add 192.168.2.1/24 dev vpeer-dhcp
sleep 0.1

#Set up interfaces
ip netns exec h1 ip link set lo up
sleep 0.1
ip netns exec h2 ip link set lo up
sleep 0.1
ip netns exec h3 ip link set lo up
sleep 0.1
ip netns exec r1 ip link set lo up
sleep 0.1
ip netns exec dhcp-server ip link set lo up
sleep 0.1
ip netns exec h1 ip link set vpeer1 up
sleep 0.1
ip netns exec h2 ip link set vpeer2 up
sleep 0.1
ip netns exec h3 ip link set vpeer3 up
sleep 0.1
ip netns exec dhcp-server ip link set vpeer-dhcp up
sleep 0.1
ip netns exec r1 ip link set veth3 up
sleep 0.1
ip netns exec r1 ip link set vpeer-router up
sleep 0.1

printf "\nNetworknamespaces:\n"
#Print netnss
ip netns list

printf "\nradvd running..."

# Init router advertisement daemon
ip netns exec r1 radvd -n
