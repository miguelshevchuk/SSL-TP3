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


 %define api.value.type {char *}
%token FDT PROGRAMA FIN VARIABLES CODIGO DEFINIR LEER ESCRIBIR CONSTANTE IDENTIFICADOR ASIGNACION


%left  '-'  '+'
%left  '*'  '/'
%precedence  NEG

%%
programa: PROGRAMA {cargaBiblioteca("rtlib");} variables codigo  FIN {stop(); if (yynerrs || yylexerrs) YYABORT;};

variables: VARIABLES declararVariable | error '.';

declararVariable: DEFINIR IDENTIFICADOR '.'{declarar($2);} declararVariable | 
	%empty ;
	
codigo: CODIGO sentencia bloque ;

bloque: sentencia bloque | %empty ;

sentencia: leer | asignar | escribir | error '.';

leer: LEER'('IDENTIFICADOR {leer($2);} listaIdentificadores')''.';

escribir: ESCRIBIR'('expresion[exp] {escribir($exp);} listaExpresiones')''.';

asignar: IDENTIFICADOR[destino] ASIGNACION expresion[exp]'.' {asignar($exp, $destino);};

listaIdentificadores: ',' IDENTIFICADOR {leer($1);}  listaIdentificadores | %empty;

listaExpresiones: ',' expresion[exp] {escribir($exp);} listaExpresiones | %empty;

expresion: 
	expresion[izq] '*' expresion[der] {$$ = generarInfijo($izq, '*', $der);} | 
  	expresion[izq] '/' expresion[der] {$$ = generarInfijo($izq, '/', $der);}|
	expresion[izq] '+' expresion[der] {$$ = generarInfijo($izq, '+', $der);} | 
	expresion[izq] '-' expresion[der] {$$ = generarInfijo($izq, '-', $der);} |
  	CONSTANTE | 
	IDENTIFICADOR[iden] {verificarExistencia($iden);}|
	'('expresion[expr]')' {$$ = $expr;}| 
	'-' expresion[der] %prec NEG {$$ = generarInfijo($der, '_', $der);};

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
