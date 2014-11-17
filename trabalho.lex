NUMERO  [0-9]
LETRA   [A-Za-z_]
DELIM   [\t ]
LINHA   [\n]

IF      [Ii][Ff]
ELSE    [Ee][Ll][Ss][Ee]
FOR     [Ff][Oo][Rr]
WHILE   [Ww][Hh][Ii][Ll][Ee]
DO      [Dd][Oo]
SWITCH  [Ss][Ww][Ii][Tt][Cc][Hh]
CASE    [Cc][Aa][Ss][Ee]
DEFAULT [Dd][Ee][Ff][Aa][Uu][Ll][Tt]

INT     {NUMERO}+
DOUBLE  {NUMERO}+("."{NUMERO}+)?
FLOAT   {DOUBLE}[Ff]
CHAR    ['][^\n'][']
BOOLEAN ([Tt][Rr][Uu][Ee])|([Ff][Aa][Ll][Ss][Ee])
STR     (\"([^"]|\\\")*\")

ID      {LETRA}({LETRA}|{NUMERO})*
ID_INC  (("<")({LETRA})*(".h")?(">")|(\")({LETRA})*(".h")?(\"))

%%

{LINHA}    { nlinha++; }
{DELIM}    {}
"main"     { return TK_MAIN; }

{IF}       { return TK_IF; }
{ELSE}     { return TK_ELSE; }
{FOR}      { return TK_FOR; }
{WHILE}    { return TK_WHILE; }
{DO}       { return TK_DO; }
{SWITCH}   { return TK_SWITCH; }
{CASE}     { return TK_CASE; }
{DEFAULT}  { return TK_DEFAULT; }
"interval" { return TK_INTERVAL; }
"filter"   { return TK_FILTER; }
"forEach"  { return TK_FOR_EACH; }
"sort"     { return TK_SORT; }

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
".."       { return TK_FROM_TO; }

"printf"   { return TK_PRINTF; }
"scanf"    { return TK_SCANF; }
"return"   { return TK_RETURN; }

{ID}       { return TK_ID; }
{INT}      { return TK_CINT; }
{BOOLEAN}  { return TK_CBOOLEAN; }
{DOUBLE}   { return TK_CDOUBLE; }
{FLOAT}    { return TK_CFLOAT; }
{CHAR}     { return TK_CCHAR; }
{STR}      { return TK_STR; }
.          { return *yytext; }

%%
