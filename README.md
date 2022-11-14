# Backup-and-Restore Script
This repository is about backup/restore scripts for a Unraid system. (Scripts are available in English and German).
These backup/restore scripts have been tested by me personally. 
However, I do not assume any liability if these scripts cause any damage. 
Any person can check these scripts at any time! Before using any of the scripts, please fill in the variables!

With my scripts in this repository you can make a backup/restore from a Unraid server. This backup will be written to a proxmox server. 

# Warnings / Important information
- Read the README.md and the LICENCE.md carefully if you want to use or reuse the script.

- Adjust all variables! Otherwise errors may occur.

- Instructions can be found in my blog: [German](https://blog.easytec.tech/index.php/2022/11/14/backupskript-fuer-unraid-auf-proxmox/) / [English](https://easytec.tech/index.php/en/2022/05/14/backup-script-for-unraid-on-proxmox/)

- All my scripts are currently in BETA VERSION! There may be errors or bugs!

- In case of errors, read the error carefully. *(Report the error if necessary)*

- Please note that the restore script can NOT run AUTOMATICALLY for security reasons.

- Both my scripts are available in English and in German.
In both languages there is a version with or without a cache folder. That means, if you use a cache on your Unraid system, you need the script for "with cache".
But if you don't use a cache, you need to use the normal script.

# Preconditions
- Proxmox server (backup server)
- Unraid server (server with data -> for backup)
- at least as big hard disk in backup server (Proxmox) as data on Unraid server
- Authorize Proxmox ssh access (by IP address) ([YouTube-Tutorial-german](https://youtu.be/K1mC23QjsSY))
- activate WakeOnLan autostart for Proxmox ([YouTube-Tutorial-german](https://youtu.be/lArZdf0d_Ow))

# Explanation of scripts:
- **Normal** (directly in the ```german/english``` folder): Backup/Restore of the data
- **mariadb_backup** (in the folder ```german/english /mariadb_backup``` ): backup/restore of data + backup/restore database
- **discord** (in the folder ```german/english /discord``` ): Backup/restore of the data + discordWebhook message
- **extended** (in the folder ```german/english /extended``` ): backup/restore data + backup/restore database + discordWebhook message

***Please note that there is currently no script for the "Cache" folder, where functions like "Discord" or "MariaDB" are available. This must be put together independently! (Or it will be added at a later time and inserted here)***

# Usage
1. Download the backup/restore script.
2. **ADJUST ALL VARIABLES** in the script
3.  Go to your Unraid web interface. Publicly under the point "SETTINGS" "Userscripts". Create a new script with "ADD NEW SCRIPT" and insert the **ADAPTED** script.
4. Save the script with the "SAVE CHANGES" button
5. Run the script by clicking the "RUN SCRIPT" button


last change: 25.09.2022
