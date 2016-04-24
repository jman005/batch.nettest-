@echo OFF
rem Scath's Net Inspection Script, (c) 2106
rem
rem This script should be considered released into the Public Domain, however I would appreciate a rem thank you or a tip @ the bitcoin address 1FqukbmrZf2EnnKYf3BkioWTYysqnynFWy :)
rem 
rem I'm not liable for any misuse of this script. It's designed to be non-invasive, but things may 
rem change in Windows since I release it, and therefore things might break. You're liable for your
rem own mistakes. (or those of the helper who misused this, whatever)
rem
rem
rem FLAGS
rem
rem These can be used to turn various parts of the script on and off. "on" = active, "off" = rem skipped. IF YOU ARE HELPING SOMEONE WITH THIS, YOU SHOULD SET THE FLAGS BEFORE GIVING THE
rem SCRIPT TO THEM. Conversely, IF SOMEONE IS HELPING YOU AND ASKS YOU TO RUN THIS SCRIPT, DON'T
rem MESS WITH THE FLAGS. No instruction is given because you should not be using this if you don't
rem understand what each part of the script does.
rem
rem ipconfig /all
SET FLAG_IPC=on
rem
rem ping most common gateway IPs (192.168.1.1, 192.168.0.1, and 10.0.0.1)
SET FLAG_PINGG=on
rem
rem ping localhost
SET FLAG_PINGL=on
rem
rem ping ip (8.8.8.8)
SET FLAG_PINGI=on
rem
rem ping A record (google.com)
SET FLAG_PINGD=on
rem
rem traceroute to google
SET FLAG_TRACE=on
rem
rem delete file after showing notepad (eases cleanup)
SET FLAG_CLEAN=off
rem
rem allows changing of the file name, in case you want to run tests separately, or a file with the
rem same name already exists.
SET FILE=netTest.txt
rem
rem skips the check for a file with a name equal to %FILE%. Advanced users only.
SET FLAG_SKIPFILE=off
rem
rem BEGIN logic
rem
rem File check
rem
IF /I "%FLAG_SKIPFILE%" EQU "on" goto main
IF EXIST %FILE% goto abort-file
:main
rem
rem Header, contains tool version, free software notice, and Datestamp.
rem
ECHO =============Scath's Network Scanner v0.1.1============== > %FILE%
ECHO "This is a FREE TOOL. If you purchased this from anywhere, try to get a refund!" >> %FILE%
ECHO =============Date: %date%=================== >> %FILE%
rem
rem Tests
rem
IF /I "%FLAG_IPC%" EQU "on" (
	echo "testing IP Configuration, Please Wait..."
	ECHO ===============IPCONFIG================= >> %FILE%
	ipconfig /all >> %FILE%
)
IF /I "%FLAG_PINGL%" EQU "on" (
	echo testing ping capability, please wait... >> %FILE%
	ECHO =============PING LOCALHOST============= >> %FILE%
	ping -n 5 127.0.0.1 >> %FILE%
)
IF /I "%FLAG_PINGG%" EQU "on" (
	echo "testing gateway connection, Please Wait..."
	ECHO ==============PING GATE================= >> %FILE%
	ping -n 5 192.168.2.1 >> %FILE%
	ping -n 5 192.168.1.1 >> %FILE%
	ping -n 5 192.168.0.1 >> %FILE%
	ping -n 5 10.0.0.1 >> %FILE%
)
IF /I "%FLAG_PINGI%" EQU "on" (
	echo "pinging external IP, Please Wait..."
	ECHO ===============PING IP================== >> %FILE%
	ping -n 5 8.8.8.8 >> %FILE%
)
IF /I "%FLAG_PINGD%" EQU "on" (
	echo "pinging external Domain Name, Please Wait..."
	ECHO ===============PING DNS================= >> %FILE%
	ping -n 5 google.com >> %FILE%
)
IF /I "%FLAG_TRACE%" EQU "on" (
	echo "tracing route to google.com, Please Wait..."
	ECHO ===============TRACE==================== >> %FILE%
	tracert google.com >> %FILE%
)
ECHO ================EOF===================== >> %FILE%
rem
rem open file for viewing / copy pasting.
rem
notepad %FILE%
rem 
rem cleanup (if active)
rem
IF /I "%FLAG_CLEAN%" EQU "on" (
	echo please post or copy and paste the file into your reply, then
	pause
	del %FILE%
)
rem
rem skip error message
rem
goto end
rem
rem anchor for file exists error
rem
:abort-file
ECHO "CRITICAL ERROR: FILE/DIRECTORY %FILE% ALREADY EXISTS! EXITING..."
pause
:end
