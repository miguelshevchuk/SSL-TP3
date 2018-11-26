#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *simbolos[200];
int nroSimbolo = 0;

int noEstaEnLaTabla(char *s){

	for(int i = 0; i < nroSimbolo ; i++){

		if(strcmp(simbolos[i], s) == 0){
			return 0;
		}
	}

	return 1;

}

void agregarALaTabla(char *nuevoID){
//queda definir el limite de la tabla y calcular el tamanio de la tabla para comparar
int tamanioTabla = 0, limiteTabla = 0;

	if(tamanioTabla < limiteTabla){
		simbolos[nroSimbolo] = nuevoID;
		nroSimbolo++;
	}else{
		return 0; //para que salga del programa, pero tendriamos que indicarle un tipo de error 
	}
}






