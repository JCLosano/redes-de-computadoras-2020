# Install utils 
apt install bridge-utils radvd

# Create config files
tee -a /etc/radvd.conf <<EOF
interface vpeer-router { 
        AdvSendAdvert on;
        MinRtrAdvInterval 3; 
        MaxRtrAdvInterval 10;
        prefix 2001::/64 { 
                AdvOnLink on; 
                AdvAutonomous on; 
                AdvRouterAddr on; 
        };
};
interface veth3 { 
        AdvSendAdvert on;
        MinRtrAdvInterval 3; 
        MaxRtrAdvInterval 10;
        prefix 2002::/64 { 
                AdvOnLink on; 
                AdvAutonomous on; 
                AdvRouterAddr on; 
        };
};
EOF

# Create resources
ip netns add h1
ip netns add h2
ip netns add h3
ip netns add dhcp-server
ip netns add r1
ip link add name veth1 type veth peer name vpeer1
ip link add name veth2 type veth peer name vpeer2
ip link add name veth3 type veth peer name vpeer3
ip link add name veth-dhcp type veth peer name vpeer-dhcp
ip link add name veth-router type veth peer name vpeer-router
brctl addbr sw1

# Set peer link up
ip link set veth1 up
ip link set veth2 up
ip link set veth3 up
ip link set veth-dhcp up
ip link set veth-router up
ip link set sw1 up

# Assign interfaces to namespaces 
ip link set dev vpeer1 netns h1
ip link set dev vpeer2 netns h2
ip link set dev vpeer3 netns h3
ip link set dev vpeer-dhcp netns dhcp-server
ip link set dev vpeer-router netns r1
ip link set dev veth3 netns r1

# Connect veth to bridge
brctl addif sw1 veth1
brctl addif sw1 veth2
brctl addif sw1 veth-router
brctl addif sw1 veth-dhcp #agrego el server al switch

# Configure router as router
ip netns exec r1 sysctl -w net.ipv6.conf.all.forwarding=1
ip netns exec r1 sysctl -w net.ipv4.ip_forward=1

# Configure IP addresses
ip netns exec r1 ip -6 addr add 2001::113/64 dev vpeer-router
ip netns exec r1 ip -6 addr add 2002::111/64 dev veth3

#Asignacion de las IPv4
#Router
ip netns exec r1 ip addr add 192.168.2.12/24 dev vpeer-router
ip netns exec r1 ip addr add 192.168.1.11/24 dev veth3
ip netns exec h3 ip addr add 192.168.1.10/24 dev vpeer3
ip netns exec dhcp-server ip addr add 192.168.2.1/24 dev vpeer-dhcp


# Set Up interfaces
ip netns exec h1 ip link set lo up
ip netns exec h2 ip link set lo up
ip netns exec h3 ip link set lo up
ip netns exec r1 ip link set lo up
ip netns exec dhcp-server ip link set lo up

ip netns exec h1 ip link set vpeer1 up
ip netns exec h2 ip link set vpeer2 up
ip netns exec h3 ip link set vpeer3 up
ip netns exec dhcp-server ip link set vpeer-dhcp up
ip netns exec r1 ip link set veth3 up
ip netns exec r1 ip link set vpeer-router up

# Init router advertisement daemon
ip netns exec r1 radvd -n

# iniciar server
# dentro de dhcp-server

dnsmasq --dhcp-range=192.168.2.13,192.168.2.254,255.255.255.0 --interface=vpeer-dhcp --no-daemon

#Clear environment 
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
rm /etc/radvd.conf
