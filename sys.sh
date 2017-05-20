#!/bin/bash
clear


echo "#**********************BIENVENUE SUR MON PROJET SYS***************************#"

echo "________________________________________________________________________________"
echo "*********************** CHOISIR L'OPTION A EXECUTER ****************************"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "***** a - les informations sur les utilisateurs enregistrer il ya 3 jours  *****"
echo "***** b - aquisition et installation de l'environement xampp              ******"
echo "***** c - archivage des elts du rep pers modifier par le sudoer il ya 2 jours***"
echo "***** d - infos d'utilisation du disque,memoire,disque,processus,swap     ******"
echo "*****   quitter(Q/q)                                                      ******"
echo "*****+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++******"

echo ".........................MAHMOUD DJIBRILLA 14A323FS ..................."

read -r choix
case $choix in 
	#liste de tout les users
	'a') cut -d : -f 1 /etc/passwd>all_users
	
	#liste des repertoires se trouvant dans /home 
	ls /home>user_foders
	
	while read line 
	do
		while read line1
		do	
		if [ $line == $line1 ] ; then 
		echo $line1>user1
		fi
		done<user_foders
	done<all_users
	find /home/* -type d -ctime 3 -print>userx

	while read line1
	do
	   while read user
	   do 
	      if [ $line1 == '/home/'$user ] ; then
		echo " $user a ete cree il ya 3jour">3days_user.txt
	      fi

	  done<user1 
	done<userx
	cat 3days_users.txt
	
 ;;
	'b') echo "tellechagement  de xampp"
	 wget https://downloadsapachefriends.global.ssl.fastly.net/xampp-files/5.6.30/xampp-linux-x64-5.6.30-1-installer.run?from_af=true
	 echo " insatllation "
	 ./xampp-linux-x64-5.6.30-1-installer.run
	
	 sudo su
	#arret du service apache 
	service apache2 stop
	#arret du service ftp
	service proftpd stop
	#demarage de xampp
	/opt/lampp/lampp start


;;
	'c') echo "archivage"
	#archivage des fichier du rep home modifier par le sudoer il ya 2 jours
	mkdir -p /home/seed/archive
	find /home/seed/ -type f -mtime 2 -print>/home/seed/ficmodi
	while read line
	do
	cp $line archive
	done </home/seed/ficmodi
	tar -czvf archive.tar.gz archive
	#mv archive.tar.gz /media/usb/*/archive.tar.gz
	mv archive.tar.gz /home/seed/prof/archive.tar.gz
	;;
	'd') echo "les informations sur l'utilisation du disque :"
		df -h |grep /dev/sd
		echo "les informations sur l'utilisation de la memoire et de la swap :"
		free -h 
;;
	* )  exit 1 ;;
esac


