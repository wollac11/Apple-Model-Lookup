#!/bin/bash

# Check if running on target machine
read -r -p "Are we running on device in question? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
		# Obtain serial from system
		serial=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
    ;;
    *)
		# Request serial from user
		echo -n "Please enter Apple serial number: "
		read serial
    ;;
esac

# Remove first 8 chars
ser_end=$(echo "${serial}" | cut -c 9-)

# Lookup & output model
echo -n "Model: "
curl -s http://support-sp.apple.com/sp/product?cc=${ser_end} | awk -v FS="(<configCode>|</configCode>)" '{print $2}'