/* Definition section */
%{
    #include "common.h"
    #include "y.tab.h"	/* header file generated by bison */
    extern YYSTYPE yylval;

    #define YY_NO_UNPUT
    #define YY_NO_INPUT
%}


/* Define regular expression label */
letter  [a-zA-Z_]
digit [0-9]
id {letter}+({letter}|{digit})*
inumber {digit}+
fnumber ({digit}*\.{digit}+)
newline		[\n]

%x CMT
%x STR
%option yylineno

/* Rules section */
%%

"/*"        { BEGIN(CMT); }
<CMT>"*/"   { BEGIN(INITIAL); }
<CMT>\n     {;}
<CMT>.      {;}
"//".*      {;}
"\"" {
    BEGIN(STR);
}
<STR>"\"" {
    BEGIN(INITIAL);
}
<STR>[^\"]* {
    yylval.str = strdup(yytext);
    return STRING_LIT;
}

"(" {
    return LPAREN;
}
")" {
    return RPAREN;
}
"[" {
    return LBRACK;
}
"]" {
    return RBRACK;
}
"{" {
    return LBRAC;
}
"}" {
    return RBRAC;
}

"++" {
    return INC;
}
"--" {
    return DEC;
}

"=" {
    return ASSIGN;
}
"+=" {
    return ADD_ASSIGN;
}
"-=" {
    return SUB_ASSIGN;
}
"*=" {
    return MUL_ASSIGN;
}
"/=" {
    return QUO_ASSIGN;
}
"%=" {
    return REM_ASSIGN;
}

"||" {
    return OR;
}
"&&" {
    return AND;
}
"!" {
    return NOT;
}

"==" {
    return EQL;
}
"!=" {
    return NEQ;
}
"<" {
    return LSS;
}
"<=" {
    return LEQ;
}
">" {
    return GTR;
}
">=" {
    return GEQ;
}

"+" {
    return PLUS;
}
"-" {
    return MINUS;
}

"*" {
    return MUL;
}
"/" {
    return QUO;
}
"%" {
    return REM;
}

"int" {
    return INT;
}
"float" {
    return FLOAT;
}
"bool" {
    return BOOL;
}
"string" {
    return STRING;
}

"print" {
    return PRINT;
}

"if" {
    return IF;
}

"else" {
    return ELSE;
}

"while" {
    return WHILE;
}

"for" {
    return FOR;
}

{inumber} {
    yylval.str = strdup(yytext);
    return INT_LIT;
}
{fnumber} {
    yylval.str = strdup(yytext);
    return FLOAT_LIT;
}
"true" {
    yylval.str = strdup("TRUE");
    return BOOL_LIT;
}
"false" {
    yylval.str = strdup("FALSE");
    return BOOL_LIT;
}

{id} {
    yylval.str = strdup(yytext);
    return Identifier;
}
[;] {
    return SEMICOLON;
}

[\n]        {;}
[ \t]+      {;}
.           {;}
<<EOF>> {
    static int once = 0;
    if (once++) {
        yyterminate();
    }
}
%%
/*  C Code section */
int yywrap(void)
{
    return 1;
}