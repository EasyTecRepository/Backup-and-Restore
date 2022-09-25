#!/bin/bash
#
# Bash skript fuer eine rsync uebertragung der (externen backup-) Proxmox Daten auf einen internen Unraid-server 
# Es werden auch Backups einer MariaDB wiederhergestellt. Zudem werden Discord messages versendet.
# Enthaelt Variablen und eine Message in Unraid.
# Dieses Skript ist fuer eine rsync uebertragung der (externen backup-) Proxmox daten auf einen externen Unraid-server geschrieben worden.
# Dieses Skript kann nur fuer Docker umgebungen verwendet werden, die das Backup auf einen Proxmox server schreiben.
# Erstellt von Easy Tec (youtube.com/EasyTec100)
# Anleitung (German): https://easytec.tech/index.php/2022/04/08/backupskript-fuer-unraid-auf-proxmox/
# Dieses Skript muss von Hand ausgeführt werden!
# Script Language: German
#

#
# Version 1.1.0
# nur fuer backupskript Version 1.3.x zugelassen!
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
DockerName1="Docker1"

# Name des DockerName2
DockerName2="Docker2"

# Name des DockerName3
DockerName3="Docker3"

# Name des DockerName4
DockerName4="Docker4"

# Name des DockerName5
DockerName5="Docker5"

# Name des DockerName6
DockerName6="Docker6"

# Name des DockerName7
DockerName7="Docker7"

# Name des DockerName8
DockerName8="Docker8"

# Name des DockerName9
DockerName9="Docker9"

# Name des DockerName10
DockerName10="Docker10"

# Name des DockerName11
DockerName11="docker11"

# Name des DockerName12
DockerName12="docker12"


# Standard-Pfad share (vor-pfad)
hauptPfadshare="/mnt/user"

# Name des Shares 1
Share1Name="Share1"

# Name des Shares 2
Share2Name="Share2"

# Name des Shares 3
Share3Name="Share3"

# Name des Shares 4
Share4Name="Share4"

# Name des Shares 5
Share5Name="Share5"

# Name des Shares 6
Share6Name="Share6"

# Name des Shares 7
Share7Name="Share7"

# Name des Shares 8
Share8Name="Share8"

# Name des Shares 9
Share9Name="Share9"

# Name des Shares 10
Share10Name="Share10"

# Name des Shares 11
Share11Name="Share11"

# Name des Shares 12
Share12Name="Share12"


### Variablen - MariaDB dumps (ANPASSEN!) ###
### Wenn mehr / weniger Variablen benoetigt werden, hinzufuegen / auskommentieren. (auch im Skript) ###
# Dieser abschnitt muss auskommentiert werden, wenn keine Dumps ausgeführt werden sollen!!
# Alle Nummern muessen zu der gleichen Datenbank gehoehren!

## Funktion für error messages ##
errorecho() { cat <<< "$@" 1>&2; }

## Passwort für MariaDB (SiChErEsPaSsWoRt)
mariadbPassWD="your password"

## MariaDB config path (standard-pfad)
db_config_path="mnt/user/mariadb_backups/MariaDB/config"

## MariaDB verzeichnis path (Standard-pfad)
db_verzeichnis="mnt/user/appdata/mariadb"

## Pfad fuer MariaDB dump 1 (am ende KEIN "/"! \ beispiel-pfad!! Bitte anpassen!!)
mariadb_pfad_dump_datenbank_1="/mnt/user/mariadb_backups/dump/datenbank1"

## Pfad fuer MariaDB dump 2 (am ende KEIN "/"! \ beispiel-pfad!! Bitte anpassen!!)
mariadb_pfad_dump_datenbank_2="/mnt/user/mariadb_backups/dump/datenbank2"

## Pfad fuer MariaDB dump 3 (am ende KEIN "/"! \ beispiel-pfad!! Bitte anpassen!!)
mariadb_pfad_dump_datenbank_3="/mnt/user/mariadb_backups/dump/datenbank3"

## Pfad fuer MariaDB dump 4 (am ende KEIN "/"! \ beispiel-pfad!! Bitte anpassen!!)
mariadb_pfad_dump_datenbank_4="/mnt/user/mariadb_backups/dump/datenbank4"

## Pfad fuer MariaDB dump 5 (am ende KEIN "/"! \ beispiel-pfad!! Bitte anpassen!!)
mariadb_pfad_dump_datenbank_5="/mnt/user/mariadb_backups/dump/datenbank5"

## Pfad fuer MariaDB dump 6 (am ende KEIN "/"! \ beispiel-pfad!! Bitte anpassen!!)
mariadb_pfad_dump_datenbank_6="/mnt/user/mariadb_backups/dump/datenbank6"

## Pfad fuer MariaDB dump 7 (am ende KEIN "/"! \ beispiel-pfad!! Bitte anpassen!!)
mariadb_pfad_dump_datenbank_7="/mnt/user/mariadb_backups/dump/datenbank7"

## Datenbank von MariaDB (1 Datenbank \ Datenbank = beispiel)
mariadb_dumps_datenbank_1="datenbank1"

## Datenbank von MariaDB (2 Datenbank \ Datenbank = beispiel)
mariadb_dumps_datenbank_2="datenbank2"

## Datenbank von MariaDB (3 Datenbank \ Datenbank = beispiel)
mariadb_dumps_datenbank_3="datenbank3"

## Datenbank von MariaDB (4 Datenbank \ Datenbank = beispiel)
mariadb_dumps_datenbank_4="datenbank4"

## Datenbank von MariaDB (5 Datenbank \ Datenbank = beispiel)
mariadb_dumps_datenbank_5="datenbank5"

## Datenbank von MariaDB (6 Datenbank \ Datenbank = beispiel)
mariadb_dumps_datenbank_6="datenbank6"

## Datenbank von MariaDB (7 Datenbank \ Datenbank = beispiel)
mariadb_dumps_datenbank_7="datenbank7"

## Namen der Docker von MariaDB dumps
DockerName_dumps_1="name1"
DockerName_dumps_2="name2"
DockerName_dumps_3="name3"
DockerName_dumps_4="name4"
DockerName_dumps_5="name5"
DockerName_dumps_6="name6"
DockerName_dumps_7="name7"
DockerName_dumps_mariadb="mariadb"

## Funktion fuer die neusten backup-dateien ##
latestfile1=$(ls -rt1 | tail -1)
latestfile2=$(ls -rt1 | tail -1)
latestfile3=$(ls -rt1 | tail -1)
latestfile4=$(ls -rt1 | tail -1)
latestfile5=$(ls -rt1 | tail -1)
latestfile6=$(ls -rt1 | tail -1)


### NICHT ANPASSEN! ###

# auf root-rechte pruefen
#
if [ "$(id -u)" != "0" ]
then
	echo "<font color='red'>ERROR: Dieses Skript muss als root ausgefuehrt werden!</font>"
	exit 1
fi

# Fragen vor anfang
echo "<font color='orange'>Moechtest du dieses Skript wirklich ausfuehren?</font>"
echo "<font color='orange'>Dieses Skript spielt deine Daten vom Backupserver auf diesen Unraidserver.</font>"
echo "<font color='orange'>Hierbei koennen fehler auftreten. Trotzdem fortfahren?</font>"
echo "<font color='red'>[Skript fährt in 20 Sekunden automatisch fort!]</font>"
echo "<font color='orange'>[Fuer Abbrechen das X oben rechts druecken!]</font>"
sleep 20
echo "<font color='green'>Fahre fort...</font>"

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

# Pruefe Quellen

# Pruefe Quellen (message)
echo "<font color='blue'>Pruefe ob Quellen existieren...</font>"

# DockerName1
if [ -d "${backupServerZielPfad}/${DockerName1}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName1}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName2
if [ -d "${backupServerZielPfad}/${DockerName2}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName2}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName3
if [ -d "${backupServerZielPfad}/${DockerName3}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName3}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName4
if [ -d "${backupServerZielPfad}/${DockerName4}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName4}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName5
if [ -d "${backupServerZielPfad}/${DockerName5}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName5}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName6
if [ -d "${backupServerZielPfad}/${DockerName6}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName6}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName7
if [ -d "${backupServerZielPfad}/${DockerName7}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName7}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName8
if [ -d "${backupServerZielPfad}/${DockerName8}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName8}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName9
if [ -d "${backupServerZielPfad}/${DockerName9}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName9}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo 

# DockerName10
if [ -d "${backupServerZielPfad}/${DockerName10}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName10}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# DockerName11
if [ -d "${backupServerZielPfad}/${DockerName11}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName11}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# DockerName12
if [ -d "${backupServerZielPfad}/${DockerName12}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName12}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo



# Share1Name
if [ -d "${backupServerZielPfad2}/${Share1Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share1Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share2Name
if [ -d "${backupServerZielPfad2}/${Share2Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share2Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share3Name
if [ -d "${backupServerZielPfad2}/${Share3Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share3Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share4Name
if [ -d "${backupServerZielPfad2}/${Share4Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share4Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share5Name
if [ -d "${backupServerZielPfad2}/${Share5Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share5Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share6Name
if [ -d "${backupServerZielPfad2}/${Share6Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share6Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share7Name
if [ -d "${backupServerZielPfad2}/${Share7Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share7Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share8Name
if [ -d "${backupServerZielPfad2}/${Share8Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share8Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share9Name
if [ -d "${backupServerZielPfad2}/${Share9Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share9Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share10Name
if [ -d "${backupServerZielPfad2}/${Share10Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share10Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share11Name
if [ -d "${backupServerZielPfad2}/${Share11Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share11Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo

# Share12Name
if [ -d "${backupServerZielPfad2}/${Share12Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share12Name}" existiert nicht! Breche ab...</font>"
     exit 1
fi

echo


# Stoppe Docker
echo "<font color='black'>Stoppe Docker...</font>"
echo

# DockerName1
echo "<font color='blue'>Stoppe "${DockerName1}"...</font>"
docker stop "${DockerName1}"

# warten 1
sleep 5

# DockerName2
echo "<font color='blue'>Stoppe "${DockerName2}"...</font>"
docker stop "${DockerName2}"

# warten 2
sleep 5

# DockerName3
echo "<font color='blue'>Stoppe "${DockerName3}"...</font>"
docker stop "${DockerName3}"

# warten 3
sleep 5

# DockerName4
echo "<font color='blue'>Stoppe "${DockerName4}"...</font>"
docker stop "${DockerName4}"

# warten 4
sleep 5

# DockerName5
echo "<font color='blue'>Stoppe "${DockerName5}"...</font>"
docker stop "${DockerName5}"

# warten 5
sleep 5

# DockerName6
echo "<font color='blue'>Stoppe "${DockerName6}"...</font>"
docker stop "${DockerName6}"

# warten 6
sleep 5

# DockerName7
echo "<font color='blue'>Stoppe "${DockerName7}"...</font>"
docker stop "${DockerName7}"

# warten 7
sleep 5

# DockerName8
echo "<font color='blue'>Stoppe "${DockerName8}"...</font>"
docker stop "${DockerName8}"

# warten 8
sleep 5

# DockerName9
echo "<font color='blue'>Stoppe "${DockerName9}"...</font>"
docker stop "${DockerName9}"

# warten 8
sleep 5

# DockerName10
echo "<font color='blue'>Stoppe "${DockerName10}"...</font>"
docker stop "${DockerName10}"

# warten 9
sleep 5

# DockerName11
echo "<font color='blue'>Stoppe "${DockerName11}"...</font>"
docker stop "${DockerName11}"

# warten 10
sleep 5

# DockerName12
echo "<font color='blue'>Stoppe "${DockerName12}"...</font>"
docker stop "${DockerName12}"

# warten 11
sleep 5

# Starte rsync
echo "<font color='blue'>rsync Vorgang wird gestartet...</font>"
echo "<font color='blue'>Dies kann laenger dauern...</font>"

# rsync DockerName1
echo "<font color='blue'>rsync von "${DockerName1}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName1}" "${hauptPfadAppData}"
echo

# warten 12
sleep 5

# rsync DockerName2
echo "<font color='blue'>rsync von "${DockerName2}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName2}" "${hauptPfadAppData}"
echo

# warten 13
sleep 5

# rsync DockerName3
echo "<font color='blue'>rsync von "${DockerName3}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName3}" "${hauptPfadAppData}"
echo

# warten 14
sleep 5

# rsync DockerName4
echo "<font color='blue'>rsync von "${DockerName4}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName4}" "${hauptPfadAppData}"
echo

# warten 15
sleep 5

# rsync DockerName5
echo "<font color='blue'>rsync von "${DockerName5}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName5}" "${hauptPfadAppData}"
echo

# warten 16
sleep 5

# rsync DockerName6
echo "<font color='blue'>rsync von "${DockerName6}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName6}" "${hauptPfadAppData}"
echo

# warten 17
sleep 5

# rsync DockerName7
echo "<font color='blue'>rsync von "${DockerName7}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName7}" "${hauptPfadAppData}"
echo

# warten 18
sleep 5

# rsync DockerName8
echo "<font color='blue'>rsync von "${DockerName8}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName8}" "${hauptPfadAppData}"
echo

# warten 19
sleep 5

# rsync DockerName9
echo "<font color='blue'>rsync von "${DockerName9}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName9}" "${hauptPfadAppData}"
echo

# warten 20
sleep 5

# rsync DockerName10
echo "<font color='blue'>rsync von "${DockerName10}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName10}" "${hauptPfadAppData}"
echo

# warten 21
sleep 5

# rsync DockerName11
echo "<font color='blue'>rsync von "${DockerName11}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName11}" "${hauptPfadAppData}"
echo

# warten 22
sleep 5

# rsync DockerName12
echo "<font color='blue'>rsync von "${DockerName12}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad}/${DockerName12}" "${hauptPfadAppData}"
echo

# warten 23
sleep 5



# rsync Share1Name
echo "<font color='blue'>rsync von "${Share1Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share1Name}" "${hauptPfadshare}"
echo

# warten 24
sleep 5

# rsync Share2Name
echo "<font color='blue'>rsync von "${Share2Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share2Name}" "${hauptPfadshare}"
echo

# warten 25
sleep 5

# rsync Share3Name
echo "<font color='blue'>rsync von "${Share3Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share3Name}" "${hauptPfadshare}"
echo

# warten 26
sleep 5

# rsync Share4Name
echo "<font color='blue'>rsync von "${Share4Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share4Name}" "${hauptPfadshare}"
echo

# warten 27
sleep 5

# rsync Share5Name
echo "<font color='blue'>rsync von "${Share5Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share5Name}" "${hauptPfadshare}"
echo

# warten 28
sleep 5

# rsync Share6Name
echo "<font color='blue'>rsync von "${Share6Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share6Name}" "${hauptPfadshare}"
echo

# warten 29
sleep 5

# rsync Share7Name
echo "<font color='blue'>rsync von "${Share7Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share7Name}" "${hauptPfadshare}"
echo

# warten 30
sleep 5

# rsync Share8Name
echo "<font color='blue'>rsync von "${Share8Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share8Name}" "${hauptPfadshare}"
echo

# warten 31
sleep 5

# rsync Share9Name
echo "<font color='blue'>rsync von "${Share9Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share9Name}" "${hauptPfadshare}"
echo

# warten 32
sleep 5

# rsync Share10Name
echo "<font color='blue'>rsync von "${Share10Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share10Name}" "${hauptPfadshare}"
echo

# warten 33
sleep 5

# rsync Share11Name
echo "<font color='blue'>rsync von "${Share11Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share11Name}" "${hauptPfadshare}"
echo

# warten 34
sleep 5

# rsync Share12Name
echo "<font color='blue'>rsync von "${Share12Name}"...</font>"
sudo rsync -az --progress "${rsync_user}"@"${backupServerIP}":"${backupServerZielPfad2}/${Share12Name}" "${hauptPfadshare}"
echo

# warten 35
sleep 5


## Pruefen ob daten angekommen sind ##
echo "<font color='blue'>Pruefe ob Daten im Ziel sind...</font>"


# DockerName1
if [ test -d "${hauptPfadAppData}/${DockerName1}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName1}" existiert nicht!</font>"
fi
echo 

# DockerName2
if [ test -d "${hauptPfadAppData}/${DockerName2}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName2}" existiert nicht!</font>"
fi
echo 

# DockerName3
if [ test -d "${hauptPfadAppData}/${DockerName3}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName3}" existiert nicht!</font>"
fi
echo 

# DockerName4
if [ test -d "${hauptPfadAppData}/${DockerName4}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName4}" existiert nicht!</font>"
fi
echo 

# DockerName5
if [ test -d "${hauptPfadAppData}/${DockerName5}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName5}" existiert nicht!</font>"
fi
echo 

# DockerName6
if [ test -d "${hauptPfadAppData}/${DockerName6}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName6}" existiert nicht!</font>"
fi
echo 

# DockerName7
if [ test -d "${hauptPfadAppData}/${DockerName7}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName7}" existiert nicht!</font>"
fi
echo  

# DockerName8
if [ test -d "${hauptPfadAppData}/${DockerName8}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName8}" existiert nicht!</font>"
fi
echo 


# DockerName9
if [ test -d "${hauptPfadAppData}/${DockerName9}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName9}" existiert nicht!</font>"
fi
echo 

# DockerName10
if [ test -d "${hauptPfadAppData}/${DockerName10}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName10}" existiert nicht!</font>"
fi
echo 

# DockerName11
if [ test -d "${hauptPfadAppData}/${DockerName11}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName11}" existiert nicht!</font>"
fi
echo 

# DockerName12
if [ test -d "${hauptPfadAppData}/${DockerName12}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${DockerName12}" existiert nicht!</font>"
fi
echo


# Share1
if [ test -d "${hauptPfadshare}/${Share1Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share1Name}" existiert nicht!</font>"
fi
echo

# Share2
if [ test -d "${hauptPfadshare}/${Share2Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share2Name}" existiert nicht!</font>"
fi
echo

# Share3
if [ test -d "${hauptPfadshare}/${Share3Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share3Name}" existiert nicht!</font>"
fi
echo

# Share4
if [ test -d "${hauptPfadshare}/${Share4Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share4Name}" existiert nicht!</font>"
fi
echo

# Share5
if [ test -d "${hauptPfadshare}/${Share5Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share5Name}" existiert nicht!</font>"
fi
echo

# Share6
if [ test -d "${hauptPfadshare}/${Share6Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share6Name}" existiert nicht!</font>"
fi
echo

# Share7
if [ test -d "${hauptPfadshare}/${Share7Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share7Name}" existiert nicht!</font>"
fi
echo

# Share8
if [ test -d "${hauptPfadshare}/${Share8Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share8Name}" existiert nicht!</font>"
fi
echo

# Share9
if [ test -d "${hauptPfadshare}/${Share9Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share9Name}" existiert nicht!</font>"
fi
echo

# Share10
if [ test -d "${hauptPfadshare}/${Share10Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share10Name}" existiert nicht!</font>"
fi
echo

# Share11
if [ test -d "${hauptPfadshare}/${Share11Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share11Name}" existiert nicht!</font>"
fi
echo

# Share12
if [ test -d "${hauptPfadshare}/${Share12Name}" ]
  then
    echo "<font color='green'>OK</font>"
  else
    echo "<font color='red'>ERROR: Vezeichnis von "${Share12Name}" existiert nicht!</font>"
fi
echo


read -p "Soll die MariaDB Datenbank wirklich zurueckgespielt werden? (y/n)" query_db_rollback

if [ "$query_db_rollback" = y ];
then
  echo -e "Okay, fahre fort.."
  # Starte MariaDB Docker
  echo "<font color='black'>Starte MariaDB Docker...</font>"

  # DockerName12
  echo "<font color='blue'>Starte "${DockerName12}"...</font>"
  docker start "${DockerName9}"

  # warten 36
  sleep 5

  #MariaDB backup
  echo
  echo "<font color='blue'>Starte MariaDB dumps...</font>"
  echo

  ## Ausgabe: Skript startet Dump 1 ##
  echo "<font color='blue'>Spiele Backup von "${DockerName_dumps_1}" zurueck...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## Bestaetigen Dump 1 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo

  ## Warten Dump 1 ##
  echo "<font color='black'>warte 5 sekunden...</font>"
  sleep 5

  ## Ausgabe: Skript startet Dump 2 ##
  echo "<font color='blue'>Spiele Backup von "${DockerName_dumps_2}" zurueck...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## Bestaetigen Dump 2 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## Warten Dump 2 ##
  echo "<font color='black'>warte 5 sekunden...</font>"
  sleep 5

  ## Ausgabe: Skript startet Dump 3 ##
  echo "<font color='blue'>Spiele Backup von "${DockerName_dumps_3}" zurueck...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## Bestaetigen Dump 3 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## Warten Dump 3 ##
  echo "<font color='black'>warte 5 sekunden...</font>"
  sleep 5

  ## Ausgabe: Skript startet Dump 4 ##
  echo "<font color='blue'>Spiele Backup von "${DockerName_dumps_4}" zurueck...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## Bestaetigen Dump 4 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo

  ## Warten Dump 4 ##
  echo "<font color='black'>warte 5 sekunden...</font>"
  sleep 5

  ## Ausgabe: Skript startet Dump 5 ##
  echo "<font color='blue'>Spiele Backup von "${DockerName_dumps_5}" zurueck...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## Bestaetigen Dump 5 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## Warten Dump 5 ##
  echo "<font color='black'>warte 5 sekunden...</font>"
  sleep 5

  ## Ausgabe: Skript startet Dump 6 ##
  echo "<font color='blue'>Spiele Backup von "${DockerName_dumps_6}" zurueck...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## Bestaetigen Dump 6 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## Warten Dump 6 ##
  echo "<font color='black'>warte 5 sekunden...</font>"
  sleep 5

  ## Ausgabe: Skript startet Dump 7 ##
  echo "<font color='blue'>Spiele Backup von "${DockerName_dumps_7}" zurueck...</font>"
  docker exec "${DockerName_dumps_mariadb}" /usr/bin/mysqldump --user=root --password=${mariadbPassWD} "${mariadb_dumps_datenbank_1}" < "${mariadb_pfad_dump_datenbank_1}"/${latestfile1}

  ## Bestaetigen Dump 7 ##
  echo "<font color='green'>OK</font>"
  errorecho "<font color='red'></font>"
  echo 

  ## Warten Dump 7 ##
  echo "<font color='black'>warte 5 sekunden...</font>"
  sleep 5

  #WARNUNG
  echo "Datenbank wurde wiederhergestellt. Prüfe dennoch manuell, ob alles funktioniert hat!"
else
  echo -e "ueberspringen..."
fi



# Starte Docker
echo "<font color='black'>Starte Docker...</font>"

# DockerName12
echo "<font color='blue'>Starte "${DockerName12}"...</font>"
docker start "${DockerName9}"

# warten 36
sleep 5

# DockerName11
echo "<font color='blue'>Starte "${DockerName11}"...</font>"
docker start "${DockerName11}"

# warten 37
sleep 5

# DockerName10
echo "<font color='blue'>Starte "${DockerName10}"...</font>"
docker start "${DockerName10}"

# warten 38
sleep 5

# DockerName9
echo "<font color='blue'>Starte "${DockerName9}"...</font>"
docker start "${DockerName9}"

# warten 39
sleep 5

# DockerName8
echo "<font color='blue'>Starte "${DockerName8}"...</font>"
docker start "${DockerName8}"

# warten 40
sleep 5

# DockerName7
echo "<font color='blue'>Starte "${DockerName7}"...</font>"
docker start "${DockerName7}"

# warten 41
sleep 5

# DockerName6
echo "<font color='blue'>Starte "${DockerName6}"...</font>"
docker start "${DockerName6}"

# warten 42
sleep 5

# DockerName5
echo "<font color='blue'>Starte "${DockerName5}"...</font>"
docker start "${DockerName5}"

# warten 43
sleep 5

# DockerName4
echo "<font color='blue'>Starte "${DockerName4}"...</font>"
docker start "${DockerName4}"

# warten 44
sleep 5

# DockerName3
echo "<font color='blue'>Starte "${DockerName3}"...</font>"
docker start "${DockerName3}"

# warten 45
sleep 5

# DockerName2
echo "<font color='blue'>Starte "${DockerName2}"...</font>"
docker start "${DockerName2}"

# warten 46
sleep 5

# DockerName1
echo "<font color='blue'>Starte "${DockerName1}"...</font>"
docker start "${DockerName1}"

# warten 47
sleep 5

# Ordnung schaffen
echo
echo

# Abschliessen
if [ -d $hauptPfadAppData ] && [ -d $hauptPfadshare ]
  then
    /usr/local/emhttp/webGui/scripts/notify -i normal -s "Restore abgeschlossen." -d "Restore erfolgreich geschrieben."
    echo "<font color='green'>Restore erfolgreich abgeschlossen.</font>"
  else
    /usr/local/emhttp/webGui/scripts/notify -i alert -s "Restore fehlgeschlagen." -d "Restore konnte nicht geschrieben werden."
    echo "<font color='red'>Restore fehlgeschlagen.</font>"
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
