#! /bin/bash
# Deploy to configPBBDESARROLLO (by default) to two machines
# VMADR5ACFG1 and VMAD4ACFG1
# debe existir una relacion de confianza (ssh) entre la maquina q ejecuta script
# y la maquina receptora

#########
# PATHS #
#########
# En origen el esqueleto es (html y cgi son hermanos)
# path_origen/html
# path_origen/cgi

# ORIGEN SCRIPTS
path_origen="/home/dan/cosas_hechas/92.webSMSIT/"   # el '/' final es importante
# DESTINO SCRIPTS
path_destino="/var/www/html"    # aqui se va a concatenar nombre_app_destino


##############
# Nombre app desarrollo o produccion son iguales
# desarrollo: webSMSIT
# produccion: webSMSIT
##############
nombre_app_destino=''
# if there are no arguments Nombre app es DESARROLLO
if [ ! $1 ]; then
	nombre_app_destino="websmsit"
else
	nombre_app_destino=$1
fi

echo "====================PATHS===================="
echo "path_origen ["$path_origen"]"
echo "path_destino ["$path_destino"]"
echo "nombre_app_destino ["$nombre_app_destino"]"
echo "============================================="


#################
# Hosts destino #
#################
array_hosts_destino=( "VMADR5SMSIT1" )

function sincronizar(){
	host_destino=$1
	echo $host_destino

	# exit
	# Todo el contenido de html/
	# las entradas y salidas estaban en este directorio en pruebas mias.
	# ahora estan en directorios donde HERMES va a escribir
	rsync -vr  $path_origen --exclude=".git" --exclude="deploy*" --exclude="docs" --exclude="utils" --exclude="prueba*" op1@$host_destino:$path_destino/$nombre_app_destino
	if [ ! $? -eq 0 ]; then
		echo "=========================>ERROR EN rsync[1]"
	fi

	# librerias_comunes
	# rsync -vr --exclude="test*" $path_librerias_comunes_origen/* op1@$host_destino:$path_librerias_comunes_destino
	# if [ ! $? -eq 0 ]; then
	# 	echo "=========================>ERROR EN rsync[2] Librerias comunes"
	# fi

	# # Parte CGI
	# # excluyo TODO.txt la carpeta con utisl y los ficheros_salida y fichero_salida_detalles
	# rsync -vr  $path_origen/* op1@$host_destino:$path_destino
	# # rsync -vr --exclude="TODO.txt" --exclude="util*" $path_origen/cgi-bin/* op1@$host_destino:$path_destino/html/$nombre_app_destino/cgi-bin/
	# if [ ! $? -eq 0 ]; then
	# 	echo "=========================>ERROR EN rsync[2]"
	# fi
}



# Recorrer array_hosts_destino y sincronizar para cada host
for i in "${array_hosts_destino[@]}"
do
	sincronizar $i
	echo "DONE SINCRONIZATION OF [$i]=============================="
done

notify-send "subido $nombre_app_destino a $array_hosts_destino en DESARROLLO"