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

int agregarALaTabla(char *nuevoID){

	if(nroSimbolo < 200){
		simbolos[nroSimbolo] = nuevoID;
		nroSimbolo++;
		return 1;
	}

	return 0;

}






