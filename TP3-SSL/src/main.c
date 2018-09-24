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

char *token_names[] = {"ERROR_CONSTANTE", "ERROR_COMUN", "ERROR_IDENTIFICADOR", "PROGRAMA", "FIN", "VARIABLES", "CODIGO", "DEFINIR", "LEER", "ESCRIBIR", "CONSTANTE", "IDENTIFICADOR", "OPERADOR", "CARACTER_PUNTUACION", "ASIGNACION"};
int main() {
	enum token t;
	while ((t = yylex()) != EOF)
		printf("Token: %s\t\tValor: %s\n", token_names[t], yytext);
	return 0;
}
