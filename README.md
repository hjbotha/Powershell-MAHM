# Powershell-MAHM
 Submit system performance data from MSI Afterburner Remote Server to InfluxDB

# About
Inspired by [GamerGraf](https://github.com/ragesaq/gamergraf). Much as I love WSL I didn't really want to have to run that just to run CollectD so I wrote this instead. It submits metrics a bit differently so if using the GamerGraf it will need some minor adjustments if you want to use this script with it.

# Usage
- Clone this repository
- Rename Config.example.psd1 to Config.psd1 and edit it according to your requirement
- Run it, and/or create a Windows scheduled task to run it automatically when you log in (Remember to set MSI Afterburner and Remote Server to run at logon too)