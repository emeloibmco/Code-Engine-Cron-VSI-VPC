#!/bin/bash

# Importar variables de entorno desde env.sh
source ./env.sh

  
ibmcloud login --apikey $APIKEY -r $REGION

iam_token=$(ibmcloud iam oauth-tokens)

# Extraer el token de la salida
token=$(echo "$iam_token" | awk -F"Bearer " '{print $2}')
hora_actual=$(date +%H)
url="$VPC_API_ENDPOINT/instances/$id_vsi/actions?version=2024-06-04&generation=2"

if [ "$hora_actual" -eq 19 ]; then
  curl -X POST $url -H "Authorization: $token" -d '{"type": "stop"}'
  echo -e "\nActualizado a apagada" 
elif [ "$hora_actual" -eq 23 ]; then
  curl -X POST $url -H "Authorization: $token" -d '{"type": "start"}'
  echo -e "\nActualizado a encendida" 
else
  echo "No es hora $hora_actual"
fi
