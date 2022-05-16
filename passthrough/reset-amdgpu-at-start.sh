#!/bin/bash

ps -ef | grep Xorg | grep -o "vt[0-9]" | grep -o "[0-9]" >> /tmp/macos
echo "device_specific" | sudo tee /sys/bus/pci/devices/0000:03:00.0/reset_method && \
echo "0000:03:00.0" | sudo tee /sys/bus/pci/drivers/amdgpu/unbind && \
sudo killall Xorg
sudo killall openbox

sudo -u max lsof | grep amdgpu | grep -v reset-amdgpu.sh | awk '{print $2}' | uniq | xargs sudo kill -9
sleep 1
sudo modprobe -r amdgpu
