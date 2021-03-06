//Fabio de Matos Carrilho.  DRE: 111031170
//Mateus Gregorio de Souza. DRE: 109062660
//Vitor Marques de Miranda. DRE: 111222886

%{
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <map>
#include <vector>

using namespace std;

const int MAX_STR = 256;

struct Tipo {
  string nome;
  string argumentos;
  int nDim;
  int d1;
  int d2;
  
  Tipo() { nome = ""; argumentos = ""; nDim = 0; d1 = 0; d2 = 0; }
  Tipo( string nome ) {
    this->nome = nome;
    nDim = 0; 
    d1 = 0; 
    d2 = 0;
  }
};

struct Atributo {
  string v;  // Valor
  Tipo   t;  // tipo
  string c;  // codigo
  
  Atributo() {}  // inicializacao automatica para vazio ""
  Atributo( string v, string t = "", string c = "" ) {
    this->v = v;
    this->t = Tipo(t);
    this->c = c;
  }
};

string blocoAtual = "global"; //Bloco em escrita, usado para escrita e leitura de variáveis
typedef map< string, Tipo > TS;
TS ts; // Tabela de simbolos

typedef map< string, Tipo > TF;
TF tf; // Tabela de funções

string pipeAtivo; // Tipo do pipe ativo
string pipeAtivoInicio;
string pipeAtivoFim;
string contadorPipe;
string passoPipeAtivo; // Label 'fim' do pipe ativo

Tipo tipoResultado( Tipo a, string operador, Tipo b );
string geraTemp( Tipo tipo );
string geraLabel( string cmd );
string geraDeclaracaoTemporarias(string bloco);
string geraDeclaracaoVarPipe();

string obterCharDeDeclaracaoParaTipo(string tipo);
void insereVariavelTS( TS&, string nomeVar, Tipo tipo );
bool buscaVariavelTS( TS&, string nomeVar, Tipo* tipo );
void insereFuncaoTF( TF&, string nomeVar, Tipo tipo, string args );
bool buscaFuncaoTF( TF&, string nomeVar, Tipo* tipo, string args );
void erro( string msg );
int toInt( string n );
string toStr( int n );
string toUpperString( string input );

void geraCodigoValorVetor( Atributo* SS, const Atributo& id, string indice1 = "0", string indice2 = "0" );
void geraCodigoScanf( Atributo* SS, const Atributo& id, string indice1 = "0", string indice2 = "0" );
void geraCodigoAtribuicao( Atributo* SS, Atributo& lvalue, const Atributo& rvalue, string indice1 = "0", string indice2 = "0" );
Atributo geraCodigoIndice( const Tipo& t, string id, string indice1 = "0", string indice2 = "0" );
void geraCodigoOperadorBinario( Atributo* SS, const Atributo& S1, const Atributo& S2, const Atributo& S3 );
void geraCodigoOperadorNegacao( Atributo* SS, const Atributo& oper, const Atributo& value );
void geraCodigoOperadorMenos( Atributo* SS, const Atributo& oper, const Atributo& value );

void geraCodigoIfComElse( Atributo* SS, const Atributo& expr, const Atributo& cmdsThen, const Atributo& cmdsElse );
void geraCodigoIfSemElse( Atributo* SS, const Atributo& expr, const Atributo& cmdsThen );
void geraCodigoSwitchCase( Atributo* SS, const Atributo& exprSwitch);
void geraCodigoCase( Atributo* SS, const Atributo& indiceCase, const Atributo& cmdsCase, 
                                   const Atributo& valorExprSwitch, const Atributo& cmdBreak );
void geraCodigoDefault( Atributo* SS, const Atributo& cmds, const Atributo& cmdCaseWithBreakGoto );
void geraCodigoFor( Atributo* SS, const Atributo& inicial, const Atributo& condicao, 
                                  const Atributo& passo, const Atributo& cmds );
void geraCodigoWhile( Atributo* SS, const Atributo& condicao, const Atributo& cmds );
void geraCodigoDoWhile( Atributo* SS, const Atributo& cmds, const Atributo& condicao );
void geraCodigoInterval( Atributo* SS, const Atributo& variavel, string valinicial, string valfinal, const Atributo& cmds );
void geraCodigoForEach( Atributo* SS, Atributo& variavel, Atributo& indice, const Atributo& cmds );

void geraCodigoFilter( Atributo* SS, const Atributo& condicao );
void geraCodigoFirstN( Atributo* SS, const Atributo& totalN );
void geraCodigoLastN( Atributo* SS, const Atributo& totalN );

void geraDeclaracaoVariavel( Atributo* SS, const Atributo& tipo,
                                           const Atributo& id );
void geraDeclaracaoFuncao( Atributo* SS, const Atributo& tipo,
                                         const Atributo& id,
                                         const Atributo& argsFunc,
                                         const Atributo& cmdsFunc );

//NÃO UTILIZE as funções abaixo isoladamente!! AO INVÉS DISSO, CHAME A FUNÇÃO void geraCodigoAtribuicao();
string geraCodigoAtribuicaoVariavelSimples( const Atributo& lvalue, const Atributo& rvalue );
string geraCodigoAtribuicaoVetor( const Atributo& lvalue, const Atributo& rvalue, string indice1 = "0", string indice2 = "0" );

// Usando const Atributo& não cria cópia desnecessária.

#define YYSTYPE Atributo

int yylex();
int yyparse();
void yyerror(const char *);
%}

%token TK_MAIN TK_ID TK_IF TK_ELSE TK_FOR TK_WHILE TK_DO TK_SWITCH TK_CASE TK_DEFAULT TK_BREAK
%token TK_PIPE TK_X TK_INTERVAL TK_FILTER TK_FOR_EACH TK_IN TK_FIRST_N TK_LAST_N TK_SPLIT TK_MERGE TK_SORT 
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
                { $$ = $1; }
              ;

FUNCAO : TIPO TK_ID { blocoAtual = $2.v; } '(' ARGUMENTOS ')' CORPO_DE_FUNCAO
         { geraDeclaracaoFuncao( &$$, $1, $2, $5, $7 ); }
       | TK_VOID TK_ID { blocoAtual = $2.v; } '(' ARGUMENTOS ')' CORPO_DE_FUNCAO
         { geraDeclaracaoFuncao( &$$, $1, $2, $5, $7 ); }
       ;

MAIN : TK_INT TK_MAIN { blocoAtual = "main"; } '(' ')' MAIN_BLOCO 
       { $$ = Atributo();
         $$.c = "\nint main()" + $6.c + "\n";
       }
     ; 

MAIN_BLOCO : '{' VARIAVEIS COMANDOS '}'
             { $$ = Atributo();
               $$.c = "{\n" + geraDeclaracaoVarPipe() + "\n" + 
			      geraDeclaracaoTemporarias("main") + "\n" +
			      $2.c + $3.c + 
                      "\n  return 0;\n}"; }
           ; 
     
CORPO_DE_FUNCAO : '{' VARIAVEIS COMANDOS '}'
                  { $$ = Atributo();
                    $$.c = "{\n" + geraDeclaracaoVarPipe() + "\n" + 
                                   geraDeclaracaoTemporarias(blocoAtual) + "\n"
                                   + $2.c + $3.c + "}";
                    $$.v = $3.v; }
                | ';'
                  { $$ = Atributo();
                    $$.c = ';'; }
                ;

BLOCO_COMANDO : '{' VARIAVEIS COMANDOS '}'
		{ $$ = Atributo();
		  $$.c = $2.c + $3.c; }
              | COMANDO     //LOCALIZAÇÃO DO SHIFT/REDUCE; PONHA UM ';' QUE ELE SAI
                { $$ = $1;
                  $$.c += '\n'; }
              ; 

ARGUMENTOS : ARGUMENTO
             { $$ = $1; }
           | { $$ = Atributo(); }
           ;

//MULTI_ARGUMENTOS : ARGUMENTO ',' MULTI_ARGUMENTOS
//                 | ARGUMENTO
//                 ;

ARGUMENTO : FUNCAO_TIPO TK_ID ARRAY ',' ARGUMENTO
            { insereVariavelTS( ts, $2.v, $1.t );
              $$.c = $1.c + " " + $2.v + ", " + $5.c;
              $$.v = $$.v + $1.c + "+" + $5.v;
              $$.t.nDim++; } 
          | FUNCAO_TIPO TK_ID ARRAY
            { insereVariavelTS( ts, $2.v, $1.t );
              $$.c = $1.c + " " + $2.v;
              $$.v = $$.v + $1.c;
              $$.t.nDim++; } 
          ;

FUNCAO_TIPO : TIPO
              { $$ = $1; 
                $$.c = $1.t.nome; }
            | TIPO '&'
              { $$ = $1; 
                $$.c = $1.t.nome + "&"; }
            ;

TIPO : TK_INT
     | TK_CHAR
     | TK_BOOLEAN
     | TK_FLOAT
     | TK_DOUBLE
     | TK_STRING
     ;

VARIAVEIS : VARIAVEIS VARIAVEL ';' 
            { $$ = Atributo(); 
              $$.c = $1.c + $2.c;}
          | { $$ = Atributo(); }
          ;

VARIAVEL : VARIAVEL ',' TK_ID ARRAY
           { $1.t.nDim = $4.t.nDim;
             $1.t.d1   = $4.t.d1;
             $1.t.d2   = $4.t.d2;
           
             $3.t.nDim = $4.t.nDim;
             $3.t.d1   = $4.t.d1;
             $3.t.d2   = $4.t.d2;

             insereVariavelTS( ts, $3.v, $1.t ); 
             geraDeclaracaoVariavel( &$$, $1, $3 ); }
             
         | TIPO TK_ID ARRAY
           { $1.t.nDim = $3.t.nDim;
             $1.t.d1   = $3.t.d1;
             $1.t.d2   = $3.t.d2;
             
             $2.t.nDim = $3.t.nDim;
             $2.t.d1   = $3.t.d1;
             $2.t.d2   = $3.t.d2;
             
             insereVariavelTS( ts, $2.v, $1.t );
             geraDeclaracaoVariavel( &$$, $1, $2 ); }
         ;

ARRAY : '[' CONST_INT ']' '[' CONST_INT ']'
        { $$ = Atributo();
          $$.t.nDim = 2;
          $$.t.d1 = toInt( $2.v );
          $$.t.d2 = toInt( $5.v ); }
      | '[' CONST_INT ']'
        { $$ = Atributo();
          $$.t.nDim = 1;
          $$.t.d1 = toInt( $2.v ); }
      |
	{ $$ = Atributo(); }
      ;

COMANDOS : COMANDO COMANDOS
           { $$ = Atributo();
             $$.c = $1.c + '\n' + $2.c; }
         | CMD_PIPE ';' COMANDOS
           { $$.c = $1.c + $3.c; }
         | { $$ = Atributo(); }
         ;

COMANDO : CMD_ATRIB ';'
          { $$ = $1; }
        | CMD_DO_WHILE ';'
          { $$ = $1; }
        | CMD_RETURN ';'
          { $$ = $1;
            $$.c += ";"; }
        | FUN_PROC ';'
          { $$ = $1;
            $$.c = $$.v + ";";
            $$.v = ""; }
        | CMD_PRINTF ';'
          { $$ = $1;
            $$.c += ";"; }
        | CMD_SCANF ';'
          { $$ = $1;
            $$.c += ";"; }
        | COMANDO_BLOCO
          { $$ = $1; }
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
	      { geraCodigoIfComElse( &$$, $3, $5, $6 ); }
            ;

CMD_ELSE : TK_ELSE BLOCO_COMANDO
           { $$ = $2; }
         | { $$ = Atributo(); }
         ;

CMD_FOR : TK_FOR '(' CMD_ATRIB ';' OPERACAO ';' CMD_ATRIB ')' BLOCO_COMANDO
	  { geraCodigoFor( &$$, $3, $5, $7, $9 ); }
        ;

CMD_WHILE : TK_WHILE '(' OPERACAO ')' BLOCO_COMANDO 
	    { geraCodigoWhile( &$$, $3, $5 ); }
          ;

CMD_DO_WHILE : TK_DO BLOCO_COMANDO TK_WHILE '(' OPERACAO ')'
	       { geraCodigoDoWhile( &$$, $2, $5 ); }
             ;

CMD_SWITCH : TK_SWITCH SW '}'
	     { $$ = $2; }
           ;

SW : CMD_CASE TK_DEFAULT ':' COMANDOS 
     { geraCodigoDefault( &$$, $4, $1 ); }
   ;

CMD_CASE : '(' INDICE ')' '{' 
	   { geraCodigoSwitchCase(&$$, $2); }
         | CMD_CASE TK_CASE INDICE ':' COMANDOS CMD_BREAK
	   { geraCodigoCase(&$$, $3, $5, $1, $6); }
	 ;

CMD_BREAK : TK_BREAK ';'
            { $$.v = "BREAK"; }
          | { $$.v = ""; }
          ;

          
          
          
          
          
          
          
          
CMD_PIPE : TK_INTERVAL '[' START_PIPE TK_FROM_TO INI_PIPE ']' PROCS CONSOME 
          { 
            Atributo inicio, condicao, passo, cmd;
            
            inicio.c = $3.c + $5.c +
                       "  x_" + pipeAtivo + " = " + $3.v + ";\n";
            condicao.t.nome = "bool";
            condicao.v = geraTemp( Tipo( "bool" ) ); 
            condicao.c = "  " + condicao.v + " = " + "x_" + pipeAtivo + 
                         " <= " + $5.v + ";\n";
            passo.c = "\n" + passoPipeAtivo + ":\n" + 
                      "  x_" + pipeAtivo + " = x_" + pipeAtivo + " + 1;\n";
            cmd.c = $7.c + $8.c;
            
            geraCodigoFor( &$$, inicio, condicao, passo, cmd );
            
            pipeAtivo = "";
          }
        ;

START_PIPE : OPERACAO
             { $$ = $1;
               pipeAtivoInicio = $1.v;
             }
           ;

INI_PIPE : OPERACAO
           { $$ = $1;
             pipeAtivo = $1.t.nome;
             contadorPipe = "x_" + pipeAtivo + "_contador";
             pipeAtivoFim = $1.v;
             passoPipeAtivo = geraLabel( "passo_pipe" ); 
             $$.c = $$.c + " " + contadorPipe + " = 0;\n"; }
         ;    
        
PROCS : TK_PIPE PROC PROCS 
        { $$.c = $2.c + $3.c; }
      | TK_PIPE
        { $$ = Atributo(); }
      ;
      
PROC : TK_FILTER '[' OPERACAO ']'
       { geraCodigoFilter( &$$, $3 ); }
     | TK_FIRST_N '[' OPERACAO ']'
       { geraCodigoFirstN( &$$, $3 ); }
     | TK_LAST_N '[' OPERACAO ']'
       { geraCodigoLastN( &$$, $3 ); }
     | TK_SORT '[' TK_X ']'
     ;
      
CONSOME : TK_FOR_EACH '[' COMANDO ']'
          { $$.c = $3.c; }
        ;
        
        
        
        
        
        
        
        
        
        
          
CMD_INTERVAL : TK_INTERVAL '(' TK_ID '=' INDICE TK_FROM_TO INDICE ')' BLOCO_COMANDO
               { geraCodigoInterval( &$$, $3, $5.v, $7.v, $9); }
             ;

//#Dentro de OPERACAO haverá acesso à variável INDEX que diz a posição em que o filtro se encontra
CMD_FILTER : TK_FILTER '(' OPERACAO ')' BLOCO_COMANDO
           ;

//#TK_ID deve ser array 	
CMD_FOREACH : TK_FOR_EACH '(' TK_ID TK_IN TK_ID ')' BLOCO_COMANDO 	
              { geraCodigoForEach(&$$, $5, $3, $7); } 	
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
            { geraCodigoAtribuicao( &$$, $1, $3 ); }
          | TK_ID '[' INDICE ']' '=' OPERACAO
            { geraCodigoAtribuicao( &$$, $1, $6, $3.v ); }
          | TK_ID '[' INDICE ']' '[' INDICE ']' '=' OPERACAO
            { geraCodigoAtribuicao( &$$, $1, $9, $3.v, $6.v ); }
          | TK_ID TK_ADICIONA_UM
	    { Atributo operacaoMaisMais = Atributo();
	      string varTemp = geraTemp( Tipo("int") );
	      
	      operacaoMaisMais.t = Tipo( "int" );
	      operacaoMaisMais.c = "  " + varTemp + " = " + $1.v + " + 1;\n";
	      operacaoMaisMais.v = varTemp;
	      
	      geraCodigoAtribuicao( &$$, $1, operacaoMaisMais ); }
          | TK_ID TK_DIMINUI_UM
	    { Atributo operacaoMenosMenos = Atributo();
	      string varTemp = geraTemp( Tipo("int") );
	      
	      operacaoMenosMenos.t = Tipo( "int" );
	      operacaoMenosMenos.c = "  " + varTemp + " = " + $1.v + " - 1;\n";
	      operacaoMenosMenos.v = varTemp;
	      
	      geraCodigoAtribuicao( &$$, $1, operacaoMenosMenos ); }
          ;

CMD_RETURN : TK_RETURN VALOR
             { $$.c = "  return " + $2.v; }
           | TK_RETURN
             { $$.c = "  return"; }
           ;

FUN_PROC : TK_ID '(' ')'
           { if( buscaFuncaoTF( tf, $1.v, &$$.t, "" ) ){ 
                $$.v = "  " + $1.v + "()"; 
             }else
                 erro( "Funcao nao declarada: " + $1.v );
           }
         | TK_ID '(' PARAMETROS ')'
           { if( buscaFuncaoTF( tf, $1.v, &$$.t, $3.v ) ){ 
               $$.v = "  " + $1.v + "(" + $3.c + ")"; 
             }else
               erro( "Funcao nao declarada: " + $1.v );
           }
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
           { geraCodigoOperadorNegacao(&$$, $1, $2); }
         | '-' OPERACAO
           { geraCodigoOperadorMenos(&$$, $1, $2); }
         | '(' OPERACAO ')'
           { $$ = $2; }
         | VALOR
         ;

VALOR : CONST_INT
        {  $$.v = $1.v; 
           $$.t = Tipo( "int" ); }
      | CONST_CHAR
        {  $$.v = $1.v; 
           $$.t = Tipo( "char" ); }
      | CONST_BOOLEAN
        {  if (toUpperString($1.v) == "TRUE") $$.v = "1"; 
	   else $$.v = "0"; 
           $$.t = Tipo( "bool" ); }
      | CONST_FLOAT
        {  $$.v = $1.v; 
           $$.t = Tipo( "float" ); }
      | CONST_DOUBLE
        {  $$.v = $1.v; 
           $$.t = Tipo( "double" ); }
      | CONST_STRING
        {  $$.v = $1.v; 
           $$.t = Tipo( "string" ); }
      | TK_ID
        { if( buscaVariavelTS( ts, $1.v, &$$.t ) ) 
             $$.v = $1.v; 
          else
             erro( "Variavel nao declarada: " + $1.v );
        }
      | TK_ID '[' INDICE ']'
        { geraCodigoValorVetor( &$$, $1, $3.v ); }
      | TK_ID '[' INDICE ']' '[' INDICE ']'
        { geraCodigoValorVetor( &$$, $1, $3.v, $6.v ); }
      | FUN_PROC
        { $$ = $1; }
      | TK_X
        { if( pipeAtivo != "" )
            $$ = Atributo( "x_" + pipeAtivo, pipeAtivo );
          else
            erro( "Variavel 'x' so pode ser usada dentro de pipe" );
        }
      | FUN_SORT
      | FUN_FIRST_N
      | FUN_LAST_N
      | FUN_SPLIT
      | FUN_MERGE
      ;

PARAMETROS : FUNCAO_VALOR ',' PARAMETROS
             { $$.c = $1.v + ", " + $3.c;
               $$.v = $1.c + "+" + $3.v; }
           | FUNCAO_VALOR
             { $$.c = $1.v;
               $$.v = $1.c; }
           ;

FUNCAO_VALOR : VALOR
               { $$ = $1; 
                 $$.c = $1.t.nome; }
             | '&' VALOR 
               { $$ = $2; 
                 $$.c = $2.t.nome + "&"; }
             ;

//#TK_ID deve ser apenas do tipo TK_INT
INDICE : CONST_INT
         {  $$.v = $1.v; 
            $$.t = Tipo( "int" ); }
       | TK_ID
         {  $$ = $1; }
       ;
       
CMD_PRINTF : TK_PRINTF '(' VALOR STR_PRINTF ')'
	     { $$.c = $3.c + "  printf( \"%" + obterCharDeDeclaracaoParaTipo($3.t.nome) + "\", " + $3.v + " )" + $4.c; }
           ;

STR_PRINTF : '+' VALOR STR_PRINTF
             { $$.c = ";\n" + $2.c + "  printf( \"%" + obterCharDeDeclaracaoParaTipo($2.t.nome) + "\", " + $2.v + " )" + $3.c; }
           | { $$ = Atributo(); }
           ;
           
CMD_SCANF : TK_SCANF '(' TK_ID ')'
	     { geraCodigoScanf( &$$, $3 ); }
          | TK_SCANF '(' TK_ID '[' INDICE ']' ')'
            { geraCodigoScanf( &$$, $3, $5.v ); }
          | TK_SCANF '(' TK_ID '[' INDICE ']' '[' INDICE ']' ')'
            { geraCodigoScanf( &$$, $3, $5.v, $8.v ); }
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

string geraLabel( string cmd ) {
  return "L_" + cmd +"_" + toStr( ++label[cmd] );
}

string geraDeclaracaoVarPipe() {
  return "  int x_int;\n"
         "  int x_int_contador;\n"
         "  double x_double;\n"
         "  double x_double_contador;\n"
         "  float x_float;\n"
         "  float x_float_contador;\n";
}
string geraDeclaracaoTemporarias(string bloco) {
  string c;
  
  for( int i = 0; i < n_var_temp[bloco + "+bool"]; i++ )
    c += "  int temp_bool_" + toStr( i + 1 ) + ";\n";
    
  for( int i = 0; i < n_var_temp[bloco + "+int"]; i++ )
    c += "  int temp_int_" + toStr( i + 1 ) + ";\n";

  for( int i = 0; i < n_var_temp[bloco + "+char"]; i++ )
    c += "  char temp_char_" + toStr( i + 1 ) + ";\n";
  
  for( int i = 0; i < n_var_temp[bloco + "+charptr"]; i++ )
    c += "  char* temp_charptr_" + toStr( i + 1 ) + ";\n";
    
  for( int i = 0; i < n_var_temp[bloco + "+double"]; i++ )
    c += "  double temp_double_" + toStr( i + 1 ) + ";\n";

  for( int i = 0; i < n_var_temp[bloco + "+float"]; i++ )
    c += "  float temp_float_" + toStr( i + 1 ) + ";\n";
    
  for( int i = 0; i < n_var_temp[bloco + "+string"]; i++ )
    c += "  char temp_string_" + toStr( i + 1 ) + "[" + toStr( MAX_STR )+ "];\n";
    
  return c;  
}
string geraTemp( Tipo tipo ) {
  return "temp_" + tipo.nome + "_" + toStr( ++n_var_temp[blocoAtual + "+" + tipo.nome] );
}

string obterCharDeDeclaracaoParaTipo(string tipo){
  if (tipo == "int") return "d";
  if (tipo == "float") return "f";
  if (tipo == "char") return "c";
  if (tipo == "double") return "lf";
  if (tipo == "bool") return "d";
  if (tipo == "string") return "s";
  return "d";
}
bool isTypeCompatibleWith(string lvalue, string rvalue){
  if (lvalue == rvalue) return true;
  
  if ((lvalue == "int" || lvalue == "float" || lvalue == "double") && 
      (rvalue == "int" || rvalue == "float" || rvalue == "double")) return true;
  
  if (lvalue == "string" && rvalue == "char") return true;
  
  return false;
}

void insereVariavelTS( TS& ts, string nomeVar, Tipo tipo ) {
  if( !buscaVariavelTS( ts, blocoAtual + "+" + nomeVar, &tipo ) )
    ts[blocoAtual + "+" + nomeVar] = tipo;
  else  
    erro( "Variavel já definida: " + nomeVar );
}
bool buscaVariavelTS( TS& ts, string nomeVar, Tipo* tipo ) {
  if( ts.find( blocoAtual + "+" + nomeVar ) != ts.end() ) {
    *tipo = ts[ blocoAtual + "+" + nomeVar ];
    return true;
  }
  else{
    if( ts.find( "global+" + nomeVar ) != ts.end() ) {
      *tipo = ts[ "global+" + nomeVar ];
      return true;
    }
  }
  return false;
}

void insereFuncaoTF( TF& tf, string nomeVar, Tipo tipo, string args ) {
  tipo.argumentos = args;
  if( !buscaFuncaoTF( tf, nomeVar, &tipo, args ) )
    tf[nomeVar] = tipo;
  else  
    erro( "Funcao já definida: " + nomeVar );
}
bool buscaFuncaoTF( TF& tf, string nomeVar, Tipo* tipo, string args ) {
  if( tf.find( nomeVar ) != tf.end() ) {
    if (tf[ nomeVar ].argumentos == args) {
      *tipo = tf[ nomeVar ];
      return true;
    } else erro ("Número de argumentos na função " + nomeVar + " está incorreto. Devia ser " + tf[ nomeVar ].argumentos + " mas é " + args + ".");
  }
  return false;
}

void geraCodigoIfComElse( Atributo* SS, const Atributo& expr, const Atributo& cmdsThen, const Atributo& cmdsElse ) {
  string ifTrue = geraLabel( "if_true" ),
         ifFalse = geraLabel( "if_false" ),
         ifFim = geraLabel( "if_fim" );
      
  *SS = Atributo();
  SS->c = expr.c + 
          "  if( " + expr.v + " ) goto " + ifTrue + ";\n" +
          "  goto " + ifFalse + ";\n" +
          "  " + ifTrue + ":\n" + cmdsThen.c +
          "  goto " + ifFim + ";\n" +
          "  " + ifFalse + ":\n" + cmdsElse.c +
          "  " + ifFim + ":\n";
}

void geraCodigoSwitchCase( Atributo* SS, const Atributo& exprSwitch) {
  *SS = Atributo();
  SS->c = exprSwitch.c;
  SS->v = exprSwitch.v;
  SS->t.nome = geraLabel( "if_fim_switch" );
}

void geraCodigoCase( Atributo* SS, const Atributo& indiceCase, 
                                   const Atributo& cmdsCase, 
                                   const Atributo& valorExprSwitch, 
                                   const Atributo& cmdBreak ) {
  string breakValue = "";
  if (cmdBreak.v == "BREAK") breakValue = "  goto " + valorExprSwitch.t.nome + ";\n";

  string ifStartCase = geraLabel( "if_start_case" );
  string valorNotCond = geraTemp( Tipo( "bool" ) );
  
  SS->c = "  " + valorNotCond + " = " + indiceCase.v + " == " + valorExprSwitch.v + ";\n"
	  "  if( " + valorNotCond + " ) goto " + ifStartCase + ";\n" +
	  valorExprSwitch.c + "  " + ifStartCase + ":\n" + cmdsCase.c + breakValue;
}

void geraCodigoDefault( Atributo* SS, const Atributo& cmds, const Atributo& cmdCaseWithBreakGoto ) {
  SS->c = SS->c + cmds.c + "\n  " + cmdCaseWithBreakGoto.t.nome + ":\n";
}

void geraCodigoFor( Atributo* SS, const Atributo& inicial, 
                                  const Atributo& condicao, 
                                  const Atributo& passo, 
                                  const Atributo& cmds ) {
  string forCond = geraLabel( "for_cond" ),
         forFim = geraLabel( "for_fim" );
  string valorNotCond = geraTemp( Tipo( "bool" ) );
         
  *SS = Atributo();
  if( condicao.t.nome != "bool" )
    erro( "A expressão de teste deve ser booleana: " + condicao.t.nome ); 
  
  // Funciona apenas para filtro, sem pipe que precisa de buffer 
  // (sort, por exemplo, não funciona)
  SS->c = inicial.c + "  " + forCond + ":\n" + condicao.c +
          "  " + valorNotCond + " = !" + condicao.v + ";\n" +
          "  if( " + valorNotCond + " ) goto " + forFim + ";\n" +
          cmds.c + passo.c + "  goto " + forCond + ";\n  " + 
          forFim + ":\n";
}

void geraCodigoWhile( Atributo* SS, const Atributo& condicao, 
                                    const Atributo& cmds ) {
  string whileCond = geraLabel( "while_cond" ),
         whileFim = geraLabel( "while_fim" );
  string valorNotCond = geraTemp( Tipo( "bool" ) );
         
  *SS = Atributo();
  if( condicao.t.nome != "bool" )
    erro( "A expressão de teste deve ser booleana: " + condicao.t.nome ); 
  
  SS->c = "  " + whileCond + ":\n" + condicao.c +
          "  " + valorNotCond + " = !" + condicao.v + ";\n" +
          "  if( " + valorNotCond + " ) goto " + whileFim + ";\n" +
          cmds.c + "  goto " + whileCond + ";\n  " + 
          whileFim + ":\n";
}

void geraCodigoDoWhile( Atributo* SS, const Atributo& cmds, 
                                      const Atributo& condicao ) {
  string whileInicio = geraLabel( "do_while_inicio" );
  
  *SS = Atributo();
  if( condicao.t.nome != "bool" )
    erro( "A expressão de teste deve ser booleana: " + condicao.t.nome ); 
  
  SS->c = "  " + whileInicio + ":\n" + cmds.c + condicao.c +
          "  if( " + condicao.v + " ) goto " + whileInicio + ";\n";
}

void geraCodigoFilter( Atributo* SS, const Atributo& condicao ) {
  *SS = Atributo();
  SS->v = geraTemp( Tipo( "bool" ) );
  SS->c = condicao.c + 
          "  " + SS->v + " = !" + condicao.v + ";\n" +
          "  if( " + SS->v + " ) goto " + passoPipeAtivo + ";\n";
}

void geraCodigoFirstN( Atributo* SS, const Atributo& totalN ) {
  *SS = Atributo();
  string condContador = geraTemp( Tipo( "bool" ) );
  
  SS->c = totalN.c + 
          " " + contadorPipe + " = " + contadorPipe + " + 1;\n"
          "  " + condContador + " = " + contadorPipe + ">" + totalN.v + ";\n" +
          "  if( " + condContador + " ) goto " + passoPipeAtivo + ";\n";
}

void geraCodigoLastN( Atributo* SS, const Atributo& totalN ) {
  string temp = geraTemp( Tipo( "int" ) );
  *SS = Atributo();
  SS->v = geraTemp( Tipo( "bool" ) );
  SS->c = totalN.c + 
          "  " + temp + " = " + pipeAtivoFim + " - " + totalN.v + ";\n" +
          "  " + SS->v + " = x_" + pipeAtivo + "<=" + temp + ";\n" +
          "  if( " + SS->v + " ) goto " + passoPipeAtivo + ";\n";
}

void geraCodigoInterval( Atributo* SS, const Atributo& variavel, string valinicial, string valfinal, const Atributo& cmds ) {
  string intvrCond = geraLabel( "intrv_cond" ),
         intvrFim = geraLabel( "intrv_fim" );
  string valorNotCond = geraTemp( Tipo( "bool" ) );
         
  string tokenMaiorMenor;
  string tokenBiggerSmaller;
  if (valinicial < valfinal){
     tokenBiggerSmaller = "++";
     tokenMaiorMenor = ">";
  }
  else{
     tokenBiggerSmaller = "--";
     tokenMaiorMenor = "<";
  }
  
  SS->c = SS->c + variavel.c + 
          "  " + variavel.v + "=" + valinicial + ";\n" + 
          "  " + intvrCond + ":\n" + 
          "  " + valorNotCond + " = " + variavel.v + tokenMaiorMenor + valfinal + ";\n" +
          "  if( " + valorNotCond + " ) goto " + intvrFim + ";\n" +
          cmds.c + "  " + variavel.v + tokenBiggerSmaller + ";\n" +
          "  goto " + intvrCond + ";\n  " + 
          intvrFim + ":\n";
}

void geraCodigoForEach( Atributo* SS, Atributo& variavel, Atributo& indice, const Atributo& cmds ) { 	
  string feachCond = geraLabel( "feach_cond" ), 
  feachFim = geraLabel( "feach_fim" ); 
  string valorNotCond = geraTemp( Tipo( "bool" ) ); 

  *SS = Atributo(); 
  if( buscaVariavelTS( ts, indice.v, &indice.t ) ){ 
    if( buscaVariavelTS( ts, variavel.v, &variavel.t ) ){ 
      SS->c = SS->c + variavel.c + 
              "  x_int = 0;\n" + 
              "  " + indice.v + "= " + variavel.v + "[0];\n" + 
              "  " + feachCond + ":\n" + 
              "  " + valorNotCond + " = x_int >" + toStr(variavel.t.d1-1) + ";\n" + 
              "  if( " + valorNotCond + " ) goto " + feachFim + ";\n" + cmds.c + 
              "  x_int++;\n" + 
              "  " + indice.v + "= " + variavel.v + "[x_int];\n" + 
              "  goto " + feachCond + ";\n " +
              feachFim + ":\n";
    }
  }
}

void geraDeclaracaoVariavel( Atributo* SS, const Atributo& tipo, const Atributo& id ) {
  SS->v = "";
  SS->t = tipo.t;
  
  string tipoNome = tipo.t.nome;
  if( tipoNome == "bool") tipoNome = "int";
  if( tipoNome == "string") tipoNome = "char";
  
  if ( tipo.t.nome == "string" ) {
    switch( id.t.nDim ) {
      case 0: SS->c = tipoNome + " " + id.v + "["+ toStr( MAX_STR ) +"]"; break;
      case 1: SS->c = tipoNome + " " + id.v + "[" + toStr( id.t.d1 * MAX_STR ) + "]"; break;
      case 2: SS->c = tipoNome + " " + id.v + "[" + toStr( id.t.d1 * id.t.d2 * MAX_STR ) + "]";
    }
  } else {
    switch( id.t.nDim ) {
      case 0: SS->c = tipoNome + " " + id.v; break;
      case 1: SS->c = tipoNome + " " + id.v + "[" + toStr( id.t.d1 ) + "]"; break;
      case 2: SS->c = tipoNome + " " + id.v + "[" + toStr( id.t.d1 * id.t.d2 ) + "]";
    }
  }
  
  SS->c = tipo.c + "  " + SS->c + ";\n";
}
void geraDeclaracaoFuncao( Atributo* SS, const Atributo& tipo, const Atributo& id, const Atributo& argsFunc, const Atributo& cmdsFunc ) {
  if (cmdsFunc.c == ";") {
     if( buscaFuncaoTF( tf, id.v, &SS->t, argsFunc.v) ) return;
     else insereFuncaoTF( tf, id.v, tipo.t, argsFunc.v );
  } else {
     if( buscaFuncaoTF( tf, id.v, &SS->t, argsFunc.v) ) SS->v = id.v;
     else insereFuncaoTF( tf, id.v, tipo.t, argsFunc.v ); 
  }

  SS->t = tipo.t;
  SS->t.nDim = argsFunc.t.nDim;

  string tipoNome = tipo.t.nome;
  if( tipoNome == "bool") tipoNome = "int";
  if( tipoNome == "string") tipoNome = "char";
  
  if ( tipo.t.nome == "string" ) 
       SS->c = tipo.c + tipoNome + "* " + id.v; 
  else SS->c = tipo.c + tipoNome + " " + id.v;
  
  SS->c = SS->c + "(" + argsFunc.c + ")" + cmdsFunc.c + "\n";
}

void geraCodigoScanf( Atributo* SS, const Atributo& id, string indice1, string indice2 ) {
  if( buscaVariavelTS( ts, id.v, &SS->t ) ){ 
    if (SS->t.nDim == 0) {
      if (SS->t.nome == "string")
        SS->c = id.c + "  scanf( \"%" + obterCharDeDeclaracaoParaTipo(SS->t.nome) + "\", " + id.v + " )";
      else
        SS->c = id.c + "  scanf( \"%" + obterCharDeDeclaracaoParaTipo(SS->t.nome) + "\", &" + id.v + " )";
    }else {
      Atributo indice = geraCodigoIndice( SS->t, id.v, indice1, indice2 );
      SS->c = id.c + indice.c + "  scanf( \"%" + obterCharDeDeclaracaoParaTipo(SS->t.nome) + "\", &" + id.v + "[" + indice.v + "]" + " )";
    }
  }else erro( "Variavel nao declarada: " + id.v );
}

void geraCodigoAtribuicao( Atributo* SS, Atributo& lvalue, const Atributo& rvalue, string indice1, string indice2) {
  if( buscaVariavelTS( ts, lvalue.v, &lvalue.t ) ) {
    if(isTypeCompatibleWith(lvalue.t.nome, rvalue.t.nome)) {
    
      if ( lvalue.t.nDim == 0 )
	SS->c = lvalue.c + rvalue.c + geraCodigoAtribuicaoVariavelSimples(lvalue, rvalue);
      else
	SS->c = lvalue.c + rvalue.c + geraCodigoAtribuicaoVetor(lvalue, rvalue, indice1, indice2);
	
    } else erro( "Expressao " + rvalue.t.nome + " nao pode ser atribuida a variavel " + lvalue.t.nome );
  } else erro( "Variavel nao declarada: " + lvalue.v );
}

string geraCodigoAtribuicaoVariavelSimples( const Atributo& lvalue, const Atributo& rvalue ) {
  
  if( lvalue.t.nome == "string" ) {
    if ( rvalue.t.nome == "string" ) {
      return "  strncpy( " + lvalue.v + ", " + rvalue.v + ", " + toStr( MAX_STR - 1 ) + " );\n"
             "  " + lvalue.v + "[" + toStr( MAX_STR - 1 ) + "] = 0;\n";
    }
    if ( rvalue.t.nome == "char" ) {
      return "  " + lvalue.v + "[0] = " + rvalue.v + ";\n"
             "  " + lvalue.v + "[1] = 0;\n";
    }
  }else {
    return "  " + lvalue.v + " = " + rvalue.v + ";\n";
  }
}

string geraCodigoAtribuicaoVetor( const Atributo& lvalue, const Atributo& rvalue, string indice1, string indice2 ) {
  string codigoTemporarias, codigoAtrib;
  Atributo indice = geraCodigoIndice(lvalue.t, lvalue.v, indice1, indice2);
  
  if( lvalue.t.nome == "string" ) {
    string varIndiceFimString = geraTemp ( Tipo( "int" ) );
    
    if ( rvalue.t.nome == "string" ) {
      string varTempPtrLvalue = geraTemp ( Tipo ( "charptr" ) );
      
      codigoTemporarias = indice.c +
                          "  " + varIndiceFimString + " = " + indice.v + " + " + toStr( MAX_STR - 1 ) + ";\n"
                          "  " + varTempPtrLvalue + " = " + lvalue.v + "+" + indice.v + ";\n";
      codigoAtrib = "  strncpy( " + varTempPtrLvalue + ", " + rvalue.v + ", " + toStr( MAX_STR - 1 ) + " );\n"
                    "  " + lvalue.v + "[" + varIndiceFimString + "] = 0;\n";
      
      return codigoTemporarias + codigoAtrib;
    }
    
    if ( rvalue.t.nome == "char" ) {
      codigoTemporarias = indice.c +
                          "  " + varIndiceFimString + " = " + indice.v + " + 1;\n";
      codigoAtrib = "  " + lvalue.v + "[" + indice.v + "] = " + rvalue.v + ";\n"
                    "  " + lvalue.v + "[" + varIndiceFimString + "] = 0;\n";
      
      return codigoTemporarias + codigoAtrib;
    }
  }else{
    codigoTemporarias = indice.c;
    codigoAtrib = "  " + lvalue.v + "[" + indice.v + "] = " + rvalue.v + ";\n";
    
    return codigoTemporarias + codigoAtrib;
  }
}

void geraCodigoValorVetor( Atributo* SS, const Atributo& id, string indice1, string indice2 ) {
  if( buscaVariavelTS( ts, id.v, &SS->t ) ) {
    Atributo indice = geraCodigoIndice( SS->t, id.v, indice1, indice2 );
    
    string nomeVarTemp = geraTemp ( Tipo ( SS->t ) );
    Atributo lvalueTemp = Atributo();
    lvalueTemp.t = Tipo ( SS->t );
    lvalueTemp.v = nomeVarTemp;
    
    Atributo rvalueTemp = Atributo();
    rvalueTemp.t = Tipo ( SS->t );
    
    if ( rvalueTemp.t.nome == "string" ) {
      string varTempPtrRvalue = geraTemp ( Tipo ( "charptr" ) );
      rvalueTemp.c = "  " + varTempPtrRvalue + " = " + id.v + "+" + indice.v + ";\n";
      rvalueTemp.v = varTempPtrRvalue;
    }else {
      rvalueTemp.v = id.v + "[" + indice.v + "]";
    }
    
    SS->c = indice.c + "\n" +
            rvalueTemp.c +
            geraCodigoAtribuicaoVariavelSimples( lvalueTemp, rvalueTemp );
    SS->v = nomeVarTemp;
  }else
    erro( "Variavel nao declarada: " + id.v );
}

Atributo geraCodigoIndice( const Tipo& t, string id, string indice1, string indice2 ) {
  string varTemp1, varTemp2, varTemp3;
  
  varTemp1 = geraTemp ( Tipo( "int" ) );
  Atributo indiceVetor = Atributo();
  
  if ( t.nome == "string" ) {
    switch ( t.nDim ) {
      case 1:
        //if ( indice1 < t.d1 )
          indiceVetor.c = "  " + varTemp1 + " = " + indice1 + " * " + toStr( MAX_STR ) + ";\n";
          indiceVetor.v = varTemp1;
          
          return indiceVetor;
        //else break;
      case 2:
        //if ( indice1 < t.d1 && indice2 < t.d2 )
          varTemp2 = geraTemp ( Tipo( "int" ) );
          varTemp3 = geraTemp ( Tipo( "int" ) );
          
          indiceVetor.c = "  " + varTemp1 + " = " + indice1 + " * " + toStr( t.d2 ) + ";\n"
                          "  " + varTemp2 + " = " + varTemp1 + " + " + indice2 + ";\n"
                          "  " + varTemp3 + " = " + varTemp2 + " * " + toStr( MAX_STR ) + ";\n";
          indiceVetor.v = varTemp3;
          
          return indiceVetor;
          
          //return "( " + indice1 + " * " + toStr( t.d2 ) + " + " + indice2 + " ) * " + toStr( MAX_STR );
        //else break;
    }
  }else {
    switch ( t.nDim ) {
      case 1:
        //if ( indice1 < t.d1 )
          indiceVetor.c = "  " + varTemp1 + " = " + indice1 + ";\n";
          indiceVetor.v = varTemp1;
          
          return indiceVetor;
        //else break;
      case 2:
        //if ( indice1 < t.d1 && indice2 < t.d2 )
          varTemp2 = geraTemp ( Tipo( "int" ) );
          varTemp3 = geraTemp ( Tipo( "int" ) );
          
          indiceVetor.c = "  " + varTemp1 + " = " + indice1 + " * " + toStr( t.d2 ) + ";\n"
                          "  " + varTemp2 + " = " + varTemp1 + " + " + indice2 + ";\n";
          indiceVetor.v = varTemp2;
          
          return indiceVetor;
          //return indice1 + " * " + toStr( t.d2 ) + " + " + indice2;
        //else break;
    }
  }
  
  erro( "Indice invalido para o vetor " + id );
}

void geraCodigoOperadorBinario( Atributo* SS, const Atributo& S1, const Atributo& S2, const Atributo& S3 ) {
  SS->t = tipoResultado( S1.t, S2.v, S3.t );
  SS->v = geraTemp( SS->t );

  if( SS->t.nome == "string" ) {
    // Falta o operador de comparação para string
    SS->c = S1.c + S3.c + 
            "\n  strncpy( " + SS->v + ", " + S1.v + ", " + toStr( MAX_STR - 1 ) + " );\n" +
              "  strncat( " + SS->v + ", " + S3.v + ", " + toStr( MAX_STR - 1 ) + " );\n" +
                       "  " + SS->v + "[" + toStr( MAX_STR - 1 ) + "] = 0;\n\n";
  }
  else
    SS->c = S1.c + S3.c + 
            "  " + SS->v + " = " + S1.v + " " + S2.v + " " + S3.v + ";\n";
}

void geraCodigoOperadorNegacao( Atributo* SS, const Atributo& oper, const Atributo& value ) {
  SS->t = Tipo("bool");
  SS->v = geraTemp( SS->t );

  if( value.t.nome == "int" || value.t.nome == "bool") {
    SS->c = value.c + 
            "\n  " + SS->v + " = !" + value.v + ";\n\n";
  }
  else erro( "Operacao nao permitida: " + oper.v + value.v);
}

void geraCodigoOperadorMenos( Atributo* SS, const Atributo& oper, const Atributo& value ) {
  SS->t = value.t;
  SS->v = geraTemp( SS->t );
  string menosUm = geraTemp ( Tipo ( "int" ) );
  
  if( value.t.nome == "int" || value.t.nome == "float" || value.t.nome == "double") {
    SS->c = value.c + "\n" 
            "  " + menosUm + " = -1;\n"
            "  " + SS->v + " = " + menosUm + " * " + value.v + ";\n\n";
  }
  else erro( "Operacao nao permitida: " + oper.v + value.v);
}

Tipo tipoResultado( Tipo a, string operador, Tipo b ) {
  if (resultadoOperador.find( a.nome + operador + b.nome ) == resultadoOperador.end())
      if (resultadoOperador.find( b.nome + operador + a.nome ) == resultadoOperador.end())
	  erro( "Operacao nao permitida: " + a.nome + operador + b.nome );
      else return resultadoOperador[b.nome + operador + a.nome];
  else return resultadoOperador[a.nome + operador + b.nome];
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
  resultadoOperador["int>=int"] = Tipo( "bool" );
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
  resultadoOperador["int>=float"] = Tipo( "bool" );
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
  resultadoOperador["float>=float"] = Tipo( "bool" );
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
  resultadoOperador["int>=double"] = Tipo( "bool" );
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
  resultadoOperador["float>=double"] = Tipo( "bool" );
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
  resultadoOperador["double>=double"] = Tipo( "bool" );
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

int toInt( string n ) {
  int aux = 0;
  sscanf( n.c_str(), "%d", &aux );
  
  return aux;
}
string toStr( int n ) {
  char buf[1024] = ""; 
  sprintf( buf, "%d", n );
  return buf;
}
string toUpperString(string input) {
  int k;
  for (k = 0; k<input.length(); k++)
    input[k] = toupper(input[k]);
  return input;
}

void erro( string msg ) {
  yyerror( msg.c_str() );
  exit(0);
}

int main( int argc, char* argv[] ) {
  inicializaResultadoOperador();
  yyparse();
}
