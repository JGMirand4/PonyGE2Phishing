#!/bin/bash

# Script simples para executar o experimento de classificação de phishing
echo "Iniciando experimento de classificação de phishing..."
echo "Data/Hora: $(date)"

# Executar o experimento
cd PonyGE2/src
python ponyge.py --parameters ../../parameters/classificationPhishing.txt --verbose

echo "Experimento finalizado em: $(date)" 