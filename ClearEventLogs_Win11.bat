@echo off
:: Script to clear all Windows Event Logs on Windows 11
:: NOTE: This script must be run with administrative privileges.

:: Loop through each event log and clear it
for /F "tokens=*" %%1 in ('wevtutil.exe el') DO (
    wevtutil.exe cl "%%1"
)