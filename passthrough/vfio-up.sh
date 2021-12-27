#!/bin/bash


systemctl stop display-manager.service
echo 0 | tee /sys/class/vtconsole/vtcon0/bind
#echo 0 | tee /sys/bus/platform/drivers/efi-framebuffer/unbind

virsh --connect qemu:///system nodedev-detach pci_0000_03_00_1 && \
virsh --connect qemu:///system nodedev-detach pci_0000_03_00_0 && \
virsh --connect qemu:///system nodedev-detach pci_0000_02_00_0 && \
virsh --connect qemu:///system nodedev-detach pci_0000_01_00_0 && \
modprobe -r amdgpu && \
modprobe -r wl && \
modprobe -r brcmfmac && \
modprobe vfio-pci && \
#echo "0000:03:00.0" | sudo tee /sys/bus/pci/devices/0000:03:00.0/driver/unbind && \
#echo "vfio-pci" | sudo tee /sys/bus/pci/devices/0000:03:00.0/driver_override && \
#echo "0000:03:00.1" | sudo tee /sys/bus/pci/devices/0000:03:00.1/driver/unbind && \
#echo "vfio-pci" | sudo tee /sys/bus/pci/devices/0000:03:00.1/driver_override && \
#echo "1002 6863" | sudo tee  /sys/bus/pci/drivers/vfio-pci/new_id
#echo "0000:03:00.0" | sudo tee /sys/bus/pci/drivers/vfio-pci/bind
#    #echo "1002 aaf8" | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id && \
#    #echo "0000:03:00.1" | sudo tee /sys/bus/pci/drivers/vfio-pci/bind && \
#echo 1 | tee /sys/bus/pci/devices/0000:00:01.0/remove && \
#echo 1 | tee /sys/bus/pci/rescan && \
#echo 1 | tee /sys/bus/pci/devices/0000:03:00.0/reset

#sleep 2

#modprobe vfio
#modprobe vfio_iommu_type1
#modprobe vfio_pci
#modprobe vfio_virqfd

#sleep 2
#
