@echo off

:: ###########################
:: TOOLS
:: windump.exe
:: procmon.exe
:: graphviz
:: ProcDot (post processing)
:: Windows PSR ( Event driven screen capture tool )
:: ###########################
:: SET WORKING DIRECTORY
set basePath=C:\Users\IEUser\Desktop\autoanalysis
:: ###########################
:: Variables
:: Get TimeStamp
:: See http://stackoverflow.com/q/1642677/1143274
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET DateTime=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%
set logPath=%basePath%\logs\%DateTime%
set toolPath=%basePath%\tools
:: ###########################

echo -----------------
echo Starting Analysis
echo -----------------

cd %basePath%
mkdir %logPath%

echo Starting Windump...
start /min %toolPath%\windump\windump.exe -s 0 -w %logPath%\capture.pcap

echo Starting Procmon...
start /min %toolPath%\SysinternalsSuite\procmon.exe /AcceptEula /Quiet /Minimized /backingfile %logPath%\capture.pml
start /min %toolPath%\SysinternalsSuite\procmon.exe /AcceptEula /WaitForIdle

echo Starting PSR...
start psr /start /output %logPath%\psr.zip /sc 1 /gui 0 

echo Sleeping 5 seconds...
ping -n 5 localhost > nul

echo Capturing Data... 
echo Execute test plan and close when done executing processes.
pause

start /min %toolPath%\SysinternalsSuite\procmon.exe /AcceptEula /Terminate
start /min %toolPath%\SysinternalsSuite\procmon.exe /AcceptEula /PagingFile /NoConnect /Minimized /Quiet

echo Killing windump
taskkill /im windump.exe /f

echo Sleeping 10 seconds...
ping -n 10 localhost > nul

echo Terminating Capture
%toolPath%\SysinternalsSuite\procmon.exe /Terminate

echo Sleeping 5 seconds...
ping -n 5 localhost > nul
psr /stop

echo Sleeping 5 seconds...
ping -n 5 localhost > nul

echo Saving as .csv
%toolPath%\SysinternalsSuite\procmon.exe /AcceptEula /OpenLog %logPath%\capture.pml /SaveAs %logPath%\capture.csv

echo.
echo Logs Saved - %logPath%

pause
