#!/bin/bash
# Helpful to read output when debugging
set -x

long_delay=10
medium_delay=5
short_delay=1
echo "Beginning of startup!"

#if test -e "/tmp/macos" ; then
#	rm -f /tmp/macos
#fi
#
#ps -ef | grep Xorg | grep -o "vt[0-9]" | grep -o "[0-9]" >> /tmp/macos
#
#DISPLAY=:0 openbox --exit
#sudo killall Xorg
#sudo killall openbox

# Unbind VTconsoles if currently bound (adapted from https://www.kernel.org/doc/Documentation/fb/fbcon.txt)
if test -e "/tmp/vfio-bound-consoles" ; then
    rm -f /tmp/vfio-bound-consoles
fi
for (( i = 0; i < 16; i++))
do
  if test -x /sys/class/vtconsole/vtcon${i}; then
      if [ `cat /sys/class/vtconsole/vtcon${i}/name | grep -c "frame buffer"` \
           = 1 ]; then
	       echo 0 > /sys/class/vtconsole/vtcon${i}/bind
           echo "Unbinding console ${i}"
           echo $i >> /tmp/vfio-bound-consoles
      fi
  fi
done

# Unbind EFI-Framebuffer
if test -e "/tmp/vfio-is-nvidia" ; then
    rm -f /tmp/vfio-is-nvidia
    echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
fi


echo "End of startup!"
