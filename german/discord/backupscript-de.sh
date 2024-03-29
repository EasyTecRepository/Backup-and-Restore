#!/bin/bash
#
# Bash skript fuer eine rsync uebertragung der Unraid Daten auf einen externen Backup-server (Proxmox) 
# Es werden Discord messages versendet.
# Enthaelt Variablen und eine Message in Unraid.
# Dieses Skript ist fuer eine rsync uebertragung der Unraid daten auf einen externen Backup-server geschrieben worden.
# Dieses Skript kann nur fuer Docker umgebungen verwendet werden, die das Backup auf einen Proxmox server schreiben.
# Erstellt von Easy Tec (youtube.com/EasyTec100)
# Anleitung (German): https://easytec.tech/index.php/2022/04/08/backupskript-fuer-unraid-auf-proxmox/
# Script Language: German
#

#
# Version 1.4.0
# Version BETA 
#
#

## Zeitfunktion (NICHT ANPASSEN!!) ##
currentDate=$(date +"%Y%m%d_%H%M%S")


### Variablen - Skript (ANPASSEN!) ###

# backup-server ip-adresse (standard = beispiel-adresse)
backupServerIP="111.222.333.444.55"

# backup-server Pfad AppData(Ziel) (OHNE "/" am Anfang und am ende)
backupServerZielPfad="Unraid-Backups/AppData"

# backup-server Pfad Shares(Ziel) (OHNE "/" am Anfang und am ende) 
backupServerZielPfad2="Unraid-Backups/Shares"

# RSYNC user (Standard = rsyncuser)
rsync_user="rsyncuser"

## Quellen-Pfade - Skript (ANPASSEN!) ##
## Wenn diese liste nicht reicht - ergaenzt diese! ##
## Zu viele - macht ein '#' davor! ##

# Standard-Pfad AppData(vor-pfad)
hauptPfadAppData="/mnt/user/appdata"

## Docker-namen - Bitte in reihenfolge eingeben, in der sie gestoppt werden sollen ##
## TIPP: Datenbank IMMER als LETZTES angeben! (So wird diese als letztes gestoppt und als erstes gestartet)

# Name des DockerName1
DockerName1="docker1"

# Name des DockerName2
DockerName2="docker2"

# Name des DockerName3
DockerName3="docker3"

# Name des DockerName4
DockerName4="docker4"

# Name des DockerName5
DockerName5="docker5"

# Name des DockerName6
DockerName6="docker6"

# Name des DockerName7
DockerName7="docker7"

# Name des DockerName8
DockerName8="docker8"

# Name des DockerName9
DockerName9="docker9"

# Name des DockerName10
DockerName10="docker10"

# Name des DockerName11
DockerName11="docker11"

# Name des DockerName12
DockerName12="docker12"


## Start/Stopp Container steuerung Docker ##
## Diese Variablen sind fuer die Dockernamen 
## Diese Namen koennen auch andere als der Pfad (selbststaendig oben angegeben) sein!
## Bitte in folgender Reihenfolge angeben:  Als erstes Starten > Als letztes Starten
## Beispiel: ContainerName1 wird zuerst GESTOPPT und als letztes GESTARTET
## TIPP: Datenbank IMMER als LETZTES angeben! (So wird diese als letztes gestoppt und als erstes gestartet)

# Name des ContainerName1
ContainerName1="Container1"

# Name des ContainerName2
ContainerName2="Container2"

# Name des ContainerName3
ContainerName3="Container3"

# Name des ContainerName4
ContainerName4="Container4"

# Name des ContainerName5
ContainerName5="Container5"

# Name des ContainerName6
ContainerName6="Container6"

# Name des ContainerName7
ContainerName7="Container7"

# Name des ContainerName8
ContainerName8="Container8"

# Name des ContainerName9
ContainerName9="Container9"

# Name des ContainerName10
ContainerName10="Container10"

# Name des ContainerName11
ContainerName11="Container11"

# Name des ContainerName12
ContainerName12="Container12"


# Standard-Pfad share (vor-pfad)
hauptPfadshare="/mnt/user"

# Name des Shares 1
Share1Name="share1"

# Name des Shares 2
Share2Name="share2"

# Name des Shares 3
Share3Name="share3"

# Name des Shares 4
Share4Name="share4"

# Name des Shares 5
Share5Name="share5"

# Name des Shares 6
Share6Name="share6"

# Name des Shares 7
Share7Name="share7"

# Name des Shares 8
Share8Name="share8"

# Name des Shares 9
Share9Name="share9"

# Name des Shares 10
Share10Name="share10"

# Name des Shares 11
Share11Name="share11"

# Name des Shares 12
Share12Name="share12"


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
DISCORD_START_COLOR="0x00FF7F" #mit "0x"!
DISCORD_ERROR_COLOR="0xFF3030" #mit "0x"!
DISCORD_END_COLOR="0xFFA500" #mit "0x"!
DISCORD_AUTHOR="EasyBackup"
DISCORD_AUTHOR_ICON="your picture url"
DISCORD_START_THUMBNAIL="your picture url"
DISCORD_ERROR_THUMBNAIL="your picture url"
DISCORD_END_THUMBNAIL="your picture url"


### NICHT ANPASSEN! ###

# auf root-rechte pruefen
#
if [ "$(id -u)" != "0" ]
then
	echo "<font color='red'>ERROR: Dieses Skript muss als root ausgefuehrt werden!</font>"
	exit 1
fi

# Pruefe Quellen

# Pruefe Quellen (message)
echo "<font color='blue'>Pruefe ob Quellen existieren...</font>"

# DockerName1
if [ -d "${hauptPfadAppData}/${DockerName1}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName1}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName2
if [ -d "${hauptPfadAppData}/${DockerName2}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName2}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName3
if [ -d "${hauptPfadAppData}/${DockerName3}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName3}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName4
if [ -d "${hauptPfadAppData}/${DockerName4}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName4}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName5
if [ -d "${hauptPfadAppData}/${DockerName5}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName5}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName6
if [ -d "${hauptPfadAppData}/${DockerName6}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName6}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName7
if [ -d "${hauptPfadAppData}/${DockerName7}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName7}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName8
if [ -d "${hauptPfadAppData}/${DockerName8}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName8}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName9
if [ -d "${hauptPfadAppData}/${DockerName9}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName9}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName10
if [ -d "${hauptPfadAppData}/${DockerName10}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName10}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# DockerName11
if [ -d "${hauptPfadAppData}/${DockerName11}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName11}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# DockerName12
if [ -d "${hauptPfadAppData}/${DockerName12}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName12}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo



# Share1Name
if [ -d "${hauptPfadshare}/${Share1Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share1Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share2Name
if [ -d "${hauptPfadshare}/${Share2Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share2Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share3Name
if [ -d "${hauptPfadshare}/${Share3Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share3Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share4Name
if [ -d "${hauptPfadshare}/${Share4Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share4Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share5Name
if [ -d "${hauptPfadshare}/${Share5Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share5Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share6Name
if [ -d "${hauptPfadshare}/${Share6Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share6Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share7Name
if [ -d "${hauptPfadshare}/${Share7Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share7Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share8Name
if [ -d "${hauptPfadshare}/${Share8Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share8Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share9Name
if [ -d "${hauptPfadshare}/${Share9Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share9Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share10Name
if [ -d "${hauptPfadshare}/${Share10Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share10Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share11Name
if [ -d "${hauptPfadshare}/${Share11Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share11Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share12Name
if [ -d "${hauptPfadshare}/${Share12Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share12Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo


###

# Backup-Server starten
echo "<font color='blue'>Backup Server wird gestartet...</font>"
python3 /boot/config/plugins/user.scripts/scripts/wake.py

# warten
echo "<font color='black'>warte 40 sekunden...</font>"
sleep 40

# BackupServer anpingen
if ping -c 1 ${backupServerIP} &> /dev/null
  then
    echo "<font color='green'>Server aktiv. Es wird fortgefahren...</font>"
else
    echo "<font color='red'>Fehler. Versuche erneut in 20 sekunden...</font>"
    sleep 20
        if ping -c 1 ${backupServerIP} &> /dev/null
         then
          echo "<font color='green'>Server nun aktiv. Es wird fortgefahren...</font>"
        else
          echo "<font color='red'>Fehler. Server startet nicht! Breche ab...</font>"
            exit 1
  fi
 fi


# Discord Message
sudo bash discord.sh --webhook-url="$WEBHOOK" --username "$DISCORD_USERNAME" --avatar "$DISCORD_AVATAR_URL" --title "$DISCORD_START_TITLE" --description "$DISCORD_START_DESCRIPTION" --color "$DISCORD_START_COLOR" --author "$DISCORD_AUTHOR" --author-icon "$DISCORD_AUTHOR_ICON" --thumbnail "$DISCORD_START_THUMBNAIL" --footer "automatically generated message" --timestamp


## ordnung schaffen ##
echo
echo


# Stoppe Docker
echo "<font color='black'>Stoppe Docker...</font>"
echo

# ContainerName1
echo "<font color='blue'>Stoppe "${ContainerName1}"...</font>"
docker stop "${ContainerName1}"

# warten 1
sleep 5

# ContainerName2
echo "<font color='blue'>Stoppe "${ContainerName2}"...</font>"
docker stop "${ContainerName2}"

# warten 2
sleep 5

# ContainerName3
echo "<font color='blue'>Stoppe "${ContainerName3}"...</font>"
docker stop "${ContainerName3}"

# warten 3
sleep 5

# ContainerName4
echo "<font color='blue'>Stoppe "${ContainerName4}"...</font>"
docker stop "${ContainerName4}"

# warten 4
sleep 5

# ContainerName5
echo "<font color='blue'>Stoppe "${ContainerName5}"...</font>"
docker stop "${ContainerName5}"

# warten 5
sleep 5

# ContainerName6
echo "<font color='blue'>Stoppe "${ContainerName6}"...</font>"
docker stop "${ContainerName6}"

# warten 6
sleep 5

# ContainerName7
echo "<font color='blue'>Stoppe "${ContainerName7}"...</font>"
docker stop "${ContainerName7}"

# warten 7
sleep 5

# ContainerName8
echo "<font color='blue'>Stoppe "${ContainerName8}"...</font>"
docker stop "${ContainerName8}"

# warten 8
sleep 5

# ContainerName9
echo "<font color='blue'>Stoppe "${ContainerName9}"...</font>"
docker stop "${ContainerName9}"

# warten 8
sleep 5

# ContainerName10
echo "<font color='blue'>Stoppe "${ContainerName10}"...</font>"
docker stop "${ContainerName10}"

# warten 9
sleep 5

# ContainerName11
echo "<font color='blue'>Stoppe "${ContainerName11}"...</font>"
docker stop "${ContainerName11}"

# warten 10
sleep 5

# ContainerName12
echo "<font color='blue'>Stoppe "${ContainerName12}"...</font>"
docker stop "${ContainerName12}"

# warten 11
sleep 5


# Ordnung schaffen
echo
echo


# Starte rsync
echo "<font color='blue'>rsync Vorgang wird gestartet...</font>"
echo "<font color='blue'>Dies kann laenger dauern...</font>"

# rsync DockerName1
echo "<font color='blue'>rsync von "${DockerName1}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName1}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 12
sleep 5

# rsync DockerName2
echo "<font color='blue'>rsyn von "${DockerName2}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName2}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 13
sleep 5

# rsync DockerName3
echo "<font color='blue'>rsync von "${DockerName3}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName3}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 14
sleep 5

# rsync DockerName4
echo "<font color='blue'>rsync von "${DockerName4}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName4}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 15
sleep 5

# rsync DockerName5
echo "<font color='blue'>rsync von "${DockerName5}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName5}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 16
sleep 5

# rsync DockerName6
echo "<font color='blue'>rsync von "${DockerName6}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName6}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 17
sleep 5

# rsync DockerName7
echo "<font color='blue'>rsync von "${DockerName7}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName7}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 18
sleep 5

# rsync DockerName8
echo "<font color='blue'>rsync von "${DockerName8}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName8}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 19
sleep 5

# rsync DockerName9
echo "<font color='blue'>rsync von "${DockerName9}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName9}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 20
sleep 5

# rsync DockerName10
echo "<font color='blue'>rsync von "${DockerName10}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName10}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 21
sleep 5

# rsync DockerName11
echo "<font color='blue'>rsync von "${DockerName11}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName11}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 22
sleep 5

# rsync DockerName12
echo "<font color='blue'>rsync von "${DockerName12}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadAppData}/${DockerName12}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}"
echo

# warten 23
sleep 5



# rsync Share1Name
echo "<font color='blue'>rsync von "${Share1Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share1Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 24
sleep 5

# rsync Share2Name
echo "<font color='blue'>rsync von "${Share2Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share2Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 25
sleep 5

# rsync Share3Name
echo "<font color='blue'>rsync von "${Share3Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share3Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 26
sleep 5

# rsync Share4Name
echo "<font color='blue'>rsync von "${Share4Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share4Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 27
sleep 5

# rsync Share5Name
echo "<font color='blue'>rsync von "${Share5Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share5Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 28
sleep 5

# rsync Share6Name
echo "<font color='blue'>rsync von "${Share6Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share6Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 29
sleep 5

# rsync Share7Name
echo "<font color='blue'>rsync von "${Share7Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share7Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 30
sleep 5

# rsync Share8Name
echo "<font color='blue'>rsync von "${Share8Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share8Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 31
sleep 5

# rsync Share9Name
echo "<font color='blue'>rsync von "${Share9Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share9Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 32
sleep 5

# rsync Share10Name
echo "<font color='blue'>rsync von "${Share10Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share10Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 33
sleep 5

# rsync Share11Name
echo "<font color='blue'>rsync von "${Share11Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share11Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 34
sleep 5

# rsync Share12Name
echo "<font color='blue'>rsync von "${Share12Name}"...</font>"
sudo rsync --ignore-existing -az "${hauptPfadshare}/${Share12Name}" "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}"
echo

# warten 35
sleep 5


## Pruefen ob daten angekommen sind ##
echo "<font color='blue'>Pruefe ob Daten im Ziel sind...</font>"


# DockerName1
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName1}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName1}" existiert nicht!</font>"
fi
echo 

# DockerName2
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName2}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName2}" existiert nicht!</font>"
fi
echo 

# DockerName3
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName3}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName3}" existiert nicht!</font>"
fi
echo 

# DockerName4
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName4}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName4}" existiert nicht!</font>"
fi
echo 

# DockerName5
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName5}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName5}" existiert nicht!</font>"
fi
echo 

# DockerName6
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName6}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName6}" existiert nicht!</font>"
fi
echo 

# DockerName7
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName7}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName7}" existiert nicht!</font>"
fi
echo  

# DockerName8
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName8}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName8}" existiert nicht!</font>"
fi
echo 


# DockerName9
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName9}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName9}" existiert nicht!</font>"
fi
echo 

# DockerName10
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName10}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName10}" existiert nicht!</font>"
fi
echo 

# DockerName11
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName11}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName11}" existiert nicht!</font>"
fi
echo 

# DockerName12
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad}/${DockerName12}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName12}" existiert nicht!</font>"
fi
echo


# Share1
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share1Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share1Name}" existiert nicht!</font>"
fi
echo

# Share2
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share2Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share2Name}" existiert nicht!</font>"
fi
echo

# Share3
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share3Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share3Name}" existiert nicht!</font>"
fi
echo

# Share4
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share4Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share4Name}" existiert nicht!</font>"
fi
echo

# Share5
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share5Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share5Name}" existiert nicht!</font>"
fi
echo

# Share6
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share6Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share6Name}" existiert nicht!</font>"
fi
echo

# Share7
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share7Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share7Name}" existiert nicht!</font>"
fi
echo

# Share8
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share8Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share8Name}" existiert nicht!</font>"
fi
echo

# Share9
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share9Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share9Name}" existiert nicht!</font>"
fi
echo

# Share10
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share10Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share10Name}" existiert nicht!</font>"
fi
echo

# Share11
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share11Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share11Name}" existiert nicht!</font>"
fi
echo

# Share12
if [[ `ssh "${rsync_user}"@"${backupServerIP}" test -d "${backupServerZielPfad2}/${Share12Name}" && echo exists` ]]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share12Name}" existiert nicht!</font>"
fi
echo


# Starte Docker
echo "<font color='black'>Starte Docker...</font>"

# ContainerName12
echo "<font color='blue'>Starte "${ContainerName12}"...</font>"
docker start "${ContainerName12}"

# warten 36
sleep 5

# ContainerName11
echo "<font color='blue'>Starte "${ContainerName11}"...</font>"
docker start "${ContainerName11}"

# warten 37
sleep 5

# ContainerName10
echo "<font color='blue'>Starte "${ContainerName10}"...</font>"
docker start "${ContainerName10}"

# warten 38
sleep 5

# ContainerName9
echo "<font color='blue'>Starte "${ContainerName9}"...</font>"
docker start "${ContainerName9}"

# warten 39
sleep 5

# ContainerName8
echo "<font color='blue'>Starte "${ContainerName8}"...</font>"
docker start "${ContainerName8}"

# warten 40
sleep 5

# ContainerName7
echo "<font color='blue'>Starte "${ContainerName7}"...</font>"
docker start "${ContainerName7}"

# warten 41
sleep 5

# ContainerName6
echo "<font color='blue'>Starte "${ContainerName6}"...</font>"
docker start "${ContainerName6}"

# warten 42
sleep 5

# ContainerName5
echo "<font color='blue'>Starte "${ContainerName5}"...</font>"
docker start "${ContainerName5}"

# warten 43
sleep 5

# ContainerName4
echo "<font color='blue'>Starte "${ContainerName4}"...</font>"
docker start "${ContainerName4}"

# warten 44
sleep 5

# ContainerName3
echo "<font color='blue'>Starte "${ContainerName3}"...</font>"
docker start "${ContainerName3}"

# warten 45
sleep 5

# ContainerName2
echo "<font color='blue'>Starte "${ContainerName2}"...</font>"
docker start "${ContainerName2}"

# warten 46
sleep 5

# ContainerName1
echo "<font color='blue'>Starte "${ContainerName1}"...</font>"
docker start "${ContainerName1}"

# warten 47
sleep 5


## Beenden ##

# Abschliessen
if ! ssh "${rsync_user}"@"${backupServerIP}" "ls /"${backupServerZielPfad}" >/dev/null 2>&1" && ! ssh "${rsync_user}"@"${backupServerIP}" "ls /"${backupServerZielPfad2}" >/dev/null 2>&1"
  then
    /usr/local/emhttp/webGui/scripts/notify -i normal -s "Backup abgeschlossen." -d "Backup erfolgreich auf Proxmox geschrieben."
    echo "<font color='green'>Skript erfolgreich abgeschlossen.</font>"
    # Discord Message
    sudo bash discord.sh --webhook-url="$WEBHOOK" --username "$DISCORD_USERNAME" --avatar "$DISCORD_AVATAR_URL" --title "$DISCORD_END_TITLE" --description "$DISCORD_END_DESCRIPTION" --color "$DISCORD_END_COLOR" --author "$DISCORD_AUTHOR" --author-icon "$DISCORD_AUTHOR_ICON" --thumbnail "$DISCORD_END_THUMBNAIL" --footer "automatically generated message" --timestamp
  else
    /usr/local/emhttp/webGui/scripts/notify -i alert -s "Backup fehlgeschlagen." -d "Backup konnte nicht auf Proxmox geschrieben werden."
    echo "<font color='red'>Skript fehlgeschlagen.</font>"
    # Discord Message
    sudo bash discord.sh --webhook-url="$WEBHOOK" --username "$DISCORD_USERNAME" --avatar "$DISCORD_AVATAR_URL" --title "$DISCORD_ERROR_TITLE" --description "$DISCORD_ERROR_DESCRIPTION" --color "$DISCORD_ERROR_COLOR" --author "$DISCORD_AUTHOR" --author-icon "$DISCORD_AUTHOR_ICON" --thumbnail "$DISCORD_ERROR_THUMBNAIL" --footer "automatically generated message" --timestamp
fi
echo

echo "<font color='blue'>BackupServer wird heruntergefahren...</font>"
ssh "${rsync_user}"@"${backupServerIP}" sudo shutdown -h now

# warten
echo "<font color='black'>Warte 60 sekunden...</font>"
sleep 60

# BackupServer anpingen
if ping -c 1 ${backupServerIP} &> /dev/null
  then
    echo "<font color='red'>Fehler. Versuche erneut in 30 sekunden...</font>"
      sleep 30
           elif ping -c 1 ${backupServerIP} &> /dev/null
                  then
                    echo "<font color='red'>Fehler. Server faehrt nicht herunter! Server muss manuell gestoppt werden!</font>"
                    echo "<font color='red'>Gehe dafuer auf den Server und gebe  shutdown -h now  ein.</font>"
            else
    echo "<font color='green'>Server erfolgreich heruntergefahren</font>"
fi

# ENDE
echo "<font color='black'>Skirpt wurde abgeschlossen.</font>"
