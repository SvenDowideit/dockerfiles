#!/bin/bash
VERSION='0.61';
RELEASE_DATE='1 April 2012';
LAST_GIT_COMMIT='';
RETRIEVAL_DATE='';
################################################################################
#                                                                              #
# Copyright (c) 2009-2010      Ulrich Meierfrankenfeld                         #
# Copyright (c) 2011-2012      Gert Hulselmans                                 #
#                                                                              #
# Permission is hereby granted, free of charge, to any person obtaining a copy #
# of this software and associated documentation files (the "Software"), to     #
# deal in the Software without restriction, including without limitation the   #
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or  #
# sell copies of the Software, and to permit persons to whom the Software is   #
# furnished to do so, subject to the following conditions:                     #
#                                                                              #
# The above copyright notice and this permission notice shall be included in   #
# all copies or substantial portions of the Software.                          #
#                                                                              #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR   #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,     #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER       #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING      #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS #
# IN THE SOFTWARE.                                                             #
#                                                                              #
################################################################################
#                                                                              #
# Current developer:  Gert Hulselmans                                          #
#                                                                              #
# Past developer:     Ulrich Meierfrankenfeld (meierfra) (ubuntuforums.org)    #
# Past contributor:   caljohnsmith (ubuntuforums.org)                          #
#                                                                              #
# Hosted at:          http://sourceforge.net/projects/bootinfoscript/          #
#                                                                              #
# The birth of Boot Info Script:                                               #
#                     http://ubuntuforums.org/showthread.php?t=837791          #
#                                                                              #
# Tab width:          8 spaces                                                 #
#                                                                              #
################################################################################



## Check if the script is run with bash as shell interpreter.

if [ -z "$BASH_VERSION" ] ; then
   echo 'Boot Info Script needs to be run with bash as shell interpreter.' >&2;
   exit 1;
fi



## Display help text ##
#
#   ./bootinfoscript -h
#   ./bootinfoscript -help
#   ./bootinfoscript --help
 
help () {
   cat <<- HELP
	
	Usage Boot Info Script:
	-----------------------
	
	  Run the script as sudoer:
	
	    sudo ${0} <outputfile>
	
	  or if your operating system does not use sudo:
	
	    su -
	    ${0} <outputfile>
	
	
	  When running the script, without specifying an output file, all the output
	  is written to the file "RESULTS.txt" in the same folder as the script.
	
	  But when run from /bin, /sbin, /usr/bin, or another system folder, the file
	  "RESULTS.txt" is written to the home directory of the user.
	
	  When the file "RESULTS.txt" already exists, the results will be written to
	  "RESULTS1.txt". If "RESULTS1.txt" exists, the results will be written to
	  "RESULTS2.txt", ...
	
	
	  To get version number, release date, last git commit and git retrieval date
	  of this script, use (no root rights needed):
	
	    ${0} -v
	    ${0} -V
	    ${0} --version
	
	
	  To get this help text, use (no root rights needed):
	
	    ${0} -h
	    ${0} -help
	    ${0} --help
	
		
	  To automatically gzip a copy of the output file, use (root rights needed):
	
	    ${0} -g <outputfile>
	    ${0} --gzip <outputfile>
	
		
	  To write the output to stdout instead of a file, use (root rights needed):
	
	    ${0} --stdout
	
	
	  The last development version of Boot Info Script can be downloaded, with:
	    (no root rights needed)
	
	    ${0} --update <filename>
	
	  If no filename is specified, the file will be saved in the home dir as
	  "bootinfoscript_YYYY-MM-DD_hh:mm:ss".
	
	
	  If multiple versions of Boot Info Script are detected in the same directory,
	  Boot Info Script will list all versions found.
	  In that case you need to force Boot Info Script to run a certain version,
	  by adding "--this" as first argument (root rights needed):
	
	    ${0} --this <outputfile>
	
	HELP

   exit 0;
}



## Download the last development version of BIS from git: ##
#
#   ./bootinfoscript --update <filename>
#
#   If no filename is specified, the file will be saved in the home dir as
#   "bootinfoscript_YYYY-MM-DD_hh:mm:ss".

update () {
  local git_bis_url='http://bootinfoscript.git.sourceforge.net/git/gitweb.cgi?p=bootinfoscript/bootinfoscript;a=blob_plain;f=bootinfoscript;hb=HEAD';
  local git_commit_url='http://bootinfoscript.sourceforge.net/bis-last-commit.txt'

  # Check if date is available.
  if [ $(type date > /dev/null 2>&1 ; echo $?) -ne 0 ] ; then
     echo '"date" could not be found.' >&2;
     exit 1;
  fi

  # Get current UTC time in YYYY-MM-DD-hh:mm:ss format.
  UTC_TIME=$(date --utc "+%Y-%m-%d %T");

  if [ ! -z "$1" ] ; then
     GIT_BIS_FILENAME="$1";
  else
     GIT_BIS_FILENAME="${HOME}/bootinfoscript_${UTC_TIME/ /_}"
  fi

  # Check if wget or curl is available
  if [ $(type wget > /dev/null 2>&1 ; echo $?) -eq 0 ] ; then
     printf '\nDownloading last development version of Boot Info Script from git:\n\n';
     wget -O "${GIT_BIS_FILENAME}" "${git_bis_url}";
     LAST_GIT_COMMIT=$(wget -O - "${git_commit_url}" 2> /dev/null);
  elif [ $(type curl > /dev/null 2>&1 ; echo $?) -eq 0 ] ; then
     printf 'Downloading last development version of Boot Info Script from git:\n\n';
     curl -o "${GIT_BIS_FILENAME}" "${git_bis_url}";
     LAST_GIT_COMMIT=$(curl "${git_commit_url}");
  else
     printf '"wget" or "curl" could not be found.\nInstall at least one of them and try again.\n' >&2;
     exit 1;
  fi

  # Set the retrieval date in just downloaded script.
  sed -i -e "4,0 s@LAST_GIT_COMMIT='';@LAST_GIT_COMMIT='${LAST_GIT_COMMIT}';@" \
	 -e "5,0 s/RETRIEVAL_DATE='';/RETRIEVAL_DATE='${UTC_TIME}';/" \
	 "${GIT_BIS_FILENAME}";

  printf '\nThe development version of Boot Info Script is saved as:\n"%s"\n\n' "${GIT_BIS_FILENAME}";
  exit 0;
}



## Display version, release, last git commit and git retrieval date of the script when asked: ##
#
#   ./bootinfoscript -v
#   ./bootinfoscript -V
#   ./bootinfoscript --version 

version () {
  printf '\nBoot Info Script version: %s\nRelease date:             %s' "${VERSION}" "${RELEASE_DATE}";

  if [ ! -z "${LAST_GIT_COMMIT}" ] ; then
     printf '\nLast git commit:          %s\nRetrieved from git on:    %s' "${LAST_GIT_COMMIT}" "${RETRIEVAL_DATE}";
  fi

  printf '\n\n';

  exit 0;
}



## Run this version of BIS even when multiple versions are detected in the same directory?
this_BIS=0;	 # no=0

## Gzip a copy of the output file? ##
gzip_output=0;	 # off=0

## Write the output to the standard output instead of to a file? ##
stdout_output=0; # off=0



## Get arguments passed to the script. ##

process_args () {
  if [ ${#@} -ge 1 ] ; then
     if [ $1 = '--this' ] ; then
	this_BIS=1;	# run this version of BIS even if multiple versions are detected.

	if [ ${#@} -ge 2 ] ; then
	   shift;	# shift the command line parameters ($2 -> $1), so they can be processed.
	else
	   return 0;	# exit this function when only '--this' was passed.
	fi
     fi

     # Process other arguments.
     case "$1" in
	-g	  ) gzip_output=1; if [ ! -z "$2" ] ; then LogFile_cmd="$2"; fi;;
	--gzip	  ) gzip_output=1; if [ ! -z "$2" ] ; then LogFile_cmd="$2"; fi;;
	-h	  ) help;;
	-help	  ) help;;
	--help	  ) help;;
	--stdout  ) stdout_output=1;;
	--update  ) update "$2";;
	-v	  ) version;;
	-V	  ) version;;
	--version ) version;;
	-*	  ) help;;
	*	  ) LogFile_cmd="$1";;
     esac
  fi
}




## Get arguments passed to the script. ##

process_args ${@};



## Display version number, release and git retrieval date. ##

printf '\nBoot Info Script %s      [%s]' "${VERSION}" "${RELEASE_DATE}";

if [ ! -z "${LAST_GIT_COMMIT}" ] ; then
   printf '\n  Last git commit:         %s\n  Retrieved from git on:   %s' "${LAST_GIT_COMMIT}" "${RETRIEVAL_DATE}";
fi

printf '\n\n';



## Check whether Boot Info Script is run with root rights or not. ##

if [ $(type whoami > /dev/null 2>&1 ; echo $?) -ne 0 ] ; then
   echo 'Please install "whoami" and run Boot Info Script again.' >&2;
   exit 1;
elif [ $(whoami) != 'root' ] ; then
   cat <<- EOF >&2
	Please use "sudo" or become "root" to run this script.
	
	  Run the script as sudoer:
	
	    sudo ${0} <outputfile>
	
	  or if your operating system does not use sudo:
	
	    su -
	    ${0} <outputfile>

	For more info, see the help:

	    ${0} --help
	
	EOF
   exit 1;
fi



## Check if all necessary programs are available. ##

# Programs that are in /bin or /usr/bin.
Programs='
	basename
	cat
	chown
	dd
	dirname
	expr
	fold
	grep
	gzip
	hexdump
	ls
	mkdir
	mktemp
	mount
	printf
	pwd
	rm
	sed
	sort
	umount
	wc'

# Programs that are in /usr/sbin or /sbin.
Programs_SBIN='
	blkid
	fdisk
	filefrag
	losetup'


Check_Prog=1;

for Program in ${Programs} ${Programs_SBIN}; do
  if [ $(type ${Program} > /dev/null 2>&1 ; echo $?) -ne 0 ] ; then
     echo "\"${Program}\" could not be found." >&2;
     Check_Prog=0;
  fi
done



## Can we decompress a LZMA stream? ##
#
#   The Grub2 (v1.99) core_dir string is contained in a LZMA stream.
#   See if we have xz or lzma installed to decompress the stream.
#

if [ $(type xz > /dev/null 2>&1 ; echo $?) -eq 0 ] ; then
   UNLZMA='xz --format=lzma --decompress';
elif [ $(type lzma > /dev/null 2>&1 ; echo $?) -eq 0 ] ; then
   UNLZMA='lzma -cd';
else
   UNLZMA='none';
fi



## Do we have gawk? ##
#
#   If we don't have gawk, look for "busybox awk".
#

# Make a variable named ${TAB}, needed for setting the separator for awk to a tab.
TAB=$(printf "\t");

# Set awk binary to gawk.
AWK='gawk';


if [ $(type gawk > /dev/null 2>&1 ; echo $?) -ne 0 ] ; then
   # Do we have a busybox version?
   for BUSYBOX in 'busybox' '/usr/lib/initramfs-tools/bin/busybox' ; do
     # And if we have one, does is support "awk"?
     if [ $(type ${BUSYBOX} > /dev/null 2>&1 ; echo $?) -eq 0 ] && [ $(echo 'test' | ${BUSYBOX} awk '{ print $0 }' > /dev/null 2>&1; echo $?) -eq 0 ] ; then
	printf '\n"gawk" could not be found, using "%s awk" instead.\nThis may lead to unreliable results.\n\n' "${BUSYBOX}" >&2;

	# Set awk binary to busybox's awk.
	AWK="${BUSYBOX} awk";
	break;
     fi
   done

   # If no busybox (or one without awk support) is found, "${AWK}" is still set to "gawk".
   if [ "${AWK}" == 'gawk' ] ; then
      echo '"gawk" could not be found.' >&2;
      Check_Prog=0;
   fi
fi



if [ ${Check_Prog} -eq 0 ] ; then
   printf '\nPlease install the missing program(s) and run Boot Info Script again.\n' >&2;
   exit 1;
fi



## Check if there are other bootinfoscript files in the same directory. ##
#
#   This can be useful when BIS was downloaded multiple times with Firefox, Chromium, ...
#   Those browsers will add a suffix to the filename, when there was already
#   a file with the same name:
#
#     bootinfoscript(<number>)
#
#   To force BIS to run a certain version, add "--this" as first argument:
#
#     ./bootinfoscript --this <outputfile>
#

if [ ${this_BIS} -eq 0 ] ; then
   declare -a BIS_files;

   BIS_files=( $(ls "$(dirname "$0")/bootinfoscript" "$(dirname \"$0\")"/bootinfoscript\(*\) 2> /dev/null) );

   if [ "${#BIS_files[*]}" -ge 2 ] ; then
      printf 'Multiple bootinfoscript files where found:\n\n';

      for i in ${!BIS_files[@]} ; do
	eval $(echo 'BIS_'$(grep -m1 '^VERSION' "${BIS_files[$i]}") );
	printf "  - ${BIS_files[$i]}:\tversion ${BIS_VERSION}\n";
      done

      printf '\nAre you sure you want to run this version? If so, run:\n\n  %s --this %s\n\n' "$0" "$*";
      exit 1;
   fi
fi



## List of folders which might contain files used for chainloading. ##

Boot_Codes_Dir='
	/
	/NST/
	'



## List of files whose names will be displayed, if found. ##

Boot_Prog_Normal='
	/bootmgr	/BOOTMGR
	/boot/bcd	/BOOT/bcd	/Boot/bcd	/boot/BCD	/BOOT/BCD	/Boot/BCD
	/Windows/System32/winload.exe	/WINDOWS/system32/winload.exe	/WINDOWS/SYSTEM32/winload.exe	/windows/system32/winload.exe
	/Windows/System32/Winload.exe	/WINDOWS/system32/Winload.exe	/WINDOWS/SYSTEM32/Winload.exe	/windows/system32/Winload.exe
	/grldr		/GRLDR		/grldr.mbr	/GRLDR.MBR
	/ntldr		/NTLDR
	/NTDETECT.COM	/ntdetect.com
	/NTBOOTDD.SYS	/ntbootdd.sys
	/wubildr	/ubuntu/winboot/wubildr
	/wubildr.mbr	/ubuntu/winboot/wubildr.mbr
	/ubuntu/disks/root.disk
	/ubuntu/disks/home.disk
	/ubuntu/disks/swap.disk
	/core.img	/grub/core.img		/boot/grub/core.img	/grub2/core.img	/boot/grub2/core.img
	/burg/core.img	/boot/burg/core.img
	/ldlinux.sys	/syslinux/ldlinux.sys	/boot/syslinux/ldlinux.sys
	/extlinux.sys	/extlinux/extlinux.sys	/boot/extlinux/extlinux.sys
	/boot/map	/map
	/DEFAULT.MNU	/default.mnu
	/IO.SYS		/io.sys
	/MSDOS.SYS	/msdos.sys 
	/KERNEL.SYS	/kernel.sys
	/DELLBIO.BIN	/dellbio.bin		/DELLRMK.BIN	/dellrmk.bin
	/COMMAND.COM	/command.com
	'

Boot_Prog_Fat='
	/bootmgr
	/boot/bcd
	/Windows/System32/winload.exe
	/grldr
	/grldr.mbr
	/ntldr
	/freeldr.sys
	/NTDETECT.COM
	/NTBOOTDD.SYS
	/wubildr
	/wubildr.mbr
	/ubuntu/winboot/wubildr
	/ubuntu/winboot/wubildr.mbr
	/ubuntu/disks/root.disk
	/ubuntu/disks/home.disk
	/ubuntu/disks/swap.disk
	/core.img	/grub/core.img		/boot/grub/core.img	/grub2/core.img	/boot/grub2/core.img
	/burg/core.img	/boot/burg/core.img
	/ldlinux.sys	/syslinux/ldlinux.sys	/boot/syslinux/ldlinux.sys
	/extlinux.sys	/extlinux/extlinux.sys	/boot/extlinux/extlinux.sys
	/boot/map	/map
	/DEFAULT.MNU
	/IO.SYS
	/MSDOS.SYS
	/KERNEL.SYS
	/DELLBIO.BIN	/DELLRMK.BIN
	/COMMAND.COM
	'



## List of files whose contents will be displayed. ##

Boot_Files_Normal='
	/menu.lst	/grub/menu.lst	/boot/grub/menu.lst	/NST/menu.lst	
	/grub.cfg	/grub/grub.cfg	/boot/grub/grub.cfg	/grub2/grub.cfg	/boot/grub2/grub.cfg
	/burg.cfg	/burg/burg.cfg	/boot/burg/burg.cfg
	/grub.conf	/grub/grub.conf	/boot/grub/grub.conf	/grub2/grub.conf	/boot/grub2/grub.conf
	/ubuntu/disks/boot/grub/menu.lst	/ubuntu/disks/install/boot/grub/menu.lst	/ubuntu/winboot/menu.lst
	/boot.ini	/BOOT.INI
	/etc/fstab
	/etc/lilo.conf	/lilo.conf
	/syslinux.cfg	/syslinux/syslinux.cfg	/boot/syslinux/syslinux.cfg
	/extlinux.conf	/extlinux/extlinux.conf	/boot/extlinux/extlinux.conf
	/grldr		/grub.exe
	'

Boot_Files_Fat='
	/menu.lst	/grub/menu.lst	/boot/grub/menu.lst	/NST/menu.lst
	/grub.cfg	/grub/grub.cfg	/boot/grub/grub.cfg	/grub2/grub.cfg	/boot/grub2/grub.cfg
	/burg.cfg	/burg/burg.cfg	/boot/burg/burg.cfg
	/grub.conf	/grub/grub.conf	/boot/grub/grub.conf	/grub2/grub.conf	/boot/grub2/grub.conf
	/ubuntu/disks/boot/grub/menu.lst	/ubuntu/disks/install/boot/grub/menu.lst	/ubuntu/winboot/menu.lst
	/boot.ini
	/freeldr.ini
	/etc/fstab
	/etc/lilo.conf	/lilo.conf
	/syslinux.cfg	/syslinux/syslinux.cfg	/boot/syslinux/syslinux.cfg
	/extlinux.conf	/extlinux/extlinux.conf	/boot/extlinux/extlinux.conf
	/grldr		/grub.exe
	'


## List of files whose end point (in GiB / GB) will be displayed. ##

GrubError18_Files='
	menu.lst	grub/menu.lst	boot/grub/menu.lst	NST/menu.lst
	ubuntu/disks/boot/grub/menu.lst
	grub.conf	grub/grub.conf	boot/grub/grub.conf	grub2/grub.conf	boot/grub2/grub.conf
	grub.cfg	grub/grub.cfg	boot/grub/grub.cfg	grub2/grub.cfg	boot/grub2/grub.cfg
	burg.cfg	burg/burg.cfg	boot/burg/burg.cfg
	core.img	grub/core.img	boot/grub/core.img	grub2/core.img	boot/grub2/core.img
	burg/core.img	boot/burg/core.img
	stage2		grub/stage2	boot/grub/stage2
	boot/vmlinuz*	vmlinuz*	ubuntu/disks/boot/vmlinuz*
	boot/initrd*	initrd*		ubuntu/disks/boot/initrd*
	boot/kernel*.img
	initramfs*	boot/initramfs*
	'

SyslinuxError_Files='
	syslinux.cfg	syslinux/syslinux.cfg	boot/syslinux/syslinux.cfg
	extlinux.conf	extlinux/extlinux.conf	boot/extlinux/extlinux.conf
	ldlinux.sys	syslinux/ldlinux.sys	boot/syslinux/ldlinux.sys
	extlinux.sys	extlinux/extlinux.sys	boot/extlinux/extlinux.sys
	*.c32		syslinux/*.c32			boot/syslinux/*.c32
	extlinux/*.c32	boot/extlinux/*.c32
	'



## Set output filename ##

if [ ${stdout_output} -eq 1 ] ; then
  # The LogFile name is not used when --stdout is specified.
  LogFile="";
elif ( [ ! -z "${LogFile_cmd}" ]) ; then
  # The RESULTS filename is specified on the commandline.
  LogFile=$(basename "${LogFile_cmd}");

  # Directory where the RESULTS file will be stored.
  Dir=$(dirname "${LogFile_cmd}");
  
  # Check if directory exists.
  if [ ! -d "${Dir}" ] ; then
     echo "The directory \"${Dir}\" does not exist.";
     echo 'Create the directory or specify another path for the output file.';
     exit 1;
  fi

  Dir=$(cd "${Dir}"; pwd);
  LogFile="${Dir}/${LogFile}";
else
  # Directory containing this script.
  Dir=$(cd "$(dirname "$0")"; pwd);

  # Set ${Dir} to the home folder of the current user if the script is
  # in one of the system folders.
  # This allows placement of the script in /bin, /sbin, /usr/bin, ...
  # while still having a normal location to write the output file to.

  for systemdir in /bin /boot /cdrom /dev /etc /lib /lost+found /opt /proc /sbin /selinux /srv /sys /usr /var; do
    if [ $(expr "${Dir}" : ${systemdir}) -ne 0 ] ; then
       Dir="${HOME}";
       break;
    fi
  done

  # To avoid overwriting existing files, look for a non-existing file:
  # RESULT.txt, RESULTS1.txt, RESULTS2.txt, ... 

  LogFile="${Dir}/RESULTS";

  while ( [ -e "${LogFile}${j}.txt" ] ) ; do
    if [ x"${j}" = x'' ]; then
       j=0;
    fi
    j=$((${j}+1));
    wait;
  done

  LogFile="${LogFile}${j}.txt";  ## The RESULTS file. ##
fi



## Redirect stdout to RESULT File ##
#
#   exec 6>&1   
#   exec > "${LogFile}"



## Create temporary directory ##

Folder=$(mktemp -t -d BootInfo-XXXXXXXX);



## Create temporary filenames. ##

cd ${Folder}
Log=${Folder}/Log				# File to record the summary.
Log1=${Folder}/Log1				# Most of the information which is not part of
						# the summary is recorded in this file.
Error_Log=${Folder}/Error_Log			# File to catch all unusal Standar Errors.
Trash=${Folder}/Trash				# File to catch all usual Standard Errors these
						# messagges will not be included in the RESULTS.
Mount_Error=${Folder}/Mount_Error		# File to catch Mounting Errors.
Unknown_MBR=${Folder}/Unknown_MBR		# File to record all unknown MBR and Boot sectors.
Tmp_Log=${Folder}/Tmp_Log			# File to temporarily hold some information.
core_img_file=${Folder}/core_img		# File to temporarily store an embedded core.img of grub2.
core_img_file_unlzma=${Folder}/core_img_unlzma	# File to temporarily store the uncompressed part of core.img of grub2.
PartitionTable=${Folder}/PT			# File to store the Partition Table.
FakeHardDrives=${Folder}/FakeHD			# File to list devices which seem to have  no corresponding drive.
BLKID=${Folder}/BLKID				# File to store the output of blkid.



## Redirect all standard error to the file Error_Log. ##

exec 2> ${Error_Log};



## List of all hard drives ##
#
#   Support more than 26 drives.

All_Hard_Drives=$(ls /dev/hd[a-z] /dev/hd[a-z][a-z] /dev/sd[a-z] /dev/sd[a-z][a-z] 2>> ${Trash});


## Add found RAID disks to list of hard drives. ##

if [ $(type dmraid >> ${Trash} 2>> ${Trash} ; echo $?) -eq 0 ] ; then
  InActiveDMRaid=$(dmraid -si -c);

  if [ x"${InActiveDMRaid}" = x"no raid disks" ] ; then 
     InActiveDMRaid='';
  fi

  if [ x"${InActiveDMRaid}" != x'' ] ; then
     dmraid -ay ${InActiveDMRaid} >> ${Trash};
  fi

  if [ x"$(dmraid -sa -c)" != x"no raid disks" ] ; then
     All_DMRaid=$(dmraid -sa -c | ${AWK} '{ print "/dev/mapper/"$0 }');
     All_Hard_Drives="${All_Hard_Drives} ${All_DMRaid}";
  fi  
fi



## Arrays to hold information about Partitions: ##
#
#   name, starting sector, ending sector, size in sector, partition type,
#   filesystem type, UUID, kind(Logical, Primary, Extended), harddrive,
#   boot flag,  parent (for logical partitions), label,
#   system(the partition id according the partition table),
#   the device associated with the partition.

declare -a NamesArray StartArray EndArray SizeArray TypeArray  FileArray UUIDArray KindArray DriveArray BootArray ParentArray LabelArray SystemArray DeviceArray;


## Arrays to hold information about the harddrives. ##

declare -a HDName FirstPartion LastPartition HDSize HDMBR HDHead HDTrack HDCylinder HDPT HDStart HDEnd HDUUID;


## Array for hard drives formatted as filesystem. ##

declare -a FilesystemDrives;



PI=-1;  ## Counter for the identification number of a partition.   (each partition gets unique number)   ##
HI=0;   ## Counter for the identification number of a hard drive.  (each hard drive gets unique number)  ##
PTFormat='%-10s %4s%14s%14s%14s %3s %s\n';	## standard format (hexdump) to use for partition table. ##



## Get total number of blocks on a device. ##
#
#   Sometimes "fdisk -s" seems to malfunction or isn't supported (busybox fdisk),
#   so use "sfdisk -s" if available.
#   If sfdisk isn't available, calculate the number of blocks from the number of
#   sectors (divide by 2).

fdisks () {
  if [ $(type sfdisk >> ${Trash} 2>> ${Trash} ; echo $?) -eq 0 ] ; then
     sfdisk -s "$1" 2>> ${Trash};
  else
     # Calculate the number of blocks from the number of sectors (divide by 2).
     fdisk -lu "$1" 2>> ${Trash} | awk '$0 ~ /, .*, .*, .*/ { print $(NF - 1) / 2 }';
  fi
}
   


##  A function which checks whether a file is on a mounted partition. ##

# List of mount points for devices: also allow mount points with spaces.

MountPoints=$(mount \
	      | ${AWK} -F "${TAB}" '{ if ( ($1 ~ "^/dev") && ($3 != "/") ) { sub(" on ", "\t", $0); sub(" type ", "\t", $0); print $2 } }' \
	      | sort -u);


FileNotMounted () {	
  local File=$1 curmp=$2;

  IFS_OLD="${IFS}";  # Save original IFS.
  IFS=$'\012';       # Set IFS temporarily to newline only, so mount points with spaces can be processed too.

  for mp in ${MountPoints}; do 
    if [ $(expr match "${File}" "${mp}/" ) -ne 0 ] && [ "${mp}" != "${curmp}" ] ; then
       IFS="${IFS_OLD}";  # Restore original IFS.
       return 1;
    fi
  done

  IFS="${IFS_OLD}";       # Restore original IFS.
  return 0;
}



## Function which converts the two digit hexcode to the partition type. ##
#
#   The following list is taken from sfdisk -T and 
#   http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
#   is work in progress.

HexToSystem () {
  local type=$1 system;

  case ${type} in
    0)  system='Empty';;
    1)  system='FAT12';;
    2)  system='XENIX root';;
    3)  system='XENIX /usr';;
    4)  system='FAT16 <32M';;
    5)  system='Extended';;
    6)  system='FAT16';;
    7)  system='NTFS / exFAT / HPFS';;
    8)  system='AIX bootable';;
    9)  system='AIX data';;
    a)  system='OS/2 Boot Manager';;
    b)  system='W95 FAT32';;
    c)  system='W95 FAT32 (LBA)';;
    e)  system='W95 FAT16 (LBA)';;
    f)  system='W95 Extended (LBA)';;
    10) system='OPUS';;
    11) system='Hidden FAT12';;
    12) system='Compaq diagnostics';;
    14) system='Hidden FAT16 < 32M';;
    16) system='Hidden FAT16';;
    17) system='Hidden NTFS / HPFS';;
    18) system='AST SmartSleep';;
    1b) system='Hidden W95 FAT32';;
    1c) system='Hidden W95 FAT32 (LBA)';;
    1e) system='Hidden W95 FAT16 (LBA)';;
    24) system='NEC DOS';;
    27) system='Hidden NTFS (Recovery Environment)';;
    2a) system='AtheOS File System';;
    2b) system='SyllableSecure';;
    32) system='NOS';;
    35) system='JFS on OS/2';;
    38) system='THEOS';;
    39) system='Plan 9';;
    3a) system='THEOS';;
    3b) system='THEOS Extended';;
    3c) system='PartitionMagic recovery';;
    3d) system='Hidden NetWare';;
    40) system='Venix 80286';;
    41) system='PPC PReP Boot';;
    42) system='SFS';;
    44) system='GoBack';;
    45) system='Boot-US boot manager';;
    4d) system='QNX4.x';;
    4e) system='QNX4.x 2nd part';;
    4f) system='QNX4.x 3rd part';;
    50) system='OnTrack DM';;
    51) system='OnTrack DM6 Aux1';;
    52) system='CP/M';;
    53) system='OnTrack DM6 Aux3';;
    54) system='OnTrack DM6 DDO';;
    55) system='EZ-Drive';;
    56) system='Golden Bow';;
    57) system='DrivePro';;
    5c) system='Priam Edisk';;
    61) system='SpeedStor';;
    63) system='GNU HURD or SysV';;
    64) system='Novell Netware 286';;
    65) system='Novell Netware 386';;
    70) system='DiskSecure Multi-Boot';;
    74) system='Scramdisk';;
    75) system='IBM PC/IX';;
    78) system='XOSL filesystem';;
    80) system='Old Minix';;
    81) system='Minix / old Linux';;
    82) system='Linux swap / Solaris';;
    83) system='Linux';;
    84) system='OS/2 hidden C: drive';;
    85) system='Linux extended';;
    86) system='NTFS volume set';;
    87) system='NTFS volume set';;
    88) system='Linux plaintext';;
    8a) system='Linux Kernel (AiR-BOOT)';;
    8d) system='Free FDISK hidden Primary FAT12';;
    8e) system='Linux LVM';;
    90) system='Free FDISK hidden Primary FAT16 <32M';;
    91) system='Free FDISK hidden Extended';;
    92) system='Free FDISK hidden Primary FAT16';;
    93) system='Amoeba/Accidently Hidden Linux';;
    94) system='Amoeba bad block table';;
    97) system='Free FDISK hidden Primary FAT32';;
    98) system='Free FDISK hidden Primary FAT32 (LBA)';;
    9a) system='Free FDISK hidden Primary FAT16 (LBA)';;
    9b) system='Free FDISK hidden Extended (LBA)';;
    9f) system='BSD/OS';;
    a0) system='IBM Thinkpad hibernation';;
    a1) system='Laptop hibernation';;
    a5) system='FreeBSD';;
    a6) system='OpenBSD';;
    a7) system='NeXTSTEP';;
    a8) system='Darwin UFS';;
    a9) system='NetBSD';;
    ab) system='Darwin boot';;
    af) system='HFS / HFS+';;
    b0) system='BootStar';;
    b1 | b3) system='SpeedStor / QNX Neutrino Power-Safe';;
    b2) system='QNX Neutrino Power-Safe';;
    b4 | b6) system='SpeedStor';; 
    b7) system='BSDI fs';;
    b8) system='BSDI swap';;
    bb) system='Boot Wizard hidden';;
    bc) system='Acronis BackUp';;
    be) system='Solaris boot';;
    bf) system='Solaris';;
    c0) system='CTOS';;
    c1) system='DRDOS / secured (FAT-12)';;
    c2) system='Hidden Linux (PowerBoot)';;
    c3) system='Hidden Linux Swap (PowerBoot)';;
    c4) system='DRDOS secured FAT16 < 32M';;
    c5) system='DRDOS secured Extended';;
    c6) system='DRDOS secured FAT16';;
    c7) system='Syrinx';;
    cb) system='DR-DOS secured FAT32 (CHS)';;
    cc) system='DR-DOS secured FAT32 (LBA)';;
    cd) system='CTOS Memdump?';;
    ce) system='DR-DOS FAT16X (LBA)';;
    cf) system='DR-DOS secured EXT DOS (LBA)';;
    d0) system='REAL/32 secure big partition';;
    da) system='Non-FS data / Powercopy Backup';;
    db) system='CP/M / CTOS / ...';;
    dd) system='Dell Media Direct';;
    de) system='Dell Utility';;
    df) system='BootIt';;
    e1) system='DOS access';;
    e3) system='DOS R/O';;
    e4) system='SpeedStor';;
    e8) system='LUKS';;
    eb) system='BeOS BFS';;
    ec) system='SkyOS';;
    ee) system='GPT';;
    ef) system='EFI (FAT-12/16/32)';;
    f0) system='Linux/PA-RISC boot';;
    f1) system='SpeedStor';;
    f2) system='DOS secondary';;
    f4) system='SpeedStor';;
    fb) system='VMware VMFS';;
    fc) system='VMware VMswap';;
    fd) system='Linux raid autodetect';;
    fe) system='LANstep';;
    ff) system='Xenix Bad Block Table';;
     *) system='Unknown';;
  esac

  echo "${system}";
}



## Function to convert GPT's Partition Type. ##
#
#   List from http://en.wikipedia.org/wiki/GUID_Partition_Table#Partition_type_GUIDs
#
#   ABCDEFGH-IJKL-MNOP-QRST-UVWXYZabcdef is stored as
#   GHEFCDAB-KLIJ-OPMN-QRST-UVWXYZabcdef (without the dashes)
#
#   For easy generation of the following list:
#    - Save list in a file "Partition_type_GUIDs.txt" in the folowing format: 
#
#	 Partition Type (OS) <TAB> GUID
#	 Partition Type (OS) <TAB> GUID
#	 Partition Type (OS) <TAB> GUID
#
#    - Then run the following:
#
#	 gawk -F '\t' '{ GUID=tolower($2); printf "    %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s)  system=\"%s\";;\n", substr(GUID,7,1), substr(GUID,8,1), substr(GUID,5,1), substr(GUID,6,1), substr(GUID,3,1), substr(GUID,4,1), substr(GUID,1,1), substr(GUID,2,1), substr(GUID,12,1), substr(GUID,13,1), substr(GUID,10,1), substr(GUID,11,1), substr(GUID,17,1), substr(GUID,18,1), substr(GUID,15,1), substr(GUID,16,1), substr(GUID,20,4), substr(GUID,25,12), $1 } END { print "				   *)  system='-';" }' Partition_type_GUIDs.txt
#
#    - Some GUIDs are not unique for one OS. To find them, you can run:
#
#	 gawk -F "\t" '{print $2}' GUID_Partition_Table_list.txt | sort | uniq -d | grep -f - GUID_Partition_Table_list.txt
#
#		Basic data partition (Windows)	EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
#		Data partition (Linux)		EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
#		ZFS (Mac OS X)			6A898CC3-1DD2-11B2-99A6-080020736631
#		/usr partition (Solaris)	6A898CC3-1DD2-11B2-99A6-080020736631
#

UUIDToSystem () {
  local type=$1 system;

  case ${type} in
    00000000000000000000000000000000)  system='Unused entry';;
    41ee4d02e733d3119d690008c781f39f)  system='MBR partition scheme';;
    28732ac11ff8d211ba4b00a0c93ec93b)  system='EFI System partition';;
    4861682149646f6e744e656564454649)  system='BIOS Boot partition';;

    ## GUIDs that are not unique for one OS ##
    a2a0d0ebe5b9334487c068b6b72699c7)  system='Data partition (Windows/Linux)';;
    c38c896ad21db21199a6080020736631)  system='ZFS (Mac OS X) or /usr partition (Solaris)';;
    
    ## Windows GUIDs ##
    16e3c9e35c0bb84d817df92df00215ae)  system='Microsoft Reserved Partition (Windows)';;
    # Same GUID as old GUID for "Basic data partition (Linux)"
  # a2a0d0ebe5b9334487c068b6b72699c7)  system='Basic data partition (Windows)';;
    aac808588f7ee04285d2e1e90434cfb3)  system='Logical Disk Manager metadata partition (Windows)';;
    a0609baf3114624fbc683311714a69ad)  system='Logical Disk Manager data partition (Windows)';;
    a4bb94ded106404da16abfd50179d6ac)  system='Windows Recovery Environment (Windows)';;
    90fcaf377def964e91c32d7ae055b174)  system='IBM General Parallel File System (GPFS) partition (Windows)';;

    ## HP-UX GUIDs ##
    1e4c8975eb3ad311b7c17b03a0000000)  system='Data partition (HP-UX)';;
    28e7a1e2e332d611a6827b03a0000000)  system='Service Partition (HP-UX)';;

    ## Linux GUIDs ##
    # Same GUID as "Basic data partition (Windows)" GUID
  # a2a0d0ebe5b9334487c068b6b72699c7)  system='Data partition (Linux)';;
    # New GUID to avoid that Linux partitions show up as unformatted partitions in Windows.
    af3dc60f838472478e793d69d8477de4)  system='Data partition (Linux)';;  
    0f889da1fc053b4da006743f0f84911e)  system='RAID partition (Linux)';;
    6dfd5706aba4c44384e50933c84b4f4f)  system='Swap partition (Linux)';;
    79d3d6e607f5c244a23c238f2a3df928)  system='Logical Volume Manager (LVM) partition (Linux)';;
    3933a68d0700c060c436083ac8230908)  system='Reserved (Linux)';;

    ## FreeBSD GUIDs ##
    9d6bbd83417fdc11be0b001560b84f0f)  system='Boot partition (FreeBSD)';;
    b47c6e51cf6ed6118ff800022d09712b)  system='Data partition (FreeBSD)';;
    b57c6e51cf6ed6118ff800022d09712b)  system='Swap partition (FreeBSD)';;
    b67c6e51cf6ed6118ff800022d09712b)  system='Unix File System (UFS) partition (FreeBSD)';;
    b87c6e51cf6ed6118ff800022d09712b)  system='Vinum volume manager partition (FreeBSD)';;
    ba7c6e51cf6ed6118ff800022d09712b)  system='ZFS partition (FreeBSD)';;

    ## Mac OS X GUIDs ##
    005346480000aa11aa1100306543ecac)  system='Hierarchical File System Plus (HFS+) partition (Mac OS X)';;
    005346550000aa11aa1100306543ecac)  system='Apple UFS (Mac OS X)';;
  # c38c896ad21db21199a6080020736631)  system='ZFS (Mac OS X)';;
    444941520000aa11aa1100306543ecac)  system='Apple RAID partition (Mac OS X)';;
    444941524f5faa11aa1100306543ecac)  system='Apple RAID partition offline (Mac OS X)';;
    746f6f420000aa11aa1100306543ecac)  system='Apple Boot partition (Mac OS X)';;
    6562614c006caa11aa1100306543ecac)  system='Apple Label (Mac OS X)';;
    6f6365526576aa11aa1100306543ecac)  system='Apple TV Recovery partition (Mac OS X)';;

    ## Solaris GUIDs ##
    45cb826ad21db21199a6080020736631)  system='Boot partition (Solaris)';;
    4dcf856ad21db21199a6080020736631)  system='Root partition (Solaris)';;
    6fc4876ad21db21199a6080020736631)  system='Swap partition (Solaris)';;
    2b648b6ad21db21199a6080020736631)  system='Backup partition (Solaris)';;
  # c38c896ad21db21199a6080020736631)  system='/usr partition (Solaris)';;
    e9f28e6ad21db21199a6080020736631)  system='/var partition (Solaris)';;
    39ba906ad21db21199a6080020736631)  system='/home partition (Solaris)';;
    a583926ad21db21199a6080020736631)  system='Alternate sector (Solaris)';;
    3b5a946ad21db21199a6080020736631)  system='Reserved partition (Solaris)';;
    d130966ad21db21199a6080020736631)  system='Reserved partition (Solaris)';;
    6707986ad21db21199a6080020736631)  system='Reserved partition (Solaris)';;
    7f23966ad21db21199a6080020736631)  system='Reserved partition (Solaris)';;
    c72a8d6ad21db21199a6080020736631)  system='Reserved partition (Solaris)';;

    ## NetBSD GUIDs ##
    328df4490eb1dc11b99b0019d1879648)  system='Swap partition (NetBSD)';;
    5a8df4490eb1dc11b99b0019d1879648)  system='FFS partition (NetBSD)';;
    828df4490eb1dc11b99b0019d1879648)  system='LFS partition (NetBSD)';;
    aa8df4490eb1dc11b99b0019d1879648)  system='RAID partition (NetBSD)';;
    c419b52d0fb1dc11b99b0019d1879648)  system='Concatenated partition (NetBSD)';;
    ec19b52d0fb1dc11b99b0019d1879648)  system='Encrypted partition (NetBSD)';;

    ## ChromeOS GUIDs ##
    5d2a3afe324fa741b725accc3285a309)  system="ChromeOS kernel";;
    02e2b83c7e3bdd478a3c7ff2a13cfcec)  system="ChromeOS rootfs";;
    3d750a2e489eb0438337b15192cb1b5e)  system="ChromeOS future use";;

				   *)  system='-';
				       echo 'Unknown GPT Partiton Type' >> ${Unknown_MBR};
				       echo  ${type} >> ${Unknown_MBR};;   
  esac

  echo "${system}";
}



## Function which inserts a comma every third digit of a number. ##

InsertComma () {
  echo $1 | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta';
}



## Function to read 4 bytes starting at $1 of device $2 and convert result to decimal. ##

Read4Bytes () {
  local start=$1 device=$2;

  echo $(hexdump -v -s ${start} -n 4 -e '4 "%u"' ${device});
}



## Function to read 8 bytes starting at $1 of device $2 and convert result to decimal. ##

Read8Bytes () {
  local start=$1 device=$2;
  local first4 second4;

  # Get ${first4} and ${second4} bytes at once.
  eval $(hexdump -v -s ${start} -n 8 -e '1/4 "first4=%u; " 1/4 "second4=%u"' ${device});

  echo $(( ${second4} * 1073741824 + ${first4} ));
}



## Functions to pretty print blkid output. ##

BlkidFormat='%-16s %-38s %-10s %s\n';

BlkidTag () {
  echo $(blkid -s $2 -o value $1 2>> ${Trash});
}



PrintBlkid () {
  local part=$1 suffix=$2;

  if [ x"$(blkid ${part} 2> ${Tmp_Log})" != x'' ] ; then
     printf "${BlkidFormat}" "${part}" "$(BlkidTag ${part} UUID)" "$(BlkidTag ${part} TYPE)" "$(BlkidTag ${part} LABEL)" >> ${BLKID}${suffix};
  else
     # blkid -p is not available on all systems.
     # This contructs makes sure the "usage" message is not displayed, but catches the "ambivalent" error.
     blkid -p "${part}" 2>&1 | grep "^${part}" >> ${BLKID}${suffix};
  fi
}



## Read and display the partition table and check the partition table for errors. ##
#
#   This function can be applied iteratively so extended partiton tables can also be processed.
#
#   Function arguments:
#
#   - arg 1: HI         = HI of hard drive
#   - arg 2: StartEx    = start sector of the extended Partition
#   - arg 3: N          = number of partitions in table (4 for regular PT, 2 for logical
#   - arg 4: PT_file    = file for storing the partition table
#   - arg 5: format     = display format to use for displaying the partition table
#   - arg 6: EPI        = PI of the primary extended partition containing the extended partition.
#                         ( equals ""  for hard drive)
#   - arg 7: LinuxIndex = Last linux index assigned (the number in sdXY).

ReadPT () {
  local HI=$1 StartEx=$2 N=$3 PT_file=$4 format=$5 EPI=$6 Base_Sector;
  local LinuxIndex=$7 boot size start end type drive system;
  local i=0 boot_hex label limit MBRSig;

  drive=${HDName[${HI}]};
  limit=${HDSize[${HI}]};

  dd if=${drive} skip=${StartEx} of=${Tmp_Log} count=1 2>> ${Trash};

  MBRSig=$(hexdump -v -s 510 -n 2 -e '"%04x"' ${Tmp_Log});

  [[ "${MBRSig}" != 'aa55' ]] && echo 'Invalid MBR Signature found.' >> ${PT_file};

  if [[ ${StartEx} -lt ${limit} ]] ; then
     # set Base_Sector to 0 for hard drive, and to the start sector of the
     # primary extended partition otherwise.
     [[ x"${EPI}" = x'' ]] && Base_Sector=0 || Base_Sector=${StartArray[${EPI}]};

     for (( i=0; i < N; i++ )) ; do
       dd if=${drive} skip=${StartEx} of=${Tmp_Log} count=1 2>> ${Trash};

       boot_hex=$(hexdump -v -s $((446+16*${i})) -n 1 -e '"%02x"' ${Tmp_Log});

       case ${boot_hex} in
		00) boot=' ';;
		80) boot='* ';;
		 *) boot='?';;
       esac

       # Get amd set: partition type, partition start, and partition size.
       eval $(hexdump -v -s $((450+16*${i})) -n 12 -e '1/1 "type=%x; " 3/1 "tmp=%x; " 1/4 "start=%u; " 1/4 "size=%u"' ${Tmp_Log});

       if [[ ${size} -ne 0 ]] ; then
	  if ( ( [ "${type}" = '5' ] || [ "${type}" = 'f' ] ) && [ ${Base_Sector} -ne 0 ] ) ; then
	     # start sector of an extended partition is relative to the
	     # start sector of an primary extended partition.
	     start=$((${start}+${Base_Sector}));

	     if [[ ${i} -eq 0 ]] ; then
	        echo 'Extended partition linking to another extended partition.' >> ${PT_file};
	     fi

	     ReadPT ${HI} ${start} 2 ${PT_file} "${format}" ${EPI} ${LinuxIndex};
	  else  
	     ((PI++));

	     if [[ "${type}" = '5' || "${type}" = 'f' ]] ; then
	        KindArray[${PI}]='E';
	     else
	        # Start sector of a logical partition is relative to the
	        # start sector of directly assocated extented partition.
	        start=$((${start}+${StartEx}));
	        [[ ${Base_Sector} -eq 0 ]] && KindArray[${PI}]='P' || KindArray[${PI}]='L';
	     fi

	     LinuxIndex=$((${LinuxIndex}+1));
	     end=$((${start}+${size}-1));

	     [[ "${HDPT[${HI}]}" = 'BootIt' ]] && label="${NamesArray[${EPI}]}_" || label=${drive};

	     system=$(HexToSystem ${type});

	     printf "${format}" "${label}${LinuxIndex}" "${boot}" $(InsertComma ${start}) "$(InsertComma ${end})" "$(InsertComma ${size})" "${type}" "${system}" >> ${PT_file};

	     NamesArray[${PI}]="${label}${LinuxIndex}";
	     StartArray[${PI}]=${start};
	     EndArray[${PI}]=${end};
	     TypeArray[${PI}]=${type};
	     SystemArray[${PI}]="${system}";
	     SizeArray[${PI}]=${size};
	     BootArray[${PI}]="${boot}";
	     DriveArray[${PI}]=${HI};
	     ParentArray[${PI}]=${EPI};

             ( [[ x"${EPI}" = x'' ]] || [[ x"${DeviceArray[${EPI}]}" != x'' ]] ) && DeviceArray[${PI}]=${drive}${LinuxIndex};

	     if [[ "${type}" = '5' || "${type}" = 'f' ]] ; then
	        ReadPT ${HI} ${start} 2 ${PT_file} "${format}" ${PI} 4;
	     fi
	  fi
       
       elif ( [ ${Base_Sector} -ne 0 ]  && [ ${i} -eq 0 ] ) ; then
	  echo 'Empty Partition.' >> ${PT_file};
       else 
	  LinuxIndex=$((${LinuxIndex}+1));
       fi
     done
  else
    echo 'EBR refers to a location outside the hard drive.' >> ${PT_file};
  fi
}



## Read the GPT partition table (GUID, EFI) ##
#
#   Function arguments:
#
#   - arg 1: HI       = HI of hard drive
#   - arg 2: GPT_file = file for storing the GPT partition table

ReadEFI () {
  local HI=$1 GPT_file=$2 drive size N=0 i=0 format label PRStart start end type size system;

  drive="${HDName[${HI}]}";
  format='%-10s %14s%14s%14s %s\n';

  printf "${format}" 'Partition' 'Start Sector' 'End Sector' '# of Sectors' 'System' >> ${GPT_file};

  HDStart[${HI}]=$( Read8Bytes 552 ${drive});
  HDEnd[${HI}]=$(   Read8Bytes 560 ${drive});
  HDUUID[${HI}]=$(  hexdump -v -s 568 -n 16 -e '/1 "%02x"' ${drive});
  PRStart=$(        Read8Bytes 584 ${drive});
  N=$(              Read4Bytes 592 ${drive});
  PRStart=$((       ${PRStart}*512));
  PRSize=$(         Read4Bytes 596 ${drive});

  for (( i = 0; i < N; i++ )) ; do
    type=$(hexdump -v -s $((${PRStart}+${PRSize}*${i})) -n 16 -e '/1 "%02x"' ${drive});

    if [ "${type}" != '00000000000000000000000000000000' ] ; then
       ((PI++));

       start=$(Read8Bytes $((${PRStart}+32+${PRSize}*${i})) ${drive});
       end=$(  Read8Bytes $((${PRStart}+40+${PRSize}*${i})) ${drive});

       size=$((${end}-${start}+1));
       system=$(UUIDToSystem ${type});
       label=${drive}$((${i}+1));

       printf "${format}" "${label}" "$(InsertComma ${start})" "$(InsertComma ${end})" "$(InsertComma ${size})" "${system}"  >> ${GPT_file};

       NamesArray[${PI}]=${label};
       DeviceArray[${PI}]=${label};
       StartArray[${PI}]=${start};
       TypeArray[${PI}]=${type};
       SizeArray[${PI}]=${size};
       SystemArray[${PI}]=${system};
       EndArray[${PI}]=${end};
       DriveArray[${PI}]=${HI};
       KindArray[${PI}]='P';
       ParentArray[${PI}]='';
    fi
  done
}



## Read the Master Partition Table of BootIt NG. ##
#
#   Function arguments:
#
#   - arg 1: HI       = HI of hard drive
#   - arg 2: MPT_file = file for storing the MPT

ReadEMBR () {
  local HI=$1 MPT_file=$2 drive size N=0 i=0 BINGIndex label start end type format;
  local BINGUnknown system StoredPI FirstPI=${FirstPartition[$1]} LastPI=${PI} New;

  drive="${HDName[${HI}]}";
  format='%-18s %4s%14s%14s%14s %3s %-15s %3s %2s\n';

  printf "${format}" 'Partition' 'Boot' 'Start Sector' 'End Sector' '# of Sectors' 'Id' 'System' 'Ind' '?' >> ${MPT_file};

  N=$(hexdump -v -s 534 -n 1 -e '"%u"' ${drive});

  for (( i = 0;  i < N; i++ )) ; do
    New=1;
    BINGUnknown=$(hexdump -v -s $((541+28*${i})) -n 1 -e '"%x"' ${drive});
    start=$(      hexdump -v -s $((542+28*${i})) -n 4 -e '4 "%u"' ${drive});
    end=$(        hexdump -v -s $((546+28*${i})) -n 4 -e '4 "%u"' ${drive});
    BINGIndex=$(  hexdump -v -s $((550+28*${i})) -n 1 -e '"%u"' ${drive});
    type=$(       hexdump -v -s $((551+28*${i})) -n 1 -e '"%x"' ${drive});
    size=$((      ${end}-${start}+1));
    label=$(      hexdump -v -s $((552+28*${i})) -n 15 -e '"%_u"' ${drive}| sed -e 's/nul[^$]*//');
    system=$(     HexToSystem ${type});

    printf "${format}" "${label}" "-" "$(InsertComma ${start})" "$(InsertComma ${end})" "$(InsertComma ${size})" "${type}" "${system}" "${BINGIndex}" "${BINGUnknown}" >> ${MPT_file};

    StoredPI=${PI};

    for (( j = FirstPI; j <= LastPI; j++ )); do
      if (( ${StartArray[${j}]} == ${start} )) ; then 
	 PI=${j};
	 New=0;
	 break;
      fi
    done
     
    if [ ${New} -eq 1 ] ; then
       ((PI++));
       StoredPI=${PI};
       StartArray[${PI}]=${start};
       TypeArray[${PI}]=${type};
       SizeArray[${PI}]=${size};
       SystemArray[${PI}]=${system};
       EndArray[${PI}]=${end};
       DriveArray[${PI}]=${HI};
    fi

    NamesArray[${PI}]=${label};
  
    if ( [ ${type} = 'f' ] || [ ${type} = '5' ] ) ; then
       KindArray[${PI}]='E';
       ParentArray[${PI}]=${PI};
       ReadPT ${HI} ${start} 2 ${MPT_file} "${format}" ${PI} 4;  
    else
       KindArray[${PI}]='P';
       ParentArray[${PI}]='';
    fi

    PI=${StoredPI};

  done
}



## Check partition table for errors. ##
#
#  This function checks whether:
#    - there are any overlapping partitions
#    - the logical partitions are inside the extended partition
#
#   Function arguments:
#
#   - arg 1: PI_first  = PI of first partition to consider
#   - arg 2: PI_last   = PI of last partition to consider
#   - arg 3: CHK_file  = file for the error messages
#   - arg 4: HI        = HI of containing hard drive

CheckPT () {
  local PI_first=$1 PI_last=$2 CHK_file=$3 HI=$4;
  local Si Ei Sj Ej Ki Kj i j k cyl track head cyl_bound sec_bound;

  cyl=${HDCylinder[${HI}]};
  track=${HDTrack[${HI}]};
  head=${HDHead[${HI}]};
  cyl_bound=$((cyl * track * head));
  sec_bound=${HDSize[${HI}]};

  for (( i = PI_first; i <= PI_last; i++ )); do
    Si=${StartArray[${i}]};
    Ei=${EndArray[${i}]};
    Ki=${KindArray[${i}]};
    Ni=${NamesArray[${i}]};

    if [[ "${Ei}" -gt "${sec_bound}" ]] ; then
       echo "${Ni} ends after the last sector of ${HDName[${HI}]}" >> ${CHK_file};
    elif [[ "${Ei}" -gt "${cyl_bound}" ]] ; then
       echo "${Ni} ends after the last cylinder of ${HDName[${HI}]}" >> ${Trash};
    fi

    if [[ ${Ki} = "L" ]] ; then
       k=${ParentArray[${i}]};
       Sk=${StartArray[${k}]};
       Ek=${EndArray[${k}]};
       Nk=${NamesArray[${k}]};
       [[ ${Si} -le ${Sk} || ${Ei} -gt ${Ek} ]] &&  echo "the logical partition ${Ni} is not contained in the extended partition ${Nk}" >> ${CHK_file};
    fi

    for (( j = i+1; j <= PI_last; j++ )); do
      Sj=${StartArray[${j}]};
      Ej=${EndArray[${j}]};
      Kj=${KindArray[${j}]};
      Nj=${NamesArray[${j}]};

      ( !( ( [ "${Ki}" = 'L' ] && [ "${Kj}" = 'E' ] )  || ( [ "${Ki}" = 'E' ] && [ "${Kj}" = 'L' ] ) )  \
	&& ( ( [ "${Si}" -lt "${Sj}" ] && [ "${Sj}" -lt "${Ei}" ] )  || ( [ "${Sj}" -lt "${Si}" ] && [ "${Si}" -lt "${Ej}" ] ) ) )  \
	&& echo "${Ni} overlaps with ${Nj}" >> ${CHK_file};

    done
  done
}



## Syslinux ##
#
#   Determine the exact Syslinux version ("SYSLINUX - version - date"), display
#   the offset to the second stage, check the internal checksum (if not correct,
#   the ldlinux.sys file, probably moved), display the directory to which
#   Syslinux is installed.

syslinux_info () {
  local partition=$1;

  # Magic number used by Syslinux:
  local LDLINUX_MAGIC='fe02b23e';

  local LDLINUX_BSS LDLINUX_SECTOR2 ADV_2SECTORS;
  local sect1ptr0_offset sect1ptr0 sect1ptr1 tmp;
  local magic_offset syslinux_version syslinux_dir;

  # Patch area variables:
  local pa_version pa_size pa_hexdump_format pa_magic pa_instance pa_data_sectors;
  local pa_adv_sectors pa_dwords pa_checksum pa_maxtransfer pa_epaoffset;
  local pa_ldl_sectors pa_dir_inode;

  # Extended patch area variables:
  local epa_size epa_hexdump_format epa_advptroffset epa_diroffset epa_dirlen;
  local epa_subvoloffset epa_subvollen epa_secptroffset epa_secptrcnt;
  local epa_sect1ptr0 epa_sect1ptr1 epa_raidpatch epa_syslinuxbanner;

  # ADV magic numbers:
  local ADV_MAGIC_HEAD='a52f2d5a';		# Head signature
  local ADV_MAGIC_TAIL='64bf28dd';		# Tail signature
  local ADV_MAGIC_CHECKSUM=$((0xa3041767));	# Magic used for calculation ADV checksum

  # ADV variables:
  local ADVoffset ADV_calculated_checksum ADV_read_checksum ADVentry_offset;
  local tag='999' tag_len label;

  local csum;



  # Clear previous Syslinux message string.
  Syslinux_Msg='';

  # Read first 512 bytes of partition and convert to hex (ldlinux.bss)
  LDLINUX_BSS=$(hexdump -v -n512 -e '/1 "%02x"' ${partition});

  # Look for LDLINUX_MAGIC: bytes 504-507
  if [ "${LDLINUX_BSS:1008:8}" = "${LDLINUX_MAGIC}" ] ; then
     # Syslinux 4.04-pre5 and higher.
     pa_version=4;	 # Syslinux 4.xx patch area

     # The offset of Sect1Load in LDLINUX_BSS can be found by doing a
     # bitwise XOR of bytes 508-509 (little endian) with 0x1b << 9.
     # sect1ptr0_offset starts 2 bytes furter than Sect1Load.
     sect1ptr0_offset=$(( ( 0x${LDLINUX_BSS:1018:2}${LDLINUX_BSS:1016:2} ^ ( 0x1b << 9 ) ) + 2 ));

     # Get "boot sector offset" (in sectors) of sector 1 ptr LSW: sect1ptr0
     # Get "boot sector offset" (in sectors) of sector 1 ptr MSW: sect1ptr1
     eval $(hexdump -v -s ${sect1ptr0_offset} -n 10 -e '1/4 "sect1ptr0=%u; " 1/2 "tmp=%u; " 1/4 "sect1ptr1=%u;"' ${partition});

  else
     # Check if bytes 508-509 = "7f00".
     if [ "${LDLINUX_BSS:1016:4}" = '7f00' ] ; then
	# Syslinux 3.xx
	pa_version=3;	 # Syslinux 3.xx patch area

	# Get "boot sector offset" (in sectors) of sector 1 ptr LSW: sect1ptr0
	eval $(hexdump -v -s 504 -n 4 -e '1/4 "sect1ptr0=%u;"' ${partition});
     else
	# Syslinux 4.00 - Syslinux 4.04-pre4.
	pa_version=4;	 # Syslinux 4.xx patch area

	# Search for offset to sect1ptr0 (only found in Syslinux 4.xx)
	#   66 b8 xx xx xx xx 66 ba xx xx xx xx bb 00
	#         [sect1ptr0]       [sect1ptr1]
	#
	# Start searching for this hex string after the DOS superblock: byte 0x5a = 90
	eval $(echo ${LDLINUX_BSS:180:844} \
		| ${AWK} '{ mask_offset=match($0,"66b8........66ba........bb00"); \
		if (mask_offset == "0") { print "sect1ptr0_offset=0;" } \
		else { print "sect1ptr0_offset=" (mask_offset -1 ) / 2 + 2 + 90 } }');

	if [ ${sect1ptr0_offset} -ne 0 ] ; then
	   # Syslinux 4.00 - Syslinux 4.04-pre4.

	   # Get "boot sector offset" (in sectors) of sector 1 ptr LSW: sect1ptr0
	   # Get "boot sector offset" (in sectors) of sector 1 ptr MSW: sect1ptr1
	   eval $(hexdump -v -s ${sect1ptr0_offset} -n 10 -e '1/4 "sect1ptr0=%u; " 1/2 "tmp=%u; " 1/4 "sect1ptr1=%u;"' ${partition});
	else
	   Syslinux_Msg='No evidence that this is realy a Syslinux boot sector.';
	   return;
	fi
     fi
  fi

  Syslinux_Msg="Syslinux looks at sector ${sect1ptr0} of ${partition} for its second stage.";

  # Start reading 0.5MiB (more than enough) from second sector of the Syslinux
  # bootloader (= first sector of ldlinux.sys).
  dd if=${partition} of=${Tmp_Log} skip=${sect1ptr0} count=1000 bs=512 2>> ${Trash};

  # Get second sector of the Syslinux bootloader (= first sector of ldlinux.sys)
  # and convert to hex.
  LDLINUX_SECTOR2=$(hexdump -v -n 512 -e '/1 "%02x"' ${Tmp_Log});

  # Look for LDLINUX_MAGIC (8 bytes aligned) in sector 2 of the Syslinux bootloader.
  for (( magic_offset = $((0x10)); magic_offset < $((0x50)); magic_offset = magic_offset + 8 )); do
    if [ "${LDLINUX_SECTOR2:$(( ${magic_offset} * 2 )):8}" = ${LDLINUX_MAGIC} ] ; then

       if [ ${pa_version} -eq 4 ] ; then
	  # Syslinux 4.xx patch area.

	  # Patch area size: 4+4+2+2+4+4+2+2 = 4*4 + 4*2 = 24 bytes
	  pa_size='24';

	  # Get pa_magic, pa_instance, pa_data_sectors, pa_adv_sectors, pa_dwords, pa_checksum, pa_maxtransfer and pa_epaoffset.
	  pa_hexdump_format='1/4 "pa_magic=0x%04x; " 1/4 "pa_instance=0x%04x; " 1/2 "pa_data_sectors=%u; " 1/2 "pa_adv_sectors=%u; " 1/4 "pa_dwords=0x%u; " 1/4 "pa_checksum=0x%04x; " 1/2 "pa_maxtransfer=%u; " 1/2 "pa_epaoffset=%u;"';

	  eval $(hexdump -v -s ${magic_offset} -n ${pa_size} -e "${pa_hexdump_format}" ${Tmp_Log});

       else
	  # Syslinux 3.xx patch area.

	  # Patch area size: 4+4+2+2+4+4 = 4*4 + 2*2 = 20 bytes
	  pa_size='20';

	  # Get pa_magic, pa_instance, pa_dwords, pa_ldl_sectors and pa_checksum.
	  #  - pa_dwords:	Total dwords starting at ldlinux_sys not including ADVs.
	  #  - pa_ldl_sectors:	Number of sectors - (bootsec + sector2) but including any ADVs.
	  pa_hexdump_format='1/4 "pa_magic=0x%04x; " 1/4 "pa_instance=0x%04x; " 1/2 "pa_dwords=%u; " 1/2 "pa_ldl_sectors=%u; " 1/4 "pa_checksum=0x%04x; " 1/4 "pa_dir_inode=%u;"';

	  eval $(hexdump -v -s ${magic_offset} -n ${pa_size} -e "${pa_hexdump_format}" ${Tmp_Log});

	  # Calulate pa_data_sectors: number of sectors (not including ldlinux.bss = first sector of Syslinux).
	  #  - divide by 128 (128 dwords / 512 byte sector)
	  pa_data_sectors=$(( ${pa_dwords} / 128 ));

	  # If total dwords is not exactly a multiple of 128, round up the number of sectors (add 1).
	  if [ $(( ${pa_dwords}%128 )) -ne 0 ] ; then
	     pa_data_sectors=$(( ${pa_data_sectors} + 1 ));
	  fi


	  # Some Syslinux 4.00-pre?? releases are different:
	  #  - have Syslinux 3.xx signature: bytes 508-509 = "7f00".
	  #  - have the "boot sector offset" (in sectors) of sector 1 ptr LSW (bytes 504-507)
	  #    for sect1ptr0, like Syslinux 3.xx.
	  #  - have like Syslinux 4.xx, the same location for pa_data_sectors.
	  #
	  # If pa_dwords is less than 1024, it contains the value of pa_data_sectors:
	  #  - if less and pa_words would really be pa_words:		ldlinux.sys would be smaller than 4 kiB
	  #  - if more and pa_words would really be pa_data_sectors:	ldlinux.sys would be more than 500 kiB

	  if [ ${pa_dwords} -lt 1024 ] ; then
	     pa_data_sectors=${pa_dwords};
	  fi

       fi       


       # Get the "SYSLINUX - version - date" string.
       syslinux_version=$(hexdump -v -e '"%_p"' -s 2 -n $(( ${magic_offset} - 2 )) ${Tmp_Log});
       syslinux_version="${syslinux_version% \.*}";

       # Overwrite the "boot sector type" variable, which was set before calling this function,
       # with a more exact Syslinux version number.
       BST="${syslinux_version}";


       # Check integrity of Syslinux:
       #  - Checksum starting at ldlinux.sys, stopping before the ADV part.
       #  - checksum start = LDLINUX_MAGIC - [sum of dwords].
       #  - add each dword to the checksum value.
       #  - the value of the checksum after adding all dwords of ldlinux.sys should be 0.

       csum=$(hexdump -v -n $(( ${pa_data_sectors} * 512)) -e '/4 "%u\n"' ${Tmp_Log} \
	    | ${AWK} 'BEGIN { csum=4294967296-1051853566 } { csum=(csum + $1)%4294967296 } END {print csum}' );

       if [ $(expr index "${csum}" 'e') -ne 0 ] ; then
	  # Check if the ${csum} variable contains an 'e'.
	  # "busybox awk" gives values like 3.20611e+09 instead of normal integer numbers.
	  Syslinux_Msg="${Syslinux_Msg} The integrity of Syslinux couldn't be verified (install gawk).";
       elif [ ${csum} -ne 0 ] ; then
	  Syslinux_Msg="${Syslinux_Msg} The integrity check of Syslinux failed.";
	  return;
       fi


       if [ ${pa_version} -eq 4 ] ; then
	  # Extended patch area size: 11*2 = 22 bytes
	  epa_size='22';

	  # Get epa_advptroffset, epa_diroffset, epa_dirlen, epa_subvoloffset, epa_subvollen,
	  # epa_secptroffset, epa_secptrcnt, epa_sect1ptr0, epa_sect1ptr1 and epa_raidpatch.
	  epa_hexdump_format='1/2 "epa_advptroffset=%u; " 1/2 "epa_diroffset=%u; " 1/2 "epa_dirlen=%u; " 1/2 "epa_subvoloffset=%u; " 1/2 "epa_subvollen=%u; " 1/2 "epa_secptroffset=%u; " 1/2 "epa_secptrcnt=%u; " 1/2 "epa_sect1ptr0=%u; " 1/2 "epa_sect1ptr1=%u; " 1/2 "epa_raidpatch=%u; " 1/2 "epa_syslinuxbanner=%u;"';

	  eval $(hexdump -v -s ${pa_epaoffset} -n ${epa_size} -e "${epa_hexdump_format}" ${Tmp_Log});

	  # Get the Syslinux install directory.
	  syslinux_dir=$(hexdump -v -e '"%_p"' -s ${epa_diroffset} -n ${epa_dirlen} ${Tmp_Log});
	  syslinux_dir=${syslinux_dir%%\.*};

	  Syslinux_Msg="${Syslinux_Msg} ${syslinux_version:0:8} is installed in the ${syslinux_dir} directory.";


	  # In Syslinux 4.04 and higher, the whole Syslinux banner is not in the first sector of ldlinux.sys.
	  # Only the "SYSLINUX - version" string is still located in the first sector.
	  # epa_syslinuxbanner points to the whole "SYSLINUX - version - date" string.

	  if [ ${epa_syslinuxbanner} -lt $(( ${pa_data_sectors} * 512 )) ] ; then
	     # Get the "SYSLINUX - version - date" string.
	     tmp=$(hexdump -v -e '"%_p"' -s $(( ${epa_syslinuxbanner} + 2 )) -n 100 ${Tmp_Log});


	     # Check if we have Syslinux 4.04 or higher, which suppport the epa_syslinuxbanner field
	     # by comparing the first 8 bytes ("SYSLINUX") of the Syslinux banner from sector 1 with
	     # the 8 bytes to which epa_syslinuxbanner points.

	     if [ x"${tmp:0:8}" = x"${syslinux_version:0:8}" ] ; then
	        syslinux_version="${tmp%%\.No DEFAULT*}";

	        # Overwrite the "boot sector type" variable, which was set before calling this function,
	        # with a more exact Syslinux version number.
	        BST="${syslinux_version}";
	     fi
	  fi



	  # ADV stuff starts here.

	  if [ ${pa_adv_sectors} -ne 2 ] ; then
	     Syslinux_Msg="${Syslinux_Msg} There are ${pa_adv_sectors} ADV sectors instead of 2.";
	     return;
	  fi

	  # Get the ADV offset.
	  ADVoffset=$(( pa_data_sectors * 512 ));

	  # Get the ADV.
	  ADV_2SECTORS=$(hexdump -v -s ${ADVoffset} -n 1024 -e '/1 "%02x"' ${Tmp_Log});

	  # Check if the 2 ADV sectors are exactly the same.
	  if [ "${ADV_2SECTORS:0:1024}" != "${ADV_2SECTORS:1024:1024}" ] ; then
	     Syslinux_Msg="${Syslinux_Msg} The 2 ADV sectors are not the same (corrupt).";
	     return;
	  fi

	  # Check if the ADV area contains the ADV head and tail magic.
	  if ( [ "${ADV_2SECTORS:0:8}" = "${ADV_MAGIC_HEAD}" ] && [ "${ADV_2SECTORS:1016:8}" = "${ADV_MAGIC_TAIL}" ] ) ; then

	     # Caculate the ADV checksum.
	     ADV_calculated_checksum=$(hexdump -v -s $(( ${ADVoffset} + 8 )) -n $((512 - 3*4)) -e '/4 "%u\n"' ${Tmp_Log} \
				     | awk 'BEGIN { csum='${ADV_MAGIC_CHECKSUM}' } { csum=(csum - $1 + 4294967296)%4294967296 } END { print csum }');

	     ADV_read_checksum=$(hexdump -s $(( ${ADVoffset} + 4 )) -n 4 -e '/4 "%u\n"' ${Tmp_Log});


	     if [ ${ADV_calculated_checksum} -eq ${ADV_read_checksum} ] ; then 

		# Get the info stored in the ADV area:
		#
		# maximum 2 entries can be stored in the ADV, which have the following layout:
		#   - byte 1		     : tag	==> 0 = no entry, 1 = boot-once entry, 2 = menu-save entry
		#   - byte 2		     : tag_len	==> length of label string
		#   - byte 3 - (3 + tag_len) : label	==> label name that will be used

		# First entry starts a offset 8.
		ADVentry_offset=8;

		until eval $(hexdump -s $(( ${ADVoffset} + ${ADVentry_offset} )) -n $((512 - 3*4)) \
			     -e '1/1 "tag=%u; " 1/1 "tag_len=%u; label='\''" 498 "%_p"' ${Tmp_Log};
			   printf "'");
		      [ ${tag} -eq 0 ] ; do


		  if [ ${tag_len} -gt 0 ] ; then
		     label=${label:0:${tag_len}};
		  fi		   

		  case ${tag} in
			1) Syslinux_Msg="${Syslinux_Msg} ${syslinux_version:0:8}'s ADV is set to boot label \"${label}\" next boot only.";;
			2) Syslinux_Msg="${Syslinux_Msg} ${syslinux_version:0:8}'s ADV is set to boot label \"${label}\" by default.";;
		  esac

		  # Adjust the ADVentry_offset, so it points to the next entry.
		  ADVentry_offset=$(( ${ADVentry_offset} + ${tag_len} + 2 ));

		done
	     else
		Syslinux_Msg="${Syslinux_Msg} The integrity check of the ADV area failed.";
	     fi
	  else
	     Syslinux_Msg="${Syslinux_Msg} The ADV head and tail magic bytes were not found.";
	  fi
       fi

       return;
    fi
  done

  # LDLINUX_MAGIC not found.
  Syslinux_Msg="${Syslinux_Msg} It is very unlikely that Syslinux is (still) installed. The second stage could not be found.";

}



## Grub Legacy ##
#
#   Determine the embeded location of stage 2 in a stage 1 file,
#   look for the stage 2 and, if found, determine the
#   the location and the path of the embedded menu.lst.

stage2_loc () {
  local stage1="$1" HI;

  offset=$(hexdump -v -s 68 -n 4 -e '4 "%u"' "${stage1}");
  dr=$(hexdump -v -s 64 -n 1 -e '1/1 "%u"' "${stage1}");
  pa='T';
  Grub_Version='';

  for HI in ${!HDName[@]}; do
    hdd=${HDName[${HI}]};

    if [ ${offset} -lt  ${HDSize[HI]} ] ; then
       tmp=$(dd if=${hdd} skip=${offset} count=1 2>> ${Trash} | hexdump -v -n 4 -e '"%x"');

       if [[ "${tmp}" = '3be5652' || "${tmp}" = 'bf5e5652' ]] ; then
	  # stage2 files were found.
	  dd if=${hdd} skip=$((offset+1)) count=1 of=${Tmp_Log} 2>> ${Trash};
	  pa=$(hexdump -v -s 10 -n 1 -e '"%d"' ${Tmp_Log});
	  stage2_hdd=${hdd};
	  Grub_String=$(hexdump -v -s 18 -n 94 -e '"%_u"' ${Tmp_Log});
	  Grub_Version=$(echo ${Grub_String} | sed -e 's/nul[^$]*//');
	  BL=${BL}${Grub_Version};
	  menu=$(echo ${Grub_String} | sed -e 's/[^\/]*//' -e 's/nul[^$]*//');
	  menu=${menu%% *};
       fi
    fi
  done

  dr=$((${dr}-127));
  Stage2_Msg="looks at sector ${offset}";       

  if [ "${dr}" -eq 128 ] ; then
     Stage2_Msg="${Stage2_Msg} of the same hard drive";
  else
     Stage2_Msg="${Stage2_Msg} on boot drive #${dr}";
  fi

  Stage2_Msg="${Stage2_Msg} for the stage2 file";
                    
  if [ "${pa}" = "T" ] ; then
     # no stage 2 file found.
     Stage2_Msg="${Stage2_Msg}, but no stage2 files can be found at this location.";
  else
     pa=$((${pa}+1));
     Stage2_Msg="${Stage2_Msg}.  A stage2 file is at this location on ${stage2_hdd}.  Stage2 looks on";
                  
     if [ "${pa}" -eq 256 ] ; then
	Stage2_Msg="${Stage2_Msg} the same partition";
     else
	Stage2_Msg="${Stage2_Msg} partition #${pa}";
     fi

     Stage2_Msg="${Stage2_Msg} for ${menu}.";
  fi
}



## Grub2 ##
#
#   Determine the (embeded) location of core.img for a Grub2 boot.img file,
#   determine the path of the grub2 directory and look for an embedded config file.
#

grub2_info () {
  local stage1="$1" hdd="$2" grub2_version="$3";

  local sector_offset drive_offset directory_offset sector_nr drive_nr drive_nr_hex;
  local partition core_dir embedded_config HI magic core_img_found=0 embedded_config_found=0;
  local total_module_size kernel_image_size compressed_size offset_lzma lzma_uncompressed_size;
  local grub_module_info_offset grub_module_magic grub_modules_offset grub_modules_size;
  local grub_module_type grub_module_size grub_module_header_offset grub_modules_end_offset;


  case "${grub2_version}" in
    1.96) sector_offset='68';  drive_offset='76'; directory_offset='553';;
    1.97) sector_offset='92';  drive_offset='100'; directory_offset='540';;
    1.99) sector_offset='92';  drive_offset='100';;
  esac

  # Offset to core.img (in sectors).
  sector_nr=$(hexdump -v -s ${sector_offset} -n 4 -e '4 "%u"' "${stage1}" 2>> ${Trash});

  # BIOS drive number on which grub2 looks for its second stage (=core.img):
  #   - "0xff" means that grub2 will use the BIOS drive number passed via the DL register.
  #   - if this value isn't "0xff", that value will used instead.
  drive_nr_hex=$(hexdump -v -s ${drive_offset} -n 1 -e '"0x%02x"' "${stage1}" 2>> ${Trash});
  drive_nr=$(( ${drive_nr_hex} - 127 ));

  Grub2_Msg="looks at sector ${sector_nr} of the same hard drive for core.img";

  for HI in ${!HDName[@]} ; do
    # If the drive name passed to grub2_info matches the drive name of the current
    # value of HDName, see if the sector offset to core.img is smaller than the
    # total number of sectors of that drive.

    if [ ${hdd} = ${HDName[${HI}]} ] ; then
       if [ ${sector_nr} -lt ${HDSize[HI]} ] ; then

	  if [ ${sector_nr} -eq 1 ] ; then
	     # Use "file/partition/drive" passed to grub2_info directly.
	     dd if="${stage1}" of=${core_img_file} skip=${sector_nr} count=1024 2>> ${Trash};
	  else
	     # Use "hdd" passed to grub2_info.
	     dd if="${hdd}" of=${core_img_file} skip=${sector_nr} count=1024 2>> ${Trash};
	  fi

	  magic=$(hexdump -v -n 4 -e '/1 "%02x"' ${core_img_file});

	  if ( [ "${magic}" = '5256be1b' ] || [ "${magic}" = '52e82801' ] ) ; then
	     # core.img file was found.
	     core_img_found=1;

	     if [ ${grub2_version} = '1.99' ] ; then

		# For Grub2 (v1.99), the core_dir is just at the beginning of the compressed part of core.img:
		# 
		# Get grub_total_module_size	: byte 0x208-0x20b of embedded core.img ==> byte 520
		# Get grub_kernel_image_size	: byte 0x20c-0x20f of embedded core.img ==> byte 524
		# Get grub_compressed_size	: byte 0x210-0x213 of embedded core.img ==> byte 528
		# Get grub_install_dos_part	: byte 0x214-0x218 of embedded core.img ==> byte 532 --> only 1 byte needed (partition)

		eval $(hexdump -v -s 520 -n 13 -e '1/4 "total_module_size=%u; " 1/4 "kernel_image_size=%u; " 1/4 "compressed_size=%u; " 1 "partition=%d;"' ${core_img_file});


		# Scan for "d1 e9 df fe ff ff 00 00": last 8 bytes of lzma_decode to find the offset of the lzma_stream.
		eval $(hexdump -v -n ${kernel_image_size} -e '1/1 "%02x"' ${core_img_file} | \
		       ${AWK} '{ found_at=match($0, "d1e9dffeffff0000" ); if (found_at == "0") { print "offset_lzma=0" } \
			     else { print "offset_lzma=" ((found_at - 1 ) / 2 ) + 8 } }');

		# Do we have xz or lzma installed?
		if [ "${UNLZMA}" != 'none' ] ; then
		   if [ ${offset_lzma} -ne 0 ] ; then

		      # Correct the offset to the lzma stream, when 8 subsequent bytes of zeros are at the start of this offset, 
		      if [ $(hexdump -v -s ${offset_lzma} -n 8 -e '1/1 "%02x"'  ${core_img_file}) = '0000000000000000' ] ; then
			 offset_lzma=$(( ${offset_lzma} + 8 ));
		      fi

		      # Calculate the uncompressed size to which the compressed lzma stream needs to be expanded. 
		      lzma_uncompressed_size=$(( ${total_module_size} + ${kernel_image_size} - ${offset_lzma} + 512 ));

		      # Make lzma header (13 bytes): ${lzma_uncompressed_size} must be displayed in little endian format.
		      printf '\x5d\x00\x00\x01\x00'$( printf '%08x' $((${total_uncompressed_size} - ${offset_lzma} + 512 ))  | awk '{printf "\\x%s\\x%s\\x%s\\x%s", substr($0,7,2), substr($0,5,2), substr($0,3,2), substr($0,1,2)}' )'\x00\x00\x00\x00' > ${Tmp_Log};

		      # Get lzma_stream, add it after the lzma header and decompress it.
		      dd if=${core_img_file} bs=${offset_lzma} skip=1 count=$((${lzma_uncompressed_size} / ${offset_lzma} + 1)) 2>> ${Trash} \
			 | cat ${Tmp_Log} - | ${UNLZMA} > ${core_img_file_unlzma};

		      # Get core dir.
		      core_dir=$( hexdump -v -n 64 -e '"%_c"' ${core_img_file_unlzma} );
		      # Remove "\0"s at the end.
		      core_dir="${core_dir%%\\0*}";


		      # Offset of the grub_module_info structure in the uncompressed part.
		      grub_module_info_offset=$(( ${kernel_image_size} - ${offset_lzma} + 512 ));

		      eval $(hexdump -v -n 12 -s ${grub_module_info_offset} -e '"grub_module_magic=" 4/1 "%_c" 1/4 "; grub_modules_offset=%u; " 1/4 "grub_modules_size=%u;"' ${core_img_file_unlzma});

		      # Check for the existence of the grub_module_magic.
		      if [ x"${grub_module_magic}" = x'mimg' ] ; then
			 # Embedded grub modules found.
			 grub_modules_end_offset=$(( ${grub_module_info_offset} + ${grub_modules_size} ));
			 grub_module_header_offset=$(( ${grub_module_info_offset} + ${grub_modules_offset} ));

			 # Traverse through the list of modules and check if it is a config module.
			 while [ ${grub_module_header_offset} -lt ${grub_modules_end_offset} ] ; do

			   eval $(hexdump -v -n 8 -s ${grub_module_header_offset} -e '1/4 "grub_module_type=%u; " 1/4 "grub_module_size=%u;"' ${core_img_file_unlzma});

			   if [ ${grub_module_type} -eq 2 ] ; then
			      # This module is an embedded config file.
			      embedded_config_found=1;

			      embedded_config=$( hexdump -v -n $(( ${grub_module_size} - 8 )) -s $(( ${grub_module_header_offset} + 8 )) -e '"%_c"' ${core_img_file_unlzma} );
			      # Remove "\0" at the end.
			      embedded_config=$( printf "${embedded_config%\\0}" );

			      break;
			   fi

			   grub_module_header_offset=$(( ${grub_module_header_offset} + ${grub_module_size} ));

			done
		     fi		      
		   fi
		else
		   # When xz or lzma isn't available, we can't get the core_dir, but we still can show the other info.
		   core_dir='??';

		   echo 'To be able to see for which directory Grub2 (v1.99) looks for, install "xz" or "lzma".' >&2;
		fi

	     else
		# Grub2 (v1.96 and v1.97-1.98).
		partition=$(hexdump -v -s 532 -n 1 -e '"%d"' ${core_img_file});
		core_dir=$(hexdump -v -s ${directory_offset} -n 64 -e '"%_u"' ${core_img_file} | sed 's/nul[^$]*//');
	     fi
	  fi
       fi
    fi
  done


  if [ ${core_img_found} -eq 0 ] ; then
     # core.img not found.
     Grub2_Msg="${Grub2_Msg}, but core.img can not be found at this location";
  else
     # core.img found.

     if [ "${drive_nr_hex}" != '0xff' ] ; then
	Grub2_Msg="${Grub2_Msg}. Grub2 is configured to load core.img from BIOS drive ${drive_nr} (${drive_nr_hex}) instead of using the boot drive passed by the BIOS";
     fi

     Grub2_Msg="${Grub2_Msg}. core.img is at this location"

     partition=$(( ${partition} + 1 ));

     if [ ${embedded_config_found} -eq 0 ] ; then
	# No embedded config file found.

	if [ ${partition} -eq 255 ] ; then
	   Grub2_Msg="${Grub2_Msg} and looks for ${core_dir} on this drive";
	else
	   Grub2_Msg="${Grub2_Msg} and looks in partition ${partition} for ${core_dir}";
	fi

     else
	# Embedded config file found.

	Grub2_Msg=$(printf "${Grub2_Msg} and uses an embedded config file:\n\n--------------------------------------------------------------------------------\n${embedded_config}\n--------------------------------------------------------------------------------\n");

     fi
  fi
}



## Get embedded menu for grub4dos (grldr/grub.exe) and wee (installed in the MBR). ##
#
#   Function arguments:
#
#   - arg 1:  source     = file (grub4dos) / device (WEE)
#   - arg 2:  titlename  = first part of the title that needs to be displayed
#

get_embedded_menu () {
  local source=$1 titlename=$2;

  # Check if magic bytes that go before the embedded menu, are present.
  offset_menu=$(dd if="${source}" count=4 bs=128k 2>> ${Trash} | hexdump -v -e '/1 "%02x"' | grep -b -o 'b0021ace000000000000000000000000');

  if [ -n "${offset_menu}" ] ; then
     # Magic found.
     titlebar_gen "${titlename}" " embedded menu";
     echo '--------------------------------------------------------------------------------' >> "${Log1}";

     # Calcutate the exact offset to the embedded menu.
     offset_menu=$(( ( ${offset_menu%:*} / 2 ) + 16 ));
	 dd if="${source}" count=1 skip=1 bs=${offset_menu} 2>> ${Trash} | ${AWK} 'BEGIN { RS="\0" } { if (NR == 1) print $0 }' >> "${Log1}";

     echo '--------------------------------------------------------------------------------' >> "${Log1}";
  fi
}



## Show the location (offset) of a file on a disk ##
#
#   Function arguments:
#
#   - arg 1:  filename1
#   - arg 2:  filename2
#   - arg 3:  filename3
#   - ......
#

last_block_of_file () {
  local display='0';

  # Remove an existing ${Tmp_Log} log.
  rm -f ${Tmp_Log};

  # "$@" contains all function arguments (filenames).
  for file in $(ls "$@" 2>> ${Trash}) ; do
    if [[ -f ${file} ]] && [[ -s ${file} ]] && FileNotMounted "${mountname}/${file}" "${mountname}" ; then

       # There are at least 2 versions of filefrag.
       # For both versions, we can get the blocksize and the location of the block
       # of the file that is the farest away from the beginning of the disk.
       # For the newer version, we can also get the number of file fragments.

       eval $(filefrag -v "${file}" \
	     | ${AWK} -F ' ' 'BEGIN { blocksize=0; expected=0; extents=1; ext_ind=0; last_ext_loc=0; ext_length=0; filefrag_old="false"; last_block=0 } \
		{ if ( $1 == "Blocksize" ) { blocksize=$6; filefrag_old="true" }; \
		if ( filefrag_old == "true" ) { \
			if ( $1$2 ~ "LastBlock:" ) { print $3 }; \
		} else { \
		if ( $(NF-1) == "blocksize" ) { blocksize = substr($NF,0,length($NF) - 1) }; \
		if ( expected != 0 && ext_ind == $1 ) { \
		   ext_ind += 1; \
		   if ( last_ext_loc < $3 ) { \
		      last_ext_loc = $3; \
		      if ( substr($0, expected, 1) == " " ) { \
			 ext_length = $4; } \
		      else { \
			 ext_length = $5; \
		      } \
		    } \
		} \
		if ($4 == "expected") { \
		   expected= index($0,"expected") + 7; }; \
		   if ($3 == "extents") { \
		      extents=$2; \
		   } \
		} } END { \
			if ( filefrag_old == "true" ) { \
				bogus = last_block; \
				EndByte = last_block * blocksize + 512 * '${start}'; \
				printf "BlockSize=" blocksize "; Filefrag_Old=" filefrag_old "; " \
			} else { \
				bogus = last_ext_loc; \
				EndByte = ( last_ext_loc + ext_length ) * blocksize + 512 * '${start}'; \
				printf "BlockSize=" blocksize "; Fragments=" extents "; Filefrag_Old=" filefrag_old "; " \
			} \
			if ( ( bogus == 0) || ( extents == 0 ) ) { \
				printf "EndGiByte=??; EndGByte=??;" \
			} else { \
				printf "EndGiByte=%.9f; EndGByte=%.9f;", EndByte / 1024 ^ 3, EndByte / 1000 ^ 3; \
			} \
		}');

       if [ "${BlockSize}" -ne 0 ] ; then
	  if [ "${Filefrag_Old}" = "true" ] ; then
	     # Old version of filefrag.
	     printf "%14s = %-14s %s\n" "${EndGiByte}" "${EndGByte}" "${file}" >> ${Tmp_Log};
	  else
	     # New version of filefrag.
	     printf "%14s = %-14s %-45s %2s\n" "${EndGiByte}" "${EndGByte}" "${file}" "${Fragments}" >> ${Tmp_Log};
	  fi
       fi

       # If any of the files passed as arguments, is found, return 1.
       display=1;
    fi
  done

  return ${display};
}



## Get_Partition_Info search a partition for information relevant for booting. ##
#
#   Function arguments:
#
#   - arg 1:  log        = local version of RESULT.txt
#   - arg 2:  log1       = local version of log1
#   - arg 3:  part       = device for the partition
#   - arg 4:  name       = descriptive name for the partition
#   - arg 5:  mountname  = path where  partition will be mounted.
#   - arg 6:  kind       = kind of the partition
#   - arg 7:  start      = starting sector of the partition
#   - arg 8:  end        = ending sector of the partition
#   - arg 9:  system     = system of the partition
#   - arg 10: PI         = PI of the partition, (equal to "", if not a regular partition) 

Get_Partition_Info() {
  local Log="$1" Log1="$2" part="$3" name="$4" mountname="$5"  kind="$6"  start="$7"  end="$8" system="$9" PI="${10}";
  local line size=$((end-start)) BST='' BSI='' BFI='' OS='' BootFiles='' Bytes80_to_83='' Bytes80_to_81='' offset='';
  local offset_menu='' part_no_mount=0 com32='' com32_version='';


  echo "Searching ${name} for information... ";
  PrintBlkid ${part};
  
  # Type of filesystem according to blkid.
  type=$(BlkidTag ${part} TYPE);

  [ "${system}" = 'BIOS Boot partition' ] && type='BIOS Boot partition';
  [ -n ${PI} ] && FileArray[${PI}]=${type};

  # Display partition subtitle of 80 characters width.
  line='________________________________________________________________________________';
  line=${line:$(( ${#name} + 2 ))};

  printf '%s: %s\n\n' "${name}" "${line}" >> "${Log}";

  # Directory where the partition will be mounted.
  mkdir -p "${mountname}";

  # Check for extended partion.
  if ( [ "${kind}" = 'E' ] && [ x"${type}" = x'' ] ) ; then
     type='Extended Partition';

     # Don't display the error message from blkid for extended partition.
     cat ${Tmp_Log} >> ${Trash};
  else
     cat ${Tmp_Log} >&2;
  fi

  # Display the File System Type.
  echo "    File system:       ${type}" >> "${Log}";

  # Get bytes 0x80-0x83 of the Volume Boot Record (VBR).
  Bytes80_to_83=$(hexdump -v -n 4 -s $((0x80)) -e '4/1 "%02x"' ${part});

  # Get bytes 0x80-0x81 of VBR to identify Boot sectors.
  Bytes80_to_81="${Bytes80_to_83:0:4}";


  case ${Bytes80_to_81} in
	0069) BST='ISOhybrid (Syslinux 3.72-3.73)';;
	010f) BST='HP Recovery';;
	019d) BST='BSD4.4: FAT32';;
	0211) BST='Dell Utility: FAT16';;
	0488) BST="Grub2's core.img";;
	0689) BST='Syslinux 3.00-3.52';
	      syslinux_info ${part};
	      BSI="${BSI} ${Syslinux_Msg}";;
	7405) BST='Windows 7: FAT32';;
	0734) BST='Dos_1.0';;
	0745) BST='Windows Vista: FAT32';;
	089e) BST='MSDOS5.0: FAT16';;
	08cd) BST='Windows XP: NTFS';;
	0b60) BST='Dell Utility: FAT16';; 
	0bd0) BST='MSWIN4.1: FAT32';;
	0e00) BST='Dell Utility: FAT16';;
	0fb6) BST='ISOhybrid with partition support (Syslinux 3.82-3.86)';;
	2a00) BST='ReactOS';;
	2d5e) BST='Dos 1.1';;
	31c0) BST='Syslinux 4.03 or higher';
	      syslinux_info ${part} '4.03';
	      BSI="${BSI} ${Syslinux_Msg}";;
	31d2) BST="Grub2's core.img";;
	3a5e) BST='Recovery: FAT32';;
	407c) BST='ISOhybrid (Syslinux 3.82-4.04)';;
	4216) BST='Grub4Dos: NTFS';;
	4445) BST='Dell Restore: FAT32';;
	55aa) case ${Bytes80_to_83} in
		55aa750a) BST='Grub4Dos: FAT32';;
		55aa*   ) BST='Windows Vista/7: NTFS';;	# 55aa7506 = Windows Vista
	      esac;;
	55cd) BST='FAT32';;
	5626) BST='Grub4Dos: EXT2/3/4';;
	638b) BST='Freedos: FAT32';;
	6616) BST='FAT16';;
	696e) BST='FAT16';;
	6974) BST='BootIt: FAT16';;
	6f65) BST='BootIt: FAT16';;
	6f6e) BST='-';;		# 'MSWIN4.1: Fat 32'
	6f74) BST='FAT32';; 
	7815) case ${Bytes80_to_83} in
		7815b106) BST='Syslinux 3.53-3.86';
			  syslinux_info ${part};
			  BSI="${BSI} ${Syslinux_Msg}";;
		7815*   ) BST='FAT32';;
	      esac;;
	7cc6) BST='MSWIN4.1: FAT32';;
      # 7cc6) BST='Win_98';;
	7e1e) BST='Grub4Dos: FAT12/16';;
	8a56) BST='Acronis SZ: FAT32';;
	83e1) BST='ISOhybrid with partition support (Syslinux 4.00-4.04)';;
	8ec0) BST='Windows XP: NTFS';;
	8ed0) BST='Dell Recovery: FAT32';;
	b106) BST='Syslinux 4.00-4.02';
	      syslinux_info ${part};
	      BSI="${BSI} ${Syslinux_Msg}";;
	b600) BST='Dell Utility: FAT16';;
	b6c6) BST='ISOhybrid with partition support (Syslinux 3.81)';;
	b6d1) BST='Windows XP: FAT32';;
	e2f7) BST='FAT32, Non Bootable';;
	e879) BST='ISOhybrid (Syslinux 3.74-3.80)';;
	e9d8) BST='Windows Vista/7: NTFS';;
	f6f6) BST='- (cleared BS by FDISK)';;
	fa33) BST='Windows XP: NTFS';;
	fbc0) BST='ISOhybrid (Syslinux 3.81)';;

	## If Grub or Grub 2 is in the boot sector, investigate the embedded information. ##
	48b4) BST='Grub2 (v1.96)';
	      grub2_info ${part} ${drive} '1.96';
	      BSI="${BSI} Grub2 (v1.96) is installed in the boot sector of ${name} and ${Grub2_Msg}.";;
	7c3c) BST='Grub2 (v1.97-1.98)';
	      grub2_info ${part} ${drive} '1.97';
	      BSI="${BSI} Grub2 (v1.97-1.98) is installed in the boot sector of ${name} and ${Grub2_Msg}.";;
	0020) BST='Grub2 (v1.99)';
	      grub2_info ${part} ${drive} '1.99';
	      BSI="${BSI} Grub2 (v1.99) is installed in the boot sector of ${name} and ${Grub2_Msg}.";;
 aa75 | 5272) BST='Grub Legacy';
	      stage2_loc ${part};
	      BSI="${BSI} Grub Legacy (v${Grub_Version}) is installed in the boot sector of ${name} and ${Stage2_Msg}";;

	## If Lilo is in the VBR, look for map file ##
	8053) BST='LILO';
	      # 0x20-0x23 contains the offset of /boot/map.
	      offset=$(hexdump -v -s 32 -n 4 -e '"%u"' ${part});

	      BSI="${BSI} LILO is installed in boot sector of ${part} and looks at sector ${offset} of ${drive} for the \"map\" file,";

	      # check whether offset is on the hard drive.
	      if [ ${offset} -lt  ${size} ] ; then
		 tmp=$(dd if=${drive} skip=${offset} count=1 2>> ${Trash} | hexdump -v -s 508 -n 4 -e '"%_p"');	
		 
		 if [ "${tmp}" = 'LILO' ] ; then
		    BSI="${BSI} and the \"map\" file was found at this location.";
		 else
		    BSI="${BSI} but the \"map\" file was not found at this location.";
		 fi
	      else
		 BSI="${BSI} but the \"map\" file was not found at this location.";
	      fi;;

	0000) # If the first two bytes are zero, the boot sector does not contain any boot loader.
	      BST='-';;

	   *) BST='Unknown';
	      printf "Unknown BootLoader on ${name}\n\n" >> ${Unknown_MBR};
	      hexdump -n 512 -C ${part} >> ${Unknown_MBR};
	      echo >> ${Unknown_MBR};;
  esac

  # Display the boot sector type.
  echo "    Boot sector type:  ${BST}" >> "${Log}";



  ## Investigate the Boot Parameter Block (BPB) of a NTFS partition. ##

  if [ "${type}" = 'ntfs' ] ; then
     offset=$(hexdump -v -s 28 -n 4 -e '"%u"' ${part});
     BPB_Part_Size=$(hexdump -v -s 40 -n 4 -e '"%u"' ${part})
     Comp_Size=$(( (${BPB_Part_Size} - ${size}) / 256 ))
     SectorsPerCluster=$(hexdump -v -s 13 -n 1 -e '"%d"' ${part});
     MFT_Cluster=$(hexdump -v -s 48 -n 4 -e '"%d"' ${part});
     MFT_Sector=$(( ${MFT_Cluster} * ${SectorsPerCluster} ));

     #  Track=$(hexdump -v -s 24 -n 2 -e '"%u"' ${part})''    # Number of sectors per track.
     #  Heads=$(hexdump -v -s 26 -n 2 -e '"%u"' ${part})''    # Number of heads.
     #
     #  if [ "${Heads}" -ne 255 ] || [ "${Track}" -ne 63 ] ; then
     #     BSI="${BSI} Geometry: ${Heads} Heads and ${Track} sectors per Track."
     #  fi

     if [[ "${MFT_Sector}" -lt "${size}" ]] ; then
	MFT_FILE=$(dd if=${part} skip=${MFT_Sector} count=1 2>> ${Trash} | hexdump -v -n 4 -e '"%_u"');         
     else 
	MFT_FILE='';
     fi

     MFT_Mirr_Cluster=$(hexdump -v -s 56 -n 4 -e '"%d"' ${part});
     MFT_Mirr_Sector=$(( ${MFT_Mirr_Cluster} * ${SectorsPerCluster} ));
     
     if [[ "${MFT_Mirr_Sector}" -lt "${size}" ]] ; then
	MFT_Mirr_FILE=$(dd if=${part} skip=${MFT_Mirr_Sector} count=1 2>> ${Trash} | hexdump -v -n 4 -e '"%_u"');
     else 
	MFT_Mirr_FILE='';
     fi

     if ( [ "${offset}" -eq "${start}" ] && [ "${MFT_FILE}" = 'FILE' ] && [ "${MFT_Mirr_FILE}" = 'FILE' ] && [ "${Comp_Size}" -eq 0 ] ) ; then
	BSI="${BSI} No errors found in the Boot Parameter Block.";
     else
	if [[ "${offset}" -ne "${start}" ]] ; then
	   BSI="${BSI} According to the info in the boot sector, ${name} starts at sector ${offset}.";

	   if [[ "${offset}" -ne 63 && "${offset}" -ne 2048  && "${offset}" -ne 0 || "${kind}" != 'L' ]] ; then
	      BSI="${BSI} But according to the info from fdisk, ${name} starts at sector ${start}.";
	   fi
	fi

	if [[ "${MFT_FILE}" != "FILE" ]] ; then 
	   BSI="${BSI} The info in boot sector on the starting sector of the MFT is wrong.";
	   printf "MFT Sector of ${name}\n\n" >> ${Unknown_MBR};
	   dd if=${part} skip=${MFT_Sector} count=1 2>> ${Trash} | hexdump -C >> ${Unknown_MBR};
	fi

	if [[ "${MFT_Mirr_FILE}" != 'FILE' ]] ; then
	   BSI="${BSI} The info in the boot sector on the starting sector of the MFT Mirror is wrong.";
	fi

	if [[ "${Comp_Size}" -ne 0 ]] ; then  
	   BSI="${BSI} According to the info in the boot sector, ${name} has ${BPB_Part_Size} sectors, but according to the info from fdisk, it has ${size} sectors.";
	fi
     fi
  fi



  ## Investigate the Boot Parameter Block (BPB) of (some) FAT partition. ##

  #  Identifies Fat Bootsectors which are used for booting.
  #    if [[ "${Bytes80_to_81}" = '7cc6' || "${Bytes80_to_81}" = '7815' || "${Bytes80_to_81}" = 'b6d1' || "${Bytes80_to_81}" = '7405' || "${Bytes80_to_81}" = '6974' || "${Bytes80_to_81}" = '0bd0' || "${Bytes80_to_81}" = '089e' ]] ;

  if [[ "${type}" = 'vfat' ]] ; then
     offset=$(hexdump -v -s 28 -n 4 -e '"%d\n"' ${part});	# Starting sector the partition according to BPB.
     BPB_Part_Size=$(hexdump -v -s 32 -n 4 -e '"%d"' ${part});	# Partition size in sectors according to BPB.
     Comp_Size=$(( (BPB_Part_Size - size)/256 ))		# This number will be unequal to zero, if the 2
								# partions sizes differ by more than 255 sectors.  

     #Track=$(hexdump -v -s 24 -n 2 -e '"%u"' ${part})''	# Number of sectors per track.
     #Heads=$(hexdump -v -s 26 -n 2 -e '"%u"' ${part})''	# Number of heads
     #if [[ "${Heads}" -ne 255  || "${Track}" -ne 63 ]] ; then	# Checks for an usual geometry. 
     #   BSI=$(echo ${BSI}" "Geometry: ${Heads} Heads and ${Track} sectors per Track.)  ### Report unusal geometry
     #fi;     

     # Check whether Partitons starting sector and the Partition Size of BPB and fdisk agree. 
     if [[ "${offset}" -eq "${start}" && "${Comp_Size}" -eq "0"  ]] ; then
	BSI="${BSI} No errors found in the Boot Parameter Block.";	# If they agree.
     else	# If they don't agree.
	if [[ "${offset}" -ne "${start}" ]] ; then			# If partition starting sector disagrees. 
	   # Display the starting sector according to the BPB.
	   BSI="${BSI} According to the info in the boot sector, ${name} starts at sector ${offset}.";

	   # Check whether partition is a logcial partition and if its starting sector value is a 63 or 2048.
	   if [[ "${offset}" -ne "63" && "${offset}" -ne "2048" || "${kind}" != "L" ]] ; then
	      # If not, display starting sector according to fdisk.
	      BSI="${BSI} But according to the info from fdisk, ${name} starts at sector ${start}.";
	   else
	      # This is quite common occurence, and only matters if one tries to boot Windows from a logical partition.
	      BSI="${BSI} But according to the info from fdisk, ${name} starts at sector ${start}. \"63\" and \"2048\" are quite common values for the starting sector of a logical partition and they only need to be fixed when you want to boot Windows from a logical partition.";
	   fi
	fi

	# If partition sizes from BPB and FDISK differ by more than 255 sector, display both sizes.       
	if [[ "${Comp_Size}" -ne "0" ]] ; then    
	   BSI="${BSI} According to the info in the boot sector, ${name} has ${BPB_Part_Size} sectors.";

	   if [[ "$BPB_Part_Size" -ne 0 ]] ; then 
	      BSI="${BSI}. But according to the info from the partition table, it has ${size} sectors.";
	   fi	# Don't display a warning message in the common case BPB_Part_Size=0. 
	fi
     fi		# End of BPB Error if-then-else.
  fi		# End of Investigation of the BPB of vfat partitions.



  ## Display boot sector info. ##

  printf '    Boot sector info: ' >> "${Log}";
  printf "${BSI}\n" | fold -s -w 55 | sed -e '/^-------------------------$/ d' -e '2~1s/.*/                       &/' >> "${Log}";




  ## Exclude partitions which contain no information, or which we (currently) don't know how to accces. ##

  case "${type}" in
	'BIOS Boot partition'	) part_no_mount=1;;
	'crypto_LUKS'		) part_no_mount=1;;
	'Extended Partition'	) part_no_mount=1;;
	'linux_raid_member'	) part_no_mount=1;;
	'LVM2_member'		) part_no_mount=1;;
	'swap'			) part_no_mount=1;;
	'unknown volume type'	) part_no_mount=1;;
  esac

  if [ "${part_no_mount}" -eq 0 ] ; then

     # Look for a mount point of the current partition.
     # If multiple mount points are found, use the one with the shortest pathname.
     CheckMount=$(mount | ${AWK} -F "${TAB}" '$0 ~ "^'${part}' " { sub(" on ", "\t", $0); sub(" type ", "\t", $0); print $2 }' | sort | ${AWK} '{ print $0; exit}');

     # Check whether partition is already mounted.
     if [ x"${CheckMount}" != x'' ] ; then 
	if [ "${CheckMount}" = "/" ] ; then
	   mountname='';
	else
	   # If yes, use the existing mount point.
	   mountname="${CheckMount}";
	fi
     fi

     # Try to mount the partition.
     if [ x"${CheckMount}" != x'' ] || mount -r  -t "${type}" ${part} "${mountname}" 2>> ${Mount_Error} \
	|| ( [ "${type}" = ntfs ] &&  ntfs-3g -o ro  ${part} "${mountname}" 2>> ${Mount_Error} ) ; then

	#  If partition is mounted, try to identify the Operating System (OS) by looking for files specific to the OS.
	OS='';

	grep -q "W.i.n.d.o.w.s. .V.i.s.t.a"  "${mountname}"/{windows,Windows,WINDOWS}/{System32,system32}/{Winload,winload}.exe 2>> ${Trash} && OS='Windows Vista';

	grep -q "W.i.n.d.o.w.s. .7" "${mountname}"/{windows,Windows,WINDOWS}/{System32,system32}/{Winload,winload}.exe 2>> ${Trash} && OS='Windows 7';

	for WinOS in 'MS-DOS' 'MS-DOS 6.22' 'MS-DOS 6.21' 'MS-DOS 6.0' 'MS-DOS 5.0' 'MS-DOS 4.01' 'MS-DOS 3.3' 'Windows 98' 'Windows 95'; do
	  grep -q "${WinOS}" "${mountname}"/{IO.SYS,io.sys} 2>> ${Trash} && OS="${WinOS}";
	done        

	[ -s "${mountname}/Windows/System32/config/SecEvent.Evt" ] || [ -s "${mountname}/WINDOWS/system32/config/SecEvent.Evt" ] || [ -s "${mountname}/WINDOWS/system32/config/secevent.evt" ] || [ -s "${mountname}/windows/system32/config/secevent.evt" ] && OS='Windows XP';

	[ -s "${mountname}/ReactOS/system32/config/SecEvent.Evt" ] && OS='ReactOS';

	[ -s "${mountname}/etc/issue" ] && OS=$(sed -e 's/\\. //g' -e 's/\\.//g' -e 's/^[ \t]*//' "${mountname}"/etc/issue);

	[ -s "${mountname}/etc/slackware-version" ] && OS=$(sed -e 's/\\. //g' -e 's/\\.//g' -e 's/^[ \t]*//' "${mountname}"/etc/slackware-version);



	## Search for the files in ${Bootfiles} ##
	#
	#   If found, display their content.

	BootFiles='';

	if [ "${type}" = 'vfat' ] ; then
	   Boot_Files=${Boot_Files_Fat};
	else
	   Boot_Files=${Boot_Files_Normal};  
	fi

	for file in ${Boot_Files} ; do
	  if [ -f "${mountname}${file}" ] && [ -s "${mountname}${file}" ] && FileNotMounted "${mountname}${file}" "${mountname}" ; then
	     BootFiles="${BootFiles}  ${file}";

	     # Check whether the file is a symlink.
	     if ! [ -h "${mountname}${file}" ] ; then
		# if not a symlink, display content.

		if ( [ ${file} = '/grldr' ] || [ ${file} = '/grub.exe' ] ) ; then
		   # Display the embedded menu of grub4dos.
		   get_embedded_menu "${mountname}${file}" "${name}${file}";
		else
		   titlebar_gen "${name}" ${file};			# Generates a titlebar above each file listed.
		   echo '--------------------------------------------------------------------------------' >> "${Log1}";
		   cat "${mountname}${file}"  >> "${Log1}";
		   echo '--------------------------------------------------------------------------------' >> "${Log1}";
		fi
	     fi
	  fi
	done



	## Search for Wubi partitions. ##

	if [ -f "${mountname}/ubuntu/disks/root.disk" ] ; then          
	   Wubi=$(losetup -a | ${AWK} '$3 ~ "(/host/ubuntu/disks/root.disk)" { print $1; exit }' | sed 's/.$//' );

	   # check whether Wubi already has a loop device.
	   if [[ x"${Wubi}" = x'' ]] ; then
	      Wubi=$(losetup -f --show  "${mountname}/ubuntu/disks/root.disk" );
	      WubiDev=0;
	   else
	      WubiDev=1;
	   fi

	   if [ x"${Wubi}" != x'' ] ; then
	      Get_Partition_Info "${Log}"x "${Log1}"x "${Wubi}" "${name}/Wubi" "Wubi/${mountname}" 'Wubi' 0 0 'Wubi' '';

	      # Remove Wubu loop device, if created by BIS.
	      [[ ${WubiDev} -eq 0 ]] && losetup -d "${Wubi}";
	   else 
	      echo "Found Wubi on ${name}. But could not create a loop device." >&2;
	   fi
	fi
                    
                      
             
	## Search for the filenames in ${Boot_Prog}. ##
	#
	#   If found displays their names.

	if [ "${type}" = 'vfat' ] ; then
	   # Check FAT filesystems for EFI boot files.
	   for file in "${mountname}"/efi/*/*.efi ; do
	     # Remove "${mountname}" part of the filename.
	     file="${file#${mountname}}";

	     if [ -f "${mountname}${file}" ] && [ -s "${mountname}${file}" ] && FileNotMounted "${mountname}${file}" "${mountname}" ; then 
		BootFiles="${BootFiles}  ${file}";          
	     fi
	   done

	   # Other boot program files.
	   Boot_Prog=${Boot_Prog_Fat};
	else
	   Boot_Prog=${Boot_Prog_Normal};  
	fi

	for file in ${Boot_Prog} ; do
	  if [ -f "${mountname}${file}" ] && [ -s "${mountname}${file}" ] && FileNotMounted "${mountname}${file}" "${mountname}" ; then 
	     BootFiles="${BootFiles}  ${file}";          
	  fi
	done



	## Search for files containing boot codes. ##

	# Loop through all directories which might contain boot_code files.
	for file in ${Boot_Codes_Dir} ; do

	  # If such directory exist ...
	  if [ -d "${mountname}${file}" ] && FileNotMounted "${mountname}${file}" "${mountname}" ; then
	     # Look at the content of that directory.
	     for loader in $( ls  "${mountname}${file}" ) ; do
	       # If it is a file ...
	       if [ -f "${mountname}${file}${loader}" ] && [ -s "${mountname}${file}${loader}" ] ; then

		  # Bootpart code has "BootPart" written at 0x101     
		  sig=$(hexdump -v -s 257 -n 8  -e '8/1 "%_p"' "${mountname}${file}${loader}");

		  if [ "${sig}" = 'BootPart' ] ; then
		     offset=$(hexdump -v -s 241 -n 4 -e '"%d"' "${mountname}${file}${loader}");
		     dr=$(hexdump -v -s 111 -n 1 -e '"%d"' "${mountname}${file}${loader}");
		     dr=$((dr - 127));
		     BFI="${BFI} BootPart in the file ${file}${loader} is trying to chainload sector #${offset} on boot drive #${dr}";
		  fi

		  # Grub Legacy, Grub2 (v1.96) and Grub2 (v1.99) have "GRUB" written at 0x17f.
		  sig=$(hexdump -v -s 383 -n 4 -e '4/1 "%_p"' "${mountname}${file}${loader}");

		  if [ "${sig}" = 'GRUB' ] ; then
		     sig2=$(hexdump -v -n 2 -e '/1 "%02x"' "${mountname}${file}${loader}");

		     # Distinguish Grub Legacy and Grub2 (v1.96) by the first two bytes.
		     case "${sig2}" in
		       eb48) stage2_loc "${mountname}${file}${loader}";
			     BFI="${BFI} Grub Legacy (v${Grub_Version}) in the file ${file}${loader} ${Stage2_Msg}";;
		       eb4c) grub2_info "${mountname}${file}${loader}" ${drive} 1.96;
			     BFI="${BFI} Grub2 (v1.96) in the file ${file}${loader} ${Grub2_Msg}.";;
		       eb63) grub2_info "${mountname}${file}${loader}" ${drive} 1.99;
			     BFI="${BFI} Grub2 (v1.99) in the file ${file}${loader} ${Grub2_Msg}.";;
		     esac
		  fi

		  # Grub2 (v1.97-1.98) has "GRUB" written at 0x188.
		  sig=$(hexdump -v -s 392 -n 4  -e '4/1 "%_p"' "${mountname}${file}${loader}");

		  if [ "${sig}" = 'GRUB' ]; then
		     grub2_info "${mountname}${file}${loader}" ${drive} 1.97;
		     BFI="${BFI} Grub2 (v1.97-1.98) in the file ${file}${loader} ${Grub2_Msg}."; 
		  fi
	       fi
	     done	# End of loop through the files in a particular Boot_Code_Directory.
	  fi
	done		# End of the loop through the Boot_Code_Directories.



	## Show the location (offset on disk) of all files in: ##
	#   - the GrubError18_Files list
	#   - the SyslinuxError_Files list

	cd "${mountname}/";

	if [ $( last_block_of_file ${GrubError18_Files} ; echo $? ) -ne 0 ] ; then
	   titlebar_gen "${name}" ': Location of files loaded by Grub';
	   printf "%11sGiB - GB%13sFile%33sFragment(s)\n\n" ' ' ' ' ' ' >> "${Log1}";
	   cat ${Tmp_Log} >> "${Log1}";
	fi

	if [ $( last_block_of_file ${SyslinuxError_Files} ; echo $? ) -ne 0 ] ; then
	   titlebar_gen "${name}" ': Location of files loaded by Syslinux';
	   printf "%11sGiB - GB%13sFile%33sFragment(s)\n\n" ' ' ' ' ' ' >> "${Log1}";
	   cat ${Tmp_Log} >> "${Log1}";
	fi



	rm -f ${Tmp_Log};

	# Display the version of the COM32(R) modules of Syslinux.

	for com32 in *.c32 syslinux/*.c32 extlinux/*.c32 boot/syslinux/*.c32 boot/extlinux/*.c32 ; do

	  if [ -f "${com32}" ] ; then
	     # First 5 bytes of the COM32(R) module are a magic number (used by Syslinux too).
	     com32_version=$(hexdump -n 5 -e '/1 "%02x"' "${com32}");

	     case ${com32_version} in
		b8fe4ccd21)  printf ' %-35s:  COM32R module (v4.xx)\n' "${com32}" >> ${Tmp_Log};;
		b8ff4ccd21)  printf ' %-35s:  COM32R module (v3.xx)\n' "${com32}" >> ${Tmp_Log};;
			 *)  printf ' %-35s:  not a COM32/COM32R module\n' "${com32}" >> ${Tmp_Log};;
	     esac
	  fi
	done

	if [ -f ${Tmp_Log} ] ; then
	   titlebar_gen "${name}" ': Version of COM32(R) files used by Syslinux';
	   cat ${Tmp_Log} >> "${Log1}";
	fi



	cd "${Folder}";



	echo > ${Tmp_Log};

	if [[ x"${BFI}" != x'' ]] ; then
	   printf "    Boot file info:     " >> "${Log}";
	   printf "${BFI}\n" | fold -s -w 55 | sed -e '/^-------------------------$/ d' -e '2~1s/.*/                       &/' >> "${Log}";
	fi

	echo "    Operating System:  "${OS} | fold -s -w 55 | sed -e '2~1s/.*/                       &/' >> "${Log}"
	printf "    Boot files:        " >> "${Log}";
	echo ${BootFiles} | fold -s -w 55 | sed -e '2~1s/.*/                       &/' >> "${Log}";



	# If partition was mounted by the script.
	if [ x"${CheckMount}" = x'' ] ; then
	   umount "${mountname}" || umount -l "${mountname}";          
	fi

     # If partition failed to mount.
     else
	printf "    Mounting failed:   " >> "${Log}";  
	cat ${Mount_Error} >> "${Log}"; 
     fi		# End of Mounting "if then else".
  fi	  	# End of Partition Type "if then else".

  echo >> "${Log}";

  if [[ -e "${Log}"x ]] ; then
     cat "${Log}"x >> "${Log}";
     rm "${Log}"x;
  fi

  if [[ -e "${Log1}"x ]] ; then
     cat "${Log1}"x >> "${Log1}";
     rm "${Log1}"x;
  fi
}	# End Get_Partition_Info function



## "titlebar_gen" generates the ${name}${file} title bar to always be 80 characters in length. ##

titlebar_gen () {
  local name_file name_file_length equal_signs_line_length equal_signs_line;
  
  name_file="${1}${2}:";
  name_file_length=${#name_file};

  equal_signs_line_length=$(((80-${name_file_length})/2-1));

  # Build "===" string.
  printf -v equal_signs_line "%${equal_signs_line_length}s";
  printf -v equal_signs_line "%s" "${equal_signs_line// /=}";

  if [ "$((${name_file_length}%2))" -eq 1 ]; then
     # If ${name_file_length} is odd, add an extra "=" at the end.
     printf "\n%s %s %s=\n\n" "${equal_signs_line}" "${name_file}" "${equal_signs_line}" >> "${Log1}";
  else
     printf "\n%s %s %s\n\n" "${equal_signs_line}" "${name_file}" "${equal_signs_line}" >> "${Log1}";
  fi
}



## Start ##



# Center title.
BIS_title=$(printf 'Boot Info Script %s      [%s]' "${VERSION}" "${RELEASE_DATE}");
printf -v BIS_title_space "%$(( ( 80 - ${#BIS_title} ) / 2 - 1 ))s";
printf "${BIS_title_space}${BIS_title}\n" > "${Log}";

if [ ! -z "${LAST_GIT_COMMIT}" ] ; then
   printf '\nLast git commit:       %s\nRetrieved from git on: %s\n' "${LAST_GIT_COMMIT}" "${RETRIEVAL_DATE}" >> "${Log}";
fi

printf '\n\n============================= Boot Info Summary: ===============================\n\n' >> "${Log}";



# Search for hard drives which don't exist, have a corrupted partition table
# or don't have a parition table (whole drive is a filesystem).
# Information on all hard drives which a valid partition table are stored in 
# the hard drives arrays: HD?????

# id for Filesystem Drives.
FSD=0;

# Clear blkid cache
blkid -g;

for drive in ${All_Hard_Drives} ; do
  size=$(fdisks ${drive});

  PrintBlkid ${drive};

  if [ 0 -lt ${size} 2>> ${Trash} ] ; then
     if [ x"$(blkid  ${drive})" = x'' ] || [ x"$(blkid  | grep ${drive}:)" = x'' ] ; then
	# Drive is not a filesytem.

	size=$((2*size));

	HDName[${HI}]=${drive};
	HDSize[${HI}]=${size};

	# Get and set HDHead[${HI}], HDTrack[${HI}] and HDCylinder[${HI}] all at once.
	eval $(fdisk -lu ${drive} 2>> ${Trash} | ${AWK} -F ' ' '$2 ~ "head" { print "HDHead['${HI}']=" $1 "; HDTrack['${HI}']=" $3 "; HDCylinder['${HI}']=" $5 }' );

	# Look at the first 4 bytes of the second sector to identify the partition table type.
	case $(hexdump -v -s 512 -n 4 -e '"%_u"' ${drive}) in
	  'EMBR') HDPT[${HI}]='BootIt';;
	  'EFI ') HDPT[${HI}]='EFI';;
	       *) HDPT[${HI}]='MSDos';;
	esac

	HI=$((${HI}+1));
     else
        # Drive is a filesystem.

        if [ $( expr match "$(BlkidTag "${drive}" TYPE)" '.*raid') -eq 0 ] || [ x"$(BlkidTag "${drive}" UUID)" != x'' ] ; then
	   FilesystemDrives[${FSD}]="${drive}";
	   ((FSD++));
	fi
     fi
  else
     printf "$(basename ${drive}) " >> ${FakeHardDrives};
  fi
done



## Identify the MBR of each hard drive. ##
echo 'Identifying MBRs...';

for HI in ${!HDName[@]} ; do 
  drive="${HDName[${HI}]}";
  Message="is installed in the MBR of ${drive}";

  # Read the whole MBR in hexadecimal format.
  MBR_512=$(hexdump -v -n 512 -e '/1 "%02x"' ${drive});

  ## Look at the first 2,3,4 or 8 bytes of the hard drive to identify the boot code installed in the MBR. ##
  #
  #   If it is not enough, look at more bytes.

  MBR_sig2="${MBR_512:0:4}";
  MBR_sig3="${MBR_512:0:6}";
  MBR_sig4="${MBR_512:0:8}";
  MBR_sig8="${MBR_512:0:16}";

  ## Bytes 0x80-0x81 of the MBR. ##
  #
  #   Use it to differentiate between different versions of the same bootloader.

  MBR_bytes80to81="${MBR_512:256:4}";


  case ${MBR_sig2} in

    eb48) ## Grub Legacy is in the MBR. ##
	  BL="Grub Legacy";

	  # 0x44 contains the offset to the next stage.
	  offset=$(hexdump -v -s 68 -n 4 -e '"%u"' ${drive});

	  if [ "${offset}" -ne 1 ] ; then
	     # Grub Legacy is installed without stage1.5 files.
	     stage2_loc ${drive};
	     Message="${Message} and ${Stage2_Msg}";
	  else
	     # Grub is installed with stage1.5 files.
	     Grub_String=$(hexdump -v -s 1042 -n 94 -e '"%_u"' ${drive});
	     Grub_Version="${Grub_String%%nul*}";

	     BL="Grub Legacy (v${Grub_Version})";

	     tmp="/${Grub_String#*/}";
	     tmp="${tmp%%nul*}";

	     eval $(echo ${tmp} | ${AWK} '{ print "stage=" $1 "; menu=" $2 }');

	     [[ x"$menu" = x'' ]] || stage="${stage} and ${menu}";

	     part_info=$((1045 + ${#Grub_Version}));
	     eval $(hexdump -v -s ${part_info} -n 2 -e '1/1 "pa=%u; " 1/1 "dr=%u"' ${drive});
	     
	     dr=$(( ${dr} - 127 ));
	     pa=$(( ${pa} + 1 ));

	     if [ "${dr}" -eq 128 ] ; then
		Message="${Message} and looks on the same drive in partition #${pa} for ${stage}";
	     else
		Message="${Message} and looks on boot drive #${dr} in partition #${pa} for ${stage}";
	     fi
	  fi;;

    eb4c) ## Grub2 (v1.96) is in the MBR. ##
	  BL='Grub2 (v1.96)';

	  grub2_info ${drive} ${drive} '1.96';

	  Message="${Message} and ${Grub2_Msg}";;

    eb63) ## Grub2 is in the MBR. ##
	  case ${MBR_bytes80to81} in
		7c3c) grub2_version='1.97'; BL='Grub2 (v1.97-1.98)';;
		0020) grub2_version='1.99'; BL='Grub2 (v1.99)';;
	  esac

	  grub2_info ${drive} ${drive} ${grub2_version};

	  Message="${Message} and ${Grub2_Msg}";;

    0ebe) BL='ThinkPad';;
    31c0) # Look at the first 8 bytes of the hard drive to identify the boot code installed in the MBR.
	  case ${MBR_sig8} in
	    31c08ed0bc007c8e) BL='SUSE generic MBR';;
	    31c08ed0bc007cfb) BL='Acer PQService MBR';;
	  esac;;
    33c0) # Look at the first 3 bytes of the hard drive to identify the boot code installed in the MBR.
	  case ${MBR_sig3} in
	    33c08e) BL='Windows';;
	    33c090) BL='DiskCryptor';;
	    33c0fa) BL='Syslinux MBR (4.04 and higher)';;			
	  esac;;
    33ed) # Look at bytes 0x80-0x81 to be more specific about the Syslinux variant/version.
	  case ${MBR_bytes80to81} in
	    407c) BL='ISOhybrid (Syslinux 4.04 and higher)';;
	    83e1) BL='ISOhybrid with partition support (Syslinux 4.04 and higher)';;
	  esac;;
    33ff) BL='HP/Gateway';;
    b800) BL='Plop';;
    ea05) BL='XOSL';;
    ea1e) BL='Truecrypt Boot Loader';;
    eb04) BL='Solaris';;
    eb31) BL='Paragon';;
    eb5e) # Look at the first 3 bytes of the hard drive to identify the boot code installed in the MBR.
	  case ${MBR_sig3} in
	    eb5e00) BL='fbinst';;
	    eb5e80) BL='Grub4Dos';;
	    eb5e90) BL='WEE';
		    # Get the embedded menu of WEE.
		    get_embedded_menu "${drive}" "WEE's (${drive})";;
	  esac;;
    fa31) # Look at the first 3 bytes of the hard drive to identify the boot code installed in the MBR.
	  case ${MBR_sig3} in
	    fa31c0) # Look at bytes 0x80-0x81 to be more specific about the Syslinux variant/version.
		    case ${MBR_bytes80to81} in
		      0069) BL='ISOhybrid (Syslinux 3.72-3.73)';;
		      7c66) BL='Syslinux MBR (3.61-4.03)';;
		      7cb8) BL='Syslinux MBR (3.36-3.51)';;
		      b442) BL='Syslinux MBR (3.00-3.35)';;
		      bb00) BL='Syslinux MBR (3.52-3.60)';;
		      e879) BL='ISOhybrid (Syslinux 3.74-3.80)';;
		    esac;;
	    fa31c9) BL='Master Boot LoaDeR';;   
	    fa31ed) # Look at bytes 0x80-0x81 to be more specific about the Syslinux variant/version.
		    case ${MBR_bytes80to81} in
		      0069) BL='ISOhybrid (Syslinux 3.72-3.73)';;
		      0fb6) BL='ISOhybrid with partition support (Syslinux 3.82-3.86)';;
		      407c) BL='ISOhybrid (Syslinux 3.82-4.03)';;
		      83e1) BL='ISOhybrid with partition support (Syslinux 4.00-4.03)';;
		      b6c6) BL='ISOhybrid with partition support (Syslinux 3.81)';;
		      fbc0) BL='ISOhybrid (Syslinux 3.81)';;
		    esac;;
	  esac;;
    fa33) BL='MS-DOS 3.30 through Windows 95 (A)';;
    fab8) # Look at the first 4 bytes of the hard drive to identify the boot code installed in the MBR.
	  case ${MBR_sig4} in
	    fab80000) BL='FreeDOS (eXtended FDisk)';;
	    fab8*   ) BL="No boot loader";;  
	  esac;;   
    fabe) BL='No boot loader?';;
    faeb) BL='Lilo';; 
    fafc) BL='ReactOS';;
    fc31) BL='Testdisk';;
    fc33) BL='GAG';;
    fceb) BL='BootIt NG';;
    0000) BL='No boot loader';;
       *) BL='No known boot loader';
	  printf "Unknown MBR on ${drive}\n\n" >> ${Unknown_MBR};
	  hexdump -v -n 512 -C ${drive} >> ${Unknown_MBR};
	  echo >> ${Unknown_MBR};;
  esac


  ## Output message at beginning of summary that gives MBR info for each drive: ##

  printf ' => ' >> "${Log}";
  printf "${BL} ${Message}.\n" | fold -s -w 75 | sed -e '/^-----$/ d' -e '2~1s/.*/    &/' >> "${Log}";

  HDMBR[${HI}]=${BL};
done

echo >> "${Log}";



## Store and Display all the partitions tables. ##

for HI in ${!HDName[@]} ; do
  drive=${HDName[${HI}]};

  echo "Computing Partition Table of ${drive}...";

  FP=$((PI+1));    # used if non-MS_DOS partition table is not in use.
  FirstPartition[${HI}]=${FP};
  PTType=${HDPT[${HI}]};
  HDPT[${HI}]='MSDos';
  
  echo "Drive: $(basename ${drive} ) _____________________________________________________________________" >> ${PartitionTable};
  fdisk -lu ${drive} 2>> ${Trash} | sed '/omitting/ d' | sed '6,$ d' >> ${PartitionTable};

  printf "\n${PTFormat}\n" 'Partition' 'Boot' 'Start Sector' 'End Sector' '# of Sectors' 'Id' 'System' >> ${PartitionTable};

  ReadPT ${HI} 0 4 ${PartitionTable} "${PTFormat}" '' 0;
  
  echo >> ${PartitionTable};
  LastPartition[${HI}]=${PI};
  LP=${PI};
  
  CheckPT ${FirstPartition[${HI}]} ${LastPartition[${HI}]} ${PartitionTable} ${HI};
  
  echo >> ${PartitionTable};
  HDPT[${HI}]=${PTType};
  
  case ${PTType} in
    BootIt) printf 'BootIt NG Partition Table detected' >> ${PartitionTable};
	    [[ "${HDMBR[${HI}]}" = 'BootIt NG' ]] || printf ', but does not seem to be used' >> ${PartitionTable};
	    printf '.\n\n' >> ${PartitionTable};

	    ReadEMBR  ${HI} ${PartitionTable};
	    echo >> ${PartitionTable};

	    if [ "${HDMBR[${HI}]}" = 'BootIt NG' ] ; then
	       LastPartition[${HI}]=${PI};
	       CheckPT ${FirstPartition[${HI}]} ${LastPartition[${HI}]} ${PartitionTable} ${HI}; 
	    else
	       FirstPartition[${HI}]=${FP};
	    fi;;
       EFI) FirstPartition[${HI}]=$((PI+1));
	    EFIee=$(hexdump -v -s 450 -n 1 -e '"%x"' ${drive});
	    printf 'GUID Partition Table detected' >> ${PartitionTable};
	    [[ "${EFIee}" = 'ee' ]] || printf ', but does not seem to be used' >> ${PartitionTable};
	    printf '.\n\n' >> ${PartitionTable};

	    ReadEFI ${HI} ${PartitionTable};
	    echo >> ${PartitionTable};

	    if [ "${EFIee}" = 'ee' ] ; then
	       LastPartition[${HI}]=${PI};
	       CheckPT ${FirstPartition[${HI}]} ${LastPartition[${HI}]} ${PartitionTable} ${HI};
	    else
	       FirstPartition[${HI}]=${FP};
	    fi;;
  esac
done



## Loop through all Hard Drives. ##

for HI in ${!HDName[@]} ; do
  drive=${HDName[${HI}]};

  ## And then loop through the partitions on that drive. ##
  for (( PI = FirstPartition[${HI}]; PI <= LastPartition[${HI}]; PI++ )); do
    part_type=${TypeArray[${PI}]};    # Type of the partition according to fdisk
    start=${StartArray[${PI}]};
    size=${SizeArray[${PI}]};
    end=${EndArray[${PI}]};
    kind=${KindArray[${PI}]};
    system=${SystemArray[${PI}]};

    if [[ x"${DeviceArray[${PI}]}" = x'' ]] ; then
       name="${NamesArray[${PI}]}";
       mountname=$(basename ${drive})"_"${PI};
       part=$(losetup -f --show  -o $((start*512)) ${drive});
       # --sizelimit $((size*512))    --sizelimit seems to be a recently added option for losetup. Failed on Hardy.
    else
       part="${DeviceArray[${PI}]}";
       name=$(basename ${part});      # Name of the partition (/dev/sda8 -> sda8).
       mountname=${name};
    fi

    Get_Partition_Info "${Log}" "${Log1}" "${part}" "${name}" "${mountname}" "${kind}" "${start}" "${end}" "${system}" "${PI}";
     
    [[ "${DeviceArray[${PI}]}" = '' ]] && losetup -d ${part};
    
  done
done



## Deactivate dmraid's activated by the script. ##

if [ x"$InActiveDMRaid" != x'' ] ; then
  dmraid -an ${InActiveDMRaid};
fi 



## Search LVM partitions for information. ##
#
#   Only works if the "LVM2"-package is installed.

if [ $(type lvscan lvdisplay lvchange >> ${Trash} 2>> ${Trash} ; echo $?) -eq 0 ] ; then

  LVM_Partitions=$(lvscan | ${AWK} '{ split($2, lvm_dev, "/"); print "/dev/mapper/" lvm_dev[3] "-" lvm_dev[4] }');

  for LVM in ${LVM_Partitions}; do 
    LVM_Size=$(lvdisplay -c ${LVM} | ${AWK} -F ':' '{ print $7 }');
    LVM_Status=$(lvdisplay ${LVM} | ${AWK} '$0 ~ "LV Status" { print $3 }');
    lvchange -ay ${LVM};
    name=${LVM:12};
    mountname="LVM/${name}";
    kind='LVM';
    start=0;
    end=${LVM_Size};  
    system='';
    PI='';
     
    Get_Partition_Info "${Log}" "${Log1}" "$LVM" "${name}" "${mountname}" "${kind}" "${start}" "${end}" "${system}" "${PI}";
      
    # deactivate all LVM's, which were not active.
    [[ "${LVM_Status}" = 'NOT' ]] && lvchange -an "${LVM}";

  done
fi



## Search MDRaid Partitons for Information ##
#
#   Only works if "mdadm" is installed.

if [ $(type mdadm >> ${Trash} 2>> ${Trash} ; echo $?) -eq 0 ] ; then

  # All arrays which are already assembled.
  MD_Active_Array=$(mdadm --detail --scan | ${AWK} '{ print $2 }');

  # Assemble all arrays.
  mdadm --assemble --scan;
  
  # All arrays.
  MD_Array=$(mdadm --detail --scan | ${AWK} '{ print $2 }');

  for MD in ${MD_Array}; do
    MD_Size=$(fdisks ${MD});     # size in blocks
    MD_Size=$((2*${MD_Size}));   # size in sectors
    MD_Active=0;

    # Check whether MD is active.
    for MDA in ${MD_Active_Array}; do
      if [[ "${MDA}" = "${MD}" ]] ; then
         MD_Active=1;
         break;
      fi
    done
	
    name=${MD:5};
    mountname="MDRaid/${name}";
    kind="MDRaid";
    start=0;
    end=${MD_Size};
    system='';
    PI='';
     
    Get_Partition_Info "${Log}" "${Log1}" "${MD}" "${name}" "${mountname}" "${kind}" "${start}" "${end}" "${system}" "${PI}";

    # deactivate all MD_Raid's, which were not active.
    [[ "${MD_Active}" -eq 0 ]] && mdadm --stop "${MD}";

  done
fi



## Search filesystem hard drives for information. ##

for FD in ${FilesystemDrives[@]} ; do
  FD_Size=$(fdisks ${FD});     # size in blocks
  FD_Size=$((2*${FD_Size}));   # size in sectors
  name=${FD:5};
  mountname="FD/${name}";
  kind="FD";
  start=0;
  end=${FD_Size};
  system='';
  PI='';
     
  Get_Partition_Info "${Log}" "${Log1}" "${FD}" "${name}" "${mountname}" "${kind}" "${start}" "${end}" "${system}" "${PI}";

done

  

## Drive/partition info. ##

printf '============================ Drive/Partition Info: =============================\n\n' >> "${Log}";
 
[ -e ${PartitionTable} ] && cat ${PartitionTable} >> "${Log}" || echo 'no valid partition table found' >> "${Log}";


printf '"blkid" output: ________________________________________________________________\n\n' >> "${Log}";

printf "${BlkidFormat}" Device UUID TYPE LABEL >> "${Log}";

echo >> "${Log}";

for dev in $(blkid -o device | sort); do
  PrintBlkid ${dev} '_summary';
done

cat "${BLKID}_summary" >> "${Log}";
echo >> "${Log}";



if [ $(ls -R /dev/mapper 2>> ${Trash} | wc -l) -gt 2 ] ; then
   printf '========================= "ls -R /dev/mapper/" output: =========================\n\n' >> "${Log}";
   ls -R /dev/mapper >> "${Log}";
   echo >> "${Log}";
fi
         


## Mount points. ##

printf '================================ Mount points: =================================\n\n' >> "${Log}";

MountFormat='%-16s %-24s %-10s %s\n';

printf "${MountFormat}\n" 'Device' 'Mount_Point' 'Type' 'Options' >> "${Log}";

# No idea for which mount version this is even needed.
#  original:
#    mount | grep ' / '| grep -v '^/'| sed  's/ on /'$Fis'/' |sed 's/ type /'$Fis'/'|sed  's/ (/'$Fis'(/'| gawk -F $Fis '{printf "'"$MountFormat"'", $1, $2, $3, $4 }'>>"$Log";
#  new:
#    mount | sort | gawk -F "${TAB}" '$0 ~ " / " { if ($1 !~ "^/") { sub(" on ", "\t", $0); sub(" type ", "\t", $0); optionsstart=index($3, " ("); printf "'"${MountFormat}"'", $1, $2, substr($3, 1, optionsstart - 1), substr($3, optionsstart + 1) } } END { printf "\n" }' >> "${Log}";

mount | sort | ${AWK} -F "${TAB}" '$0 ~ "^/dev" \
  { sub(" on ", "\t", $0); sub(" type ", "\t", $0); optionsstart=index($3, " ("); \
    printf "'"${MountFormat}"'", $1, $2, substr($3, 1, optionsstart - 1), substr($3, optionsstart + 1) } END { printf "\n" }' >> "${Log}";



## Write the content of Log1 to the log file. ##

[ -e "${Log1}" ] && cat "${Log1}" >> "${Log}"; 
echo >> "${Log}";



## Add unknown MBRs/Boot Sectors to the log file, if any. ##

if [ -e ${Unknown_MBR} ] ; then
   printf '======================== Unknown MBRs/Boot Sectors/etc: ========================\n\n' >> "${Log}";
   cat ${Unknown_MBR} >> "${Log}";
   echo >> "${Log}";
fi



## Add fake hard drives to the log file, if any. ##

if [ -e ${FakeHardDrives} ] ; then 
   printf "========= Devices which don't seem to have a corresponding hard drive: =========\n\n" >> "${Log}";
   cat ${FakeHardDrives} >> "${Log}";
   printf "\n\n" >> "${Log}";
fi

  

## Write the Error Log to the log file. ##

if [ -s ${Error_Log} ] ; then
   printf '=============================== StdErr Messages: ===============================\n\n' >> "${Log}";
   cat ${Error_Log} >> "${Log}";
fi



## Write a final newline. ##

echo >> "${Log}";



if [ ${stdout_output} -eq 1 ] ; then
   ## If --stdout is specified, show the output.
   cat "${Log}";
else
   ## Copy the log file to RESULTS file and make the user the owner of RESULTS file. ##

   cp "${Log}" "${LogFile}";

   if [ "${SUDO_UID}:${SUDO_GID}" != ':' ] ; then
      chown "${SUDO_UID}:${SUDO_GID}" "${LogFile}";
   fi



   ## gzip the RESULTS file, for easy uploading. ##
   #
   #   gzip a copy of the RESULTS file only when -g or --gzip is passed on the command line. 
   #
   #   ./bootinfoscript -g <outputfile> 
   #   ./bootinfoscript --gzip <outputfile> 

   if [ ${gzip_output} -eq 1 ] ; then
      cat "${LogFile}" | gzip -9 > "${LogFile}.gz";

      if [ "${SUDO_UID}:${SUDO_GID}" != ':' ] ; then
	 chown "${SUDO_UID}:${SUDO_GID}" "${LogFile}.gz";
      fi
   fi



   ## Reset the Standard Output to the Terminal. ##
   #
   #   exec 1>&-;
   #   exec 1>&6;
   #   exec 6>&-;



   printf '\nFinished. The results are in the file "%s"\nlocated in "%s".\n\n' "$(basename "${LogFile}")" "${Dir}/";
fi

exit 0;

