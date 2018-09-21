%{
#include <stdio.h>
#include "tokens.h"


%}

%option  outfile="scanner.c"
%option  header-file="scanner.h"

digito				[[:digit:]]
letra				[[:alpha:]]
operador				[+]|[-]|[*]|[/]
caracterPuntuacion	\(|\)|\.|\,
asignacion			[<-]

%%

programa							return PROGRAMA;
fin								return FIN;
variables						return VARIABLES;
codigo							return CODIGO;
definir							return DEFINIR;
leer								return LEER;
escribir							return ESCRIBIR;
{digito}+						return CONSTANTE;
{letra}({letra}|{digito})*		return IDENTIFICADOR;
{operador}						return OPERADOR;
{caracterPuntuacion}				return CARACTER_PUNTUACION;
{asignacion}						return ASIGNACION;

%%
/*char *token_names[] = {"HEXA", "DECIMAL", "OCTAL", "REAL"};
int main() {
	enum token t;
	while ((t = yylex()) != EOF)
		printf("Token: %s\t\tValor: %s\n", token_names[t], yytext);
	return 0;
}*/
