/*
    TP5 - 2018
    Grupo: 07
    Integrantes:
    - Ramirez, Jeremias - 141.941-9
    - Shevchuk Calo, Miguel Omar - 152.603-0
*/

#include <stdio.h>
#include <stdlib.h>
#include "scanner.h"
#include "parser.h"


int main() {
	int resultado = yyparse();
	switch( resultado ){
	case 0:
		puts("Compilación terminada con Éxito");
		break;
	case 1:
		puts("Errores de compilacion");
		break;
	case 2:
		puts("Memoria insuficiente");
		break;
	}

	printf("Errores sintacticos: %d \n", yynerrs);
	printf("Errores lexicos: %d \n", yylexerrs);
	printf("Errores semanticos: %d \n", yysemerrs);

	return resultado;
}
