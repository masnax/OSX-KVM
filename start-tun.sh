#!/bin/bash
sudo ip tuntap add dev tap0 mode tap
sudo ip link set tap0 up promisc on
sudo brctl addif virbr1 tap0

sudo ip link set dev virbr1 up  # as needed
sudo ip link set dev tap0 master virbr1

