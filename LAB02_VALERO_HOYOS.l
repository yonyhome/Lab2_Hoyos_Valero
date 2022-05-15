%{
    #include <stdio.h>
    #include "LAB02_VALERO_HOYOS.tab.h"
    int cerror=0;
%}
%option noyywrap


letter ([a-zA-Z])
digit ([0-9])
decimal (\.{digit}+)
letra ([a-zA-Z]+)
numero ([0-9]+)
palabrasClave ((and)|(break)|(continue)|(def)|(elif)|(else)|(for)|(if)|(import)|(in)|(is)|(not)|(or)|(pass)|(print)|(return)|(while)|(False)|(True)|(range))
identificadores "_"?{letter}({letter}|{digit}|"_")*
operadores ((\+)|(\-)|(\*\*)|(\*)|(\/\/)|(\/)|(\%)|(<<)|(>>)|(&)|(\|)|(\^)|(~)|(<)|(>)|(<=)|(>=)|(==)|(\!=)|(<>))
integer ("-"?({digit})+)
long ({integer}(L|l))
entero ({integer}|{long})
imaginario "-"?({entero}|{real})(j|J)
caracter ({letra}|{numero}|{delimitadores}|{operadores}|(\ ))
cadena ((\")({caracter}*)(\"))|((\')({caracter}*)(\'))|((\’|‘)({caracter}*)(\’|‘))
delimitadores ((\()|(\))|(\[)|(\])|(=)|(;)|(,)|(:)|(\.)|(>>=)|(<<=)|(\+=)|(-=)|(\*=)|(\/=)|(\/\/=)|(&=)|(\|=)|(\^=)|(\*\*=)|(%=))
comentario ((\#){caracter}+[^\n])
operadoresdebit ((<<)|(>>)|(&)|(\|)|(\^)|(~))
operadorescomparacion ((<)|(>)|(<=)|(>=)|(==)|(\!=)|(<>))
delimitadoresasignacion ((>>=)|(<<=)|(\+=)|(-=)|(\*=)|(\/=)|(\/\/=)|(&=)|(\|=)|(\^=)|(\*\*=)|(%=))
espacio (([^ \t\r\n]))
tab (\b\b\b\b)
Var         "_"?{letter}({letter}|{digit}|"_")* 
real        ("-"?{digit}+?{decimal})|("-"?{digit}+{decimal})
error4      {real}(L|l)+
error       ({entero}|{decimal}){letter}+((l|L|j|J)+)
error2       ({entero}|{decimal})[a-d|A-D|E|e|f-i|F-I|k|K|m-z|M-Z]+
error3       ({imaginario}|{long}|error4)({letter}|{digit})+ 
error7          ((\"|\'){Var})


%%

"and" {return(AND);}
"break" {return(BREAK);}
"continue" {return(CONTINUE);}
"def" {return(DEF);}
"elif" {return(ELIF);}
"else" {return(ELSE);}
"for"   {return(FOR);}
"if" {return(IF);}
"import" {return(IMPORT);}
"in" {return(IN);}
"is" {return(IS);}
"not" {return(NOT);}
"or" {return(OR);}
"pass" {return(PASS);}
"print" {return(PRINT);}
"return" {return(RETURN);}
"while"   {return(WHILE);}
"range" {return(RANGE);}
"False" {return(FALSE);}
"True" {return(TRUE);}
"(" {return(PARENTA);}
")" {return(PARENTC);}
"[" {return(CORCHETEA);}
"]" {return(CORCHETEC);}
"=" {return(ASIGN);}
">" {return(MAYORQUE);}
"<" {return(MENORQUE);}
";" {return(PUNTOYCOMA);}
"," {return(COMA);}
":" {return(DOSPUNTOS);}
"." {return(PUNTO);}
"" {;}
"+" { return(SUMA);}
"-" { return(RESTA);}
"*" { return(MULTI);}
"**" { return(EXPO);}
"/" { return(DIVI);}
"//" { return(DIVENT);}
"%" { return(MOD);}
\n  {cerror++; return(SALTOLINEA);}
\t  {return(TAB);}
{operadoresdebit} {return(OPB);}
{operadorescomparacion} {return(OPC);}
{identificadores} {return(ID);}
{integer} {return(INTEGER);}
{long} {return(LONG);}
{decimal} {return(DECIMAL);}
{imaginario} {return(IMAGINARIO);}
{cadena} {return(CADENA);}
{delimitadoresasignacion} {return(DELIMITADORESA);}
{comentario} {return(COMENTARIO);}
{espacio} {return(ESPACIO);}
{error} { return(ERROR);}
{error2} { return(ERROR);}
{error3} { return(ERROR);}
{error4} { return(ERROR);}
{error7} { return(ERROR);}
%%


