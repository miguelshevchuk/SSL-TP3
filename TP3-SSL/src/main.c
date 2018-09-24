/*
    TP3 - 2018
    Grupo: 07
    Integrantes:
    - Aruquipa Mamani, Jhoselyn Sandra - 160.867-8
    - Yamada, Demian - 152.711-3
    - Ramirez, Jeremias - 141.941-9
    - Shevchuk Calo, Miguel Omar - 152.603-0
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
