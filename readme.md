# ProDot Sandbox - AutoAnalysis

Quick Malware Analysis Toolkit. This repository contains quick setup notes to setup a malware analysis sandbox using a variety of tools and uses ProcDot to perform the analysis.

These instructions are very highlevel. You will need to adjust to work in your lab.

[ProcDot](http://www.procdot.com/)

## Requirements

- Target OS (Windows 10/7)
- graphviz - http://www.graphviz.org/
- ProcDOT - http://www.procdot.com/
- WinPcap - https://www.winpcap.org/
- Windump - https://www.winpcap.org/windump/default.htm
- ProcMon [Sysinternals Suite https://docs.microsoft.com/en-us/sysinternals/](https://docs.microsoft.com/en-us/sysinternals/)
- PSR - Problem Step Recorder (Built in Windows tool)

OPTIONAL: Python to run CSV_parser 

The CSV_parser directory contains a python script that can help filter noise from the procmon CSV logs.

--------------
## Installation

- Download/extract tools to a common directory
    + This example uses C:\Users\IEUser\Desktop\autoanalysis\tools\
- Install WinPcap

## Configuration

### ProcDOT

Open ProcDOT and configure the following options

**Note:** More detailed installation information can be found here [ProcDot](http://www.procdot.com/)

__Path to windump/tcpdump__

    C:\Users\IEUser\Desktop\autoanalysis\tools\windump\WinDump.exe

__Path to dot (Graphviz)__

    C:\Users\IEUser\Desktop\autoanalysis\tools\graphviz-2.38\release\bin\dot.exe

### ProcMon

You need to adjust Procmon's configuration to be compatible with ProcDOT.

__In Procmon__

- disable (uncheck) "Show Resolved Network Addresses" (Options)
- disable (uncheck) "Enable Advanced Output" (Filter)
- adjust the displayed columns (Options > Select Columns ...)
  + to not show the "Sequence" column
  + to show the "Thread ID" column

--------------
## Quick Start

1. Run AutoAnalysis.bat as Administrator
2. Execute Malware
3. Stop AutoAnalysis
4. Analyze Results

## Analyze with ProcDOT

1. Open procdot.exe

__Monitoring Logs__

Procmon:   browse to procmon capture.csv
Procmon: browse to pcap capture.pcap

2. Click ... in the Launcher button to analyze logs

3. Select the first relavant process

4. Click Refresh to build the graph

5. Proceed to analyze results

--------------
## Analyst Tips 

__Tune logs__

- Consider filtering out unnecessary data from PCAP
- Consider removing unnecessary procmon logs from the report
    + CSV_parser contains a python script that can help filter the procmon CSV logs