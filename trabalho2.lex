DELIM   [\t ]
LINHA   [\n]
NUMERO  [0-9]
LETRA   [A-Za-z_]
INT     {NUMERO}+
DOUBLE  {NUMERO}+("."{NUMERO}+)?
CHAR    ['][^\n'][']
BOOLEAN ([Tt][Rr][Uu][Ee])|([Ff][Aa][Ll][Ss][Ee])
ID      {LETRA}({LETRA}|{NUMERO})*
ID_INC  (("<")({LETRA})*(".h")?(">")|(\")({LETRA})*(".h")?(\"))
STR     (\"([^"]|\\\")*\")

IF      [Ii][Ff]
ELSE	[Ee][Ll][Ss][Ee]

%%

{LINHA}    { nlinha++; }
{DELIM}    {}
{STR}	   { return TK_STR; }	
"main"     { return TK_MAIN; }
{IF}   	   { return TK_IF; }
{ELSE}     { return TK_ELSE; }
"switch"   { return TK_SWITCH; }
"case"     { return TK_CASE; }
"default"  { return TK_DEFAULT; }
"return"   { return TK_RETURN; }
"int"      { return TK_INT; }
"char"     { return TK_CHAR; }
"float"    { return TK_FLOAT; }
"double"   { return TK_DOUBLE; }
"boolean"  { return TK_BOOLEAN; }
"string"   { return TK_STRING; }
"void"     { return TK_VOID; }
"&&"       { return TK_AND; }
"||"       { return TK_OR; }
"=="       { return TK_IGUAL; }
"!="       { return TK_DIFERENTE; }
">="       { return TK_MAIOR_IGUAL; }
"<="       { return TK_MENOR_IGUAL; }
"++"       { return TK_ADICIONA_UM; }
"--"       { return TK_DIMINUI_UM; }
"printf"   { return TK_PRINTF; }
"scanf"    { return TK_SCANF; }

{ID}       { return TK_ID; }
{INT}      { return TK_CINT; }
{BOOLEAN}  { return TK_CBOOLEAN; }
{DOUBLE}   { return TK_CDOUBLE; }
{DOUBLE}   { return TK_CFLOAT; }
{CHAR}     { return TK_CCHAR; }
{STR}      { return TK_STR; }
.          { return *yytext; }

%%

 


