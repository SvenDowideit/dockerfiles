# Boot info Docker image

run using:

```
$ docker run --rm --privileged svendowideit/bootinfo 

Boot Info Script 0.61      [1 April 2012]

Identifying MBRs...
Computing Partition Table of /dev/sda...
Computing Partition Table of /dev/sdb...
Computing Partition Table of /dev/sdc...
Searching sda1 for information... 
Searching sda2 for information... 
Searching sda5 for information... 
Searching sdb1 for information... 
Searching sdc1 for information... 
Searching sdc2 for information... 
Searching sdc3 for information... 
                  Boot Info Script 0.61      [1 April 2012]


============================= Boot Info Summary: ===============================

 => Grub2 (v1.99) is installed in the MBR of /dev/sda and looks at sector 1 of 
    the same hard drive for core.img. core.img is at this location and looks 
    in partition 135 for .
 => Grub2 (v1.99) is installed in the MBR of /dev/sdb and looks at sector 1 of 
    the same hard drive for core.img. core.img is at this location and looks 
    for (md5)/boot/grub on this drive.
 => Grub2 (v1.99) is installed in the MBR of /dev/sdc and looks at sector 1 of 
    the same hard drive for core.img. core.img is at this location and looks 
    for (,msdos3)/boot/grub on this drive.

sda1: __________________________________________________________________________

    File system:       ext4
    Boot sector type:  -
    Boot sector info: 
    Operating System:  
    Boot files:        

sda2: __________________________________________________________________________

    File system:       Extended Partition
    Boot sector type:  Unknown
    Boot sector info: 

sda5: __________________________________________________________________________

    File system:       swap
    Boot sector type:  -
    Boot sector info: 

sdb1: __________________________________________________________________________

    File system:       ext4
    Boot sector type:  -
    Boot sector info: 
    Mounting failed:   mount: /dev/sdb1 is already mounted or /tmp/BootInfo-5ykzZfl1/sdb1 busy

sdc1: __________________________________________________________________________

    File system:       ext3
    Boot sector type:  -
    Boot sector info: 
    Operating System:  Debian GNU/Linux squeeze/sid
    Boot files:        /etc/fstab

sdc2: __________________________________________________________________________

    File system:       ntfs
    Boot sector type:  Windows XP: NTFS
    Boot sector info:  No errors found in the Boot Parameter Block.
    Operating System:  Windows XP
    Boot files:        /boot.ini /BOOT.INI /ntldr /NTLDR /NTDETECT.COM 
                       /ntdetect.com

sdc3: __________________________________________________________________________

    File system:       ext4
    Boot sector type:  -
    Boot sector info: 
    Operating System:  Ubuntu 12.04.4 LTS
    Boot files:        /boot/grub/grub.cfg /etc/fstab 
                       /boot/extlinux/extlinux.conf /boot/grub/core.img

============================ Drive/Partition Info: =============================

Drive: sda _____________________________________________________________________

Disk /dev/sda: 931.5 GiB, 1000203804160 bytes, 1953523055 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

Partition  Boot  Start Sector    End Sector  # of Sectors  Id System

/dev/sda1    *          2,048 1,874,483,199 1,874,481,152  83 Linux
/dev/sda2       1,874,485,246 1,953,521,663    79,036,418   5 Extended
/dev/sda5       1,874,485,248 1,953,521,663    79,036,416  82 Linux swap / Solaris


Drive: sdb _____________________________________________________________________

Disk /dev/sdb: 1.8 TiB, 2000397852160 bytes, 3907027055 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

Partition  Boot  Start Sector    End Sector  # of Sectors  Id System

/dev/sdb1               2,048 3,907,020,000 3,907,017,953  83 Linux


Drive: sdc _____________________________________________________________________

Disk /dev/sdc: 931.5 GiB, 1000204886016 bytes, 1953525168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

Partition  Boot  Start Sector    End Sector  # of Sectors  Id System

/dev/sdc1                  63   390,700,799   390,700,737  83 Linux
/dev/sdc2    *    390,700,800 1,414,699,964 1,023,999,165   7 NTFS / exFAT / HPFS
/dev/sdc3       1,414,701,056 1,953,523,711   538,822,656  83 Linux


"blkid" output: ________________________________________________________________

Device           UUID                                   TYPE       LABEL

/dev/sda1        ce082afe-7020-4dab-803e-8ab92361da81   ext4       
/dev/sda5        ef166797-fc92-4e93-9993-e20750a5bb63   swap       
/dev/sdb1        97b673c0-0eb5-4bc4-b538-dc2df96120b6   ext4       
/dev/sdc1        66010d3c-dd42-48ab-8a57-41cd9c92d89b   ext3       
/dev/sdc2        4214DEDB14DED151                       ntfs       
/dev/sdc3        7a75e17c-60ff-4b57-a641-48fb6502effe   ext4       

================================ Mount points: =================================

Device           Mount_Point              Type       Options

/dev/sda1        /etc/hostname            ext4       (rw,relatime,errors=remount-ro,data=ordered)
/dev/sda1        /etc/hosts               ext4       (rw,relatime,errors=remount-ro,data=ordered)
/dev/sda1        /etc/resolv.conf         ext4       (rw,relatime,errors=remount-ro,data=ordered)


=============================== sdc1/etc/fstab: ================================

--------------------------------------------------------------------------------
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
proc            /proc           proc    defaults        0       0
/dev/sda1       /               ext3    errors=remount-ro 0       1
/dev/sda4       /data           ext3    errors=remount-ro 0       1
/dev/scd0       /media/cdrom0   udf,iso9660 user,noauto     0       0
/data/swapfile	swap		swap	defaults	0	0
--------------------------------------------------------------------------------

================================ sdc2/boot.ini: ================================

--------------------------------------------------------------------------------
[boot loader]
timeout=30
default=multi(0)disk(0)rdisk(0)partition(2)\WINDOWS
[operating systems]
multi(0)disk(0)rdisk(0)partition(2)\WINDOWS="Windows Server 2003, Enterprise" /noexecute=optout /fastdetect
--------------------------------------------------------------------------------

================================ sdc2/BOOT.INI: ================================

--------------------------------------------------------------------------------
[boot loader]
timeout=30
default=multi(0)disk(0)rdisk(0)partition(2)\WINDOWS
[operating systems]
multi(0)disk(0)rdisk(0)partition(2)\WINDOWS="Windows Server 2003, Enterprise" /noexecute=optout /fastdetect
--------------------------------------------------------------------------------

=========================== sdc3/boot/grub/grub.cfg: ===========================

--------------------------------------------------------------------------------
#
# DO NOT EDIT THIS FILE
#
# It is automatically generated by grub-mkconfig using templates
# from /etc/grub.d and settings from /etc/default/grub
#

### BEGIN /etc/grub.d/00_header ###
if [ -s $prefix/grubenv ]; then
  set have_grubenv=true
  load_env
fi
set default="0"
if [ "${prev_saved_entry}" ]; then
  set saved_entry="${prev_saved_entry}"
  save_env saved_entry
  set prev_saved_entry=
  save_env prev_saved_entry
  set boot_once=true
fi

function savedefault {
  if [ -z "${boot_once}" ]; then
    saved_entry="${chosen}"
    save_env saved_entry
  fi
}

function recordfail {
  set recordfail=1
  if [ -n "${have_grubenv}" ]; then if [ -z "${boot_once}" ]; then save_env recordfail; fi; fi
}

function load_video {
  insmod vbe
  insmod vga
  insmod video_bochs
  insmod video_cirrus
}

insmod part_msdos
insmod ext2
set root='(hd0,msdos3)'
search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
if loadfont /usr/share/grub/unicode.pf2 ; then
  set gfxmode=auto
  load_video
  insmod gfxterm
  insmod part_msdos
  insmod ext2
  set root='(hd0,msdos3)'
  search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
  set locale_dir=($root)/boot/grub/locale
  set lang=en_US
  insmod gettext
fi
terminal_output gfxterm
if [ "${recordfail}" = 1 ] ; then
  set timeout=-1
else
  set timeout=10
fi
### END /etc/grub.d/00_header ###

### BEGIN /etc/grub.d/05_debian_theme ###
set menu_color_normal=white/black
set menu_color_highlight=black/light-gray
if background_color 44,0,30; then
  clear
fi
### END /etc/grub.d/05_debian_theme ###

### BEGIN /etc/grub.d/10_linux ###
function gfxmode {
	set gfxpayload="${1}"
	if [ "${1}" = "keep" ]; then
		set vt_handoff=vt.handoff=7
	else
		set vt_handoff=
	fi
}
if [ "${recordfail}" != 1 ]; then
  if [ -e ${prefix}/gfxblacklist.txt ]; then
    if hwmatch ${prefix}/gfxblacklist.txt 3; then
      if [ ${match} = 0 ]; then
        set linux_gfx_mode=keep
      else
        set linux_gfx_mode=text
      fi
    else
      set linux_gfx_mode=text
    fi
  else
    set linux_gfx_mode=keep
  fi
else
  set linux_gfx_mode=text
fi
export linux_gfx_mode
if [ "${linux_gfx_mode}" != "text" ]; then load_video; fi
menuentry 'Ubuntu, with Linux 3.8.0-35-generic' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	gfxmode $linux_gfx_mode
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux	/boot/vmlinuz-3.8.0-35-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro   text
	initrd	/boot/initrd.img-3.8.0-35-generic
}
menuentry 'Ubuntu, with Linux 3.8.0-35-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	echo	'Loading Linux 3.8.0-35-generic ...'
	linux	/boot/vmlinuz-3.8.0-35-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro recovery nomodeset 
	echo	'Loading initial ramdisk ...'
	initrd	/boot/initrd.img-3.8.0-35-generic
}
submenu "Previous Linux versions" {
menuentry 'Ubuntu, with Linux 3.8.0-34-generic' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	gfxmode $linux_gfx_mode
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux	/boot/vmlinuz-3.8.0-34-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro   text
	initrd	/boot/initrd.img-3.8.0-34-generic
}
menuentry 'Ubuntu, with Linux 3.8.0-34-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	echo	'Loading Linux 3.8.0-34-generic ...'
	linux	/boot/vmlinuz-3.8.0-34-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro recovery nomodeset 
	echo	'Loading initial ramdisk ...'
	initrd	/boot/initrd.img-3.8.0-34-generic
}
menuentry 'Ubuntu, with Linux 3.8.0-33-generic' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	gfxmode $linux_gfx_mode
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux	/boot/vmlinuz-3.8.0-33-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro   text
	initrd	/boot/initrd.img-3.8.0-33-generic
}
menuentry 'Ubuntu, with Linux 3.8.0-33-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	echo	'Loading Linux 3.8.0-33-generic ...'
	linux	/boot/vmlinuz-3.8.0-33-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro recovery nomodeset 
	echo	'Loading initial ramdisk ...'
	initrd	/boot/initrd.img-3.8.0-33-generic
}
menuentry 'Ubuntu, with Linux 3.2.0-58-generic' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	gfxmode $linux_gfx_mode
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux	/boot/vmlinuz-3.2.0-58-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro   text
	initrd	/boot/initrd.img-3.2.0-58-generic
}
menuentry 'Ubuntu, with Linux 3.2.0-58-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	echo	'Loading Linux 3.2.0-58-generic ...'
	linux	/boot/vmlinuz-3.2.0-58-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro recovery nomodeset 
	echo	'Loading initial ramdisk ...'
	initrd	/boot/initrd.img-3.2.0-58-generic
}
menuentry 'Ubuntu, with Linux 3.2.0-57-generic' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	gfxmode $linux_gfx_mode
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux	/boot/vmlinuz-3.2.0-57-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro   text
	initrd	/boot/initrd.img-3.2.0-57-generic
}
menuentry 'Ubuntu, with Linux 3.2.0-57-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	echo	'Loading Linux 3.2.0-57-generic ...'
	linux	/boot/vmlinuz-3.2.0-57-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro recovery nomodeset 
	echo	'Loading initial ramdisk ...'
	initrd	/boot/initrd.img-3.2.0-57-generic
}
menuentry 'Ubuntu, with Linux 3.2.0-56-generic' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	gfxmode $linux_gfx_mode
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux	/boot/vmlinuz-3.2.0-56-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro   text
	initrd	/boot/initrd.img-3.2.0-56-generic
}
menuentry 'Ubuntu, with Linux 3.2.0-56-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	echo	'Loading Linux 3.2.0-56-generic ...'
	linux	/boot/vmlinuz-3.2.0-56-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro recovery nomodeset 
	echo	'Loading initial ramdisk ...'
	initrd	/boot/initrd.img-3.2.0-56-generic
}
menuentry 'Ubuntu, with Linux 3.0.0-32-generic' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	gfxmode $linux_gfx_mode
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux	/boot/vmlinuz-3.0.0-32-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro   text
	initrd	/boot/initrd.img-3.0.0-32-generic
}
menuentry 'Ubuntu, with Linux 3.0.0-32-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	echo	'Loading Linux 3.0.0-32-generic ...'
	linux	/boot/vmlinuz-3.0.0-32-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro recovery nomodeset 
	echo	'Loading initial ramdisk ...'
	initrd	/boot/initrd.img-3.0.0-32-generic
}
menuentry 'Ubuntu, with Linux 2.6.38-8-generic' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	gfxmode $linux_gfx_mode
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux	/boot/vmlinuz-2.6.38-8-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro   text
	initrd	/boot/initrd.img-2.6.38-8-generic
}
menuentry 'Ubuntu, with Linux 2.6.38-8-generic (recovery mode)' --class ubuntu --class gnu-linux --class gnu --class os {
	recordfail
	insmod gzio
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	echo	'Loading Linux 2.6.38-8-generic ...'
	linux	/boot/vmlinuz-2.6.38-8-generic root=UUID=7a75e17c-60ff-4b57-a641-48fb6502effe ro recovery nomodeset 
	echo	'Loading initial ramdisk ...'
	initrd	/boot/initrd.img-2.6.38-8-generic
}
}
### END /etc/grub.d/10_linux ###

### BEGIN /etc/grub.d/20_linux_xen ###
### END /etc/grub.d/20_linux_xen ###

### BEGIN /etc/grub.d/20_memtest86+ ###
menuentry "Memory test (memtest86+)" {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux16	/boot/memtest86+.bin
}
menuentry "Memory test (memtest86+, serial console 115200)" {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos3)'
	search --no-floppy --fs-uuid --set=root 7a75e17c-60ff-4b57-a641-48fb6502effe
	linux16	/boot/memtest86+.bin console=ttyS0,115200n8
}
### END /etc/grub.d/20_memtest86+ ###

### BEGIN /etc/grub.d/30_os-prober ###
menuentry "Debian GNU/Linux, with Linux 2.6.32-trunk-amd64 (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.32-trunk-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro
	initrd /boot/initrd.img-2.6.32-trunk-amd64
}
menuentry "Debian GNU/Linux, with Linux 2.6.32-trunk-amd64 (recovery mode) (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.32-trunk-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro single
	initrd /boot/initrd.img-2.6.32-trunk-amd64
}
menuentry "Debian GNU/Linux, with Linux 2.6.32-3-amd64 (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.32-3-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro
	initrd /boot/initrd.img-2.6.32-3-amd64
}
menuentry "Debian GNU/Linux, with Linux 2.6.32-3-amd64 (recovery mode) (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.32-3-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro single
	initrd /boot/initrd.img-2.6.32-3-amd64
}
menuentry "Debian GNU/Linux, with Linux 2.6.30-2-amd64 (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.30-2-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro
	initrd /boot/initrd.img-2.6.30-2-amd64
}
menuentry "Debian GNU/Linux, with Linux 2.6.30-2-amd64 (recovery mode) (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.30-2-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro single
	initrd /boot/initrd.img-2.6.30-2-amd64
}
menuentry "Debian GNU/Linux, with Linux 2.6.30-1-amd64 (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.30-1-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro
	initrd /boot/initrd.img-2.6.30-1-amd64
}
menuentry "Debian GNU/Linux, with Linux 2.6.30-1-amd64 (recovery mode) (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.30-1-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro single
	initrd /boot/initrd.img-2.6.30-1-amd64
}
menuentry "Debian GNU/Linux, with Linux 2.6.26-1-amd64 (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.26-1-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro
	initrd /boot/initrd.img-2.6.26-1-amd64
}
menuentry "Debian GNU/Linux, with Linux 2.6.26-1-amd64 (recovery mode) (on /dev/sda1)" --class gnu-linux --class gnu --class os {
	insmod part_msdos
	insmod ext2
	set root='(hd0,msdos1)'
	search --no-floppy --fs-uuid --set=root 66010d3c-dd42-48ab-8a57-41cd9c92d89b
	linux /boot/vmlinuz-2.6.26-1-amd64 root=UUID=66010d3c-dd42-48ab-8a57-41cd9c92d89b ro single
	initrd /boot/initrd.img-2.6.26-1-amd64
}
menuentry "Windows NT/2000/XP (on /dev/sda2)" --class windows --class os {
	insmod part_msdos
	insmod ntfs
	set root='(hd0,msdos2)'
	search --no-floppy --fs-uuid --set=root 4214DEDB14DED151
	drivemap -s (hd0) ${root}
	chainloader +1
}
set timeout_style=menu
if [ "${timeout}" = 0 ]; then
  set timeout=10
fi
### END /etc/grub.d/30_os-prober ###

### BEGIN /etc/grub.d/30_uefi-firmware ###
### END /etc/grub.d/30_uefi-firmware ###

### BEGIN /etc/grub.d/40_custom ###
# This file provides an easy way to add custom menu entries.  Simply type the
# menu entries you want to add after this comment.  Be careful not to change
# the 'exec tail' line above.
### END /etc/grub.d/40_custom ###

### BEGIN /etc/grub.d/41_custom ###
if [ -f  $prefix/custom.cfg ]; then
  source $prefix/custom.cfg;
fi
### END /etc/grub.d/41_custom ###

### BEGIN /etc/grub.d/60_grub-imageboot ###
### END /etc/grub.d/60_grub-imageboot ###
--------------------------------------------------------------------------------

=============================== sdc3/etc/fstab: ================================

--------------------------------------------------------------------------------
# /etc/fstab: static file system information.
#
# Use 'blkid -o value -s UUID' to print the universally unique identifier
# for a device; this may be used with UUID= as a more robust way to name
# devices that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
proc            /proc           proc    nodev,noexec,nosuid 0       0
# / was on /dev/sda3 during installation
UUID=7a75e17c-60ff-4b57-a641-48fb6502effe /               ext4    errors=remount-ro 0       1
/dev/sdc1	/data		btrfs	 defaults 0       1
/dev/md0	/data2		ext4	defaults 0	1

--------------------------------------------------------------------------------

====================== sdc3/boot/extlinux/extlinux.conf: =======================

--------------------------------------------------------------------------------
## /boot/extlinux/extlinux.conf
##
## IMPORTANT WARNING
##
## The configuration of this file is generated automatically.
## Do not edit this file manually, use: extlinux-update


default l0
prompt 1
timeout 50

include themes/debian/theme.cfg
--------------------------------------------------------------------------------

=================== sdc3: Location of files loaded by Grub: ====================

           GiB - GB             File                                 Fragment(s)


================= sdc3: Location of files loaded by Syslinux: ==================

           GiB - GB             File                                 Fragment(s)


============== sdc3: Version of COM32(R) files used by Syslinux: ===============

 boot/extlinux/chain.c32            :  COM32R module (v4.xx)

======================== Unknown MBRs/Boot Sectors/etc: ========================

Unknown BootLoader on sda2

00000000  5a fd 22 e1 46 d4 db 49  f8 5a 97 aa e4 c1 c4 7c  |Z.".F..I.Z.....||
00000010  76 13 73 55 80 34 24 ac  d5 ad 4d 8b 63 2b 8b 14  |v.sU.4$...M.c+..|
00000020  95 da fa e5 b0 af 2a 58  2a 28 cd 43 66 d1 3a b6  |......*X*(.Cf.:.|
00000030  74 14 02 43 f1 23 b0 11  58 af db bd 94 02 7e 31  |t..C.#..X.....~1|
00000040  06 a4 34 5f aa af e9 1d  4b 87 1a 3e 0f 3c 7e 56  |..4_....K..>.<~V|
00000050  2a d2 63 64 cc 0a 86 6b  4a 1d 86 2a 00 7e 32 95  |*.cd...kJ..*.~2.|
00000060  91 71 c5 8f ff 64 03 3d  21 90 2c 95 71 1a 6b ec  |.q...d.=!.,.q.k.|
00000070  a8 0d bc 2c 82 bd f1 64  72 a8 68 84 b8 c8 cb e2  |...,...dr.h.....|
00000080  75 28 64 ec 8e 26 c7 dd  a3 6b 7a 15 8d 8a fd 66  |u(d..&...kz....f|
00000090  09 47 1e a1 8f ae 52 b8  53 e2 f0 12 b9 a5 1d d2  |.G....R.S.......|
000000a0  4f 12 67 35 15 a3 a1 6d  7d e4 6a 27 1f df 2c 30  |O.g5...m}.j'..,0|
000000b0  09 ab ea be fd 68 78 2c  06 60 5f 11 5f 3b 8f 07  |.....hx,.`_._;..|
000000c0  71 c5 6d 84 eb a4 e1 18  49 75 75 10 b7 63 4f c9  |q.m.....Iuu..cO.|
000000d0  05 9a 2f af 52 cd 6e 9f  d3 31 36 0b 28 49 cc 8d  |../.R.n..16.(I..|
000000e0  d8 7e fb ea 4a 9e 62 1f  94 9d a5 a8 54 89 b9 16  |.~..J.b.....T...|
000000f0  a6 a6 c7 93 d1 51 53 7d  72 87 78 8b 3a f1 75 a2  |.....QS}r.x.:.u.|
00000100  45 33 04 94 d0 d7 5e 18  e6 8b b4 38 17 01 ed 6d  |E3....^....8...m|
00000110  2f d8 22 18 32 d7 41 3f  32 32 2e d6 05 34 65 63  |/.".2.A?22...4ec|
00000120  70 3b 07 fd 02 ec 60 b7  43 a0 22 a5 59 c0 76 8b  |p;....`.C.".Y.v.|
00000130  7e e2 0d 09 a7 41 d0 ad  03 e6 42 2f cc fc 14 24  |~....A....B/...$|
00000140  14 71 c6 cd ab 0a ac 3c  d6 1e a9 b4 6e cf f3 b9  |.q.....<....n...|
00000150  b4 cf 58 a9 de 6e 3c db  be e0 73 ca af 56 b2 7f  |..X..n<...s..V..|
00000160  91 3a b5 10 92 cb e0 da  c9 c6 fd b8 af 5d cc 70  |.:...........].p|
00000170  f9 f8 16 7c b6 8a 58 13  39 fb 39 d2 fa 14 ac 5a  |...|..X.9.9....Z|
00000180  21 91 8f e7 1e ad 3d cc  95 19 b2 6b 25 dd fd b5  |!.....=....k%...|
00000190  d1 54 fc 43 0a af 9e 4f  f3 45 89 48 b1 c0 48 e9  |.T.C...O.E.H..H.|
000001a0  82 8d 94 58 03 44 c5 37  ec 53 de e6 10 d3 b9 7d  |...X.D.7.S.....}|
000001b0  09 bf 19 cc 35 85 c4 21  70 bc c5 39 3e ee 00 fe  |....5..!p..9>...|
000001c0  ff ff 82 fe ff ff 02 00  00 00 00 00 b6 04 00 00  |................|
000001d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
00000200


========= Devices which don't seem to have a corresponding hard drive: =========

sdd 

=============================== StdErr Messages: ===============================

xz: (stdin): Compressed data is corrupt
xz: (stdin): Compressed data is corrupt
/usr/local/bin/bootinfoscript: line 2545: cd: /etc/hostname/: Not a directory
cat: /tmp/BootInfo-5ykzZfl1/Tmp_Log: No such file or directory
cat: /tmp/BootInfo-5ykzZfl1/Tmp_Log: No such file or directory
```
