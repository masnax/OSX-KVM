#!/bin/bash

echo "0000:03:00.0" | sudo tee /sys/bus/pci/drivers/amdgpu/unbind
echo "0000:03:00.1" | sudo tee /sys/bus/pci/drivers/snd_hda_intel/unbind
sudo modprobe -r vfio_pci
sudo modprobe vfio-pci disable_vga=1

echo "1002 aaf8" | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id
echo "1002 6863" | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id

echo "device_specific" | sudo tee /sys/bus/pci/devices/0000:03:00.0/reset_method
