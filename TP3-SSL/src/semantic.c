#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "symbol.h"

int nroTemporal = 1;

void declarar(char *s){

	if(noEstaEnLaTabla(s)){
		agregarALaTabla(s);

		printf("%s %s, %s \n", "Declare", s, "Integer");
	}else{
		printf("Dale, man \n");
	}

}

char* declararTemporal(){
	char *temporal = malloc(sizeof(char *));
	sprintf(temporal,"Temp#%d", nroTemporal++);

	declarar(temporal);

	return temporal;
}


void leer (char * in) {
	printf("%s %s, %s \n", "Read", in, "Integer");
}

void escribir (char * in) {
	printf("%s %s, %s \n", "Write", in, "Integer");
}


char* generarInfijo(void *operando1, char operador, void *operando2){

	char *temporal = declararTemporal();

	switch(operador){

		case '+':
			printf("%s %s, %s, %s \n", "ADD", operando1, operando2, temporal);
			break;
		case '*':
			printf("%s %s, %s, %s \n", "MULT", operando1, operando2, temporal);
			break;
		case '/':
			printf("%s %s, %s, %s \n", "DIV", operando1, operando2, temporal);
			break;
		case '-':
			printf("%s %s, %s, %s \n", "SUBS", operando1, operando2, temporal);
			break;
		case '_':
			printf("%s %s, ,%s \n", "INV", operando1, temporal);
			break;


	}

	return temporal;

}

void asignar(char* valor, char* destino){

	printf("%s %s, %s \n", "Store", valor, destino);
}

