#!/bin/bash
#
# run.sh does one of these
# - execute samba
# - run sh commands to set up samba
#
set -e

if [ "$1" == "--start" ]
then
	shift 1
	/samba-share.sh "$@"
else
	/setup-samba-share.sh "$@"
fi




