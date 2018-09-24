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
{comentario}											;
[[:space:]]											;
programa												return PROGRAMA;
fin													return FIN;
variables											return VARIABLES;
codigo												return CODIGO;
definir												return DEFINIR;
leer													return LEER;
escribir												return ESCRIBIR;
{digito}+											return CONSTANTE;
{identif}											return IDENTIFICADOR;
{operador}											return OPERADOR;
{caracterPuntuacion}									return CARACTER_PUNTUACION;
{asignacion}											return ASIGNACION;
{digito}+{letra}+[[:alnum:]]*							{printf("Error Lexico: %s: %s\n", "Constante Invalida", yytext);}
{identif}{otros}+(({letra}|{digito})*{otros}*)*		{printf("Error Lexico: %s: %s\n", "Identificador Invalido", yytext);}
{otros}+												{printf("Error Lexico: %s: %s\n", "Cadena desconocida", yytext);}

%%

