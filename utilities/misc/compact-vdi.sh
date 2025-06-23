#!/bin/sh
#
# Reducing the size of a virtualbox dynamic vdi is a two stage process:
#   1. Fill the filesystem free space with zeroes
#   2. Compacting the VDI 
#
# References:
# https://forums.virtualbox.org/viewtopic.php?p=29272#29272
# http://bethesignal.org/blog/2011/01/05/how-to-mount-virtualbox-vdi-image/
# http://blog.vmsplice.net/2011/02/how-to-access-virtual-machine-image.html
#

# Exit on errors
set -e

# Global variables
NBD_DEVICE=/dev/nbd0

# Check for number of arguments
if [ $# -ne 1 ]; then
  echo "Usage: `basename $0` vdi-absolute-path"
  exit 2
fi

echo "Loading nbd module ..."
sudo modprobe -v -r nbd
sudo modprobe -v nbd max_part=16
echo

echo "Connecting $1 to $NBD_DEVICE ..."
sudo qemu-nbd -c $NBD_DEVICE "$1"
echo

for partition_info in `sudo parted -m $NBD_DEVICE print | grep ext`; do
  echo "zerofree $partition_info ..."
  partition_number=`echo $partition_info | cut -d ':' -f 1`
  sudo zerofree -v "${NBD_DEVICE}p${partition_number}"
done
echo

echo "Disconnecting $NBD_DEVICE ..."
sudo qemu-nbd -v -d $NBD_DEVICE
echo

echo "Compacting the VDI ..."
VBoxManage modifyhd "$1" --compact
echo

echo "VDI $1 successfully compacted."

