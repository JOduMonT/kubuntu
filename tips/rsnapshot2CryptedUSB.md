# WIP

> Why rsnapshot ?
> Because he don't care if you swap the destination it does the differencial from the last backup found on the destionation

## Concept note
- I figured I was fine with by rotating 3 dedicated USB Drive for my backup
  1. one plugged on the server
  2. one at the remote location
  3. one in transit between the remote location and the server location
- Because they are physically stored on a "insecure" space; they are all crypted with LUKS
- Because I want anybody being able to do it (Plug the  damn USB Drive)
  - I use the same keyfile; to automatically unlock them
  - They are all formated with ext4 and have the same label USB4Backup
  - WARNING: be sure to simply disconnect the drive and **leave the USB cable always connected** in the same USB port.
 
## Procedure for each USB Drive
> Only plug one drive at time in the USB port you decicate to the Backup procedure

1. encrypt the USB drive `cryptsetup luksFormat /dev/disk/by-path/*usb*`

2. forge the USB path for your container LUKS: `echo "USB4Backup $(ls /dev/disk/by-path/*usb*) none luks" >> /etc/crypttab`
> So when you open the container LUKS it will be named USB4Backup in /dev/mapper

3. create a keyfile `dd if=/dev/urandom of=/etc/cryptkeyfile bs=1024 count=4 && chmod 600 /etc/cryptkeyfile`
> Why in /etc ? simply because /etc/ is also backuped

4. add the keyfile to your crypted USB drive `cryptsetup luksAdd /dev/disk/by-path/*usb* /etc/cryptkeyfile`
> Why not just having a keyfile instead of a keyphrase and a keyfile to open the LUKS's container ?
> Because the day you will loose your system and the only way you will have restore your keyfile is actually inside your crypted drive, you will cry.

5. open the crypted USB drive  `udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb*`

6. format your cryped USB drive with the label USB4Backup `mkfs.ext4 -L USB4Backup /dev/mapper/USB4Backup`

7. create the destination directory on the mounted crypted USB drive
> because I use the rsnapshot parameter no_create_root which is usefull to quickly detect if the drive is mounted or not.
````
mkdir /.rsnapshot
mount /dev/disk/by-label/USB4Backup /.rsnapshot
mkdir /.rsnapshot/$(hostname -s)
````

## Configuration

### in `/etc/crypttab` you should have something similar to
````
USB4Backup  /dev/disk/by-path/pci-0000:00:1d.7-usb-0:1.2:1.0-scsi-0:0:0:0 none luks
````
> Even if you have 3 drives USB4Backup should appear only 1 time because we use the USB path, this is why it is important to keep the USB cable connected to the same USB port.

### in `/etc/rsnapshot.conf`
````
````

### in `/etc/cron.d/rsnapshot`
> Which give us an hourly backup during the working hours (9AM to 9PM) and a windows to change the drive before 9:00AM.
````
00 9-21 * * *   root    udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb* && /usr/bin/mount /dev/mapper/USB4Backup /.rsnapshot && /usr/bin/rsnapshot hourly && /usr/bin/umount /.rsnapshot && udisksctl lock --block-device /dev/disk/by-label/USB4Backup
30 21   * * *   root    udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb* && /usr/bin/mount /dev/mapper/USB4Backup /.rsnapshot && /usr/bin/rsnapshot daily && /usr/bin/umount /.rsnapshot && udisksctl lock --block-device /dev/disk/by-label/USB4Backup
30 22   * * 1   root    udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb* && /usr/bin/mount /dev/mapper/USB4Backup /.rsnapshot && /usr/bin/rsnapshot weekly && /usr/bin/umount /.rsnapshot && udisksctl lock --block-device /dev/disk/by-label/USB4Backup
30 00   1 * *   root    udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb* && /usr/bin/mount /dev/mapper/USB4Backup /.rsnapshot && /usr/bin/rsnapshot monthly && /usr/bin/umount /.rsnapshot && udisksctl lock --block-device /dev/disk/by-label/USB4Backup
````

#### command by command
> each line contain several command
> && means it will execute this command after the previous one

1. udisksctl unlock --key-file /etc/cryptkeyfile -b /dev/disk/by-path/*usb*
> unlock the container LUKS found via the USB Path

2. && /usr/bin/mount /dev/mapper/USB4Backup /.rsnapshot
> mount the unlocked container LUKS as /.rsnapshot

3.  && /usr/bin/rsnapshot [hourly|daily|weekly|monthly]
> run the rsnapshot

4. && /usr/bin/umount /.rsnapshot
> unmount the drive

4. && udisksctl lock --block-device /dev/disk/by-label/USB4Backup
> lock the container LUKS, to prevent corruption when we unplug it.
