//Fabio de Matos Carrilho. DRE: 111031170
//Mateus Gregorio de Souza. DRE: 109062660
//Vitor Marques de Miranda. DRE: XXX

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

%token TK_MAIN TK_ID TK_IF TK_ELSE TK_FOR TK_WHILE TK_DO TK_SWITCH TK_CASE TK_DEFAULT
%token TK_INTERVAL TK_FILTER TK_FOR_EACH TK_FIRST_N TK_LAST_N TK_SPLIT TK_MERGE TK_SORT
%token TK_AND TK_OR TK_IGUAL TK_DIFERENTE TK_MAIOR_IGUAL TK_MENOR_IGUAL TK_ADICIONA_UM TK_DIMINUI_UM TK_FROM_TO 
%token TK_INT TK_CHAR TK_BOOLEAN TK_FLOAT TK_DOUBLE TK_STRING TK_VOID
%token TK_CINT TK_CCHAR TK_CBOOLEAN TK_CFLOAT TK_CDOUBLE TK_STR
%token TK_PRINTF TK_SCANF TK_RETURN

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
      ; 

BLOCO_FUNCAO : '{' VARIAVEIS COMANDOS '}'
             | COMANDO ';'
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

ARRAY : '[' TK_CINT ']' ARRAY
      | '[' ']'
      | 
      ;

COMANDOS : COMANDO ';' COMANDOS
         | COMANDO_BLOCO COMANDOS
         |
         ;

COMANDO_BLOCO : CMD_IF_ELSE
              | CMD_FOR
              | CMD_WHILE
              | CMD_SWITCH
              | CMD_INTERVAL
              | CMD_FILTER
              | CMD_FOREACH
              ;

COMANDO : CMD_ATRIB
        | CMD_DO_WHILE
        | CMD_RETURN
        | FUN_PROC
        | CMD_PRINTF
        | CMD_SCANF
        ;

CMD_IF_ELSE : TK_IF '(' OP ')' BLOCO_FUNCAO CMD_ELSE
            ;

CMD_ELSE : TK_ELSE BLOCO_FUNCAO  { cout << "cmd if-else.\n"; }
         | { cout << "cmd if.\n"; }
         ;

CMD_FOR : TK_FOR '(' CMD_ATRIB ';' OP ';' CMD_ATRIB ')' BLOCO_FUNCAO { cout << "cmd for.\n"; }
        ;

CMD_WHILE : TK_WHILE '(' OP ')' BLOCO_FUNCAO { cout << "cmd while.\n"; }
          ;

CMD_DO_WHILE : TK_DO BLOCO TK_WHILE '(' OP ')' { cout << "cmd do-while.\n"; }
             ;

CMD_SWITCH : TK_SWITCH '(' INDICE ')' '{' CMD_CASE TK_DEFAULT ':' COMANDOS '}' { cout << "cmd switch-default.\n"; }
           ;

CMD_CASE : TK_CASE INDICE ':' COMANDOS CMD_CASE { cout << "cmd switch-case.\n"; }
         |
         ;

CMD_INTERVAL : TK_INTERVAL '(' INDICE TK_FROM_TO INDICE ')' BLOCO_FUNCAO
             ;

//#Dentro de OP haverá acesso à variável INDEX que diz a posição em que o filtro se encontra
CMD_FILTER : TK_FILTER '(' OP ')' BLOCO_FUNCAO
           ;

//#TK_ID deve ser array
CMD_FOREACH : TK_FOR_EACH '(' TK_ID ')' BLOCO_FUNCAO
            ;

//#TK_ID deve ser array 
FUN_SORT : TK_SORT '(' TK_ID ')'
         ;

//#TK_ID deve ser array
FUN_FIRST_N : TK_FIRST_N '(' TK_ID ',' INDICE ')'
            ;

//#TK_ID deve ser array
FUN_LAST_N : TK_LAST_N '(' TK_ID ',' INDICE ')'
           ;

//#Dentro de OP haverá acesso à variável INDEX que diz a posição em que o split se encontra
//#O retorno é uma array bi-dimensional contendo as duas metades, uma em [0] e a outra em [1]
FUN_SPLIT : TK_SPLIT  '(' TK_ID ',' OP ')'
          ;

//#Os TK_IDs devem ser arrays
FUN_MERGE : TK_MERGE  '(' TK_ID ',' TK_ID ')'
          ;

CMD_ATRIB : TK_ID '=' OP
          | TK_ID '[' INDICE ']' '=' F
          | TK_ID TK_ADICIONA_UM
          | TK_ID TK_DIMINUI_UM
          ;

CMD_RETURN : TK_RETURN F
           | TK_RETURN
           ;

FUN_PROC : TK_ID '(' ')'
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
   | FUN_SORT
   | FUN_FIRST_N
   | FUN_LAST_N
   | FUN_SPLIT
   | FUN_MERGE
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
       ;

//#TK_ID deve ser apenas do tipo TK_INT
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
