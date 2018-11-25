@echo off
if "%1" EQU "" (
start mstsc %userprofile%\Documents\Default.rdp ) else (
start mstsc %1
)