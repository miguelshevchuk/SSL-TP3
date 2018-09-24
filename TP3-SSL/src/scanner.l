%{
#include <stdio.h>
#include "tokens.h"


%}

%option noyywrap
%option  outfile="scanner.c"
%option  header-file="scanner.h"


digito				[[:digit:]]
letra				[[:alpha:]]
asignacion			\<\-
operador				[+]|[-]|[*]|[/]
caracterPuntuacion	\(|\)|\.|\,
otros				[#]|[@]|[<]
identif				{letra}({letra}|{digito})*
comentario			\/\/.*


%%
{comentario}									;
programa									return PROGRAMA;
fin										return FIN;
variables								return VARIABLES;
codigo									return CODIGO;
definir									return DEFINIR;
leer										return LEER;
escribir									return ESCRIBIR;
{digito}+								return CONSTANTE;
{identif}								return IDENTIFICADOR;
{operador}								return OPERADOR;
{caracterPuntuacion}						return CARACTER_PUNTUACION;
{asignacion}								return ASIGNACION;
<<EOF>>									return EOF;
{digito}+{letra}+[[:alnum:]]*				return ERROR_CONSTANTE;
{identif}{otros}+(({letra}|{digito})*{otros}*)*		return ERROR_IDENTIFICADOR;
{otros}+									return ERROR_COMUN;

%%

