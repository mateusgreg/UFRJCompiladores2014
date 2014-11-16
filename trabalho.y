%{
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

#define YYSTYPE string

int yylex();
int yyparse();
void yyerror(const char *);
%}

%token TK_MAIN TK_ID TK_VALOR TK_IF TK_ELSE TK_FOR TK_WHILE TK_DO TK_SWITCH TK_CASE TK_DEFAULT TK_RETURN TK_INT TK_CHAR 
%token TK_BOOLEAN TK_FLOAT TK_DOUBLE TK_STRING TK_AND TK_OR TK_IGUAL TK_DIFERENTE TK_MAIOR_IGUAL TK_MENOR_IGUAL TK_ADICIONA_UM TK_DIMINUI_UM
%token TK_CINT TK_CCHAR TK_CBOOLEAN TK_CFLOAT TK_CDOUBLE TK_VOID
%token TK_STR TK_PRINTF TK_SCANF

%%


S : VARIAVEIS LISTAF { cout << "Aceito" << endl; } 
  ;

LISTAF : FUN LISTAF 
       | MAIN 
       ;

FUN : TIPO TK_ID '(' ARGUMENTOS ')' CORPO 
    | TK_VOID TK_ID '(' ARGUMENTOS ')' CORPO 
    ;

MAIN : TK_INT TK_MAIN '(' ')' BLOCO 
     ; 

CORPO : BLOCO 
      | ';' 
      ;

BLOCO : '{' VARIAVEIS COMANDOS '}'
      | '{' COMANDOS '}'
      ; 

ARGUMENTOS : ARGUMENTO
           | 
           ;

ARGUMENTO : TIPO NOMEARG ARRAY ',' ARGUMENTO 
          | TIPO NOMEARG ARRAY 
          ;

NOMEARG : TK_ID
        |
        ;

VARIAVEIS : VARIAVEIS TIPO VAR ';' 
          | 
          ;

TIPO : TK_INT
     | TK_CHAR
     | TK_BOOLEAN { cout << "tkn boolean.\n"; }
     | TK_FLOAT   { cout << "tkn float.\n"; }
     | TK_DOUBLE  { cout << "tkn double.\n"; }
     | TK_STRING
     ;

VAR : TK_ID ARRAY
    | TK_ID ARRAY ',' VAR
    ;

ARRAY : '[' TK_CINT ']' 
      | '[' ']'
      | 
      ;

COMANDOS : COMANDO ';' COMANDOS
         |
         ;

COMANDO : CMD_ATRIB
        | CMD_IF_ELSE
        | CMD_FOR
        | CMD_WHILE
        | CMD_DO_WHILE
        | CMD_SWITCH
        | CMD_RETURN
        | CMD_PROC
        | CMD_PRINTF
        | CMD_SCANF
        ;

CMD_IF_ELSE : TK_IF '(' OP ')' BLOCO TK_ELSE BLOCO  { cout << "cmd if-else.\n"; }
            | TK_IF '(' OP ')' BLOCO  { cout << "cmd if.\n"; }
            ;

CMD_FOR : TK_FOR '(' CMD_ATRIB ';' OP ';' CMD_ATRIB ')' BLOCO
        ;

CMD_WHILE : TK_WHILE '(' OP ')' BLOCO
          ;

CMD_DO_WHILE : TK_DO BLOCO TK_WHILE '(' OP ')'
             ;

//#TK_ID deve ser apenas do tipo TK_INT
CMD_SWITCH : TK_SWITCH '(' TK_ID ')' '{' CMD_CASE TK_DEFAULT ':' COMANDOS '}'
           ;

CMD_CASE : TK_CASE TK_CINT ':' COMANDOS CMD_CASE
         |
         ;

CMD_ATRIB : TK_ID '=' OP
          | TK_ID '[' INDICE ']' '=' F
          | TK_ID TK_ADICIONA_UM
          | TK_ID TK_DIMINUI_UM
          ;

CMD_RETURN : TK_RETURN F
           | TK_RETURN
           ;

CMD_PROC : TK_ID '(' ')'
         | TK_ID '(' PARAMS ')'
         ;

OP : F '+' F
   | F '-' F
   | F '*' F
   | F '/' F
   | F '%' F
   | F TK_AND F
   | F TK_OR F
   | F TK_IGUAL F
   | F '>' F
   | F '<' F
   | F '|' F
   | F '&' F
   | F '^' F
   | '~' F
   | F TK_MENOR_IGUAL F
   | F TK_MAIOR_IGUAL F
   | F TK_DIFERENTE F
   | F 
   | '+' F 
   | '-' F 
   | '!' F
   | TK_ID '[' INDICE ']'
   | TK_ID '(' PARAMS ')'
   | TK_ID '(' ')'
   ;

F : TK_CINT
  | TK_CCHAR
  | TK_CBOOLEAN { cout << "cte boolean.\n"; }
  | TK_CFLOAT  { cout << "cte float.\n"; }
  | TK_CDOUBLE { cout << "cte double.\n"; }
  | TK_ID
  | TK_STR
  ;

PARAMS : F ',' PARAMS
       | F

INDICE : TK_CINT
       | TK_ID
       ;
       
CMD_PRINTF : TK_PRINTF '(' TK_STR ',' F ')'
           ;
           
CMD_SCANF : TK_SCANF '(' TK_STR ',' '&' TK_ID ')'
          ;
%%
int nlinha = 1;

#include "lex.yy.c"

int yyparse();

void yyerror( const char* st )
{
  puts( st );
  printf( "Linha: %d\nPerto de: '%s'\n", nlinha, yytext );
}

int main( int argc, char* argv[] )
{
  yyparse();
}
