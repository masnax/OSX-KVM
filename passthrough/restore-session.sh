#!/bin/bash

sleep 1

sudo modprobe -r vfio_pci vfio_iommu_type1 vfio && \
echo 1 | sudo tee /sys/bus/pci/devices/0000:03:00.0/remove && \
echo 1 | sudo tee /sys/bus/pci/rescan && \

console_num=$(cat /tmp/macos)
#sudo openvt --console=$console_num -f  startx -- :0
sudo openvt --console=1 -f  startx -- :0
#for i in `seq 1 5` ; do
#	sudo openvt --console=$console_num -f  startx -- :0
#	DISPLAY=:0 xset q &>/dev/null && {
#		sudo systemctl restart vncserver@:1.service
#		echo "Successfully restored X session for vt$console_num"
#			break
#		} || echo "Failed to restore X session for vt$console_num"
#	sleep 1
#done

rm -rf /tmp/macos
