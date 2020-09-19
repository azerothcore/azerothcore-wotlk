%option noyywrap

%{
// ========================================================================
//
// = LIBRARY
//   orbsvcs/ECTL
// 
// = FILENAME
//   ETCL.ll
//
// = AUTHOR
//   Carlos O'Ryan <coryan@uci.edu> based on previous work by
//   Seth Widoff <sbw1@cs.wustl.edu>
//
// ========================================================================

#include "ace/ETCL/ETCL_Interpreter.h"
#include "ace/ETCL/ETCL_y.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

static const char * extract_string(char*);

#define YY_LEX_DEBUG

#ifdef CONSTRAINT_DEBUG
#define YY_LEX_DEBUG OS::fprintf(stderr, "%s\n", yytext)
#endif /* CONSTRAINT_DEBUG */

#define YY_DECL int ETCL_yylex (ETCL_YYSTYPE *lvalp, void* state)

#define YY_BREAK
#define YY_NO_UNPUT

%}

white_space     [ \t]
letter		[a-zA-Z]
digit		[0-9]
alpha_num	({letter}|{digit})
integer		{digit}+ 
float		({digit}*\.{digit}+)([eE][-+]?{digit}+)? 
string		'(([^'\\]*)|([^'\\]*\\')|([^'\\]*\\\\))*'
base		{letter}({alpha_num}|[_])*
ident		{base}|\\{base}
newline		\n

%%

min             { YY_LEX_DEBUG; return ETCL_MIN; }
max             { YY_LEX_DEBUG; return ETCL_MAX; }
first           { YY_LEX_DEBUG; return ETCL_FIRST; }
random          { YY_LEX_DEBUG; return ETCL_RANDOM; }
with            { YY_LEX_DEBUG; return ETCL_WITH; }
exist		{ YY_LEX_DEBUG; return ETCL_EXIST; }
not		{ YY_LEX_DEBUG; return ETCL_NOT; }
and		{ YY_LEX_DEBUG; return ETCL_AND; }
or		{ YY_LEX_DEBUG; return ETCL_OR; }
in		{ YY_LEX_DEBUG; return ETCL_IN; }
"~"             { YY_LEX_DEBUG; return ETCL_TWIDDLE; }
"+"		{ YY_LEX_DEBUG; return ETCL_PLUS; }
"-"		{ YY_LEX_DEBUG; return ETCL_MINUS; }
"*"		{ YY_LEX_DEBUG; return ETCL_MULT; }
"/"		{ YY_LEX_DEBUG; return ETCL_DIV; }
"<"		{ YY_LEX_DEBUG; return ETCL_LT; }
"<="		{ YY_LEX_DEBUG; return ETCL_LE; }
">"		{ YY_LEX_DEBUG; return ETCL_GT; }
">="		{ YY_LEX_DEBUG; return ETCL_GE; }
"=="		{ YY_LEX_DEBUG; return ETCL_EQ; }
"!="		{ YY_LEX_DEBUG; return ETCL_NE; }
"("             { YY_LEX_DEBUG; return ETCL_LPAREN; }
")"             { YY_LEX_DEBUG; return ETCL_RPAREN; }
"$"		{ YY_LEX_DEBUG; return ETCL_DOLLAR; }
"."		{ YY_LEX_DEBUG; return ETCL_DOT; }
"default"	{ YY_LEX_DEBUG; return ETCL_DEFAULT; }
"_d"		{ YY_LEX_DEBUG; return ETCL_DISCRIMINANT; }
"_type_id"	{ YY_LEX_DEBUG; return ETCL_TYPE_ID; }
"_repos_id"	{ YY_LEX_DEBUG; return ETCL_REPOS_ID; }
"_length"	{ YY_LEX_DEBUG; return ETCL_LENGTH; }
"["		{ YY_LEX_DEBUG; return ETCL_LBRA; }
"]"		{ YY_LEX_DEBUG; return ETCL_RBRA; }
TRUE		{ 
		  lvalp->constraint = 
		    new ETCL_Literal_Constraint ((CORBA::Boolean) 1);
		  YY_LEX_DEBUG; return ETCL_BOOLEAN;
		}
FALSE		{ 
		  lvalp->constraint = 
		    new ETCL_Literal_Constraint ((CORBA::Boolean) 0);
		  YY_LEX_DEBUG; return ETCL_BOOLEAN;
		}
{integer}	{ 
		  lvalp->constraint = 
		    new ETCL_Literal_Constraint (ACE_OS::atoi (yytext));
		  YY_LEX_DEBUG; return ETCL_INTEGER; 
		}
{float}		{
		  double v;
		  sscanf (yytext, "%lf", &v); 
		  lvalp->constraint = 
		    new ETCL_Literal_Constraint (v);
		  YY_LEX_DEBUG; return ETCL_FLOAT; 
		}
{string}	{ 
		  lvalp->constraint =
		    new ETCL_Literal_Constraint (extract_string (yytext));
		  YY_LEX_DEBUG; return ETCL_STRING; 
		}
{ident}		{ 
		  lvalp->constraint = 
		    new ETCL_Identifier (yytext);
		  YY_LEX_DEBUG; return ETCL_IDENT; 
		}
{white_space}   { 
                  YY_LEX_DEBUG; break; // Ignore
                }
.               { 
                  YY_LEX_DEBUG; break; // @@ TODO
                }
%%

const char*
extract_string(char* str)
{
  char *t = str;
  for (char * i = str + 1; *i != '\''; ++i, ++t)
    {
      if (*i == '\\')
        {
          ++i;
          if (*i == 0)
            return 0;
          else if (*i == 't')
            *t = '\t';
          else if (*i == 'n')
            *t = '\n';
          else if (*i == '\\')
            *t = '\\';
          else
            *t = *i;
          continue;
        }

      *t = *i;     
    }

  *t = '\0';
  return str;
}

int
yywrap (void)
{
  return 1;
}

ACE_END_VERSIONED_NAMESPACE_DECL
