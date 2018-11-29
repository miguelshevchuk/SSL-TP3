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
extern int yysemerrs;
extern int errMemoria;

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
programa: PROGRAMA {cargaBiblioteca("rtlib");} variables codigo  FIN {stop(); if(errMemoria) return 2; else if (yynerrs || yylexerrs || yysemerrs) YYABORT; else YYACCEPT;};

variables: VARIABLES declararVariable | error '.';

declararVariable: DEFINIR IDENTIFICADOR '.'{if(!declarar($2)) YYERROR;} declararVariable | 
	%empty;
	
codigo: CODIGO sentencia bloque ;

bloque: sentencia bloque | %empty ;

sentencia: leer | asignar | escribir | error '.';

leer: LEER'(' listaIdentificadores IDENTIFICADOR[id] {if(!leer($id)) YYERROR;} ')''.';

escribir: ESCRIBIR'('expresion[exp] {escribir($exp);} listaExpresiones')''.';

asignar: IDENTIFICADOR[destino] { if(noExiste($destino)) YYERROR;} ASIGNACION expresion[exp]'.' {asignar($exp, $destino);};

listaIdentificadores:  listaIdentificadores IDENTIFICADOR[ide] ',' {if(!leer($ide)) YYERROR;}  | %empty;

listaExpresiones: ',' expresion[exp] {escribir($exp);} listaExpresiones | %empty;

expresion: 
	expresion[izq] '*' expresion[der] {$$ = generarInfijo($izq, '*', $der);} | 
  	expresion[izq] '/' expresion[der] {$$ = generarInfijo($izq, '/', $der);}|
	expresion[izq] '+' expresion[der] {$$ = generarInfijo($izq, '+', $der);} | 
	expresion[izq] '-' expresion[der] {$$ = generarInfijo($izq, '-', $der);} |
  	CONSTANTE | 
	IDENTIFICADOR[iden] { if(noExiste($iden)) YYERROR;}|
	'('expresion[expr]')' {$$ = $expr;}| 
	'-' expresion[der] %prec NEG {$$ = generarInfijo($der, '_', $der);};

%%



int yylexerrs = 0;
int yysemerrs = 0;
int errMemoria = 0;

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
