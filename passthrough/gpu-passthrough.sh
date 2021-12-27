#!/bin/bash


/bin/vfio-startup.sh
systemctl stop display-manager.service
echo 0 > /sys/class/vtconsole/vtcon0/bind
sleep 5

modprobe -r amdgpu
modprobe -r snd_hda_intel
modprobe -r gpu_sched
modprobe -r ttm

virsh --connect qemu:///system nodedev-detach pci_0000_03_00_0
virsh --connect qemu:///system nodedev-detach pci_0000_03_00_1
virsh --connect qemu:///system nodedev-detach pci_0000_02_00_0
virsh --connect qemu:///system nodedev-detach pci_0000_01_00_0

sleep 2

modprobe vfio
modprobe vfio_iommu_type1
modprobe vfio_pci
modprobe vfio_virqfd

sleep 2

echo "0000:03:00.0" | sudo tee /sys/bus/pci/devices/0000:03:00.0/driver/unbind
echo "vfio-pci" | sudo tee /sys/bus/pci/devices/0000:03:00.0/driver_override
echo "0000:03:00.1" | sudo tee /sys/bus/pci/devices/0000:03:00.1/driver/unbind
echo "vfio-pci" | sudo tee /sys/bus/pci/devices/0000:03:00.1/driver_override
sleep 2
echo "1002 6863" | sudo tee  /sys/bus/pci/drivers/vfio-pci/new_id
echo "0000:03:00.0" | sudo tee /sys/bus/pci/drivers/vfio-pci/bind
sleep 2
echo "1002 aaf8" | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id
echo "0000:03:00.1" | sudo tee /sys/bus/pci/drivers/vfio-pci/bind
