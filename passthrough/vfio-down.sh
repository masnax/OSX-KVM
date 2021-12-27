#!/bin/bash


#echo "efi-framebuffer.0" | tee /sys/bus/platform/drivers/efi-framebuffer/bind
echo 1 | tee /sys/class/vtconsole/vtcon0/bind && \
modprobe amdgpu && \
modprobe -r vfio-pci && \
echo 1 | tee /sys/bus/pci/devices/0000:00:01.0/remove && \
echo 1 | tee /sys/bus/pci/rescan && \
systemctl restart display-manager.service
