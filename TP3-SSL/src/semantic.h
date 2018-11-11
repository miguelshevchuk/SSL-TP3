void declarar(char *s);

char* generarInfijo(void *operando1, char operador, void *operando2);

void asignar(char* valor, char* destino);

void leer (char * in);

void escribir (char * in);

void cargaBiblioteca(char *biblioteca);

void stop();

int yaExiste(char *identificador);


//identificadores: IDENTIFICADOR listaIdentificadores;

//expresiones: expresion listaExpresiones;

//%token<num> CONSTANTE
//%token<str> IDENTIFICADOR
//%token ASIGNACION
