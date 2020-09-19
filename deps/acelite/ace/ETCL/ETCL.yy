%{
// ========================================================================
//
// = LIBRARY
//   orbsvcs / Extended Trader Constraint Language parser.
//
// = FILENAME
//   ETCL.yy
//
// = AUTHOR
//   Carlos O'Ryan <coryan@uci.edu> based on previous work by
//   Seth Widoff <sbw1@cs.wustl.edu>
//   Jeff Parsons <j.parsons@vanderbilt.edu>
//
// ========================================================================

#include "ace/ETCL/ETCL_y.h"
#include "ace/ETCL/ETCL_constraint.h"
#include "ace/ETCL/ETCL_Interpreter.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

extern int yylex (void);
extern void yyflush_current_buffer (void);

static void yyerror (const char *)
{
  // @@ TODO
  // Ignore error messages
}

ACE_END_VERSIONED_NAMESPACE_DECL

#include <stdio.h>

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

%}

%token ETCL_GT
%token ETCL_GE
%token ETCL_LT
%token ETCL_LE
%token ETCL_EQ
%token ETCL_NE
%token ETCL_EXIST
%token ETCL_DEFAULT
%token ETCL_AND
%token ETCL_OR
%token ETCL_NOT
%token ETCL_IN
%token ETCL_TWIDDLE
%token ETCL_BOOLEAN
%token ETCL_PLUS
%token ETCL_MINUS
%token ETCL_MULT
%token ETCL_DIV
%token ETCL_UMINUS
%token ETCL_INTEGER
%token ETCL_FLOAT
%token ETCL_STRING
%token ETCL_RPAREN
%token ETCL_LPAREN
%token ETCL_RBRA
%token ETCL_LBRA
%token ETCL_IDENT
%token ETCL_UNSIGNED
%token ETCL_SIGNED
%token ETCL_DOUBLE
%token ETCL_CONSTRAINT
%token ETCL_COMPONENT
%token ETCL_WITH
%token ETCL_MAX
%token ETCL_MIN
%token ETCL_FIRST
%token ETCL_RANDOM
%token ETCL_DOLLAR
%token ETCL_DOT
%token ETCL_DISCRIMINANT
%token ETCL_LENGTH
%token ETCL_TYPE_ID
%token ETCL_REPOS_ID


%type <constraint> ETCL_IDENT
%type <constraint> ETCL_BOOLEAN
%type <constraint> ETCL_STRING
%type <constraint> ETCL_FLOAT
%type <constraint> ETCL_INTEGER
%type <constraint> expr_in
%type <constraint> constraint preference bool_or bool_and bool_compare
%type <constraint> expr_in expr_twiddle expr term factor_not factor
%type <constraint> union_pos union_val component_array
%type <constraint> component_array component_assoc component_pos
%type <constraint> component_dot component_ext component

%start constraint

%%

constraint: bool_or
        | preference
	;

preference:     ETCL_MIN bool_or
        { $$ = new ETCL_PREFERENCE_CLASS (ETCL_MIN, $2); }
        |       ETCL_MAX bool_or
        { $$ = new ETCL_PREFERENCE_CLASS (ETCL_MAX, $2); }
        |       ETCL_WITH bool_or
        { $$ = new ETCL_PREFERENCE_CLASS (ETCL_WITH, $2); }
        |       ETCL_FIRST
        { $$ = new ETCL_PREFERENCE_CLASS (ETCL_FIRST); }
        |       ETCL_RANDOM
        { $$ = new ETCL_PREFERENCE_CLASS (ETCL_RANDOM); }
        ;

bool_or:	bool_or ETCL_OR bool_and
		{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_OR, $1, $3); }
	|	bool_and
	;

bool_and:	bool_and ETCL_AND bool_compare
		{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_AND, $1, $3); }
	|	bool_compare
	;

bool_compare:	expr_in ETCL_EQ expr_in
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_EQ, $1, $3); }
	|	expr_in ETCL_NE expr_in
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_NE, $1, $3); }
	|	expr_in ETCL_GT expr_in
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_GT, $1, $3); }
	|	expr_in ETCL_GE expr_in
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_GE, $1, $3); }
	|	expr_in	ETCL_LT expr_in
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_LT, $1, $3); }
	|	expr_in ETCL_LE expr_in
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_LE, $1, $3); }
	|	expr_in
	;

expr_in:	expr_twiddle ETCL_IN component
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_IN, $1, $3); }
	|	expr_twiddle ETCL_IN ETCL_DOLLAR component
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_IN, $1, $4); }
	|	expr_twiddle
	;

expr_twiddle:	expr ETCL_TWIDDLE expr
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_TWIDDLE, $1, $3); }
	|	expr
	;

expr:		expr ETCL_PLUS term
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_PLUS, $1, $3); }
	|	expr ETCL_MINUS term
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_MINUS, $1, $3); }
	|	term
	;

term:		term ETCL_MULT factor_not
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_MULT, $1, $3); }
	|	term ETCL_DIV factor_not
	{ $$ = new ETCL_BINARY_EXPR_CLASS (ETCL_DIV, $1, $3); }
	|	factor_not
	;

factor_not:	ETCL_NOT factor
	{ $$ = new ETCL_UNARY_EXPR_CLASS (ETCL_NOT, $2); }
	|	factor
	;

factor:		ETCL_LPAREN bool_or ETCL_RPAREN
	{ $$ = $2; }
	|	ETCL_INTEGER
	{ $$ = $1; }
	|	ETCL_PLUS ETCL_INTEGER
	{ $$ = new ETCL_UNARY_EXPR_CLASS (ETCL_PLUS, $2); }
	|	ETCL_MINUS ETCL_INTEGER
	{ $$ = new ETCL_UNARY_EXPR_CLASS (ETCL_MINUS, $2); }
	|	ETCL_FLOAT
	{ $$ = $1; }
	|	ETCL_PLUS ETCL_FLOAT
	{ $$ = new ETCL_UNARY_EXPR_CLASS (ETCL_PLUS, $2); }
	|	ETCL_MINUS ETCL_FLOAT
	{ $$ = new ETCL_UNARY_EXPR_CLASS (ETCL_MINUS, $2); }
	|	ETCL_STRING
	{ $$ = $1; }
	|	ETCL_BOOLEAN
	{ $$ = $1; }
	|	ETCL_EXIST ETCL_IDENT
	{ $$ = new ETCL_EXIST_CLASS ($2); }
	|	ETCL_EXIST ETCL_DOLLAR component
	{ $$ = new ETCL_EXIST_CLASS ($3); }
	|	ETCL_DEFAULT ETCL_DOLLAR component
	{ $$ = new ETCL_DEFAULT_CLASS ($3); }
	|	ETCL_DOLLAR component
	{ $$ = new ETCL_EVAL_CLASS ($2); }
	| 	ETCL_IDENT
	{ $$ = $1; }
	;

component:	/* empty */
	{ $$ = 0; }
	| ETCL_DOT component_dot
	{ $$ = new ETCL_DOT_CLASS ($2); }

	| ETCL_IDENT component_ext
	{ $$ = new ETCL_COMPONENT_CLASS ($1, $2); }

	| component_array
	| component_assoc
	;

component_ext:	/* empty */
	{ $$ = 0; }
	| ETCL_DOT component_dot
	{ $$ = new ETCL_Dot ($2); }

	| component_array
	| component_assoc
	;

component_dot:  ETCL_IDENT component_ext
	{ $$ = new ETCL_COMPONENT_CLASS ($1, $2); }
	| ETCL_LENGTH
	{ $$ = new ETCL_SPECIAL_CLASS (ETCL_LENGTH); }
	| ETCL_DISCRIMINANT
	{ $$ = new ETCL_SPECIAL_CLASS (ETCL_DISCRIMINANT); }
	| ETCL_TYPE_ID
	{ $$ = new ETCL_SPECIAL_CLASS (ETCL_TYPE_ID); }
	| ETCL_REPOS_ID
	{ $$ = new ETCL_SPECIAL_CLASS (ETCL_REPOS_ID); }
	| component_pos
	| union_pos
	;

component_array:  ETCL_LBRA ETCL_INTEGER ETCL_RBRA component_ext
	{ $$ = new ETCL_COMPONENT_ARRAY_CLASS ($2, $4); }
	;

component_assoc:  ETCL_LPAREN ETCL_IDENT ETCL_RPAREN component_ext
	{ $$ = new ETCL_COMPONENT_ASSOC_CLASS ($2, $4); }
	;

component_pos:  ETCL_INTEGER component_ext
	{ $$ = new ETCL_COMPONENT_POS_CLASS ($1, $2); }
	;

union_pos:  ETCL_LPAREN union_val ETCL_RPAREN component_ext
	{ $$ = new ETCL_UNION_POS_CLASS ($2, $4); }
	;

union_val:  /* empty */
	{ $$ = 0; }
	| ETCL_INTEGER
	{ $$ = new ETCL_UNION_VALUE_CLASS (+1, $1); }
	| ETCL_PLUS ETCL_INTEGER
	{ $$ = new ETCL_UNION_VALUE_CLASS (+1, $2); }
	| ETCL_MINUS ETCL_INTEGER
	{ $$ = new ETCL_UNION_VALUE_CLASS (-1, $2); }
	| ETCL_STRING
	{ $$ = new ETCL_UNION_VALUE_CLASS ($1); }
	;

%%

ACE_END_VERSIONED_NAMESPACE_DECL
