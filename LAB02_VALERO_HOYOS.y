%{
	#include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
	extern int yylex();
	extern FILE * yyin;
	extern FILE * yyout;
	extern int yylineno;
	extern int cerror;
	extern char *yytext;
	int ANT = 0;
	int errores = 0;
	void yyerror(const char *s);

%}

%token SUMA
%token RESTA
%token MULTI
%token DIVI
%token DIVENT
%token EXPO
%token MOD
%token MAYORQUE
%token MENORQUE
%token ERROR
%token AND
%token CONTINUE
%token DEF
%token ELIF
%token ELSE
%token FOR
%token IF
%token IMPORT
%token FALSE
%token TRUE
%token RANGE
%token IN
%token IS
%token NOT
%token OR
%token PASS
%token PRINT
%token RETURN
%token WHILE
%token OPB
%token OPC
%token ID
%token INTEGER
%token LONG
%token DECIMAL
%token IMAGINARIO
%token CADENA
%token PARENTA
%token PARENTC
%token CORCHETEA
%token CORCHETEC
%token ASIGN
%token PUNTOYCOMA
%token COMA
%token DOSPUNTOS
%token PUNTO
%token DELIMITADORESA
%token COMENTARIO
%token SALTOLINEA
%token ESPACIO
%token BREAK
%token TAB 
%start INICIO
%%

OPA: SUMA
    | RESTA
    | MULTI
    | EXPO
    | DIVI
    | DIVENT
    | MOD
    ;

INICIO: IMPORTAR
     | IMPORTAR SALTOLINEA INICIO
     | INSTRUCCIONES;
     
IMPORTAR: IMPORT ID
        ;

INSTRUCCIONES: 
             | INSTRUCCION | INSTRUCCION SALTOLINEA INSTRUCCIONES
             ;

INSTRUCCION: IMPRIMIR
           | ASIGNACION
           | BREAK
           | CONTINUE
           | PASS
           | CICLO
           | DEFINICIONFUNCION
           | CONDICIONALIF
           | EPSILON
           ;

ASIGNACION: ID ASIGN ID
          | ID ASIGN INTEGER
          | ID ASIGN LISTA
          | LISTA ASIGN LISTA
          ;



EXPRESION: ID | EXPRESIONARITMETICA | EXPRESIONBOOLEANA | CADENA | LLAMADAFUNCIONES
         ;
         
MATRIZ: ID POSICIONLISTA POSICIONLISTA;

EXPRESIONES: EXPRESION COMAEXPRESION | EPSILON
           ;

COMAEXPRESION: COMA EXPRESION COMAEXPRESION 
             | EPSILON
             ;
             
EXPRESIONARITMETICA: INTEGER
                   | DECIMAL
                   | LONG
                   | IMAGINARIO
                   | ID
                   | MATRIZ
                   | LISTA
                   | LLAMADAFUNCIONES OPA INTEGER
                   | ID OPA ID
                   | INTEGER OPA INTEGER
                   | DECIMAL OPA DECIMAL
                   | LONG OPA LONG
                   | IMAGINARIO OPA IMAGINARIO
                   | ID OPA INTEGER
                   | ID OPA DECIMAL
                   | ID OPA LONG
                   | ID OPA IMAGINARIO
                   | LISTA OPA INTEGER
                   | INTEGER OPA ID
                   | DECIMAL OPA ID
                   | LONG OPA ID
                   | IMAGINARIO OPA ID
                   
                   ;

EXPRESIONBOOLEANA: FALSE
                 | TRUE
                 | ID OPC ID
                 | ID IS ID
                 | NOT ID
                 | ID AND ID
                 | ID OR ID
                 ;

LLAMADAFUNCIONES: ID PARENTA PARENTC
                ;

SENTENCIA: ASIGNACION
         | IMPRIMIR
         | CICLO
		     | CONDICIONALIF
         ;
       
CICLO: CICLOFOR
     | CICLOWHILE
     ;

CICLOFOR: FOR ID IN SECUENCIA DOSPUNTOS SALTOLINEA INSTRUCCIONES SALTOLINEA
        ;
      
CICLOWHILE: WHILE CONDICIONES DOSPUNTOS SALTOLINEA INSTRUCCIONES SALTOLINEA
          ;

CONDICIONALIF: IF CONDICIONES DOSPUNTOS SALTOLINEA SENTENCIA SALTOLINEA CONDICIONALELIF
             ;

CONDICIONALELSE: ELSE DOSPUNTOS SALTOLINEA SENTENCIA
               ;

CONDICIONALELIF: ELIF CONDICIONES DOSPUNTOS SALTOLINEA SENTENCIA SALTOLINEA CONDICIONALELIF
               | ELIF CONDICIONES DOSPUNTOS SALTOLINEA SENTENCIA SALTOLINEA CONDICIONALELSE
               | EPSILON
               ;

SECUENCIA: RANGEFOR 
         | LISTA
         ;

RANGEFOR: RANGE PARENTA EXPRESIONARITMETICA COMA EXPRESIONARITMETICA  COMA EXPRESIONARITMETICA  PARENTC
        | RANGE PARENTA EXPRESIONARITMETICA COMA EXPRESIONARITMETICA PARENTC
        | RANGE PARENTA LLAMADAFUNCIONES OPA INTEGER COMA EXPRESIONARITMETICA PARENTC
        ;

CONDICIONES: EXPRESIONBOOLEANA
           | EXPRESIONBOOLEANA AND CONDICIONES
           | EXPRESIONBOOLEANA OR CONDICIONES
           | NOT CONDICIONES
           | EXPRESION MAYORQUE EXPRESION
           | EXPRESION MENORQUE EXPRESION
           ;        

LISTA: ID POSICIONLISTA
     | ID ASIGN POSICIONLISTA
     ;

POSICIONLISTA: CORCHETEA EXPRESION CORCHETEC
             | CORCHETEA EXPRESIONES CORCHETEC
             ;



IMPRIMIR: PRINT PARENTA EXPRESIONES PARENTC
        ;           



PARAMETRO: ID | ID PARAMETROS | EPSILON
         ;
            
PARAMETROS: COMA ID PARAMETROS 
          | EPSILON
          ;

DEFINICIONFUNCION: DEF ID PARENTA PARAMETRO PARENTC DOSPUNTOS SALTOLINEA INSTRUCCIONES SALTOLINEA RETURN EXPRESION
                 | DEF ID PARENTA PARAMETRO PARENTC DOSPUNTOS SALTOLINEA INSTRUCCIONES SALTOLINEA
                 ;

EPSILON: ;

%%

int main(int argc, char *argv[]){
    if (argc == 2){
        yyin = fopen (argv[1], "r");
        yyout=fopen("salida.txt","w");
        if (yyin == NULL){
            printf ("El fichero %s no se puede abrir\n", argv[1]);
            exit (-1);
        }else{
            while(!feof(yyin)){
                yyparse();
            }
            if(errores==0){
                fprintf(yyout, "No hubo ningun error sintactico.");
                fprintf(stderr, "No hubo ningun error sintactico.\n");
            }
        }
    }
}
void yyerror(const char *s){
	if (ANT != cerror+1){
		fprintf(yyout, "ERROR en la línea %d de tipo: %s\n",cerror+1,s);
		ANT = cerror+1;
	}	
	errores++;		
}

