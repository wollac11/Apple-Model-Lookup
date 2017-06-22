#!/bin/bash

# Requests serial from user
req_serial() {
	echo -n "Please enter Apple serial number: "
	read serial
}

# Intro header
print_info() {
	echo "------------------------
-  Apple Model Lookup  -
-     Version 0.2      -
-  C.W.A. Callow 2017  -
------------------------
"
}

# Prints supported input options
print_help() {
    echo "-h | --help               	: See this options list"
    echo "-a | --about              	: View version info"
    echo "-s | --serial [serial no.]	: Provide serial (non-interactive mode)"
    echo "-d | --ondevice           	: Get serial from current system"
}

# Gets serial of currently in-use device
on_mac() {
	# Verify machine is running OSX
	if [[ "$OSTYPE" =~ darwin.* ]]; then
		# Obtain serial from system
		serial=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
	else
		echo "This is not a Mac!"
		req_serial
	fi
}

# Proccess input arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -h|--help)
            print_help
            exit
        ;;
        -a|--about)
            print_info
            exit
        ;;
        -d|--ondevice)
			interactive=false
			print_info
			on_mac
            shift # past argument
        ;;
        -s|--serial)
			serial=$2
			interactive=false
			print_info
			if [ ! "${serial}" ]; then
				echo "No serial entered!"
				req_serial
			fi
        ;;
        *)
                # unknown option
        ;;
    esac
    shift # past argument or value
done

# Check if interactive mode disabled
if [ ! "${interactive}" = false ]; then
	print_info
	# Check if running on target machine
	read -r -p "Are we running on device in question? [y/N] " response
	case "$response" in
	    [yY][eE][sS]|[yY]) 
			on_mac
		;;
	    *)
			req_serial
	    ;;
	esac
fi

# Remove first 8 chars
ser_end=$(echo "${serial}" | cut -c 9-)

# Lookup & output model
echo -n "Model: "
curl -s http://support-sp.apple.com/sp/product?cc=${ser_end} | awk -v FS="(<configCode>|</configCode>)" '{print $2}'