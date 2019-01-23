#!/bin/bash
clear && fdisk -l 2>/dev/null | awk '/(Disk )?\/dev\//' && echo -e "\n\n\n" && read -p "Plz enter your NEW partition: " Disk && { if which pvcreate >/dev/null 2>&1; then pvcreate /dev/$Disk; else yum install -y lvm2;fi; } && { if vgs | awk 'NR>1{exit ($1=="DTVG"?0:1)}'; then vgextend DTVG /dev/$Disk; else vgcreate DTVG /dev/$Disk; fi; } && { lvcreate -l 100%FREE -n data DTVG && mkfs.xfs -f /dev/DTVG/data && echo "$(blkid /dev/DTVG/data|awk '{gsub(/"/,"");print $2}') /data xfs defaults 0 0" >> /etc/fstab && { [ -d /data ] || mkdir -p /data; } && mount -a && clear && df -hP; }

