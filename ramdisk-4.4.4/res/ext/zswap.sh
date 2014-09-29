#!/sbin/busybox sh
#
# zswap
#

RAMSIZE=`grep MemTotal /proc/meminfo | awk '{ print \$2 }'`
# 128 is 12.5% of 1024, so ramdisk will be 12.5% of available RAM
ZSWAPSIZE=$(($RAMSIZE*128))

if [ $ZSWAPSIZE -gt 0 ]; then
echo $ZSWAPSIZE > /sys/devices/virtual/block/vnswap0/disksize
/sbin/busybox swapoff /dev/block/vnswap0 > /dev/null 2>&1
/sbin/busybox mkswap /dev/block/vnswap0 > /dev/null 2>&1
/sbin/busybox swapon -p 2 /dev/block/vnswap0 > /dev/null 2>&1
fi
