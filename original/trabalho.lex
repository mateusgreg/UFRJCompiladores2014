DELIM   [\t ]
LINHA   [\n]
NUMERO  [0-9]
LETRA   [A-Za-z_]
INT     {NUMERO}+
DOUBLE  {NUMERO}+("."{NUMERO}+)
ID      {LETRA}({LETRA}|{NUMERO})*
STRING  \"[^"\n]*\"

%%

{LINHA}    { nlinha++; }
{DELIM}    {}

"int"		{  yylval = Atributo( "", yytext ); return _INT; }
"char"		{  yylval = Atributo( "", yytext ); return _CHAR; }
"bool"		{  yylval = Atributo( "", yytext ); return _BOOL; }
"double"		{  yylval = Atributo( "", yytext ); return _DOUBLE; }
"float"		{  yylval = Atributo( "", yytext ); return _FLOAT; }
"string"		{  yylval = Atributo( "", yytext ); return _STRING; }

"<<" 		{  yylval = Atributo( yytext ); return _SHIFTL; }
"cout"		{  yylval = Atributo( yytext ); return _COUT; }

{ID}       { yylval = Atributo( yytext ); return _ID; }
{INT}      { yylval = Atributo( yytext ); return _CTE_INT; }
{DOUBLE}   { yylval = Atributo( yytext ); return _CTE_DOUBLE; }
{STRING}   { yylval = Atributo( yytext ); return _CTE_STRING; }

.          { yylval = Atributo( yytext ); return *yytext; }

%%

 


