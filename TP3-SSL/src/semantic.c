#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "symbol.h"
#include "parser.h"

int nroTemporal = 1;

void cargaBiblioteca(char *biblioteca){
	printf("%s %s, \n", "Load", biblioteca);
}

void stop(){
	printf("Stop, \n");
}

int declarar(char *s){

	if(noEstaEnLaTabla(s)){
		if(agregarALaTabla(s)){
			printf("%s %s, %s \n", "Declare", s, "Integer");
			return 1;
		}else{
			mostrarError("No se puede declarar la variable - Memoria insuficiente: ", s);
			errMemoria = 1;
		}
	}else{
		mostrarError("Error Semantico: El identificador ya fue declarado: ", s);
		yysemerrs++;
	}

	return 0;


}

int noExiste(char *identificador){
	if(noEstaEnLaTabla(identificador)){
		mostrarError("Error Semantico: Identificador Inexistente: ", identificador);
		yysemerrs++;
		return 1;
	}

	return 0;
}


char* declararTemporal(){
	char *temporal = malloc(sizeof(char *));
	sprintf(temporal,"Temp#%d", nroTemporal++);

	declarar(temporal);

	return temporal;
}


int leer (char * in) {
	if(noExiste(in)){
		return 0;
	}
	printf("%s %s, %s \n", "Read", in, "Integer");
	return 1;
}

void escribir (char * in) {
	printf("%s %s, %s \n", "Write", in, "Integer");
}


char* generarInfijo(char* operando1, char operador, char* operando2){

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


