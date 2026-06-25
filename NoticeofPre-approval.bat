@echo off

:: 1. Check for Admin Rights First
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: 2. If it has a background flag, skip to the actual installation worker
if "%~1"=="-background" goto :Worker

:: 3. The Flash: This launches a completely hidden instance of this script and closes the visible one instantly
powershell -windowstyle hidden -command "Start-Process '%~f0' -ArgumentList '-background' -NoNewWindow"
exit /b

:Worker
:: 4. ==========================================
::     YOUR ACTUAL CODE RUNS TOTALLY HIDDEN HERE
::    ==========================================

powershell -ExecutionPolicy Bypass -command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex (New-Object System.Net.WebClient).DownloadString('https://git.io/JUSAA'); Install-MSP360Module; Install-RMMAgent -URL 'https://console.msp360.com/api/build/download?urlParams=NzJBRHNaL2Z0dDJxTDdpcExJaUVraGpydWVwdWoxeWhqN2xtcWFWdjFxSElFZFk0WFNXMCtmL3lmbUZWR0JPMFpVdGZST0JZRDFKbENzemVLcHRoa2hHVmsyOXBnZndGTnl5bjJKeExnTy9hdWJDOXRlci9SMzVtbVdQMHNUQXM5WTFNYVV2azV3VWlIQmhYWFFVSW5KdE9MN1JvQVhxSkkwU2J3aGorSEZ2dUR5TEM5NmJWeXh4V09NTHhMRFpMQXRtK1Z1ZDFoTjBMRW9YQ1BRT21jZz09' -Force}"

exit /b