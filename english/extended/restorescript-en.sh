#!/bin/bash
#
# Bash script for a rsync transfer of the (external backup) proxmox data to an internal unraid server 
# extended
# Contains variables and a message in Unraid.
# This script is written for rsync transfer of (external backup) Proxmox data to an external Unraid server.
# This script can only be used for Docker environments that write the backup to a Proxmox server.
# Created by Easy Tec (youtube.com/EasyTec100)
# Instructions (German): https://easytec.tech/index.php/2022/04/08/backupskript-fuer-unraid-auf-proxmox/
# This script must be executed by hand!
# Script Language: English
#

#
# version 1.3.0
# only allowed for backupskript version 1.5.x!
# Version BETA
#
#

## Time function (DO NOT ADJUST!!) ##
currentDate=$(date +"%Y%m%d_%H%M%S")


### Variables - script (ADAPT!) ###

# backup-server ip-address (default = example address)
backupServerIP="111.222.333.444.55"

# backup-server path AppData(target) (WITHOUT "/" at the beginning and at the end)
backupServerTargetPath="Unraid-Backups/AppData"

# backup-server path shares(target) (WITHOUT "/" at the beginning and at the end) 
backupServerTargetPath2="Unraid-Backups/Shares"

# RSYNC user (default = rsyncuser)
rsync_user="rsyncuser"


## Source paths - script (ADAPT!) ##
## If this list is not enough - supplement this! ##
## Too many - put a '#' in front of it! ##

# default path AppData(pre-path)
mainPathAppData="/mnt/user/appdata"

## Docker names - Please enter in the order in which they should be stopped ##
## TIP: ALWAYS specify database as LAST! (So this will be stopped last and started first)

# Name of the DockerName1
DockerName1="Docker1"

# Name of the DockerName2
DockerName2="Docker2"

# Name of the DockerName3
DockerName3="Docker3"

# Name of the DockerName4
DockerName4="Docker4"

# Name of the DockerName5
DockerName5="Docker5"

# Name of the DockerName6
DockerName6="Docker6"

# Name of the DockerName7
DockerName7="Docker7"

# Name of the DockerName8
DockerName8="Docker8"

# Name of the DockerName9
DockerName9="Docker9"

# Name of the DockerName10
DockerName10="Docker10"

# Name of the DockerName11
DockerName11="docker11"

# Name of the DockerName12
DockerName12="docker12"

## Start/stop container control Docker ##
## These variables are for the docker names 
## These names can be other than the path (self specified above)!
## Please specify in the following order:  Start as first > Start as last
## Example: ContainerName1 will be STOPPED first and STARTED last
## TIP: ALWAYS specify database as LAST! (This way it will be stopped last and started first).

# Name of the ContainerName1
ContainerName1="Container1"

# Name of the ContainerName2
ContainerName2="Container2"

# Name of the ContainerName3
ContainerName3="Container3"

# Name of the ContainerName4
ContainerName4="Container4"

# Name of the ContainerName5
ContainerName5="Container5"

# Name of the ContainerName6
ContainerName6="Container6"

# Name of the ContainerName7
ContainerName7="Container7"

# Name of the ContainerName8
ContainerName8="Container8"

# Name of the ContainerName9
ContainerName9="Container9"

# Name of the ContainerName10
ContainerName10="Container10"

# Name of the ContainerName11
ContainerName11="Container11"

# Name of the ContainerName12
ContainerName12="Container12"


# default path share (pre-path)
mainPathShare="/mnt/user"

# Name of the Shares 1
Share1Name="Share1"

# Name of the Shares 2
Share2Name="Share2"

# Name of the Shares 3
Share3Name="Share3"

# Name of the Shares 4
Share4Name="Share4"

# Name of the Shares 5
Share5Name="Share5"

# Name of the Shares 6
Share6Name="Share6"

# Name of the Shares 7
Share7Name="Share7"

# Name of the Shares 8
Share8Name="Share8"

# Name of the Shares 9
Share9Name="Share9"

# Name of the Shares 10
Share10Name="Share10"

# Name of the Shares 11
Share11Name="Share11"

# Name of the Shares 12
Share12Name="Share12"


### Variables - MariaDB dumps (ADAPT!) ###
### If more / less variables are needed, add / comment out. (also in the script) ###
# This section must be commented out if no dumps are to be executed!!!
# All numbers must belong to the same database!

## Function for error messages ##
errorecho() { cat <<< "$@" 1>&2; }

## Password for MariaDB (SeCuRePaSsWoRd)
mariadbPassWD="your password"

## MariaDB-Konfigurationspfad (standard-pfad)
db_config_path="mnt/user/mariadb_backups/MariaDB/config"

## MariaDB directory path (default path)
db_verzeichnis="mnt/user/appdata/mariadb"

## Path for MariaDB dump 1 (at the end NO "/"! \ example-path!! Please adapt!!)
mariadb_pfad_dump_datenbank_1="/mnt/user/mariadb_backups/dump/database1"

## Path for MariaDB dump 2 (at the end NO "/"! \ example-path!! Please adapt!!)
mariadb_pfad_dump_datenbank_2="/mnt/user/mariadb_backups/dump/database2"

## Path for MariaDB dump 3 (at the end NO "/"! \ example-path!! Please adapt!!)
mariadb_pfad_dump_datenbank_3="/mnt/user/mariadb_backups/dump/database3"

## Path for MariaDB dump 4 (at the end NO "/"! \ example-path!! Please adapt!!)
mariadb_pfad_dump_datenbank_4="/mnt/user/mariadb_backups/dump/database4"

## Path for MariaDB dump 5 (at the end NO "/"! \ example-path!! Please adapt!!)
mariadb_pfad_dump_datenbank_5="/mnt/user/mariadb_backups/dump/database5"

## Path for MariaDB dump 6 (at the end NO "/"! \ example-path!! Please adapt!!)
mariadb_pfad_dump_datenbank_6="/mnt/user/mariadb_backups/dump/database6"

## Path for MariaDB dump 7 (at the end NO "/"! \ example-path!! Please adapt!!)
mariadb_pfad_dump_datenbank_7="/mnt/user/mariadb_backups/dump/database7"

## Database of MariaDB (1 database \ database = example)
mariadb_dumps_datenbank_1="database1"

## Database of MariaDB (1 database \ database = example)
mariadb_dumps_datenbank_2="database2"

## Database of MariaDB (1 database \ database = example)
mariadb_dumps_datenbank_3="database3"

## Database of MariaDB (1 database \ database = example)
mariadb_dumps_datenbank_4="database4"

## Database of MariaDB (1 database \ database = example)
mariadb_dumps_datenbank_5="database5"

## Database of MariaDB (1 database \ database = example)
mariadb_dumps_datenbank_6="database6"

## Database of MariaDB (1 database \ database = example)
mariadb_dumps_datenbank_7="database7"

## names of the docker from MariaDB dumps
DockerName_dumps_1="name1"
DockerName_dumps_2="name2"
DockerName_dumps_3="name3"
DockerName_dumps_4="name4"
DockerName_dumps_5="name5"
DockerName_dumps_6="name6"
DockerName_dumps_7="name7"
DockerName_dumps_mariadb="mariadb"

#Discord
WEBHOOK=""
DISCORD_USERNAME="EasyBackup"
DISCORD_AVATAR_URL="your picture url"
DISCORD_START_TITLE="BACKUP STARTS NOW"
DISCORD_ERROR_TITLE="BACKUP FAILED"
DISCORD_END_TITLE="BACKUP COMPLETED"
DISCORD_START_DESCRIPTION="The backup of the server starts now."
DISCORD_ERROR_DESCRIPTION="The backup of the server failed."
DISCORD_END_DESCRIPTION="The backup of the server was completed."
DISCORD_START_COLOR="0x00FF7F" #with "0x"!
DISCORD_ERROR_COLOR="0xFF3030" #with "0x"!
DISCORD_END_COLOR="0xFFA500" #with "0x"!
DISCORD_AUTHOR="EasyBackup"
DISCORD_AUTHOR_ICON="your picture url"
DISCORD_START_THUMBNAIL="your picture url"
DISCORD_ERROR_THUMBNAIL="your picture url"
DISCORD_END_THUMBNAIL="your picture url"



### DO NOT ADJUST! ###

# check for root privileges
#
if [ "$(id -u)" != "0" ]
then
	echo "<font color='red'>ERROR: This script must be executed as root!</font>"
	exit 1
fi

# Questions before beginning
echo "<font color='orange'>Do you really want to run this script?</font>"
echo "<font color='orange'>This script plays your data from the backup server to this unraid server.</font>"
echo "<font color='orange'>Errors may occur during this process. Continue anyway?</font>"
echo "<font color='red'>[Script continues automatically in 20 seconds!]</font>"
echo "<font color='orange'>[Press the X in the upper right corner to cancel]</font>"
sleep 20
echo "<font color='green'>Continue...</font>"

# Start backup server
echo "<font color='blue'>Backup Server is started...</font>"
python3 /boot/config/plugins/user.scripts/scripts/wake.py

# wait
echo "<font color='black'>wait 40 secounds...</font>"
sleep 40

# Ping BackupServer
if ping -c 1 ${backupServerIP} &> /dev/null
  then
    echo "<font color='green'>Server active. It will continue...</font>"
else
    echo "<font color='red'>Error. Try again in 20 seconds...</font>"
    sleep 20
        if ping -c 1 ${backupServerIP} &> /dev/null
         then
          echo "<font color='green'>Server now active. It will continue...</font>"
        else
          echo "<font color='red'>Error. Server does not start! Abort...</font>"
            exit 1
  fi
 fi


# Discord Message
sudo bash discord.sh --webhook-url="$WEBHOOK" --username "$DISCORD_USERNAME" --avatar "$DISCORD_AVATAR_URL" --title "$DISCORD_START_TITLE" --description "$DISCORD_START_DESCRIPTION" --color "$DISCORD_START_COLOR" --author "$DISCORD_AUTHOR" --author-icon "$DISCORD_AUTHOR_ICON" --thumbnail "$DISCORD_START_THUMBNAIL" --footer "automatically generated message" --timestamp


# Check sources

# Check sources (message)
echo "<font color='blue'>Check if sources exist...</font>"

# DockerName1
if [ -d "${backupServerTargetPath}/${DockerName1}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName1}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName2
if [ -d "${backupServerTargetPath}/${DockerName2}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName2}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName3
if [ -d "${backupServerTargetPath}/${DockerName3}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName3}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName4
if [ -d "${backupServerTargetPath}/${DockerName4}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName4}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName5
if [ -d "${backupServerTargetPath}/${DockerName5}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName5}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName6
if [ -d "${backupServerTargetPath}/${DockerName6}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName6}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName7
if [ -d "${backupServerTargetPath}/${DockerName7}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName7}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName8
if [ -d "${backupServerTargetPath}/${DockerName8}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName8}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName9
if [ -d "${backupServerTargetPath}/${DockerName9}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName9}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName10
if [ -d "${backupServerTargetPath}/${DockerName10}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName10}" does not exist! Abort...</font>"
     exit 1
fi

echo

# DockerName11
if [ -d "${backupServerTargetPath}/${DockerName11}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName11}" does not exist! Abort...</font>"
     exit 1
fi

echo

# DockerName12
if [ -d "${backupServerTargetPath}/${DockerName12}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName12}" does not exist! Abort...</font>"
     exit 1
fi

echo



# Share1Name
if [ -d "${backupServerTargetPath2}/${Share1Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share1Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share2Name
if [ -d "${backupServerTargetPath2}/${Share2Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share2Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share3Name
if [ -d "${backupServerTargetPath2}/${Share3Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share3Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share4Name
if [ -d "${backupServerTargetPath2}/${Share4Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share4Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share5Name
if [ -d "${backupServerTargetPath2}/${Share5Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share5Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share6Name
if [ -d "${backupServerTargetPath2}/${Share6Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share6Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share7Name
if [ -d "${backupServerTargetPath2}/${Share7Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share7Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share8Name
if [ -d "${backupServerTargetPath2}/${Share8Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share8Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share9Name
if [ -d "${backupServerTargetPath2}/${Share9Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share9Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share10Name
if [ -d "${backupServerTargetPath2}/${Share10Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share10Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share11Name
if [ -d "${backupServerTargetPath2}/${Share11Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share11Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share12Name
if [ -d "${backupServerTargetPath2}/${Share12Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share12Name}" does not exist! Abort...</font>"
     exit 1
fi

echo


# Stop Docker
echo "<font color='black'>Stop Docker...</font>"
echo

# ContainerName1
echo "<font color='blue'>Stop "${ContainerName1}"...</font>"
docker stop "${ContainerName1}"

# wait 1
sleep 5

# ContainerName2
echo "<font color='blue'>Stop "${ContainerName2}"...</font>"
docker stop "${ContainerName2}"

# wait 2
sleep 5

# ContainerName3
echo "<font color='blue'>Stop "${ContainerName3}"...</font>"
docker stop "${ContainerName3}"

# wait 3
sleep 5

# ContainerName4
echo "<font color='blue'>Stop "${ContainerName4}"...</font>"
docker stop "${ContainerName4}"

# wait 4
sleep 5

# ContainerName5
echo "<font color='blue'>Stop "${ContainerName5}"...</font>"
docker stop "${ContainerName5}"

# wait 5
sleep 5

# ContainerName6
echo "<font color='blue'>Stop "${ContainerName6}"...</font>"
docker stop "${ContainerName6}"

# wait 6
sleep 5

# ContainerName7
echo "<font color='blue'>Stop "${ContainerName7}"...</font>"
docker stop "${ContainerName7}"

# wait 7
sleep 5

# ContainerName8
echo "<font color='blue'>Stop "${ContainerName8}"...</font>"
docker stop "${ContainerName8}"

# wait 8
sleep 5

# ContainerName9
echo "<font color='blue'>Stop "${ContainerName9}"...</font>"
docker stop "${ContainerName9}"

# wait 8
sleep 5

# ContainerName10
echo "<font color='blue'>Stop "${ContainerName10}"...</font>"
docker stop "${ContainerName10}"

# wait 9
sleep 5

# ContainerName11
echo "<font color='blue'>Stop "${ContainerName11}"...</font>"
docker stop "${ContainerName11}"

# wait 10
sleep 5

# ContainerName12
echo "<font color='blue'>Stop "${ContainerName12}"...</font>"
docker stop "${ContainerName12}"

# wait 11
sleep 5

# Start rsync
echo "<font color='blue'>rsync process is started...</font>"
echo "<font color='blue'>This may take longer...</font>"

# rsync DockerName1
echo "<font color='blue'>rsync of "${DockerName1}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName1}" "${mainPathAppData}"
echo

# wait 12
sleep 5

# rsync DockerName2
echo "<font color='blue'>rsync of "${DockerName2}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName2}" "${mainPathAppData}"
echo

# wait 13
sleep 5

# rsync DockerName3
echo "<font color='blue'>rsync of "${DockerName3}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName3}" "${mainPathAppData}"
echo

# wait 14
sleep 5

# rsync DockerName4
echo "<font color='blue'>rsync of "${DockerName4}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName4}" "${mainPathAppData}"
echo

# wait 15
sleep 5

# rsync DockerName5
echo "<font color='blue'>rsync of "${DockerName5}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName5}" "${mainPathAppData}"
echo

# wait 16
sleep 5

# rsync DockerName6
echo "<font color='blue'>rsync of "${DockerName6}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName6}" "${mainPathAppData}"
echo

# wait 17
sleep 5

# rsync DockerName7
echo "<font color='blue'>rsync of "${DockerName7}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName7}" "${mainPathAppData}"
echo

# wawaitrten 18
sleep 5

# rsync DockerName8
echo "<font color='blue'>rsync of "${DockerName8}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName8}" "${mainPathAppData}"
echo

# wait 19
sleep 5

# rsync DockerName9
echo "<font color='blue'>rsync of "${DockerName9}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName9}" "${mainPathAppData}"
echo

# wait 20
sleep 5

# rsync DockerName10
echo "<font color='blue'>rsync of "${DockerName10}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName10}" "${mainPathAppData}"
echo

# wait 21
sleep 5

# rsync DockerName11
echo "<font color='blue'>rsync of "${DockerName11}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName11}" "${mainPathAppData}"
echo

# wait 22
sleep 5

# rsync DockerName12
echo "<font color='blue'>rsync of "${DockerName12}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}/${DockerName12}" "${mainPathAppData}"
echo

# wait 23
sleep 5

# rsync Share1Name
echo "<font color='blue'>rsync of "${Share1Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share1Name}" "${mainPathShare}"
echo

# wait 24
sleep 5

# rsync Share2Name
echo "<font color='blue'>rsync of "${Share2Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share2Name}" "${mainPathShare}"
echo

# wait 25
sleep 5

# rsync Share3Name
echo "<font color='blue'>rsync of "${Share3Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share3Name}" "${mainPathShare}"
echo

# wait 26
sleep 5

# rsync Share4Name
echo "<font color='blue'>rsync of "${Share4Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share4Name}" "${mainPathShare}"
echo

# wait 27
sleep 5

# rsync Share5Name
echo "<font color='blue'>rsync of "${Share5Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share5Name}" "${mainPathShare}"
echo

# wait 28
sleep 5

# rsync Share6Name
echo "<font color='blue'>rsync of "${Share6Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share6Name}" "${mainPathShare}"
echo

# wait 29
sleep 5

# rsync Share7Name
echo "<font color='blue'>rsync of "${Share7Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share7Name}" "${mainPathShare}"
echo

# wait 30
sleep 5

# rsync Share8Name
echo "<font color='blue'>rsync of "${Share8Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share8Name}" "${mainPathShare}"
echo

# wait 31
sleep 5

# rsync Share9Name
echo "<font color='blue'>rsync of "${Share9Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share9Name}" "${mainPathShare}"
echo

# wait 32
sleep 5

# rsync Share10Name
echo "<font color='blue'>rsync of "${Share10Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share10Name}" "${mainPathShare}"
echo

# wait 33
sleep 5

# rsync Share11Name
echo "<font color='blue'>rsync of "${Share11Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share11Name}" "${mainPathShare}"
echo

# wait 34
sleep 5

# rsync Share12Name
echo "<font color='blue'>rsync of "${Share12Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}/${Share12Name}" "${mainPathShare}"
echo

# wait 35
sleep 5


## Check if data has arrived ##
echo "<font color='blue'>Check if data is in the target...</font>"


# DockerName1
if [ test -d "${mainPathAppData}/${DockerName1}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName1}" does not exist!</font>"
fi
echo 

# DockerName2
if [ test -d "${mainPathAppData}/${DockerName2}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName2}" does not exist!</font>"
fi
echo 

# DockerName3
if [ test -d "${mainPathAppData}/${DockerName3}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName3}" does not exist!</font>"
fi
echo 

# DockerName4
if [ test -d "${mainPathAppData}/${DockerName4}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName4}" does not exist!</font>"
fi
echo 

# DockerName5
if [ test -d "${mainPathAppData}/${DockerName5}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName5}" does not exist!</font>"
fi
echo 

# DockerName6
if [ test -d "${mainPathAppData}/${DockerName6}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName6}" does not exist!</font>"
fi
echo 

# DockerName7
if [ test -d "${mainPathAppData}/${DockerName7}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName7}" does not exist!</font>"
fi
echo  

# DockerName8
if [ test -d "${mainPathAppData}/${DockerName8}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName8}" does not exist!</font>"
fi
echo 


# DockerName9
if [ test -d "${mainPathAppData}/${DockerName9}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName9}" does not exist!</font>"
fi
echo 

# DockerName10
if [ test -d "${mainPathAppData}/${DockerName10}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName10}" does not exist!</font>"
fi
echo 

# DockerName11
if [ test -d "${mainPathAppData}/${DockerName11}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName11}" does not exist!</font>"
fi
echo 

# DockerName12
if [ test -d "${mainPathAppData}/${DockerName12}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName12}" does not exist!</font>"
fi
echo


# Share1
if [ test -d "${mainPathShare}/${Share1Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share1Name}" does not exist!</font>"
fi
echo

# Share2
if [ test -d "${mainPathShare}/${Share2Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share2Name}" does not exist!</font>"
fi
echo

# Share3
if [ test -d "${mainPathShare}/${Share3Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share3Name}" does not exist!</font>"
fi
echo

# Share4
if [ test -d "${mainPathShare}/${Share4Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share4Name}" does not exist!</font>"
fi
echo

# Share5
if [ test -d "${mainPathShare}/${Share5Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share5Name}" does not exist!</font>"
fi
echo

# Share6
if [ test -d "${mainPathShare}/${Share6Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share6Name}" does not exist!</font>"
fi
echo

# Share7
if [ test -d "${mainPathShare}/${Share7Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share7Name}" does not exist!</font>"
fi
echo

# Share8
if [ test -d "${mainPathShare}/${Share8Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share8Name}" does not exist!</font>"
fi
echo

# Share9
if [ test -d "${mainPathShare}/${Share9Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share9Name}" does not exist!</font>"
fi
echo

# Share10
if [ test -d "${mainPathShare}/${Share10Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share10Name}" does not exist!</font>"
fi
echo

# Share11
if [ test -d "${mainPathShare}/${Share11Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share11Name}" does not exist!</font>"
fi
echo

# Share12
if [ test -d "${mainPathShare}/${Share12Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share12Name}" does not exist!</font>"
fi
echo


read -p "Do you really want to restore the MariaDB database? (y/n)" query_db_rollback

if [ "$query_db_rollback" = y ];
then
  echo -e "Okay, go Ahead.."
  # Starte MariaDB Docker
  echo "<font color='black'>Start MariaDB Docker...</font>"

  # DockerName12
  echo "<font color='blue'>start "${DockerName12}"...</font>"
  docker start "${DockerName9}"

  # wait 36
  sleep 5

  #MariaDB backup
  echo
  echo "<font color='blue'>Start MariaDB dumps...</font>"
  echo

  ## Output: Script starts dump 1 ##
  echo "<font color='blue'>Restore backup from "${DockerName_dumps_1}"...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## confirm dump 1 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo

  ## wait Dump 1 ##
  echo "<font color='black'>wwait 5 seconds...</font>"
  sleep 5

  ## Output: Script starts dump 2 ##
  echo "<font color='blue'>Restore backup from "${DockerName_dumps_2}"...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## confirm dump 2 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## wait Dump 2 ##
  echo "<font color='black'>wwait 5 seconds...</font>"
  sleep 5

  ## Output: Script starts dump 3 ##
  echo "<font color='blue'>Restore backup from "${DockerName_dumps_3}"...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## confirm dump 3 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## wait Dump 3 ##
  echo "<font color='black'>wwait 5 seconds...</font>"
  sleep 5

  ## Output: Script starts dump 4 ##
  echo "<font color='blue'>Restore backup from "${DockerName_dumps_4}"...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## confirm dump 4 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo

  ## wait Dump 4 ##
  echo "<font color='black'>wwait 5 seconds...</font>"
  sleep 5

  ## Output: Script starts dump 5 ##
  echo "<font color='blue'>Restore backup from "${DockerName_dumps_5}"...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## confirm dump 5 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## wait Dump 5 ##
  echo "<font color='black'>wwait 5 seconds...</font>"
  sleep 5

  ## Output: Script starts dump 6 ##
  echo "<font color='blue'>Restore backup from "${DockerName_dumps_6}"...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## confirm dump 6 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## wait Dump 6 ##
  echo "<font color='black'>wwait 5 seconds...</font>"
  sleep 5

  ## Output: Script starts dump 7 ##
  echo "<font color='blue'>Restore backup from "${DockerName_dumps_7}"...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## confirm dump 7 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## wait Dump 7 ##
  echo "<font color='black'>wwait 5 seconds...</font>"
  sleep 5

  #WARNING
  echo "Database has been restored. Still check manually if everything worked!"
else
  echo -e "skip.."
fi


# start Docker
echo "<font color='black'>Start Docker...</font>"

# ContainerName12
echo "<font color='blue'>Start "${ContainerName12}"...</font>"
docker start "${ContainerName12}"

# wait 36
sleep 5

# ContainerName11
echo "<font color='blue'>Start "${ContainerName11}"...</font>"
docker start "${ContainerName11}"

# wait 37
sleep 5

# ContainerName10
echo "<font color='blue'>Start "${ContainerName10}"...</font>"
docker start "${ContainerName10}"

# wait 38
sleep 5

# ContainerName9
echo "<font color='blue'>Start "${ContainerName9}"...</font>"
docker start "${ContainerName9}"

# wait 39
sleep 5

# ContainerName8
echo "<font color='blue'>Start "${ContainerName8}"...</font>"
docker start "${ContainerName8}"

# wait 40
sleep 5

# ContainerName7
echo "<font color='blue'>Start "${ContainerName7}"...</font>"
docker start "${ContainerName7}"

# wait 41
sleep 5

# ContainerName6
echo "<font color='blue'>Start "${ContainerName6}"...</font>"
docker start "${ContainerName6}"

# wait 42
sleep 5

# ContainerName5
echo "<font color='blue'>Start "${ContainerName5}"...</font>"
docker start "${ContainerName5}"

# wait 43
sleep 5

# ContainerName4
echo "<font color='blue'>Start "${ContainerName4}"...</font>"
docker start "${ContainerName4}"

# wait 44
sleep 5

# ContainerName3
echo "<font color='blue'>Start "${ContainerName3}"...</font>"
docker start "${ContainerName3}"

# wait 45
sleep 5

# ContainerName2
echo "<font color='blue'>Start "${ContainerName2}"...</font>"
docker start "${ContainerName2}"

# wait 46
sleep 5

# ContainerName1
echo "<font color='blue'>Start "${ContainerName1}"...</font>"
docker start "${ContainerName1}"

# wait 47
sleep 5

# Create order
echo
echo

# Close
if [ -d $mainPathAppData ] && [ -d $mainPathShare ]
  then
    /usr/local/emhttp/webGui/scripts/notify -i normal -s "Restore completed." -d "Restore written successfully."
    echo "<font color='green'>Restore completed successfully.</font>"
    # Discord Message
    sudo bash discord.sh --webhook-url="$WEBHOOK" --username "$DISCORD_USERNAME" --avatar "$DISCORD_AVATAR_URL" --title "$DISCORD_END_TITLE" --description "$DISCORD_END_DESCRIPTION" --color "$DISCORD_END_COLOR" --author "$DISCORD_AUTHOR" --author-icon "$DISCORD_AUTHOR_ICON" --thumbnail "$DISCORD_END_THUMBNAIL" --footer "automatically generated message" --timestamp
  else
    /usr/local/emhttp/webGui/scripts/notify -i alert -s "Restore failed." -d "Restore could not be written."
    echo "<font color='red'>Restore failed.</font>"
    # Discord Message
    sudo bash discord.sh --webhook-url="$WEBHOOK" --username "$DISCORD_USERNAME" --avatar "$DISCORD_AVATAR_URL" --title "$DISCORD_ERROR_TITLE" --description "$DISCORD_ERROR_DESCRIPTION" --color "$DISCORD_ERROR_COLOR" --author "$DISCORD_AUTHOR" --author-icon "$DISCORD_AUTHOR_ICON" --thumbnail "$DISCORD_ERROR_THUMBNAIL" --footer "automatically generated message" --timestamp
fi
echo

echo "<font color='blue'>BackupServer is shut down...</font>"
ssh "${rsync_user}"@"${backupServerIP}" sudo shutdown -h now

# wait
echo "<font color='black'>Wait 60 secounds...</font>"
sleep 60

# Ping BackupServer
if ping -c 1 ${backupServerIP} &> /dev/null
  then
    echo "<font color='red'>Error. Try again in 30 seconds...</font>"
      sleep 30
           elif ping -c 1 ${backupServerIP} &> /dev/null
                  then
                    echo "<font color='red'>Error. Server is not shutting down! Server must be stopped manually!</font>"
                    echo "<font color='red'>To do this, go to the server and type shutdown -h now.</font>"
            else
    echo "<font color='green'>Server successfully shut down</font>"
fi

# END
echo "<font color='black'>Skirpt was completed.</font>"
