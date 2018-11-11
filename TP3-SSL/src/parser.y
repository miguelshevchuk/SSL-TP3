%code top{
#include <stdio.h>
#include "scanner.h"
#include "semantic.h"
}
%code provides{
void yyerror(const char *);
void mostrarError(char *mensaje, char *valor);
extern int yylexerrs;
extern int yynerrs;

}
%defines "parser.h"
%output "parser.c"
%start  programa

%define parse.error verbose

%union {
	int    num;
	char   *str;
	void		*expre;
}

%token FDT PROGRAMA FIN VARIABLES CODIGO DEFINIR LEER ESCRIBIR 
%token<num> CONSTANTE
%token<str> IDENTIFICADOR
%token ASIGNACION

%left  '-'  '+'
%left  '*'  '/'
%precedence  NEG

%%
programa: PROGRAMA variables codigo  FIN { if (yynerrs || yylexerrs) YYABORT;};

variables: VARIABLES declararVariable | error '.';

declararVariable: DEFINIR IDENTIFICADOR '.'{declarar($<str>2);} declararVariable | 
	%empty ;
	
codigo: CODIGO sentencia bloque ;

bloque: sentencia bloque | %empty ;

sentencia: leer | asignar | escribir | error '.';

leer: LEER'('IDENTIFICADOR {leer($<str>2);} listaIdentificadores')''.';

escribir: ESCRIBIR'('expresion[exp] {escribir($<str>exp);} listaExpresiones')''.';

asignar: IDENTIFICADOR[destino] ASIGNACION expresion[exp]'.' {asignar($<str>exp, $<str>destino);};

listaIdentificadores: ',' IDENTIFICADOR {leer($<str>1);}  listaIdentificadores | %empty;

listaExpresiones: ',' expresion[exp] {escribir($<str>exp);} listaExpresiones | %empty;

expresion: 
	expresion[izq] '*' expresion[der] {$<str>$ = generarInfijo($<expre>izq, '*', $<expre>der);} | 
  	expresion[izq] '/' expresion[der] {$<str>$ = generarInfijo($<expre>izq, '/', $<expre>der);}|
	expresion[izq] '+' expresion[der] {$<str>$ = generarInfijo($<expre>izq, '+', $<expre>der);} | 
	expresion[izq] '-' expresion[der] {$<str>$ = generarInfijo($<expre>izq, '-', $<expre>der);} |
  	CONSTANTE[const] | 
	IDENTIFICADOR |
	'('expresion')' | 
	'-' expresion[der] %prec NEG {$<str>$ = generarInfijo($<str>der, '_', $<str>der);};

%%



int yylexerrs = 0;

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	
	return;
}


void mostrarError(char *mensaje, char *valor){

 	char *mensajeError;
	mensajeError = malloc(200);
	strcpy(mensajeError, mensaje);
   	strcat(mensajeError, valor);
   	yyerror(mensajeError);
   	free(mensajeError);
   	return;
}
