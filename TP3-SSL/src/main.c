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

char *token_names[] = {"Fin de Archivo","Programa", "Fin", "Variables", "Codigo", "Definir", "Leer", "Escribir", "Constante", "Identificador", "Asignacion", "Suma", "Resta", "Multiplicacion", "Division", "Parentesis_abre", "Parentesis_cierra", "Punto", "Coma"};
int main() {
	enum token t;
	while (t = yylex()){
		if(t == CONSTANTE || t == IDENTIFICADOR){
			printf("Token: %s\t\tLexema: %s\n", token_names[t], yytext);
		}else if(esCaracter(t)){
			printf("Token: '%c'\n", yytext[0]);
		}else{
			printf("Token: %s\n", token_names[t]);
		}

	}
	return 0;
}

int esCaracter(token){
	return token == SUMA || token == RESTA || token == MULTIPLICACION || token == DIVISION || token == PARENTESISABRE || token == PARENTESISCIERRA || token == PUNTO || token == COMA;
}
