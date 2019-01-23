#!/bin/bash
pvcreate /dev/xvdb && vgextend DTVG /dev/xvdb && lvcreate -l 100%FREE -n data DTVG && mkfs.xfs -f /dev/DTVG/data && echo "$(blkid /dev/DTVG/data|awk '{gsub(/"/,"");print $2}') /data xfs  defaults  0 0" > /etc/fstab && { [ -d /data ] || mkdir -p /data; } && mount -a && clear && df -hP

