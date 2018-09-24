/*
 ============================================================================
 Name        : TP3-SSL.c
 Author      : 
 Version     :
 Copyright   : Your copyright notice
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"
#include "scanner.h"

char *token_names[] = {"Fin de Archivo","Programa", "Fin", "Variables", "Codigo", "Definir", "Leer", "Escribir", "CONSTANTE", "IDENTIFICADOR", "OPERADOR", "CARACTER_PUNTUACION", "ASIGNACION"};
int main() {
	enum token t;
	while (t = yylex()){
		if(t == CONSTANTE || t == IDENTIFICADOR){
			printf("Token: %s\t\tLexema: %s\n", token_names[t], yytext);
		}else{
			printf("Token: '%s'\n", yytext);
		}
	}
	return 0;
}
