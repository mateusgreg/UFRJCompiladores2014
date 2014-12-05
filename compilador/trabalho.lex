NUMERO  [0-9]
LETRA   [A-Za-z_]
DELIM   [\t ]
LINHA   [\n]
MAIN	[Mm][Aa][Ii][Nn]

IF      [Ii][Ff]
ELSE    [Ee][Ll][Ss][Ee]
FOR     [Ff][Oo][Rr]
WHILE   [Ww][Hh][Ii][Ll][Ee]
DO      [Dd][Oo]
SWITCH  [Ss][Ww][Ii][Tt][Cc][Hh]
CASE    [Cc][Aa][Ss][Ee]
DEFAULT [Dd][Ee][Ff][Aa][Uu][Ll][Tt]
BREAK   [Bb][Rr][Ee][Aa][Kk]

INT     {NUMERO}+
DOUBLE  {NUMERO}+("."{NUMERO}+)?
FLOAT   {DOUBLE}[Ff]
CHAR    \'[^'\n]\'
BOOLEAN ([Tt][Rr][Uu][Ee])|([Ff][Aa][Ll][Ss][Ee])
STR     \"[^"\n]*\"

ID      ({LETRA}({LETRA}|{NUMERO})*)
ID_INC  (("<")({LETRA})*(".h")?(">")|(\")({LETRA})*(".h")?(\"))

COMMENT "//".*

%%

{LINHA}    { nlinha++; }
{DELIM}    {}
{COMMENT}  {}

{MAIN}     { return TK_MAIN; }

{IF}       { yylval = Atributo( yytext ); return TK_IF; }
{ELSE}     { yylval = Atributo( yytext ); return TK_ELSE; }
{FOR}      { yylval = Atributo( yytext ); return TK_FOR; }
{WHILE}    { yylval = Atributo( yytext ); return TK_WHILE; }
{DO}       { yylval = Atributo( yytext ); return TK_DO; }
{SWITCH}   { yylval = Atributo( yytext ); return TK_SWITCH; }
{CASE}     { yylval = Atributo( yytext ); return TK_CASE; }
{DEFAULT}  { yylval = Atributo( yytext ); return TK_DEFAULT; }
{BREAK}    { yylval = Atributo( yytext ); return TK_BREAK; }
"interval" { yylval = Atributo( yytext ); return TK_INTERVAL; }
"filter"   { yylval = Atributo( yytext ); return TK_FILTER; }
"forEach"  { yylval = Atributo( yytext ); return TK_FOR_EACH; }
"sort"     { yylval = Atributo( yytext ); return TK_SORT; }
"firstN"   { yylval = Atributo( yytext ); return TK_FIRST_N; }
"lastN"    { yylval = Atributo( yytext ); return TK_LAST_N; }
"split"    { yylval = Atributo( yytext ); return TK_SPLIT; }
"merge"    { yylval = Atributo( yytext ); return TK_MERGE; }

"int"      { yylval = Atributo( "", yytext ); return TK_INT; }
"char"     { yylval = Atributo( "", yytext ); return TK_CHAR; }
"float"    { yylval = Atributo( "", yytext ); return TK_FLOAT; }
"double"   { yylval = Atributo( "", yytext ); return TK_DOUBLE; }
"bool"     { yylval = Atributo( "", yytext ); return TK_BOOLEAN; }
"string"   { yylval = Atributo( "", yytext ); return TK_STRING; }
"void"     { yylval = Atributo( "", yytext ); return TK_VOID; }

"&&"       { yylval = Atributo( yytext ); return TK_AND; }
"||"       { yylval = Atributo( yytext ); return TK_OR; }
"=="       { yylval = Atributo( yytext ); return TK_IGUAL; }
"!="       { yylval = Atributo( yytext ); return TK_DIFERENTE; }
">="       { yylval = Atributo( yytext ); return TK_MAIOR_IGUAL; }
"<="       { yylval = Atributo( yytext ); return TK_MENOR_IGUAL; }
"++"       { yylval = Atributo( yytext ); return TK_ADICIONA_UM; }
"--"       { yylval = Atributo( yytext ); return TK_DIMINUI_UM; }
".."       { yylval = Atributo( yytext ); return TK_FROM_TO; }

"printf"   { yylval = Atributo( yytext ); return TK_PRINTF; }
"scanf"    { yylval = Atributo( yytext ); return TK_SCANF; }
"return"   { yylval = Atributo( yytext ); return TK_RETURN; }

{INT}      { yylval = Atributo( yytext ); return CONST_INT; }
{BOOLEAN}  { yylval = Atributo( yytext ); return CONST_BOOLEAN; }
{DOUBLE}   { yylval = Atributo( yytext ); return CONST_DOUBLE; }
{FLOAT}    { yylval = Atributo( yytext ); return CONST_FLOAT; }
{CHAR}     { yylval = Atributo( yytext ); return CONST_CHAR; }
{STR}      { yylval = Atributo( yytext ); return CONST_STRING; }

{ID}       { yylval = Atributo( yytext ); return TK_ID; }
.          { yylval = Atributo( yytext ); return *yytext; }

%%
