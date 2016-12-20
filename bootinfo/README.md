# Boot info Docker image

run using (example from RancherOS v0.7.1):

```
$ docker run --rm --privileged svendowideit/bootinfo 

Boot Info Script 0.61      [1 April 2012]

Identifying MBRs...
Computing Partition Table of /dev/sda...
Searching sda1 for information... 
                  Boot Info Script 0.61      [1 April 2012]


============================= Boot Info Summary: ===============================

 => Grub2 (v1.99) is installed in the MBR of /dev/sda and looks at sector 1 of 
    the same hard drive for core.img. core.img is at this location and looks 
    in partition 97 for .

sda1: __________________________________________________________________________

    File system:       ext4
    Boot sector type:  -
    Boot sector info: 
    Operating System:  
    Boot files:        

============================ Drive/Partition Info: =============================

Drive: sda _____________________________________________________________________

Disk /dev/sda: 111.8 GiB, 120034123776 bytes, 234441648 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

Partition  Boot  Start Sector    End Sector  # of Sectors  Id System

/dev/sda1               2,048   234,441,647   234,439,600  83 Linux


"blkid" output: ________________________________________________________________

Device           UUID                                   TYPE       LABEL

/dev/sda1        bdecdcc8-1d74-4d12-85ed-c9c795a8ec9e   ext4       RANCHER_STATE

================================ Mount points: =================================

Device           Mount_Point              Type       Options

/dev/sda1        /etc/hostname            ext4       (rw,relatime,data=ordered)


=============================== StdErr Messages: ===============================

/usr/local/bin/bootinfoscript: line 2545: cd: /etc/hostname/: Not a directory
```
