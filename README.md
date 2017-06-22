# Apple-Model-Lookup
Look up model / marketing name of any Apple product by its serial number (excluding peripherals).

Usage:
Download and run script from BASH shell. Script can be used interactively or by supplying the
appropriate input arguments.

- Interactive Mode: 
	Follow prompts to enter serial number or use serial from current machine.
- Non-interactive Mode: 
	Use the -s or --serial flags followed by the serial number you wish to check or use
	-d or --ondevice to use the serial number from your current machine.

Device Compatibility:

Known to work:  
- Macs including iMac, Macbook & Mac Pro lines  
- iOS devices including iPhone & iPad  
- Network devices (such as Airport Express)  

May work (not tested):  
- Apple Watch  
- Other devices with 11-12 character serial numbers  

Won't work:  
- Apple Mice  
- Apple Cinema Displays  
- Devices with serial numbers > 12 characters  
- Non-Apple devices

System Requirements:

- A Unix-based operating system (such as Linux or MacOS)
- BASH Shell
- AWK
- cURL

Note: This script will not run on Windows. A Windows/DOS version may be considered in the future.
