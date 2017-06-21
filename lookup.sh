#!/bin/bash

# Request serial from user
echo -n "Please enter Apple serial number: "
read serial

# Remove first 8 chars
ser_end=$(echo "${serial}" | cut -c 9-)

# Lookup & output model
echo -n "Model: "
curl -s http://support-sp.apple.com/sp/product?cc=${ser_end} | awk -v FS="(<configCode>|</configCode>)" '{print $2}'