@setlocal enabledelayedexpansion
@echo off
Title Mapping Home Folder

set vpnconfig=%userprofile%\OpenVPN\config\
for /f "delims=" %%a in ('dir /s /b *.ovpn') do set "vpnconfig=%%a"
for %%a in (%vpnconfig%) do (
    set filename=%%~nxa
)
set vpnconfig=%filename%

echo Mapping Home Directory
echo ======================

echo Testing network...
ping %shareserver% -n 1 > nul 2>&1
if !errorlevel! neq 0 (
	echo Connecting VPN...
	start "VPN" "C:\Program Files\OpenVPN\bin\openvpn-gui.exe" --connect "%vpnconfig%"
	powershell sleep -s 10
)

echo Mapping Drive %shareserver%\%sharepath%...
net use h: /delete > nul 2>&1
if "%1" neq "" (
	net use h: \\%shareserver%\%sharepath% /user:%1 /persistent:no
) else (
	net use h: \\%shareserver%\%sharepath% /persistent:no
)
powershell sleep -s 1