LABEL="USB4Backup"
BACKUPDIR="" # IF NOT SPECIFY $(hostname -s) aka the short hostname will be used.

apt install -y rsnapshot

cryptsetup luksFormat /dev/disk/by-path/*usb*

[[ ! -f /etc/cryptkeyfile ]] && dd if=/dev/urandom of=/etc/cryptkeyfile bs=1024 count=4
cryptsetup luksAdd /dev/disk/by-path/*usb* /etc/cryptkeyfile

[[ ! "grep $(ls /dev/disk/by-path/*usb*) /etc/crypttab" ]] && echo "${LABEL} $(ls /dev/disk/by-path/*usb*) none luks" >> /etc/crypttab
udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb*
mkfs.ext4 -L ${LABEL} /dev/mapper/${LABEL}

mkdir /.rsnapshot
mount /dev/disk/by-label/${LABEL} /.rsnapshot
mkdir /.rsnapshot/${BACKUPDIR}

echo -e "
00 9-21 * * *   root    udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb* && /usr/bin/mount /dev/mapper/${LABEL} /.rsnapshot && /usr/bin/rsnapshot hourly && /usr/bin/umount /.rsnapshot && udisksctl lock --block-device /dev/disk/by-label/${LABEL}
30 21   * * *   root    udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb* && /usr/bin/mount /dev/mapper/${LABEL} /.rsnapshot && /usr/bin/rsnapshot daily && /usr/bin/umount /.rsnapshot && udisksctl lock --block-device /dev/disk/by-label/${LABEL}
30 22   * * 1   root    udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb* && /usr/bin/mount /dev/mapper/${LABEL} /.rsnapshot && /usr/bin/rsnapshot weekly && /usr/bin/umount /.rsnapshot && udisksctl lock --block-device /dev/disk/by-label/${LABEL}
30 00   1 * *   root    udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb* && /usr/bin/mount /dev/mapper/${LABEL} /.rsnapshot && /usr/bin/rsnapshot monthly && /usr/bin/umount /.rsnapshot && udisksctl lock --block-device /dev/disk/by-label/${LABEL}
" > /etc/cron.d/rsnapshot
