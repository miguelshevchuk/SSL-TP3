%code top{
#include <stdio.h>
#include "scanner.h"
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
%token FDT PROGRAMA FIN VARIABLES CODIGO DEFINIR LEER ESCRIBIR CONSTANTE IDENTIFICADOR ASIGNACION
%define api.value.type {char *}
%define parse.error verbose

%left  '-'  '+'
%left  '*'  '/'
%precedence  NEG

%%
programa: PROGRAMA variables codigo  FIN { if (yynerrs || yylexerrs) YYABORT;};

variables: VARIABLES declararVariable | error '.';

declararVariable: DEFINIR IDENTIFICADOR '.'{printf("definir %s \n", yylval);} declararVariable | 
	%empty ;
	
codigo: CODIGO sentencia bloque ;

bloque: sentencia bloque | %empty ;

sentencia: leer | asignar | escribir | error '.';

leer: LEER'('IDENTIFICADOR listaIdentificadores')''.' {printf("leer \n");};

asignar: IDENTIFICADOR ASIGNACION expresion'.' {printf("asignacion \n");};

escribir: ESCRIBIR'('expresion listaExpresiones')''.' {printf("escribir \n");};

listaIdentificadores: ',' IDENTIFICADOR listaIdentificadores | %empty;

listaExpresiones: ',' expresion listaExpresiones | %empty;

expresion: 
	factor |
	expresion  '+'  factor {printf("suma \n");} | 
	expresion '-' factor {printf("resta \n");} |
  	factor '*' factor {printf("multiplicacion \n");} | 
  	factor '/' factor {printf("division \n");};

factor: 
	CONSTANTE | 
	IDENTIFICADOR |
	'('expresion')' {printf("parentesis \n");} | 
	'-' expresion %prec NEG {printf("inversion \n");};
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
