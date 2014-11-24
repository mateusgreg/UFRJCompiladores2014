//Fabio de Matos Carrilho. DRE: 111031170
//Mateus Gregorio de Souza. DRE: 109062660
//Vitor Marques de Miranda. DRE: XXX

%{
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <map>

using namespace std;

const int MAX_STR = 256;

struct Tipo {
  string nome;
  
  Tipo() {}
  Tipo( string nome ) {
    this->nome = nome;
  }
};

struct Atributo {
  string v;  // Valor
  Tipo   t;  // tipo
  string c;  // codigo
  
  Atributo() {}  // inicializacao automatica para vazio ""
  Atributo( string v, string t = "", string c = "" ) {
    this->v = v;
    this->t.nome = t;
    this->c = c;
  }
};

typedef map< string, Tipo > TS;
TS ts; // Tabela de simbolos

string pipeAtivo; // Tipo do pipe ativo

Tipo tipoResultado( Tipo a, string operador, Tipo b );
string geraTemp( Tipo tipo );
string geraDeclaracaoTemporarias();
string geraDeclaracaoVarPipe();

void insereVariavelTS( TS&, string nomeVar, Tipo tipo );
bool buscaVariavelTS( TS&, string nomeVar, Tipo* tipo );
void erro( string msg );
string toStr( int n );

void geraCodigoAtribuicao( Atributo* SS, Atributo& lvalue, const Atributo& rvalue );
void geraCodigoOperadorBinario( Atributo* SS, const Atributo& S1, const Atributo& S2, const Atributo& S3 );
void geraCodigoFuncaoPrincipal( Atributo* SS, const Atributo& cmds );
void geraCodigoIfComElse( Atributo* SS, const Atributo& expr, 
                                        const Atributo& cmdsThen,
                                        const Atributo& cmdsElse );
void geraCodigoIfSemElse( Atributo* SS, const Atributo& expr, 
                                        const Atributo& cmdsThen );

void geraDeclaracaoVariavel( Atributo* SS, const Atributo& tipo,
                                           const Atributo& id );
                                           
// Usando const Atributo& não cria cópia desnecessária

#define YYSTYPE Atributo

int yylex();
int yyparse();
void yyerror(const char *);
%}

%token TK_MAIN TK_ID TK_IF TK_ELSE TK_FOR TK_WHILE TK_DO TK_SWITCH TK_CASE TK_DEFAULT
%token TK_INTERVAL TK_FILTER TK_FOR_EACH TK_FIRST_N TK_LAST_N TK_SPLIT TK_MERGE TK_SORT
%token TK_AND TK_OR TK_IGUAL TK_DIFERENTE TK_MAIOR_IGUAL TK_MENOR_IGUAL TK_ADICIONA_UM TK_DIMINUI_UM TK_FROM_TO 
%token TK_INT TK_CHAR TK_BOOLEAN TK_FLOAT TK_DOUBLE TK_STRING TK_VOID
%token CONST_INT CONST_CHAR CONST_BOOLEAN CONST_FLOAT CONST_DOUBLE CONST_STRING
%token TK_PRINTF TK_SCANF TK_RETURN

%nonassoc '<' '>' TK_IGUAL TK_MENOR_IGUAL TK_MAIOR_IGUAL TK_DIFERENTE
%left TK_AND TK_OR 
%left '+' '-' 
%left '*' '/' '%' 
%left '!'

%%


S : VARIAVEIS LISTA_FUNCOES
    { cout << "#include <stdio.h>\n"
               "#include <stdlib.h>\n"
               "#include <string.h>\n\n"
            << $1.c << $2.c << endl; }
  ;

LISTA_FUNCOES : FUNCAO LISTA_FUNCOES
                { $$ = Atributo();
                  $$.c = $1.c + $2.c; }
              | MAIN
                { $$ = Atributo(); }
              ;

FUNCAO : TIPO TK_ID '(' ARGUMENTOS ')' CORPO_DE_FUNCAO
       | TK_VOID TK_ID '(' ARGUMENTOS ')' CORPO_DE_FUNCAO
       ;

MAIN : TK_INT TK_MAIN '(' ')' BLOCO 
       { geraCodigoFuncaoPrincipal( &$$, $5 ); }
     ; 

CORPO_DE_FUNCAO : BLOCO 
                | ';' 
                ;

BLOCO : '{' VARIAVEIS COMANDOS '}'
      ; 

BLOCO_COMANDO : BLOCO
              | COMANDO ';'
              ; 

ARGUMENTOS : ARGUMENTO
//           | MULTI_ARGUMENTOS
           | 
           ;

//MULTI_ARGUMENTOS : ARGUMENTO ',' MULTI_ARGUMENTOS
//                 | ARGUMENTO
//                 ;
           
ARGUMENTO : TIPO TK_ID ARRAY ',' ARGUMENTO 
          | TIPO TK_ID ARRAY 
          ;

VARIAVEIS : VARIAVEIS TIPO VARIAVEL ';' 
          | 
          ;

TIPO : TK_INT
     | TK_CHAR
     | TK_BOOLEAN
     | TK_FLOAT
     | TK_DOUBLE
     | TK_STRING
     ;

VARIAVEL : TK_ID ARRAY ',' VARIAVEL
         | TK_ID ARRAY
         ;

ARRAY : '[' CONST_INT ']' ARRAY
      | '[' ']'
      | 
      ;

COMANDOS : COMANDO COMANDOS
         |
         ;

COMANDO : CMD_ATRIB ';'
        | CMD_DO_WHILE ';'
        | CMD_RETURN ';'
        | FUN_PROC ';'
        | CMD_PRINTF ';'
        | CMD_SCANF ';'
        | COMANDO_BLOCO
        ;

COMANDO_BLOCO : CMD_IF_ELSE
              | CMD_FOR
              | CMD_WHILE
              | CMD_SWITCH
              | CMD_INTERVAL
              | CMD_FILTER
              | CMD_FOREACH
              ;

CMD_IF_ELSE : TK_IF '(' OPERACAO ')' BLOCO_COMANDO CMD_ELSE
            ;

CMD_ELSE : TK_ELSE BLOCO_COMANDO
         |
         ;

CMD_FOR : TK_FOR '(' CMD_ATRIB ';' OPERACAO ';' CMD_ATRIB ')' BLOCO_COMANDO
        ;

CMD_WHILE : TK_WHILE '(' OPERACAO ')' BLOCO_COMANDO 
          ;

CMD_DO_WHILE : TK_DO BLOCO TK_WHILE '(' OPERACAO ')'
             ;

CMD_SWITCH : TK_SWITCH '(' INDICE ')' '{' CMD_CASE TK_DEFAULT ':' COMANDOS '}' 
           ;

CMD_CASE : TK_CASE INDICE ':' COMANDOS CMD_CASE 
         |
         ;

CMD_INTERVAL : TK_INTERVAL '(' INDICE TK_FROM_TO INDICE ')' BLOCO_COMANDO
             ;

//#Dentro de OPERACAO haverá acesso à variável INDEX que diz a posição em que o filtro se encontra
CMD_FILTER : TK_FILTER '(' OPERACAO ')' BLOCO_COMANDO
           ;

//#TK_ID deve ser array
CMD_FOREACH : TK_FOR_EACH '(' TK_ID ')' BLOCO_COMANDO
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

//#Dentro de OPERACAO haverá acesso à variável INDEX que diz a posição em que o split se encontra
//#O retorno é uma array bi-dimensional contendo as duas metades, uma em [0] e a outra em [1]
FUN_SPLIT : TK_SPLIT  '(' TK_ID ',' OPERACAO ')'
          ;

//#Os TK_IDs devem ser arrays
FUN_MERGE : TK_MERGE  '(' TK_ID ',' TK_ID ')'
          ;

CMD_ATRIB : TK_ID '=' OPERACAO
          | TK_ID '[' INDICE ']' '=' VALOR
          | TK_ID TK_ADICIONA_UM
          | TK_ID TK_DIMINUI_UM
          ;

CMD_RETURN : TK_RETURN VALOR
           | TK_RETURN
           ;

FUN_PROC : TK_ID '(' ')'
         | TK_ID '(' PARAMETROS ')'
         ;

OPERACAO : OPERACAO '+' OPERACAO
         | OPERACAO '-' OPERACAO
         | OPERACAO '*' OPERACAO
         | OPERACAO '/' OPERACAO
         | OPERACAO '%' OPERACAO
         | OPERACAO TK_AND OPERACAO
         | OPERACAO TK_OR OPERACAO
         | OPERACAO TK_IGUAL OPERACAO
         | OPERACAO '>' OPERACAO
         | OPERACAO '<' OPERACAO
         | OPERACAO TK_MENOR_IGUAL OPERACAO
         | OPERACAO TK_MAIOR_IGUAL OPERACAO
         | OPERACAO TK_DIFERENTE OPERACAO
         | '!' OPERACAO
         | '(' OPERACAO ')'
         | TK_ID '[' INDICE ']'
         | TK_ID '(' PARAMETROS ')'
         | TK_ID '(' ')'
         | FUN_SORT
         | FUN_FIRST_N
         | FUN_LAST_N
         | FUN_SPLIT
         | FUN_MERGE
         | VALOR
         ;

VALOR : CONST_INT
      | CONST_CHAR
      | CONST_BOOLEAN
      | CONST_FLOAT
      | CONST_DOUBLE
      | CONST_STRING
      | TK_ID
      ;

PARAMETROS : VALOR ',' PARAMETROS
           | VALOR
           ;

//#TK_ID deve ser apenas do tipo TK_INT
INDICE : CONST_INT
       | TK_ID
       ;
       
CMD_PRINTF : TK_PRINTF '(' CONST_STRING ',' VALOR ')'
           ;
           
CMD_SCANF : TK_SCANF '(' CONST_STRING ',' '&' TK_ID ')'
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

map<string,int> n_var_temp;

string geraDeclaracaoVarPipe() {
  return "  int x_int;\n"
         "  double x_double;\n"
         "  float x_float;\n";
}

string geraDeclaracaoTemporarias() {
  string c;
  
  for( int i = 0; i < n_var_temp["bool"]; i++ )
    c += "  int temp_bool_" + toStr( i + 1 ) + ";\n";
    
  for( int i = 0; i < n_var_temp["int"]; i++ )
    c += "  int temp_int_" + toStr( i + 1 ) + ";\n";

    for( int i = 0; i < n_var_temp["char"]; i++ )
    c += "  char temp_char_" + toStr( i + 1 ) + ";\n";
    
  for( int i = 0; i < n_var_temp["double"]; i++ )
    c += "  double temp_double_" + toStr( i + 1 ) + ";\n";

    for( int i = 0; i < n_var_temp["float"]; i++ )
    c += "  float temp_float_" + toStr( i + 1 ) + ";\n";
    
  for( int i = 0; i < n_var_temp["string"]; i++ )
    c += "  char temp_string_" + toStr( i + 1 ) + "[" + toStr( MAX_STR )+ "];\n";
    
  return c;  
}

void geraCodigoFuncaoPrincipal( Atributo* SS, const Atributo& cmds ) {
  *SS = Atributo();
  SS->c = "\nint main() {\n" +
           geraDeclaracaoVarPipe() + 
           "\n" + 
           geraDeclaracaoTemporarias() + 
           "\n" +
           cmds.c + 
           "  return 0;\n" 
           "}\n";
}  

string toStr( int n ) {
  char buf[1024] = ""; 
  sprintf( buf, "%d", n );
  return buf;
}

int main( int argc, char* argv[] )
{
  yyparse();
}
