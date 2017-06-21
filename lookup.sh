#!/bin/bash

# Requests serial from user
req_serial() {
	echo -n "Please enter Apple serial number: "
	read serial
}

# Intro header
echo "------------------------
-  Apple Model Lookup  -
-     Version 0.2      -
-  C.W.A. Callow 2017  -
------------------------
"

# Check if running on target machine
read -r -p "Are we running on device in question? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
		# Verify machine is running OSX
		if [[ "$OSTYPE" =~ darwin.* ]]; then
			# Obtain serial from system
			serial=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
		else
			echo "This is not a Mac!"
			req_serial
		fi
	;;
    *)
		req_serial
    ;;
esac

# Remove first 8 chars
ser_end=$(echo "${serial}" | cut -c 9-)

# Lookup & output model
echo -n "Model: "
curl -s http://support-sp.apple.com/sp/product?cc=${ser_end} | awk -v FS="(<configCode>|</configCode>)" '{print $2}'