#!/bin/bash
echo ""
echo "LABORATORIO 02"
echo ""

rm -rf salida.txt LAB02_VALERO_HOYOS.tab.c LAB02_VALERO_HOYOS.tab.h lex.yy.c
bison -d LAB02_VALERO_HOYOS.y
flex LAB02_VALERO_HOYOS.l



echo "**"
echo "Generando ejecutable"
gcc LAB02_VALERO_HOYOS.tab.c lex.yy.c -o programa

echo ""
echo "EJECUTANDO"
./programa prueba.py

echo "La salida se genero con exito"
