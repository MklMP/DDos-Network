#!bin/bash
rojo='\033[0;31m'
verde='\033[0;32m'
amarillo='\033[0;33m'
azul='\033[0;34m'

echo -e "\n Instalando DDos-Network: "

##verificar dependencias
echo -e "ASEGURATE De TENER INSTALADO.."
echo "xclip"
echo "aircrack-ng"	
echo "php"
echo "dnsmask"
echo "hostapd"


##descargando el rockyou.txt
sudo gzip -d /usr/share/wordlists/rockyou.txt.gz
sudo cp /usr/share/wordlists/rockyou.txt /usr/local/bin/

##copiar archivos
echo -e "\n Copiando Archivos..."

sudo cp DDos_Bluetooth.sh  /usr/local/bin/
sudo cp GeneratorPass.sh /usr/local/bin/
sudo cp DDos_Wifi.sh /usr/local/bin/
sudo cp SelectionPass.sh /usr/local/bin/
sudo cp DDosNetwork /usr/local/bin/
sudo cp DefaultPass.sh /usr/local/bin/
sudo cp FAP.sh /usr/local/bin/
sudo cp MACBLUETOOTH.txt /usr/local/bin/
sudo cp NMCLI.txt /usr/local/bin/
sudo cp PasswordsFound.txt /usr/local/bin/
sudo cp rockyou.txt /usr/local/bin/
sudo cp README.md /usr/local/bin/

##dar permiso a los archivos
echo -e "\nPermisos Necesarios..."
sudo chmod +x /usr/local/bin/DDos_Bluetooth.sh 
sudo chmod +x /usr/local/bin/GeneratorPass.sh
sudo chmod +x /usr/local/bin/DDos_Wifi.sh
sudo chmod +x /usr/local/bin/DDosNetwork
sudo chmod +x /usr/local/bin/SelectionPass.sh
sudo chmod +x /usr/local/bin/DefaultPass.sh 
sudo chmod +x /usr/local/bin/FAP.sh 

echo -e "\n\nTodo instalado correctamente!!"
