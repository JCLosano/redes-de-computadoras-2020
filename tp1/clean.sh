#!/bin/bash
# Usage: Delete TPI Part 2
# Author: Tomas
# -------------------------------------------------

ip netns delete h1 
ip netns delete h2 
ip netns delete h3
ip netns delete dhcp-server
ip netns delete r1
ip link delete veth-router
ip link delete veth-dhcp
ip link delete veth1
ip link delete veth2
ip link delete veth3
ip link set sw1 down
brctl delbr sw1
