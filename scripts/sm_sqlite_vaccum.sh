#!/bin/bash
# Script to clean up Seamonkey sqlite database
#
# Directions
# Edit the path of your user /home/<user> directory
# or this script will not find the places.sqlite file
#
# Copyright 2015 Brenton Earl Tooele, UT, USA
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

PIDS=`ps cax | grep seamonkey | grep -o '^[ ]*[0-9]*'`
if [ -z "$PIDS" ]; then
	echo "Process not running." 1>&2
else
	for PID in $PIDS; do
		kill -9 $PID
	done
fi

dirs=`grep Path /home/facerip/.mozilla/seamonkey/profiles.ini | cut -f 2 -d =`
echo "Found directories " $dirs


for i in $dirs ; do
	cd /home/facerip/.mozilla/seamonkey
	cd $i
	if [ -f places.sqlite ]; then
		echo "Running command - sqlite3 /home/facerip/.mozilla/seamonkey/$i/places.sqlite vacuum"
		/usr/bin/sqlite3 /home/facerip/.mozilla/seamonkey/$i/places.sqlite vacuum
	fi
done
