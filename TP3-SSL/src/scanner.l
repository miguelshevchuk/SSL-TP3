%{
#include <stdio.h>
#include "parser.h"


%}

%option noyywrap
%option  outfile="scanner.c"
%option  header-file="scanner.h"
%option yylineno
%option  noinput    
%option  nounput


digito				[[:digit:]]
letra				[[:alpha:]]
asignacion			\<\-
suma					\+
resta				\-
multiplicacion		\*
division				\/
parentesisAbre		\(
parentesisCierra		\)
punto				\.
coma					\,
otros				[^[:space:][:digit:][:alpha:]+*/().,\n-]
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
{identif}											{yylval.str = strdup(yytext); return IDENTIFICADOR;}
{asignacion}											return ASIGNACION;
{suma}												return '+';
{resta}												return '-';
{multiplicacion}										return '*';
{division}											return '/';
{parentesisAbre}										return '(';
{parentesisCierra}									return ')';
{punto}												return '.';
{coma}												return ',';
{digito}+{letra}+[[:alnum:]]*						{yylexerrs++; mostrarError("Error Lexico: Constante Invalida: ", yytext);}
{identif}{otros}+(({letra}|{digito})*{otros}*)*		{yylexerrs++; mostrarError("Error Lexico: Identificador Invalido: ", yytext);}
{otros}+												{yylexerrs++; mostrarError("Error Lexico: Cadena desconocida: ", yytext); }

%%



