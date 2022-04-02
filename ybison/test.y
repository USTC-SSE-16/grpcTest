package sqlparser


%type <item>
    select_statement

%type <statement>
    command


%start any_command

%%

any_command:
  command opt_semicolon
  {
    setParseTree(yylex, $1)
  }

command:
  select_statement
  {
    $$ = $1.(ast.SelectStatement)
  }

opt_semicolon:
  {}
| ';'
  {}
