#!/bin/bash
###################################################################################################################
# Purpose: The purpose of the script is to create manifest to demo HAZL
# Created on: 04.10.24
# Updated on: 07.29.25
# Made with Love by: Phil Henderson
# Version 2.10
###################################################################################################################

set -e

source zones.env

mkdir -p manifest

for ZONE in $ZONE_LIST; do
  echo "Rendering $ZONE"
  sed "s|{{ZONE}}|$ZONE|g" backend-deployment-template.yaml > manifest/api-backend-$ZONE.yaml
  sed "s|{{ZONE}}|$ZONE|g" frontend-deployment-template.yaml > manifest/frontend-$ZONE.yaml
done

#cp namespace.yaml service.yaml manifest/
echo "Generated files manifest folder..."
#echo "Applying manifest..."
#kubectl create ns demo-app
#kubectl apply -f namespace.yaml
#kubectl apply -f service.yaml
#kubectl apply -f manifest/
