//Fabio de Matos Carrilho.  DRE: 111031170
//Mateus Gregorio de Souza. DRE: 109062660
//Vitor Marques de Miranda. DRE: 111222886

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
string passoPipeAtivo; // Label 'fim' do pipe ativo

Tipo tipoResultado( Tipo a, string operador, Tipo b );
string geraTemp( Tipo tipo );
string geraLabel( string cmd );
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
void geraCodigoFor( Atributo* SS, const Atributo& inicial, 
                                  const Atributo& condicao, 
                                  const Atributo& passo, 
                                  const Atributo& cmds );
void geraCodigoFilter( Atributo* SS, const Atributo& condicao );

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
              "#include <string.h>\n"
            << $1.c << $2.c << endl; }
  ;

LISTA_FUNCOES : FUNCAO LISTA_FUNCOES
                { $$ = Atributo();
                  $$.c = $1.c + $2.c; }
              | MAIN
                { $$ = $1; }
              ;

FUNCAO : TIPO TK_ID '(' ARGUMENTOS ')' CORPO_DE_FUNCAO
       | TK_VOID TK_ID '(' ARGUMENTOS ')' CORPO_DE_FUNCAO
       ;

MAIN : TK_INT TK_MAIN '(' ')' MAIN_BLOCO 
       { $$ = Atributo();
         $$.c = "\nint main()" + $5.c + "\n";
       }
     ; 

MAIN_BLOCO : '{' VARIAVEIS COMANDOS '}'
             { $$ = Atributo();
               $$.c = "{\n" + geraDeclaracaoVarPipe() + "\n" + 
			      geraDeclaracaoTemporarias() + "\n" +
			      $2.c + $3.c + 
                      "  return 0;\n}"; }
           ; 
     
CORPO_DE_FUNCAO : BLOCO 
		  { $$ = $1; }
                | ';'
                  { $$ = Atributo();
                    $$.c = ';'; }
                ;

BLOCO : '{' VARIAVEIS COMANDOS '}'
        { $$ = Atributo();
          $$.c = "{" + $2.c + $3.c + "}"; }
      ; 

BLOCO_COMANDO : BLOCO
		{ $$ = $1; }
              | COMANDO ';'
                { $$ = $1; }
              ; 

ARGUMENTOS : ARGUMENTO
             { $$ = $1; }
//           | MULTI_ARGUMENTOS
           | { $$ = Atributo(); }
           ;

//MULTI_ARGUMENTOS : ARGUMENTO ',' MULTI_ARGUMENTOS
//                 | ARGUMENTO
//                 ;
           
ARGUMENTO : TIPO TK_ID ARRAY ',' ARGUMENTO 
          | TIPO TK_ID ARRAY 
          ;

VARIAVEIS : VARIAVEIS VARIAVEL ';' 
            { $$ = Atributo(); 
              $$.c = $1.c + "  " + $2.c;}
          | { $$ = Atributo(); }
          ;

TIPO : TK_INT
     | TK_CHAR
     | TK_BOOLEAN
     | TK_FLOAT
     | TK_DOUBLE
     | TK_STRING
     ;

VARIAVEL : VARIAVEL ',' TK_ID ARRAY
           { insereVariavelTS( ts, $3.v, $1.t ); 
             geraDeclaracaoVariavel( &$$, $1, $3 );}
         | TIPO TK_ID ARRAY
           { insereVariavelTS( ts, $2.v, $1.t ); 
             geraDeclaracaoVariavel( &$$, $1, $2 );}
         ;

ARRAY : '[' CONST_INT ']' ARRAY
      | '[' ']'
        { $$ = Atributo();
          $$.c = "[]";}
      | { $$ = Atributo(); }
      ;

COMANDOS : COMANDO COMANDOS
           { $$ = Atributo();
             $$.c = $1.c + $2.c;}
         | { $$ = Atributo(); }
         ;

COMANDO : CMD_ATRIB ';'
          {$$ = $1; }
        | CMD_DO_WHILE ';'
          {$$ = $1;
           $$.c += ";"; }
        | CMD_RETURN ';'
          {$$ = $1;
           $$.c += ";"; }
        | FUN_PROC ';'
          {$$ = $1;
           $$.c += ";"; }
        | CMD_PRINTF ';'
          {$$ = $1;
           $$.c += ";"; }
        | CMD_SCANF ';'
          {$$ = $1;
           $$.c += ";"; }
        | COMANDO_BLOCO
          {$$ = $1; }
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
            { geraCodigoAtribuicao( &$$, $1, $3 );}
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
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO '-' OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO '*' OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO '/' OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO '%' OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO TK_AND OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO TK_OR OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO TK_IGUAL OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO '>' OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO '<' OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO TK_MENOR_IGUAL OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO TK_MAIOR_IGUAL OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
         | OPERACAO TK_DIFERENTE OPERACAO
           { geraCodigoOperadorBinario( &$$, $1, $2, $3 ); }
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
        {  $$.v = $1.v; 
           $$.t = Tipo( "int" ); }
      | CONST_CHAR
      | CONST_BOOLEAN
        {  $$.v = $1.v; 
           $$.t = Tipo( "bool" ); }
      | CONST_FLOAT
        {  $$.v = $1.v; 
           $$.t = Tipo( "float" ); }
      | CONST_DOUBLE
        {  $$.v = $1.v; 
           $$.t = Tipo( "double" ); }
      | CONST_STRING
      | TK_ID
        { if( buscaVariavelTS( ts, $1.v, &$$.t ) ) 
             $$.v = $1.v; 
          else
             erro( "Variavel nao declarada: " + $1.v );
        }
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
map<string,int> n_var_temp;
map<string,Tipo> resultadoOperador;
map<string,int> label;

#include "lex.yy.c"

int yyparse();

void yyerror( const char* st ) {
  puts( st );
  printf( "Linha: %d\nPerto de: '%s'\n", nlinha, yytext );
}

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
string geraTemp( Tipo tipo ) {
  return "temp_" + tipo.nome + "_" + toStr( ++n_var_temp[tipo.nome] );
}

void insereVariavelTS( TS& ts, string nomeVar, Tipo tipo ) {
  if( !buscaVariavelTS( ts, nomeVar, &tipo ) )
    ts[nomeVar] = tipo;
  else  
    erro( "Variavel já definida: " + nomeVar );
}
bool buscaVariavelTS( TS& ts, string nomeVar, Tipo* tipo ) {
  if( ts.find( nomeVar ) != ts.end() ) {
    *tipo = ts[ nomeVar ];
    return true;
  }
  else
    return false;
}

void geraDeclaracaoVariavel( Atributo* SS, const Atributo& tipo,
                                           const Atributo& id ) {
  SS->v = "";
  SS->t = tipo.t;
  if( tipo.t.nome == "string" ) {
    SS->c = tipo.c + 
           "char " + id.v + "["+ toStr( MAX_STR ) +"];\n";   
  }
  else {
    SS->c = tipo.c + 
            tipo.t.nome + " " + id.v + ";\n";
  }
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
void geraCodigoAtribuicao( Atributo* SS, Atributo& lvalue, 
                                         const Atributo& rvalue ) {
  if( buscaVariavelTS( ts, lvalue.v, &lvalue.t ) ) {
    if( lvalue.t.nome == rvalue.t.nome ) {
      if( lvalue.t.nome == "string" ) {
        SS->c = lvalue.c + rvalue.c + 
                "  strncpy( " + lvalue.v + ", " + rvalue.v + ", " + 
                            toStr( MAX_STR - 1 ) + " );\n" +
                "  " + lvalue.v + "[" + toStr( MAX_STR - 1 ) + "] = 0;\n";
      }
      else
        SS->c = lvalue.c + rvalue.c + 
                "  " + lvalue.v + " = " + rvalue.v + ";\n"; 
    }
    else
      erro( "Expressao " + rvalue.t.nome + 
            " nao pode ser atribuida a variavel " +
            lvalue.t.nome );
    } 
    else
      erro( "Variavel nao declarada: " + lvalue.v );
}      
void geraCodigoOperadorBinario( Atributo* SS, const Atributo& S1, const Atributo& S2, const Atributo& S3 ) {
  SS->t = tipoResultado( S1.t, S2.v, S3.t );
  SS->v = geraTemp( SS->t );

  if( SS->t.nome == "string" ) {
    // Falta o operador de comparação para string
    SS->c = S1.c + S3.c + 
            "\n  strncpy( " + SS->v + ", " + S1.v + ", " + 
                        toStr( MAX_STR - 1 ) + " );\n" +
            "  strncat( " + SS->v + ", " + S3.v + ", " + 
                        toStr( MAX_STR - 1 ) + " );\n" +
            "  " + SS->v + "[" + toStr( MAX_STR - 1 ) + "] = 0;\n\n";    
  }
  else
    SS->c = S1.c + S3.c + 
            "  " + SS->v + " = " + S1.v + " " + S2.v + " " + S3.v + ";\n";
}

Tipo tipoResultado( Tipo a, string operador, Tipo b ) {
  if (resultadoOperador.find( a.nome + operador + b.nome ) == resultadoOperador.end())
      if (resultadoOperador.find( b.nome + operador + a.nome ) == resultadoOperador.end())
	  erro( "Operacao nao permitida: " + a.nome + operador + b.nome );

  return resultadoOperador[a.nome + operador + b.nome];
}
void inicializaResultadoOperador() {
  //Operações envolvendo string e string
  resultadoOperador["string+string"] = Tipo( "string" );
  resultadoOperador["string==string"] = Tipo( "bool" );
  resultadoOperador["string!=string"] = Tipo( "bool" );
  
  //Operações envolvendo char e char
  resultadoOperador["char+char"] = Tipo( "string" );
  resultadoOperador["char==char"] = Tipo( "bool" );
  resultadoOperador["char!=char"] = Tipo( "bool" );
  
  //Operações envolvendo int e int
  resultadoOperador["int+int"] = Tipo( "int" );
  resultadoOperador["int-int"] = Tipo( "int" );
  resultadoOperador["int*int"] = Tipo( "int" );
  resultadoOperador["int/int"] = Tipo( "int" );
  resultadoOperador["int<int"] = Tipo( "bool" );
  resultadoOperador["int>int"] = Tipo( "bool" );
  resultadoOperador["int!=int"] = Tipo( "bool" );
  resultadoOperador["int==int"] = Tipo( "bool" );
  resultadoOperador["int<=int"] = Tipo( "bool" );
  resultadoOperador["int=>int"] = Tipo( "bool" );
  resultadoOperador["int&&int"] = Tipo( "bool" );
  resultadoOperador["int||int"] = Tipo( "bool" );
  resultadoOperador["int%int"] = Tipo( "int" );
  
  //Operações envolvendo int e float
  resultadoOperador["int+float"] = Tipo( "float" );
  resultadoOperador["int-float"] = Tipo( "float" );
  resultadoOperador["int*float"] = Tipo( "float" );
  resultadoOperador["int/float"] = Tipo( "float" );
  resultadoOperador["int<float"] = Tipo( "bool" );
  resultadoOperador["int>float"] = Tipo( "bool" );
  resultadoOperador["int!=float"] = Tipo( "bool" );
  resultadoOperador["int==float"] = Tipo( "bool" );
  resultadoOperador["int<=float"] = Tipo( "bool" );
  resultadoOperador["int=>float"] = Tipo( "bool" );
  resultadoOperador["int&&float"] = Tipo( "bool" );
  resultadoOperador["int||float"] = Tipo( "bool" );
  
  //Operações envolvendo float e float
  resultadoOperador["float+float"] = Tipo( "float" );
  resultadoOperador["float-float"] = Tipo( "float" );
  resultadoOperador["float*float"] = Tipo( "float" );
  resultadoOperador["float/float"] = Tipo( "float" );
  resultadoOperador["float<float"] = Tipo( "bool" );
  resultadoOperador["float>float"] = Tipo( "bool" );
  resultadoOperador["float!=float"] = Tipo( "bool" );
  resultadoOperador["float==float"] = Tipo( "bool" );
  resultadoOperador["float<=float"] = Tipo( "bool" );
  resultadoOperador["float=>float"] = Tipo( "bool" );
  resultadoOperador["float&&float"] = Tipo( "bool" );
  resultadoOperador["float||float"] = Tipo( "bool" );
  
  //Operações envolvendo int e double
  resultadoOperador["int+double"] = Tipo( "double" );
  resultadoOperador["int-double"] = Tipo( "double" );
  resultadoOperador["int*double"] = Tipo( "double" );
  resultadoOperador["int/double"] = Tipo( "double" );
  resultadoOperador["int<double"] = Tipo( "bool" );
  resultadoOperador["int>double"] = Tipo( "bool" );
  resultadoOperador["int!=double"] = Tipo( "bool" );
  resultadoOperador["int==double"] = Tipo( "bool" );
  resultadoOperador["int<=double"] = Tipo( "bool" );
  resultadoOperador["int=>double"] = Tipo( "bool" );
  resultadoOperador["int&&double"] = Tipo( "bool" );
  resultadoOperador["int||double"] = Tipo( "bool" );
  
  //Operações envolvendo float e double
  resultadoOperador["float+double"] = Tipo( "double" );
  resultadoOperador["float-double"] = Tipo( "double" );
  resultadoOperador["float*double"] = Tipo( "double" );
  resultadoOperador["float/double"] = Tipo( "double" );
  resultadoOperador["float<double"] = Tipo( "bool" );
  resultadoOperador["float>double"] = Tipo( "bool" );
  resultadoOperador["float!=double"] = Tipo( "bool" );
  resultadoOperador["float==double"] = Tipo( "bool" );
  resultadoOperador["float<=double"] = Tipo( "bool" );
  resultadoOperador["float=>double"] = Tipo( "bool" );
  resultadoOperador["float&&double"] = Tipo( "bool" );
  resultadoOperador["float||double"] = Tipo( "bool" );
  
  //Operações envolvendo double e double
  resultadoOperador["double+double"] = Tipo( "double" );
  resultadoOperador["double-double"] = Tipo( "double" );
  resultadoOperador["double*double"] = Tipo( "double" );
  resultadoOperador["double/double"] = Tipo( "double" );
  resultadoOperador["double<double"] = Tipo( "bool" );
  resultadoOperador["double>double"] = Tipo( "bool" );
  resultadoOperador["double!=double"] = Tipo( "bool" );
  resultadoOperador["double==double"] = Tipo( "bool" );
  resultadoOperador["double<=double"] = Tipo( "bool" );
  resultadoOperador["double=>double"] = Tipo( "bool" );
  resultadoOperador["double&&double"] = Tipo( "bool" );
  resultadoOperador["double||double"] = Tipo( "bool" );
  
  //Operações envolvendo bool e bool
  resultadoOperador["bool<bool"] = Tipo( "bool" );
  resultadoOperador["bool>bool"] = Tipo( "bool" );
  resultadoOperador["bool!=bool"] = Tipo( "bool" );
  resultadoOperador["bool==bool"] = Tipo( "bool" );
  resultadoOperador["bool&&bool"] = Tipo( "bool" );
  resultadoOperador["bool||bool"] = Tipo( "bool" );
  
  //Operações envolvendo bool e int
  resultadoOperador["bool<int"] = Tipo( "bool" );
  resultadoOperador["bool>int"] = Tipo( "bool" );
  resultadoOperador["bool!=int"] = Tipo( "bool" );
  resultadoOperador["bool==int"] = Tipo( "bool" );
  resultadoOperador["bool&&int"] = Tipo( "bool" );
  resultadoOperador["bool||int"] = Tipo( "bool" );
  
  //Operações envolvendo bool e float
  resultadoOperador["bool<float"] = Tipo( "bool" );
  resultadoOperador["bool>float"] = Tipo( "bool" );
  resultadoOperador["bool!=float"] = Tipo( "bool" );
  resultadoOperador["bool==float"] = Tipo( "bool" );
  resultadoOperador["bool&&float"] = Tipo( "bool" );
  resultadoOperador["bool||float"] = Tipo( "bool" );
  
  //Operações envolvendo bool e double
  resultadoOperador["bool<double"] = Tipo( "bool" );
  resultadoOperador["bool>double"] = Tipo( "bool" );
  resultadoOperador["bool!=double"] = Tipo( "bool" );
  resultadoOperador["bool==double"] = Tipo( "bool" );
  resultadoOperador["bool&&double"] = Tipo( "bool" );
  resultadoOperador["bool||double"] = Tipo( "bool" );
}

string toStr( int n ) {
  char buf[1024] = ""; 
  sprintf( buf, "%d", n );
  return buf;
}

void erro( string msg ) {
  yyerror( msg.c_str() );
  exit(0);
}

int main( int argc, char* argv[] ) {
  inicializaResultadoOperador();
  yyparse();
}