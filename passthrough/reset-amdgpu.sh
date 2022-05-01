#!/bin/bash

sudo systemctl stop vncserver@:1.service
sudo -u max lsof | grep amdgpu | grep -v reset-amdgpu.sh | awk '{print $2}' | uniq | xargs sudo kill -9
#sudo modprobe -r ddcci i2c_i801 i2c_dev i2c_nct6775 amdgpu
sudo modprobe -r amdgpu
