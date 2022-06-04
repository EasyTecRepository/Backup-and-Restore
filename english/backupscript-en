#!/bin/bash
#
# Bash script for an rsync transfer of the Unraid data to an external backup server (Proxmox) 
#
# Contains variables and a message in Unraid.
# This script is written for rsync transfer of Unraid data to an external backup server.
# This script can only be used for docker environments that write the backup to a proxmox server.
# Created by Easy Tec (youtube.com/EasyTec100)
# Instructions (German): https://easytec.tech/index.php/2022/04/08/backupskript-fuer-unraid-auf-proxmox/
# Script Language: English
#

#
# Version 1.2.8
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
DockerName1="docker1"

# Name of the DockerName2
DockerName2="docker2"

# Name of the DockerName3
DockerName3="docker3"

# Name of the DockerName4
DockerName4="docker4"

# Name of the DockerName5
DockerName5="docker5"

# Name of the DockerName6
DockerName6="docker6"

# Name o the DockerName7
DockerName7="docker7"

# Name of the DockerName8
DockerName8="docker8"

# Name of the DockerName9
DockerName9="docker9"

# Name of the DockerName10
DockerName10="docker10"

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
Share1Name="share1"

# Name of the Shares 2
Share2Name="share2"

# Name of the Shares 3
Share3Name="share3"

# Name of the Shares 4
Share4Name="share4"

# Name of the Shares 5
Share5Name="share5"

# Name of the Shares 6
Share6Name="share6"

# Name of the Shares 7
Share7Name="share7"

# Name of the Shares 8
Share8Name="share8"

# Name of the Shares 9
Share9Name="share9"

# Name of the Shares 10
Share10Name="share10"

# Name of the Shares 11
Share11Name="share11"

# Name of the Shares 12
Share12Name="share12"


### DO NOT ADJUST! ###

# check for root privileges
#
if [ "$(id -u)" != "0" ]
then
	echo "<font color='red'>ERROR: This script must be executed as root!</font>"
	exit 1
fi

# Check sources

# Check sources (message)
echo "<font color='blue'>Check if sources exist...</font>"

# DockerName1
if [ -d "${mainPathAppData}/${DockerName1}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName1}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName2
if [ -d "${mainPathAppData}/${DockerName2}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName2}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName3
if [ -d "${mainPathAppData}/${DockerName3}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName3}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName4
if [ -d "${mainPathAppData}/${DockerName4}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName4}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName5
if [ -d "${mainPathAppData}/${DockerName5}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName5}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName6
if [ -d "${mainPathAppData}/${DockerName6}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName6}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName7
if [ -d "${mainPathAppData}/${DockerName7}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName7}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName8
if [ -d "${mainPathAppData}/${DockerName8}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName8}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName9
if [ -d "${mainPathAppData}/${DockerName9}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName9}" does not exist! Abort...</font>"
     exit 1
fi

echo 

# DockerName10
if [ -d "${mainPathAppData}/${DockerName10}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName10}" does not exist! Abort...</font>"
     exit 1
fi

echo

# DockerName11
if [ -d "${mainPathAppData}/${DockerName11}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName11}" does not exist! Abort...</font>"
     exit 1
fi

echo

# DockerName12
if [ -d "${mainPathAppData}/${DockerName12}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName12}" does not exist! Abort...</font>"
     exit 1
fi

echo



# Share1Name
if [ -d "${mainPathShare}/${Share1Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share1Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share2Name
if [ -d "${mainPathShare}/${Share2Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share2Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share3Name
if [ -d "${mainPathShare}/${Share3Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share3Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share4Name
if [ -d "${mainPathShare}/${Share4Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share4Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share5Name
if [ -d "${mainPathShare}/${Share5Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share5Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share6Name
if [ -d "${mainPathShare}/${Share6Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share6Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share7Name
if [ -d "${mainPathShare}/${Share7Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share7Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share8Name
if [ -d "${mainPathShare}/${Share8Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share8Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share9Name
if [ -d "${mainPathShare}/${Share9Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share9Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share10Name
if [ -d "${mainPathShare}/${Share10Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share10Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share11Name
if [ -d "${mainPathShare}/${Share11Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share11Name}" does not exist! Abort...</font>"
     exit 1
fi

echo

# Share12Name
if [ -d "${mainPathShare}/${Share12Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share12Name}" does not exist! Abort...</font>"
     exit 1
fi

echo


###

# Start backup server
echo "<font color='blue'>Backup Server is started...</font>"
python3 /boot/config/plugins/user.scripts/scripts/wake.py

# wait
echo "<font color='black'>wait 40 seconds...</font>"
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


## create order ##
echo
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


# Create order
echo
echo


# start rsync
echo "<font color='blue'>rsync process is started...</font>"
echo "<font color='blue'>This may take longer...</font>"

# rsync DockerName1
echo "<font color='blue'>rsync of "${DockerName1}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName1}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 12
sleep 5

# rsync DockerName2
echo "<font color='blue'>rsyn of "${DockerName2}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName2}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 13
sleep 5

# rsync DockerName3
echo "<font color='blue'>rsync of "${DockerName3}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName3}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 14
sleep 5

# rsync DockerName4
echo "<font color='blue'>rsync of "${DockerName4}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName4}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 15
sleep 5

# rsync DockerName5
echo "<font color='blue'>rsync of "${DockerName5}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName5}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 16
sleep 5

# rsync DockerName6
echo "<font color='blue'>rsync of "${DockerName6}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName6}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 17
sleep 5

# rsync DockerName7
echo "<font color='blue'>rsync of "${DockerName7}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName7}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 18
sleep 5

# rsync DockerName8
echo "<font color='blue'>rsync of "${DockerName8}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName8}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 19
sleep 5

# rsync DockerName9
echo "<font color='blue'>rsync of "${DockerName9}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName9}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 20
sleep 5

# rsync DockerName10
echo "<font color='blue'>rsync of "${DockerName10}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName10}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 21
sleep 5

# rsync DockerName11
echo "<font color='blue'>rsync of "${DockerName11}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName11}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 22
sleep 5

# rsync DockerName12
echo "<font color='blue'>rsync of "${DockerName12}"...</font>"
sudo rsync --ignore-existing -az "${mainPathAppData}/${DockerName12}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath}"
echo

# wait 23
sleep 5

# rsync Share1Name
echo "<font color='blue'>rsync of "${Share1Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share1Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 24
sleep 5

# rsync Share2Name
echo "<font color='blue'>rsync of "${Share2Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share2Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 25
sleep 5

# rsync Share3Name
echo "<font color='blue'>rsync of "${Share3Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share3Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 26
sleep 5

# rsync Share4Name
echo "<font color='blue'>rsync of "${Share4Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share4Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 27
sleep 5

# rsync Share5Name
echo "<font color='blue'>rsync of "${Share5Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share5Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 28
sleep 5

# rsync Share6Name
echo "<font color='blue'>rsync of "${Share6Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share6Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 29
sleep 5

# rsync Share7Name
echo "<font color='blue'>rsync of "${Share7Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share7Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 30
sleep 5

# rsync Share8Name
echo "<font color='blue'>rsync of "${Share8Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share8Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 31
sleep 5

# rsync Share9Name
echo "<font color='blue'>rsync of "${Share9Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share9Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 32
sleep 5

# rsync Share10Name
echo "<font color='blue'>rsync of "${Share10Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share10Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 33
sleep 5

# rsync Share11Name
echo "<font color='blue'>rsync of "${Share11Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share11Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 34
sleep 5

# rsync Share12Name
echo "<font color='blue'>rsync of "${Share12Name}"...</font>"
sudo rsync --ignore-existing -az "${mainPathShare}/${Share12Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerTargetPath2}"
echo

# wait 35
sleep 5


## Prüfen Sie, ob Daten angekommen sind ##
echo "<font color='blue'>Check if data is in the target...</font>"


# DockerName1
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName1}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName1}" does not exist!</font>"
fi
echo 

# DockerName2
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName2}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName2}" does not exist!</font>"
fi
echo 

# DockerName3
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName3}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName3}" does not exist!</font>"
fi
echo 

# DockerName4
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName4}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName4}" does not exist!</font>"
fi
echo 

# DockerName5
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName5}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName5}" does not exist!</font>"
fi
echo 

# DockerName6
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName6}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName6}" does not exist!</font>"
fi
echo 

# DockerName7
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName7}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName7}" does not exist!</font>"
fi
echo  

# DockerName8
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName8}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName8}" does not exist!</font>"
fi
echo 


# DockerName9
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName9}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName9}" does not exist!</font>"
fi
echo 

# DockerName10
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName10}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName10}" does not exist!</font>"
fi
echo 

# DockerName11
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName11}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName11}" does not exist!</font>"
fi
echo 

# DockerName12
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath}/${DockerName12}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${DockerName12}" does not exist!</font>"
fi
echo


# Share1
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share1Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share1Name}" does not exist!</font>"
fi
echo

# Share2
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share2Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share2Name}" does not exist!</font>"
fi
echo

# Share3
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share3Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share3Name}" does not exist!</font>"
fi
echo

# Share4
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share4Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share4Name}" does not exist!</font>"
fi
echo

# Share5
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share5Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share5Name}" does not exist!</font>"
fi
echo

# Share6
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share6Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share6Name}" does not exist!</font>"
fi
echo

# Share7
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share7Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share7Name}" does not exist!</font>"
fi
echo

# Share8
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share8Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share8Name}" does not exist!</font>"
fi
echo

# Share9
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share9Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share9Name}" does not exist!</font>"
fi
echo

# Share10
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share10Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share10Name}" does not exist!</font>"
fi
echo

# Share11
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share11Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share11Name}" does not exist!</font>"
fi
echo

# Share12
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerTargetPath2}/${Share12Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Directory of "${Share12Name}" does not exist!</font>"
fi
echo


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


## Finish ##

# Close
if ! ssh "${rsync_user}"@"${backupServerIP}" "ls /"${backupServerTargetPath}" >/dev/null 2>&1" && ! ssh "${rsync_user}"@"${backupServerIP}" "ls /"${backupServerTargetPath2}" >/dev/null 2>&1"
  then
    /usr/local/emhttp/webGui/scripts/notify -i normal -s "Backup completed." -d "Backup successfully written to Proxmox."
    echo "<font color='green'>Script successfully completed.</font>"         
  else
    /usr/local/emhttp/webGui/scripts/notify -i alert -s "Backup failed." -d "Backup could not be written to Proxmox."
    echo "<font color='red'>Script failed.</font>"
fi
echo

echo "<font color='blue'>BackupServer is shut down...</font>"
ssh "${rsync_user}"@"${backupServerIP}" sudo shutdown -h now

# wait
echo "<font color='black'>Wait 60 seconds...</font>"
sleep 60

# Ping BackupServer
if ping -c 1 ${backupServerIP} &> /dev/null
  then
    echo "<font color='red'>Error. Try again in 30 seconds...</font>"
      sleep 30
           elif ping -c 1 ${backupServerIP} &> /dev/null
                  then
                    echo "<font color='red'>Error. Server is not shutting down! Server must be stopped manually!</font>"
                    echo "<font color='red'>To do this, go to the server and type  shutdown -h  now.</font>"
            else
    echo "<font color='green'>Server successfully shut down</font>"
fi

# END
echo "<font color='black'>Skirpt was completed.</font>"
