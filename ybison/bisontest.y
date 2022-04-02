%{
/*
Copyright 2017 Google Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

//lint:file-ignore SA4006 Ignore all unused code, it's generated
package sqlparser
/*
  Indentation of grammar rules:

rule: <-- starts at col 1
  {} <-- empty rule in one line
| rule1a rule1b rule1c <-- | starts at col 1, rule starts at col 3
  { <-- starts at col 3
    go code <-- starts at col 5
  }
| rule2a rule2b <-- keep rule in same line with delimiter('|')
  {
    go code
  }

  go code is format by gofmt.

  Having a uniform indentation in this file helps
  code reviews, patches, merges, and make maintenance easier.
  indentation with 2 spaces

  Thanks.
*/

import (
  "strings"
  "github.com/youtube/vitess/go/vt/sqlparser/ast"
)

func nextAliasId(yylex interface{}) string {
  yylex.(*Tokenizer).aliasID++
  return ast.GenDerivedTableAlias(yylex.(*Tokenizer).aliasID)
}

func setParseTree(yylex interface{}, stmt ast.Statement) {
  yylex.(*Tokenizer).ParseTree = stmt
}

func setAllowComments(yylex interface{}, allow bool) {
  yylex.(*Tokenizer).AllowComments = allow
}

func setHasSequenceUpdateNode(yylex interface{}, has bool) {
  yylex.(*Tokenizer).ExtraParseInfo.HasSequenceUpdateNode = has
}

func setHasGetLockNode(yylex interface{}, has bool) {
  yylex.(*Tokenizer).ExtraParseInfo.HasGetLockNode = has
}

func setHasRownum(yylex interface{}, has bool) {
  yylex.(*Tokenizer).ExtraParseInfo.HasRownum = has
}

func setHasLimit(yylex interface{}, has bool) {
  yylex.(*Tokenizer).ExtraParseInfo.HasLimit = has
}

func incNesting(yylex interface{}) bool {
  yylex.(*Tokenizer).nesting++
  if yylex.(*Tokenizer).nesting == 200000 {
    return true
  }
  return false
}

func decNesting(yylex interface{}) {
  yylex.(*Tokenizer).nesting--
}

func forceEOF(yylex interface{}) {
  yylex.(*Tokenizer).ForceEOF = true
}

func getLineNum(yylex interface{}) int {
  return yylex.(*Tokenizer).LineNum
}

func setLineNum(yylex interface{}, dd interface{}) {
  if setLineNum, ok := dd.(ast.LineNumHandler); ok {
    setLineNum.SetLineNumber(getLineNum(yylex))
  }
}

%}

%union {
  item interface{}
  ident string
  expr ast.Expr
  statement ast.Statement
}


/***********************************************************************************************************************
 ********************** %token: Abstract Syntax Tree Leaf Node **********************************************************
***********************************************************************************************************************/
%token LEX_ERROR
%token <ident>
  '('
  ')'
  ';'
  ACCESSIBLE
  ACCESS
  ACCOUNT
  ANCILLARY
  ACTION
  ADD
  ADMIN
  ADVANCED
  AFTER
  AGAINST
  ALGORITHM
  ALL
  ALLOW
  ALTER
  ALWAYS
  ANALYZE
  ANYSCHEMA
  AS
  ASC
  ASCII
  AUTO_INCREMENT
  AVG_ROW_LENGTH
  BACKEND
  BASIC
  BASICFILE
  BEFORE
  BEGIN
  BEQUEATH
  BFILE
  BIGINT
  BINARY_DOUBLE
  BINARY_FLOAT
  BINARY_INTEGER
  BINARY_MD5
  BINDING
  BIT
  BITMAP
  BIT_LITERAL
  BLOB
  BODY
  BOOL
  BOOLEAN
  BTREE
  RTREE
  BUFFER_POOL
  BY
  BYTE
  CACHE
  CALL
  CAPACITY
  CASCADE
  CASCADED
  CAST
  CHANGE
  CHAR
  CHARACTER
  CHARSET
  CHECK
  CHECKSUM
  CLIENT
  CLOB
  COALESCE
  COLLATION
  COLUMN
  COLUMN_FORMAT
  COLUMNS
  COMMENT
  COMMENT_KEYWORD
  COMMIT
  COMMITTED
  COMPACT
  COMPOUND
  COMPRESS
  COMPRESSED
  COMPRESSION
  COMPUTE
  CONCAT
  CONDITIONAL
  CONNECTION
  CONSTRAINT
  CONTEXT
  CONTAINER
  CONTAINER_MAP
  CONTAINERS_DEFAULT
  CONVERT
  CREATE
  CREATION
  CURRENT
  CURRENT_DATE
  CURRENT_TIME
  CURRENT_TIMESTAMP
  CYCLE
  DATA
  DATABASE
  DATABASES
  DATE
  DATETIME
  DAY
  DAYS
  DEC
  DECIMAL
  DEFAULT
  DELETE_ALL
  DEFERRABLE
  DEFERRED
  DEFINER
  DELAY_KEY_WRITE
  DELETE
  DESC
  DESCRIBE
  DIRECTORY
  DISABLE
  DISABLE_ALL
  DISALLOW
  DISCARD
  DISK
  DISTINCT
  DISTRIBUTED
  DML
  DOUBLE
  DOUBLE_AT_ID
  DROP
  DUAL
  DUPLICATE
  DYNAMIC
  EACH
  EDITIONABLE
  EDITIONING
  ELEMENT
  ENABLE
  ENABLE_ALL
  ENCRYPT
  ENCRYPTION
  ENFORCED
  ENGINE
  ENGINE_ATTRIBUTE
  ENGINES
  ENUM
  ERRORS
  ESCAPE
  EVENT
  EXCEPT
  EXCHANGE
  EXECUTE
  EXISTS
  EXPANSION
  EXPIRE
  EXPLAIN
  EXTENDED
  EXTERNALLY
  FAILED_LOGIN_ATTEMPTS
  FALSE
  FETCH
  FIELDS
  FILE
  FILESYSTEM_LIKE_LOGGING
  FIRST
  FIXED
  FLASH_CACHE
  FLOAT
  FLOAT_TYPE
  FOLLOWS
  FOR
  FOREIGN
  FORMAT
  FREELIST
  FREELISTS
  FROM
  FULL
  FULLTEXT
  FUNCTION
  GENERATED
  GEOMETRY
  GEOMETRYCOLLECTION
  GLKJOIN
  GLOBAL
  GLOBALLY
  GRANT
  GRANTS
  GROUP
  GROUPS
  GROUP_CONCAT
  HASH
  HAVING
  HEX
  HEXNUM
  HIGH
  HISTORY
  HOUR
  ID
  IDENTIFIED
  IDENTIFIER
  IDENTITY
  IF
  IGNORE
  ILM
  IMMEDIATE
  IMPORT
  INCEPTOR
  INCREMENT
  INDEX
  INDEXED
  INDEXES
  INDEXTYPE
  INDEXING
  INITIAL
  INITIALLY
  INITRANS
  INMEMORY
  INSERT
  INSERT_METHOD
  INSTEAD
  INT
  INTEGER
  INTEGRAL
  INTNUM
  INTO
  INVISIBLE
  INVOKER
  ISOLATION
  ISSUER
  JSON
  JSON_EXTRACT_OP
  JSON_UNQUOTE_EXTRACT_OP
  KEY
  KEYS
  KEY_BLOCK_SIZE
  KUNDB_CHECKS
  KUNDB_KEYSPACES
  KUNDB_RANGE_INFO
  KUNDB_SHARDS
  KUNDB_VINDEXES
  LANGUAGE
  LAST
  LAST_INSERT_ID
  LESS
  LEVEL
  LIMIT
  LINEAR
  LINESTRING
  LIST
  LIST_ARG
  LOB
  LOBS
  LOCAL
  LOCALTIME
  LOCALTIMESTAMP
  LOCATE
  LOCK
  LOCKING
  LOGGING
  LONG
  LONGBLOB
  LONGTEXT
  MANAGED
  LOW
  MATCH
  MAXEXTENTS
  MAXVALUE
  MAX_ROWS
  MAXSIZE
  MEDIUMBLOB
  MEDIUMINT
  MEDIUMTEXT
  MEMCOMPRESS
  MEMORY
  METADATA
  MERGE
  MFED
  MINEXTENTS
  MINUTE
  MINVALUE
  MIN_ROWS
  MODE
  MODIFICATION
  MODIFY
  MONTH
  MONTHS
  MULTILINESTRING
  MULTIPOINT
  MULTIPOLYGON
  MULTIVALUE
  NAN
  NAMES
  NATURALN
  NATIONAL
  NCHAR
  NCLOB
  NEVER
  NEXT
  NESTED
  NEW
  NO
  NOCACHE
  NOCOMPRESS
  NODEGROUP
  NOLOGGING
  NOMAXVALUE
  NOMINVALUE
  NONE
  NONEDITIONABLE
  NONSCHEMA
  NORELY
  NOVALIDATE
  NOW
  NO_WRITE_TO_BINLOG
  NOORDER
  NULL
  NULLX
  NUMERIC
  NUMERIC_STATIC_MAP
  NVARCHAR
  NVARCHAR2
  OFF
  OFFSET
  OLD
  ONLY
  OPERATOR
  OPTIMAL
  OPTIMIZE
  OPTION
  OPTIONAL
  OVERFLOW
  PACKAGE
  PACKAGES
  PACK_KEYS
  PARENT
  PARSER
  PARTIAL
  PARTITION
  PARTITIONING
  PARTITIONS
  PASSWORD
  PASSWORD_LOCK_TIME
  PCTFREE
  PCTINCREASE
  PCTUSED
  PLS_INTEGER
  POINT
  POLICY
  POLYGON
  POSITIVE
  POSITIVEN
  PRECEDES
  PRECISION
  PRETTY
  PRIMARY
  PRIVILEGES
  PROCEDURE
  PROCESS
  PROCESSLIST
  PUBLIC
  QUERY
  RANGE
  RAW
  READ
  REAL
  RECURSIVE
  RECYCLE
  REDUNDANT
  REFERENCE
  REFERENCES
  REFERENCING
  RELOAD
  RELY
  REMOTE_SEQ
  REMOVE
  RENAME
  REORGANIZE
  REPAIR
  REPEATABLE
  REPLACE
  REPLICATION
  REQUIRE
  RESTRICT
  REVERSE_BITS
  REVOKE
  ROLE
  ROLLBACK
  ROUTINE
  ROW
  ROWID
  ROWNUM
  ROW_FORMAT
  SALT
  SCAN
  SCHEMA
  SCHEMAS
  SCOPE
  SECOND
  SECONDARY_ENGINE_ATTRIBUTE
  SECUREFILE
  SECURITY
  SELECT
  SEPARATOR
  SEQUENCE
  SERIAL
  SERIALIZABLE
  SERVER
  SESSION
  SHARDS
  SHARE
  SHARING
  SHOW
  SHUTDOWN
  SIGNED
  SIGNTYPE
  SIMPLE
  SIMPLE_INTEGER
  SINGLE_AT_ID
  SLAVE
  SMALLINT
  SPATIAL
  SQL
  SQL_CACHE
  SQL_NO_CACHE
  SSL
  START
  STATEMENT
  STATS_AUTO_RECALC
  STATS_PERSISTENT
  STATS_SAMPLE_PAGES
  STATUS
  STORAGE
  STORE
  STORED
  SUBJECT
  SUPER
  SYNONYM
  SYSTEM
  TABLE
  TABLES
  TABLESPACE
  TEMPORARY
  TEMPTABLE
  TEXT
  THAN
  TIME
  TIMESTAMP
  TIMEZONE_HOUR
  TIMEZONE_MINUTE
  TIMEZONE_REGION
  TIMEZONE_ABBR
  TINYBLOB
  TINYINT
  TINYTEXT
  TIER
  TO
  TRADITIONAL
  TRANSACTION
  TREE
  TRIGGER
  TRIGGERS
  TRUE
  TRUNCATE
  TYPE
  UNBOUNDED
  UNCOMMITTED
  UNCONDITIONAL
  UNDEFINED
  UNDER
  UNDERSCORECS
  UNICODE_LOOSE_MD5
  UNIQUE
  UNLIMITED
  UNLOCK
  UROWID
  UNSIGNED
  UNUSED
  UPDATE
  USAGE
  USER
  USING
  UTC_DATE
  UTC_TIME
  UTC_TIMESTAMP
  VALIDATE
  VALIDATION
  VALUE
  VALUES
  VALUE_ARG
  VARBINARY
  VARCHAR
  VARCHAR2
  VARCHARACTER
  VARIABLES
  VARRAYS
  VARYING
  VIEW
  VIRTUAL
  VISIBLE
  VSCHEMA_TABLES
  WARNINGS
  WHERE
  WITH
  WITHOUT
  WM_CONCAT
  WRAPPER
  WRITE
  XMLSCHEMA
  X509
  YEAR
  YEARS
  ZEROFILL
  ZONE


/* The following tokens belong to plsql. */
%token <ident>
  AGGREGATE
  ANY
  ARRAY
  ASSIGN_OP
  AUTHID
  BATCH
  BINDVAR
  BOTH
  BULK
  CLOSE
  CLUSTER
  COLLECT
  COMPILE
  CONNECT
  CONSTANT
  CONSTRAINTS
  CONTINUE
  CORRUPT_XID
  CORRUPT_XID_ALL
  CURRENT_USER
  CURSOR
  C_LETTER
  CONVERSION
  DEBUG
  DECLARE
  DETERMINISTIC
  DOUBLE_POINT
  ELSIF
  ERROR
  EXCEPTION
  EXCEPTIONS
  EXCEPTION_INIT
  EXIT
  EXTERNAL
  EXTRACT
  FORALL
  PERCENT_FOUND
  GOTO
  INDICES
  INTRODUCER
  PERCENT_ISOPEN
  JAVA
  JSON_EXISTS
  JSON_QUERY
  JSON_VALUE
  KEEP
  LEADING
  LOOP
  NAME
  NEW_TIME
  NOCOPY
  NOCYCLE
  NOWAIT
  NUMBER
  PERCENT_NOTFOUND
  OBJECT
  OF
  OPEN
  OUT
  PARALLEL_ENABLE
  PIPE
  PIPELINED
  PRAGMA
  RAISE
  REBUILD
  RECORD
  REF
  RELIES_ON
  RESULT_CACHE
  RETURN
  RETURNING
  REUSE
  REVERSE
  ROWCOUNT
  PERCENT_ROWTYPE
  PERCENT_TYPE
  SAVE
  SAVEPOINT
  SEGMENT
  SESSIONTIMEZONE
  SETTINGS
  SORT
  SPECIFICATION
  STATIC
  SUBPARTITION
  SUBPARTITIONS
  SUBTYPE
  SYSDATE
  SYSTIMESTAMP
  TO_CHAR
  TO_DATE
  TO_NUMBER
  TO_TIMESTAMP
  TRAILING
  TRIM
  UNSIGNED_INTEGER
  USING_NLS_COMP
  VARRAY
  WAIT
  WHILE
  WORK
  XMLTYPE


/***********************************************************************************************************************
 ********************** %type: Abstract Syntax Tree non-Leaf Node ******************************************************
***********************************************************************************************************************/
%type <expr>
  charset_name_or_default
  col_alias
  condition
  expression
  opt_assignment_right
  function_call_conflict
  function_call_generic
  function_call_keyword
  function_call_nonkeyword
  list_expression
  now
  now_or_signed_literal
  num_val
  opt_as_ci
  opt_else_expression
  opt_expression
  opt_having
  opt_interval
  opt_like_escape
  opt_nls_param
  opt_start_part
  opt_convert_default_value
  opt_where_expression
  range_expression
  set_expr_or_default
  signed_literal
  simple_expr
  start_part
  system_variable
  temporal_literal
  tuple_expression
  upper_bound
  user_variable
  value
  value_expression
  variable

%type <ident>
  alter_algorithm_option_value
  alter_lock_option_value
  auth_plugin
  backend
  character_datatypes
  charset
  charset_keywords
  charset_name
  collation_name
  collation_option
  column_format
  compare
  constraint_constraints
  cursor_attribute
  database_opt_value
  datetime_field
  date_datatypes
  duplicate
  eq_or_assigneq
  explain_synonyms
  from_or_using
  for_locking_clause
  full_join
  hash_range_value
  ident
  ident_or_text
  ilm_policy_name
  ilm_policy_option
  ilm_time_period_option
  immediate_batch
  immediate_deferred
  index_or_key
  index_type
  indexes_or_keys
  inner_join
  insert_or_replace
  int_or_default
  Is_allow
  is_or_as
  is_suffix
  isolation_level
  json_attribute
  lob_datatypes
  lobs_or_tables
  logging_clause
  match_option
  member_of
  merge_insert_types
  native_datatype_element
  natural_join
  non_reserved_keyword
  non_reserved_keyword_ambiguous_1_roles_and_labels
  non_reserved_keyword_ambiguous_2_labels
  non_reserved_keyword_ambiguous_3_roles
  non_reserved_keyword_ambiguous_4_system_variables
  non_reserved_keyword_unambiguous
  numeric_datatypes
  only_write
  opt_analyze_optimize
  opt_array
  opt_asc_desc
  opt_basic_advanced
  opt_cache
  opt_char_byte
  opt_collate
  opt_column
  opt_comma
  opt_constant
  opt_constraint
  opt_constraint_name
  opt_container
  opt_debug
  opt_default
  opt_default_keyword
  opt_distinct
  opt_enable_disable
  opt_equal
  opt_exceptions_clause
  opt_exists
  opt_explain_format
  opt_for
  opt_full
  opt_global
  opt_ident
  opt_ignore
  opt_index_length
  opt_index_or_key
  opt_index_type
  opt_label_name
  opt_link_name
  opt_local
  opt_lock
  opt_low_high
  opt_key_algo
  opt_mode
  opt_month_second
  opt_name
  opt_name_quoted
  opt_nocycle
  opt_not
  opt_not_exists
  opt_not_null
  opt_ordering_direction
  opt_partition
  opt_partitions_num
  opt_pipelined
  opt_place
  opt_privileges
  opt_ref
  opt_replace_password
  opt_restrict
  opt_reuse_settings
  opt_rely_norely
  opt_savepoint
  opt_scope
  opt_securefile_basicfile
  opt_segment
  opt_separator
  opt_specification
  opt_storage
  opt_straight_join
  opt_subpartitions_num
  opt_temporary
  opt_type_attr
  opt_unit_kind
  opt_validate_novalidate
  opt_varray_prefix
  opt_visibility
  opt_wild
  opt_subquery_restriction_clause
  opt_work
  opt_write_clause
  opt_year_day
  ordering_direction
  outer_join
  pipelined_aggregate
  quoted_string
  raw_datatypes
  regular_id
  reserved_ident
  reserved_keyword
  role_ident
  role_ident_or_text
  role_keyword
  row_types
  rowid_datatypes
  segment_group
  sequence_option_value
  serializable_read_committed
  set_op
  sharing_value
  size_clause
  storage_media
  storage_table_clause
  storage_option
  string_list
  text_string
  unit_kind
  unsupported_show_keyword
  view_check_option
  visibility
  wait_nowait
  with_partition

%type <item>
  accessor
  accessor_list
  accessible_by_clause
  account_option
  add_binding_clause
  aliased_table_name
  alter_algorithm_option
  alter_commands_modifier
  alter_commands_modifier_list
  alter_indextype_action
  alter_indextype_action_list
  alter_lock_option
  alter_list
  alter_list_item
  alter_order_item
  alter_order_list
  alter_table_partition_options
  alter_user
  alter_user_list
  array_DML_clause
  alter_view_option
  as_create_query_expression
  attribute
  attribute_list
  opt_table_alias
  assignment_statement
  assignment_target
  auto_increment_attribute
  base_select
  between_bound
  binding_clause
  binding_element
  binding_element_list
  bind_variable
  block
  body
  boolean_value
  bounds_clause
  c_spec
  call_spec
  case_statement
  check_constraint
  close_statement
  col_tuple
  column_attribute
  column_attribute_list
  column_comment_attribute
  column_definition
  column_definition_constraint
  column_key
  column_list
  column_name
  column_type
  comment_list
  common_table_expr
  compiler_parameter_clause
  compiler_parameter_list
  compound_dml_block
  compound_dml_trigger
  constraint_enforcement
  constraint_key_type
  constraint_name
  constraint_names
  constraint_state
  continue_statement
  create_like
  create_partitioning_etc
  create_table_option
  create_table_options_etc
  create_table_options
  create_table_options_space_separated
  create_user
  create_user_list
  cursor_declaration
  cursor_expression
  cursor_manu_statement
  cursor_type_def
  database_option
  datatype_list
  data_type
  datetime_unit
  ddl_force_eof
  declare_spec
  default_attribute
  default_charset
  default_collation
  default_collation_clause
  deferrable_option
  delete_table_list
  delete_table_name
  deterministic
  distributed_by
  dml_event_clause
  dml_event_element
  dml_event_list
  dml_statement
  dml_return
  drop_binding_clause
  dynamic_return
  edition_option
  element
  else_if
  else_if_list
  else_part
  exception_declaration
  exception_handler
  exception_handler_entry
  exception_handler_list
  execute_immediate
  exit_statement
  expression_list
  fetch_statement
  field_def
  field_spec
  field_spec_list
  fk_on_delete
  fk_on_update
  fk_reference_action
  forall_statement
  force_eof
  func_arg_expr
  func_arg_list
  func_return_suffix
  func_return_suffixs
  function_alter_body
  function_body
  function_definition
  function_name
  function_spec
  general_element
  general_element_segment
  general_element_value
  general_element_value_prefix
  global_partitioned_index
  go_to_statement
  grant_ident
  hash_partitions_by_quantity
  hash_partition_quantity
  hint
  hint_list
  id_expression
  id_expression_list
  ident_string_list
  identifier
  identity_attribute
  identity_option
  identity_options
  if_force
  if_statement
  implementation_clause
  ilm_alter_or_on_clause
  ilm_clause
  ilm_compression_policy
  ilm_inmemory_policy
  ilm_policy_clause
  ilm_tiering_policy
  ilm_time_period
  in_or_out_of_line_constraint
  in_or_out_of_line_constraint_list
  index_compression
  index_id
  index_list
  index_name
  index_option
  index_option_list
  index_partitioning_clause
  index_properites
  individual_hash_partition
  individual_hash_partitions
  individual_hash_partition_list
  initially_option
  inline_constraint
  inline_constraint_list
  inline_constraint_options
  inline_ref_constraint
  inmemory_attributes
  inmemory_clause
  ins_column_list
  insert_data
  into_clause
  into_table_name
  into_using
  invoker_rights_clause
  json_on_response
  join_table
  key_list
  key_list_with_expression
  key_part
  key_part_with_expression
  label_declaration
  list_expression_list
  list_type
  list_value_tuple
  lob_item
  lob_partitioning_storage
  loop_id
  loop_param
  loop_statement
  native_type_with_precision
  nested_block
  nested_tab
  null_attribute
  null_statement
  object_attribute_list
  object_body_def
  object_body_def_list
  object_declaration
  object_body_declaration
  object_constraint
  object_constraint_list
  object_name
  object_type_def
  object_type_list
  object_type_spec_def
  object_view_clause
  on_empty
  on_error
  on_update_attribute
  open_for_statement
  open_statement
  operator_spec
  operator_spec_list
  opt_admin_option
  opt_alter_auth_option
  opt_alter_command_list
  opt_alter_table_actions
  opt_as
  opt_ascii
  opt_bequeath_option
  opt_between_bound
  opt_case_else_part
  opt_cascase_constraints
  opt_column_attribute_list
  opt_column_list
  opt_comment
  opt_compiler_parameter_list
  opt_compute_ancillary_data
  opt_conditional
  opt_constraint_enforcement
  opt_constraint_state
  opt_constraint_option
  opt_create_auth_option
  opt_distribution
  opt_create_table_options_etc
  opt_cursor_return
  opt_database_option
  opt_db_from_spec
  opt_declare_spec
  opt_default_bequeath
  opt_default_collation
  opt_default_value_part
  opt_derived_column_list
  opt_dml_event_nested_clause
  opt_duplicate_as_qe
  opt_dynamic_return
  opt_edition_option
  opt_except_role_list
  opt_expression_list
  encrypt_attribute
  opt_fmt
  opt_force
  opt_for_each_row
  opt_public
  opt_for_auery_archive
  opt_fulltext_index_options
  opt_from_clause
  opt_func_datetime_precision
  opt_func_return_suffixs
  opt_grant_as
  opt_grant_option
  opt_group_by
  opt_hierarchical_query_clause
  opt_hint_list
  opt_id_expression
  opt_implementation_clause
  opt_identified_by
  opt_index_hint_list
  opt_index_lock_and_algorithm
  opt_index_name_and_type
  opt_index_option
  opt_index_option_list
  opt_indexing_clause
  opt_initially_option
  opt_identity_options
  opt_inline_constraint_list
  opt_inmemory_attributes
  opt_into_clause
  opt_integrity_algorithm
  opt_is_select
  opt_label_declaration
  opt_limit
  opt_linear
  opt_lob_tablespace_clause
  opt_match_clause
  opt_no_row_level
  opt_no_salt
  opt_object_constraint_list
  opt_object_type
  opt_on_dup
  opt_on_empty_or_error
  opt_on_function
  opt_on_update_delete
  opt_order_by
  opt_parameter_list
  opt_part_list
  opt_partition_by_clause
  opt_partition_definitions
  opt_partition_names
  opt_partition_select
  opt_partition_storage_table_clause
  opt_partition_using
  opt_partitioning_storage_clause
  opt_password_account_option_list
  OptPrecision
  opt_pretty
  opt_proc_return_suffixs
  opt_quantity_compression_option
  opt_quantity_store_clause
  opt_quantity_over_store_clause
  opt_read_only_clause
  opt_ref_list
  opt_references
  opt_referencing_clause
  opt_relies_on_part
  opt_returning_spec
  opt_returning_type
  opt_scan_mode_hint
  opt_segment_group
  opt_unique_keys
  opt_wrapper
  partitioning_storage_list
  partitioning_storage_spec
  search_case_statement
  table_compression
  tablespace_set_clause
  opt_func_arg_list
  opt_select_expression_list
  opt_segment_attributes_clause
  opt_sequence_options
  opt_show_condition
  opt_spatial_index_options
  opt_sub_partition
  session_or_global
  simple_case_statement
  sharing_clause
  opt_sharing_clause
  opt_subpartition_by
  opt_stream_clause
  opt_subtype_range
  opt_table_index
  opt_table_name
  opt_table_name_list
  opt_tablespace_set_clause
  opt_tls_option_list
  opt_to
  opt_trigger_ordering_clause
  opt_trigger_state
  opt_trigger_when_clause
  opt_type_spec
  opt_varray_type_list
  opt_using_encrypt_algorithm
  opt_using_index_clause
  opt_view_force_edition_option
  opt_identified_option
  opt_container_option
  opt_set_role_identified_list
  opt_set_role_identified
  opt_with_clause
  opt_with_roles
  opt_with_validation
  opt_XMLSchema_nonschema_options
  opt_XMLSchema_spec
  opt_XMLSchema_store
  opt_XMLSchema_url
  order
  order_list
  out_of_line_constraint
  package_alter_body
  package_body
  package_obj_body
  package_obj_body_list
  package_obj_spec
  package_obj_spec_list
  package_spec
  parallel_enable_clause
  parameter
  parameter_list
  paren_column_list
  part_list
  partition_by_clause
  partition_clause
  partition_clause_opt
  partition_def_option
  partition_def_option_list
  partition_definition
  partition_definitions
  partition_extension
  partition_names
  partition_names_or_all
  partition_operation
  partition_operation_keyword
  password_account_option_list
  password_option
  physical_attributes
  physical_attributes_clause
  pipe_row_statement
  pl_declaration
  pl_statement
  pl_statements
  plsql_commit_statement
  plsql_rollback_statement
  pragma_declaration
  principal
  principal_list
  privilege
  proc_or_func_name
  proc_return_suffix
  proc_return_suffixs
  procedure_alter_body
  procedure_body
  procedure_definition
  procedure_spec
  raise_statement
  range_expression_list
  range_type
  range_value_tuple
  record_type_def
  references
  referencing_element
  referencing_element_list
  relies_on_part
  reserved_id_expression
  reserved_sql_id
  reserved_table_id
  result_cache_clause
  return_statement
  role
  role_list
  role_or_privilege
  role_or_privilege_list
  row_tuple
  rownum
  save_point_statement
  search_case_when_part
  search_case_when_parts
  select_clause
  select_element
  select_expression
  select_expression_list
  select_limit
  select_no_parens
  select_statement
  select_with_parens
  segment_attributes
  segment_attributes_clause
  sequence_option_def
  sequence_option_key
  sequence_option_ignore_key
  sequence_option_ignore_value
  sequence_options
  seq_of_statements
  set_const_command
  set_expression
  set_list
  set_spec
  set_trans_command
  simple_select
  simple_case_when_part
  simple_case_when_parts
  simple_dml_trigger
  sort_clause
  sql_id
  sql_statement
  standalone_alter_commands
  standalone_alter_table_action
  stream_clause
  storage_clause
  storage_list
  subquery
  subtype_declaration
  sub_part_list
  sub_part_definition
  table_alias
  table_element
  table_element_list
  table_constraint_def
  table_factor
  table_id
  table_name
  table_name_list
  table_reference
  table_references
  table_type_def
  table_view_name
  table_view_names
  tablespace
  tablespace_list
  text_string_list
  tb_from_spec
  timing_point
  timing_point_section
  timing_point_sections
  tls_option
  tls_option_list
  tps_body
  trans_ctrl_statement
  transaction_char
  transaction_chars
  trigger_body
  tuple_list
  tuple_or_empty
  type_declaration
  type_declaration_no_semicolon
  type_spec
  update_expression
  update_list
  user
  user_list
  using_index_clause
  using_clause
  using_element
  using_elements
  using_return
  var_name
  variable_declaration
  variable_name
  variable_scope
  varray_item
  varray_type_def
  varray_type_element
  varray_type_list
  view_as_clause
  view_clause_option
  view_column_list
  when_expression
  when_expression_list
  with_clause
  with_list
  with_validation
  XMLSchema_element
  XMLSchema_spec
  XMLSchema_URL
  XMLType_view_clause
  XMLType_view_expr_list

%type <statement>
  alter_database_statement
  alter_statement
  alter_table_statement
  alter_trigger_statement
  alter_function_statement
  alter_procedure_statement
  alter_package_statement
  alter_role_statement
  alter_server_statement
  alter_user_statement
  alter_view_statement
  alter_indextype_statement
  alter_operator_statement
  anonymous_statement
  begin_statement
  call_statement
  command
  commit_statement
  create_database_statement
  create_index_statement
  create_indextype_statement
  create_role_statement
  create_sequence_statement
  create_server_statement
  create_statement
  create_synonym_statement
  create_table_statement
  create_trigger_statement
  create_user_statement
  create_view_statement
  create_type_statement
  create_type_body_statement
  create_package_statement
  create_package_body_statement
  create_function_statement
  create_procedure_statement
  create_operator_statement
  dcl_statement
  delete_statement
  base_delete
  drop_database_statement
  drop_index_statement
  drop_indextype_statement
  drop_operator_statement
  drop_role_statement
  drop_sequence_statement
  drop_server_statement
  drop_statement
  drop_synonym_statement
  drop_function_statement
  drop_procedure_statement
  drop_package_statement
  drop_package_body_statement
  drop_table_statement
  drop_trigger_statement
  drop_type_statement
  drop_type_body_statement
  drop_user_statement
  drop_view_statement
  explain_statement
  explainable_statement
  grant_statement
  insert_statement
  base_insert
  other_statement
  rename_statement
  revoke_statement
  rollback_statement
  set_password_statement
  set_role_statement
  set_statement
  show_statement
  truncate_statement
  update_statement
  base_update
  use_statement


/***********************************************************************************************************************
 ********************** Operator Precedence and Associativity **********************************************************  
 ********************** Precedence: lowest to highest         **********************************************************
***********************************************************************************************************************/
%nonassoc EMPTY
%left LOWER_THAN_KEYWORD
%nonassoc LOWER_THAN_CREATE_TABLE_SELECT
%left <ident>
  KEYWORD_USED_AS_IDENT

%nonassoc <ident>
  SET

%left <ident>
  UNION
  INTERSECT
  MINUS


/*
  Resolve column attribute ambiguity -- force precedence of "UNIQUE KEY" against 
  simple "UNIQUE" and "KEY" attributes:
*/
%right UNIQUE KEY
%right <ident>
  LOWERTHANORDER

%right <ident>
  ORDER

%left <ident>
  JOIN
  STRAIGHT_JOIN
  LEFT
  RIGHT
  INNER
  OUTER
  CROSS
  NATURAL
  USE
  FORCE

%left <ident>
  ON


// Precedence dictated by mysql. But the vitess grammar is simplified.
// Some of these operators don't conflict in our situation. Nevertheless,
// it's better to have these listed in the correct order. Also, we don't
// support all operators yet.
%nonassoc <ident>
  LOWTHANSTRING

%nonassoc <ident>
  STRING

%left <ident>
  ASSIGN

%left <ident>
  OR

%left <ident>
  AND

%right <ident>
  NOT
  '!'

%left <ident>
  BETWEEN
  CASE
  WHEN
  THEN
  ELSE
  END

%left <ident>
  '='
  '<'
  '>'
  GE
  IN
  IS
  LE
  LIKE
  MEMBER
  NE
  NULL_SAFE_EQUAL
  REGEXP
  EG

%left <ident>
  OP_CONCAT

%left <ident>
  '|'

%left <ident>
  '&'

%left <ident>
  SHIFT_LEFT
  SHIFT_RIGHT

%left <ident>
  '+'
  '-'

%left <ident>
  '*'
  '/'
  DIV
  '%'
  MOD

%left <ident>
  '^'

%right <ident>
  '~'
  UNARY

%left <ident>
  COLLATE

%right <ident>
  BINARY

%right <ident>
  INTERVAL

%right <ident>
  DOUBLE_STAR

%nonassoc <ident>
  '.'

%nonassoc <ident>
  '@'
  '#'

%left SUBQUERY_AS_EXPR

%nonassoc <ident>
  LOWERTHANPARENTHESE

%nonassoc '(' ')'
%nonassoc <ident>
  HIGHERTHANPARENTHESE

%nonassoc <ident>
  LOWERTHANCOMMA

%nonassoc <ident>
  ','


%start any_command

%%

any_command:
  command opt_semicolon
  {
    setParseTree(yylex, $1)
  }

opt_semicolon:
  {}
| ';'
  {}

command:
  select_statement
  {
    $$ = $1.(ast.SelectStatement)
  }
| insert_statement
| update_statement
| delete_statement
| set_statement
| create_statement
| anonymous_statement
| alter_statement
| rename_statement
| drop_statement
| truncate_statement
| show_statement
| use_statement
| begin_statement
| commit_statement
| rollback_statement
| explain_statement
| other_statement
| call_statement
| dcl_statement

dcl_statement:
  grant_statement
| revoke_statement
| drop_user_statement
| create_user_statement
| alter_user_statement
| alter_role_statement
| drop_role_statement
| create_role_statement
| set_password_statement
| set_role_statement

grant_statement:
  GRANT opt_comment role_or_privilege_list TO principal_list opt_admin_option
  {
    comments, _ := getComments($2)
    var roles ast.Principals
    for _, rp := range $3.(ast.RoleOrDynamicPrivs) {
    	if role, ok := rp.(*ast.Principal); ok {
    		roles = append(roles, role)
    	} else if priv, ok := rp.(*ast.Privilege); ok && priv.Type == ast.DynamicPriv {
    		roles = append(roles, ast.NewRole(priv.Name(), "%"))
    	} else {
    		yylex.Error("You have an error in your SQL syntax near role list")
    		return 1
    	}
    }
    $$ = &ast.GrantRevokeStmt{Roles: roles, Principals: $5.(ast.Principals), AdminOption: $6.(bool), Comments: comments}
  }
| GRANT opt_comment ALL opt_privileges ON opt_object_type grant_ident TO principal_list opt_grant_option opt_grant_as
  {
    comments, _ := getComments($2)
    dcl := &ast.GrantRevokeStmt{AllPrivileges: true, ObjectType: $6.(ast.ObjectType).ObjectTypeEnum,
    	PrivLevel: $7.(*ast.PrivLevel), Principals: $9.(ast.Principals), GrantOption: $10.(bool), Comments: comments}
    if $11 != nil {
    	dcl.GrantAs = $11.(*ast.GrantAs)
    }
    dcl.Grant = ast.GLOBAL_ACLS
    if dcl.ObjectType != ast.ObjectTypeTable && len(dcl.Columns) != 0 {
    	yylex.Error("You have an error in your SQL syntax near acl type")
    	return 1
    }
    if err := dcl.ApplyPrivLevel(); err != nil {
    	yylex.Error(err.Error())
    	return 1
    }
    if dcl.GrantOption {
    	dcl.Grant |= ast.GRANT_ACL
    }
    $$ = dcl
  }
| GRANT opt_comment role_or_privilege_list ON opt_object_type grant_ident TO principal_list opt_grant_option opt_grant_as
  {
    comments, _ := getComments($2)
    var privs ast.Privileges
    grantPrivilege := false
    for _, rp := range $3.(ast.RoleOrDynamicPrivs) {
    	if priv, ok := rp.(*ast.Privilege); ok {
    		if priv.Grant == ast.GRANT_ACL {
    			grantPrivilege = true
    		}
    		privs = append(privs, priv)
    	} else {
    		yylex.Error("You have an error in your SQL syntax near privilege list")
    		return 1
    	}
    }
    dcl := &ast.GrantRevokeStmt{Privileges: privs, ObjectType: $5.(ast.ObjectType).ObjectTypeEnum,
    	PrivLevel: $6.(*ast.PrivLevel), Principals: $8.(ast.Principals), GrantOption: $9.(bool), Comments: comments}
    dcl.GrantPrivilege = grantPrivilege
    if $10 != nil {
    	dcl.GrantAs = $10.(*ast.GrantAs)
    }
    if dcl.ApplyPrivileges() {
    	yylex.Error("You have an error in your SQL syntax near privilege list")
    	return 1
    }
    if dcl.ObjectType != ast.ObjectTypeTable && len(dcl.Columns) != 0 {
    	yylex.Error("You have an error in your SQL syntax near acl type")
    	return 1
    }
    if err := dcl.ApplyPrivLevel(); err != nil {
    	yylex.Error(err.Error())
    	return 1
    }
    if dcl.GrantOption {
    	dcl.Grant |= ast.GRANT_ACL
    }
    $$ = dcl
  }

role_or_privilege_list:
  role_or_privilege
  {
    $$ = ast.RoleOrDynamicPrivs{$1.(ast.RoleOrDynamicPriv)}
  }
| role_or_privilege_list ',' role_or_privilege
  {
    dd := $$.(ast.RoleOrDynamicPrivs)
    d3 := $3.(ast.RoleOrDynamicPriv)
    dd = append(dd, d3)
    $$ = dd
  }

role_or_privilege:
  role_ident_or_text
  {
    $$ = ast.NewDynamicPriv($1)
  }
| role_ident_or_text SINGLE_AT_ID
  {
    $$ = ast.NewRole($1, $2)
  }
| privilege

role_ident_or_text:
  STRING
| role_ident

role_ident:
  ID
| role_keyword

role_keyword:
  non_reserved_keyword_unambiguous
| non_reserved_keyword_ambiguous_2_labels
| non_reserved_keyword_ambiguous_4_system_variables

opt_object_type:
  {
    $$ = ast.NewObjectTypeTable()
  }
| TABLE
  {
    $$ = ast.NewObjectTypeTable()
  }
| FUNCTION
  {
    $$ = ast.NewObjectTypeFunc()
  }
| PROCEDURE
  {
    $$ = ast.NewObjectTypeProc()
  }

opt_privileges:
  {}
| PRIVILEGES

privilege:
  SELECT opt_column_list
  {
    var cols ast.Columns
    if $2 != nil {
    	cols = $2.(ast.Columns)
    }
    $$ = ast.NewStaticPriv(ast.SelectPriv, ast.SELECT_ACL, cols)
  }
| INSERT opt_column_list
  {
    var cols ast.Columns
    if $2 != nil {
    	cols = $2.(ast.Columns)
    }
    $$ = ast.NewStaticPriv(ast.InsertPriv, ast.INSERT_ACL, cols)
  }
| UPDATE opt_column_list
  {
    var cols ast.Columns
    if $2 != nil {
    	cols = $2.(ast.Columns)
    }
    $$ = ast.NewStaticPriv(ast.UpdatePriv, ast.UPDATE_ACL, cols)
  }
| REFERENCES opt_column_list
  {
    var cols ast.Columns
    if $2 != nil {
    	cols = $2.(ast.Columns)
    }
    $$ = ast.NewStaticPriv(ast.ReferencesPriv, ast.REFERENCES_ACL, cols)
  }
| DELETE
  {
    $$ = ast.NewStaticPriv(ast.DeletePriv, ast.DELETE_ACL, nil)
  }
| USAGE
  {
    $$ = ast.NewStaticPriv("usage", 0, nil)
  }
| INDEX
  {
    $$ = ast.NewStaticPriv(ast.IndexPriv, ast.INDEX_ACL, nil)
  }
| ALTER
  {
    $$ = ast.NewStaticPriv(ast.AlterPriv, ast.ALTER_ACL, nil)
  }
| CREATE
  {
    $$ = ast.NewStaticPriv(ast.CreatePriv, ast.CREATE_ACL, nil)
  }
| DROP
  {
    $$ = ast.NewStaticPriv(ast.DropPriv, ast.DROP_ACL, nil)
  }
| EXECUTE
  {
    $$ = ast.NewStaticPriv(ast.ExecutePriv, ast.EXECUTE_ACL, nil)
  }
| RELOAD
  {
    $$ = ast.NewStaticPriv(ast.ReloadPriv, ast.RELOAD_ACL, nil)
  }
| SHUTDOWN
  {
    $$ = ast.NewStaticPriv(ast.ShutdownPriv, ast.SHUTDOWN_ACL, nil)
  }
| PROCESS
  {
    $$ = ast.NewStaticPriv(ast.ProcessPriv, ast.PROCESS_ACL, nil)
  }
| FILE
  {
    $$ = ast.NewStaticPriv(ast.FilePriv, ast.FILE_ACL, nil)
  }
| GRANT OPTION
  {
    $$ = ast.NewStaticPriv("grant option", ast.GRANT_ACL, nil)
  }
| SHOW DATABASES
  {
    $$ = ast.NewStaticPriv(ast.ShowDatabasesPriv, ast.SHOW_DB_ACL, nil)
  }
| SUPER
  {
    $$ = ast.NewStaticPriv(ast.SuperPriv, ast.SUPER_ACL, nil)
  }
| CREATE TEMPORARY TABLES
  {
    $$ = ast.NewStaticPriv(ast.CreateTemporaryTablesPriv, ast.CREATE_TMP_ACL, nil)
  }
| LOCK TABLES
  {
    $$ = ast.NewStaticPriv(ast.LockTablesPriv, ast.LOCK_TABLES_ACL, nil)
  }
| REPLICATION SLAVE
  {
    $$ = ast.NewStaticPriv(ast.ReplicationSlavePriv, ast.REPL_SLAVE_ACL, nil)
  }
| REPLICATION CLIENT
  {
    $$ = ast.NewStaticPriv(ast.ReplicationClientPriv, ast.REPL_CLIENT_ACL, nil)
  }
| CREATE VIEW
  {
    $$ = ast.NewStaticPriv(ast.CreateViewPriv, ast.CREATE_VIEW_ACL, nil)
  }
| SHOW VIEW
  {
    $$ = ast.NewStaticPriv(ast.ShowViewPriv, ast.SHOW_VIEW_ACL, nil)
  }
| CREATE ROUTINE
  {
    $$ = ast.NewStaticPriv(ast.CreateRoutinePriv, ast.CREATE_PROC_ACL, nil)
  }
| ALTER ROUTINE
  {
    $$ = ast.NewStaticPriv(ast.AlterRoutinePriv, ast.ALTER_PROC_ACL, nil)
  }
| CREATE USER
  {
    $$ = ast.NewStaticPriv(ast.CreateUserPriv, ast.CREATE_USER_ACL, nil)
  }
| EVENT
  {
    $$ = ast.NewStaticPriv(ast.EventPriv, ast.EVENT_ACL, nil)
  }
| TRIGGER
  {
    $$ = ast.NewStaticPriv(ast.TriggerPriv, ast.TRIGGER_ACL, nil)
  }
| CREATE TABLESPACE
  {
    $$ = ast.NewStaticPriv(ast.CreateTablespacePriv, ast.CREATE_TABLESPACE_ACL, nil)
  }
| CREATE ROLE
  {
    $$ = ast.NewStaticPriv(ast.CreateRolePriv, ast.CREATE_ROLE_ACL, nil)
  }
| DROP ROLE
  {
    $$ = ast.NewStaticPriv(ast.DropRolePriv, ast.DROP_ROLE_ACL, nil)
  }

opt_column_list:
  {
    $$ = nil
  }
| openb ins_column_list closeb
  {
    $$ = $2
  }

grant_ident:
  '*'
  {
    $$ = &ast.PrivLevel{MissingSchema: true, TableName: ast.NewTableName("", "")}
  }
| '*' '.' '*'
  {
    $$ = &ast.PrivLevel{TableName: ast.NewTableName("", "")}
  }
| table_id '.' '*'
  {
    $$ = &ast.PrivLevel{TableName: ast.NewTableName2($1.(ast.TableIdent), ast.NewTableIdent(""))}
  }
| table_id '.' table_id
  {
    $$ = &ast.PrivLevel{TableName: ast.NewTableName2($1.(ast.TableIdent), $3.(ast.TableIdent))}
  }
| table_id
  {
    $$ = &ast.PrivLevel{MissingSchema: true, TableName: ast.NewTableName2(ast.NewTableIdent(""), $1.(ast.TableIdent))}
  }

opt_set_role_identified_list:
  opt_set_role_identified
  {
    $$ = ast.RolesIdentifiedOptions{$1.(*ast.RoleIdentifiedOptions)}
  }
| opt_set_role_identified_list ',' opt_set_role_identified
  {
    dd := $$.(ast.RolesIdentifiedOptions)
    d3 := $3.(*ast.RoleIdentifiedOptions)
    dd = append(dd, d3)
    $$ = dd
  }

opt_set_role_identified:
  principal
  {
    $$ = ast.NewRoleIdentifiedOptions($1.(*ast.Principal), false, "")
  }
| principal IDENTIFIED BY ident
  {
    $$ = ast.NewRoleIdentifiedOptions($1.(*ast.Principal), true, $4)
  }

principal_list:
  principal
  {
    $$ = ast.Principals{$1.(*ast.Principal)}
  }
| principal_list ',' principal
  {
    dd := $$.(ast.Principals)
    d3 := $3.(*ast.Principal)
    dd = append(dd, d3)
    $$ = dd
  }

principal:
  ident_or_text
  {
    $$ = ast.NewPrincipal($1, "%")
  }
| ident_or_text SINGLE_AT_ID
  {
    $$ = ast.NewPrincipal($1, $2)
  }

user_list:
  user
  {
    $$ = ast.Principals{$1.(*ast.Principal)}
  }
| user_list ',' user
  {
    dd := $$.(ast.Principals)
    d3 := $3.(*ast.Principal)
    dd = append(dd, d3)
    $$ = dd
  }

user:
  ident_or_text
  {
    $$ = ast.NewUser($1, "%")
  }
| ident_or_text SINGLE_AT_ID
  {
    $$ = ast.NewUser($1, $2)
  }

role_list:
  role
  {
    $$ = ast.Principals{$1.(*ast.Principal)}
  }
| role_list ',' role
  {
    dd := $$.(ast.Principals)
    d3 := $3.(*ast.Principal)
    dd = append(dd, d3)
    $$ = dd
  }

role:
  role_ident_or_text
  {
    $$ = ast.NewRole($1, "%")
  }
| role_ident_or_text SINGLE_AT_ID
  {
    $$ = ast.NewRole($1, $2)
  }

create_user_list:
  create_user
  {
    $$ = ast.Principals{$1.(*ast.Principal)}
  }
| create_user_list ',' create_user
  {
    dd := $$.(ast.Principals)
    d3 := $3.(*ast.Principal)
    dd = append(dd, d3)
    $$ = dd
  }

create_user:
  user opt_create_auth_option
  {
    user := $1.(*ast.Principal)
    if $2 != nil {
    	user.SetAuthOption($2.(*ast.AuthOption))
    }
    $$ = user
  }

alter_user_list:
  alter_user
  {
    $$ = ast.Principals{$1.(*ast.Principal)}
  }
| alter_user_list ',' alter_user
  {
    dd := $$.(ast.Principals)
    d3 := $3.(*ast.Principal)
    dd = append(dd, d3)
    $$ = dd
  }

alter_user:
  user opt_alter_auth_option
  {
    user := $1.(*ast.Principal)
    if $2 != nil {
    	user.SetAuthOption($2.(*ast.AuthOption))
    }
    $$ = user
  }

opt_create_auth_option:
  {
    $$ = nil
  }
| IDENTIFIED BY STRING
  {
    $$ = ast.NewAuthOption(true, true, false, $3, "", "")
  }
| IDENTIFIED WITH auth_plugin
  {
    $$ = ast.NewAuthOption(false, false, false, "", "", $3)
  }
| IDENTIFIED WITH auth_plugin BY STRING
  {
    $$ = ast.NewAuthOption(true, true, false, $5, "", $3)
  }
| IDENTIFIED WITH auth_plugin AS STRING
  {
    $$ = ast.NewAuthOption(true, false, false, $5, "", $3)
  }

opt_alter_auth_option:
  opt_create_auth_option
| IDENTIFIED BY STRING REPLACE STRING
  {
    $$ = ast.NewAuthOption(true, true, true, $3, $5, "")
  }
| IDENTIFIED WITH auth_plugin BY STRING REPLACE STRING
  {
    $$ = ast.NewAuthOption(true, true, true, $5, $7, $3)
  }

auth_plugin:
  sql_id
  {
    $$ = $1.(ast.ColIdent).String()
  }
| STRING

opt_tls_option_list:
  {
    $$ = nil
  }
| REQUIRE NONE
  {
    $$ = ast.TlsOptions{&ast.TlsOption{Type: ast.NoneStr}}
  }
| REQUIRE SSL
  {
    $$ = ast.TlsOptions{&ast.TlsOption{Type: ast.SslStr}}
  }
| REQUIRE X509
  {
    $$ = ast.TlsOptions{&ast.TlsOption{Type: ast.X509Str}}
  }
| REQUIRE tls_option_list
  {
    $$ = $2
  }

tls_option_list:
  tls_option
  {
    $$ = ast.TlsOptions{$1.(*ast.TlsOption)}
  }
| tls_option_list tls_option
  {
    dd := $$.(ast.TlsOptions)
    d2 := $2.(*ast.TlsOption)
    dd = append(dd, d2)
    $$ = dd
  }
| tls_option_list AND tls_option
  {
    dd := $$.(ast.TlsOptions)
    d3 := $3.(*ast.TlsOption)
    dd = append(dd, d3)
    $$ = dd
  }

tls_option:
  ISSUER STRING
  {
    $$ = &ast.TlsOption{Type: ast.IssuerStr, Val: $2}
  }
| SUBJECT STRING
  {
    $$ = &ast.TlsOption{Type: ast.SubjectStr, Val: $2}
  }

opt_password_account_option_list:
  {
    $$ = nil
  }
| password_account_option_list

password_account_option_list:
  PASSWORD password_option
  {
    $$ = ast.PasswordAccountOptions{$2.(*ast.PasswordAccountOption)}
  }
| ACCOUNT account_option
  {
    $$ = ast.PasswordAccountOptions{$2.(*ast.PasswordAccountOption)}
  }
| FAILED_LOGIN_ATTEMPTS INTEGRAL
  {
    $$ = ast.PasswordAccountOptions{&ast.PasswordAccountOption{Type: ast.FailedLoginAttemptsStr, Val: ast.NewIntValV2($2)}}
  }
| PASSWORD_LOCK_TIME INTEGRAL
  {
    $$ = ast.PasswordAccountOptions{&ast.PasswordAccountOption{Type: ast.PasswordLockTimeStr, Val: ast.NewIntValV2($2)}}
  }
| PASSWORD_LOCK_TIME UNBOUNDED
  {
    $$ = ast.PasswordAccountOptions{&ast.PasswordAccountOption{Type: ast.PasswordLockTimeStr, Spec: true}}
  }
| password_account_option_list PASSWORD password_option
  {
    dd := $$.(ast.PasswordAccountOptions)
    d3 := $3.(*ast.PasswordAccountOption)
    dd = append(dd, d3)
    $$ = dd
  }
| password_account_option_list ACCOUNT account_option
  {
    dd := $$.(ast.PasswordAccountOptions)
    d3 := $3.(*ast.PasswordAccountOption)
    dd = append(dd, d3)
    $$ = dd
  }
| password_account_option_list FAILED_LOGIN_ATTEMPTS INTEGRAL
  {
    dd := $$.(ast.PasswordAccountOptions)
    dd = append(dd, &ast.PasswordAccountOption{Type: ast.FailedLoginAttemptsStr, Val: ast.NewIntValV2($3)})
    $$ = dd
  }
| password_account_option_list PASSWORD_LOCK_TIME INTEGRAL
  {
    dd := $$.(ast.PasswordAccountOptions)
    dd = append(dd, &ast.PasswordAccountOption{Type: ast.PasswordLockTimeStr, Val: ast.NewIntValV2($3)})
    $$ = dd
  }
| password_account_option_list PASSWORD_LOCK_TIME UNBOUNDED
  {
    dd := $$.(ast.PasswordAccountOptions)
    dd = append(dd, &ast.PasswordAccountOption{Type: ast.PasswordLockTimeStr, Spec: true})
    $$ = dd
  }

password_option:
  EXPIRE
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordExpireStr, Empty: true}
  }
| EXPIRE DEFAULT
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordExpireStr, Default: true}
  }
| EXPIRE NEVER
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordExpireStr, Spec: true}
  }
| EXPIRE INTERVAL INTEGRAL DAY
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordExpireStr, Val: ast.NewIntValV2($3)}
  }
| HISTORY DEFAULT
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordHistoryStr, Default: true}
  }
| HISTORY INTEGRAL
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordHistoryStr, Val: ast.NewIntValV2($2)}
  }
| REUSE INTERVAL DEFAULT
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordReuseIntervalStr, Default: true}
  }
| REUSE INTERVAL INTEGRAL DAY
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordReuseIntervalStr, Val: ast.NewIntValV2($3)}
  }
| REQUIRE CURRENT
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordRequireCurrentStr, Empty: true}
  }
| REQUIRE CURRENT DEFAULT
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordRequireCurrentStr, Default: true}
  }
| REQUIRE CURRENT OPTIONAL
  {
    $$ = &ast.PasswordAccountOption{Type: ast.PasswordRequireCurrentStr, Val: ast.NewSQLBoolVal(false)}
  }

account_option:
  LOCK
  {
    $$ = &ast.PasswordAccountOption{Type: ast.AccountStr, Val: ast.NewSQLBoolVal(true)}
  }
| UNLOCK
  {
    $$ = &ast.PasswordAccountOption{Type: ast.AccountStr, Val: ast.NewSQLBoolVal(false)}
  }

opt_grant_option:
  {
    $$ = false
  }
| WITH GRANT OPTION
  {
    $$ = true
  }

opt_grant_as:
  {
    $$ = nil
  }
| AS user opt_with_roles
  {
    dd := $3.(*ast.GrantAs)
    dd.User = $2.(ast.Principal)
    $$ = dd
  }

opt_with_roles:
  {
    $$ = &ast.GrantAs{RoleType: ast.RoleNone}
  }
| WITH ROLE role_list
  {
    $$ = &ast.GrantAs{RoleType: ast.RoleName}
  }
| WITH ROLE ALL opt_except_role_list
  {
    $$ = &ast.GrantAs{RoleType: ast.RoleAll, Roles: $4.(ast.Principals)}
  }
| WITH ROLE NONE
  {
    $$ = &ast.GrantAs{RoleType: ast.RoleNone}
  }
| WITH ROLE DEFAULT
  {
    $$ = &ast.GrantAs{RoleType: ast.RoleDefault}
  }

opt_except_role_list:
  {
    $$ = nil
  }
| EXCEPT role_list
  {
    $$ = $2
  }

opt_admin_option:
  {
    $$ = false
  }
| WITH ADMIN OPTION
  {
    $$ = true
  }

revoke_statement:
  REVOKE opt_comment role_or_privilege_list FROM principal_list
  {
    comments, _ := getComments($2)
    var roles ast.Principals
    for _, rp := range $3.(ast.RoleOrDynamicPrivs) {
    	if role, ok := rp.(*ast.Principal); ok {
    		roles = append(roles, role)
    	} else if priv, ok := rp.(*ast.Privilege); ok && priv.Type == ast.DynamicPriv {
    		roles = append(roles, ast.NewRole(priv.Name(), "%"))
    	} else {
    		yylex.Error("You have an error in your SQL syntax near role list")
    		return 1
    	}
    }
    $$ = &ast.GrantRevokeStmt{RevokeGrant: true, Roles: roles, Principals: $5.(ast.Principals), Comments: comments}
  }
| REVOKE opt_comment role_or_privilege_list ON opt_object_type grant_ident FROM principal_list
  {
    comments, _ := getComments($2)
    grantPrivilege := false
    var privs ast.Privileges
    for _, rp := range $3.(ast.RoleOrDynamicPrivs) {
    	if priv, ok := rp.(*ast.Privilege); ok {
    		if priv.Grant == ast.GRANT_ACL {
    			grantPrivilege = true
    		}
    		privs = append(privs, priv)
    	} else {
    		yylex.Error("You have an error in your SQL syntax near privilege list")
    		return 1
    	}
    }
    dcl := &ast.GrantRevokeStmt{RevokeGrant: true, Privileges: privs, ObjectType: $5.(ast.ObjectType).ObjectTypeEnum, PrivLevel: $6.(*ast.PrivLevel), Principals: $8.(ast.Principals), Comments: comments}
    dcl.GrantPrivilege = grantPrivilege

    if dcl.ApplyPrivileges() {
    	yylex.Error("You have an error in your SQL syntax privilege list")
    	return 1
    }
    if dcl.ObjectType != ast.ObjectTypeTable && len(dcl.Columns) != 0 {
    	yylex.Error("You have an error in your SQL syntax acl type")
    	return 1
    }
    if err := dcl.ApplyPrivLevel(); err != nil {
    	yylex.Error(err.Error())
    	return 1
    }
    if dcl.Grant == ast.GLOBAL_ACLS {
    	dcl.RevokeAll = true
    }
    $$ = dcl
  }
| REVOKE opt_comment ALL opt_privileges ON opt_object_type grant_ident FROM principal_list
  {
    comments, _ := getComments($2)
    dcl := &ast.GrantRevokeStmt{RevokeGrant: true, ObjectType: $6.(ast.ObjectType).ObjectTypeEnum, PrivLevel: $7.(*ast.PrivLevel), Principals: $9.(ast.Principals), Comments: comments}
    dcl.AllPrivileges = true
    dcl.Grant = ast.GLOBAL_ACLS
    if dcl.ObjectType != ast.ObjectTypeTable && len(dcl.Columns) != 0 {
    	yylex.Error("You have an error in your SQL syntax near acl type")
    	return 1
    }
    if err := dcl.ApplyPrivLevel(); err != nil {
    	yylex.Error(err.Error())
    	return 1
    }
    if dcl.Grant == ast.GLOBAL_ACLS & ^ast.GRANT_ACL {
    	dcl.RevokeAll = true
    }
    $$ = dcl
  }
| REVOKE opt_comment ALL opt_privileges ',' GRANT OPTION FROM principal_list
  {
    comments, _ := getComments($2)
    $$ = &ast.GrantRevokeStmt{RevokeGrant: true, Principals: $9.(ast.Principals), Comments: comments}
  }

drop_user_statement:
  DROP USER opt_exists user_list
  {
    var exists bool
    if $3 != "false" {
    	exists = true
    }

    $$ = &ast.DropUserRoleStmt{Principals: $4.(ast.Principals), IfExists: exists}
  }

create_user_statement:
  CREATE USER opt_not_exists create_user_list opt_tls_option_list opt_password_account_option_list
  {
    var notExists bool
    if $3 != "false" {
    	notExists = true
    }
    dcl := &ast.CreateUserRoleStmt{Principals: $4.(ast.Principals), IfNotExists: notExists}
    if $5 != nil {
    	dcl.TlsOptions = $5.(ast.TlsOptions)
    }
    if $6 != nil {
    	dcl.PasswordAccountOptions = $6.(ast.PasswordAccountOptions)
    }

    $$ = dcl
  }

alter_user_statement:
  ALTER USER opt_exists alter_user_list opt_tls_option_list opt_password_account_option_list
  {
    var exists bool
    if $3 != "false" {
    	exists = true
    }
    dcl := &ast.AlterUserStmt{Users: $4.(ast.Principals), IfExists: exists}
    if $5 != nil {
    	dcl.TlsOptions = $5.(ast.TlsOptions)
    }
    if $6 != nil {
    	dcl.PasswordAccountOptions = $6.(ast.PasswordAccountOptions)
    }

    $$ = dcl
  }

alter_role_statement:
  ALTER ROLE role_list opt_identified_option opt_container_option
  {
    $$ = &ast.AlterRoleStmt{Roles: $3.(ast.Principals), Identified: $4.(*ast.IdentifiedOption), Container: $5.(ast.ContainerOption)}
  }

set_role_statement:
  SET opt_comment ROLE ALL opt_except_role_list
  {
    var ExceptRoles ast.Principals
    var HasExcept bool
    HasExcept = false
    if $5 != nil {
        ExceptRoles = $5.(ast.Principals)
        HasExcept = true
    }
    $$ = &ast.SetRoleStmt{IsAll: true, HasExcept: HasExcept, ExceptRoles: ExceptRoles}
  }
| SET opt_comment ROLE opt_set_role_identified_list
  {
    $$ = &ast.SetRoleStmt{IsIdentified: true, Rolesidentified: $4.(ast.RolesIdentifiedOptions)}
  }

drop_role_statement:
  DROP ROLE role_list
  {
    $$ = &ast.DropUserRoleStmt{Principals: $3.(ast.Principals), RoleUser: true, IsOracle: true}
  }

create_role_statement:
  CREATE ROLE role_list opt_identified_option opt_container_option
  {
    $$ = &ast.CreateUserRoleStmt{Principals: $3.(ast.Principals), RoleUser: true, Identified: $4.(*ast.IdentifiedOption), Container: $5.(ast.ContainerOption), IsOracle: true}
  }

set_password_statement:
  SET opt_comment PASSWORD '=' STRING opt_replace_password
  {
    user := ast.NewUser("", "")
    replace := false
    current := ""
    if $6 != "" {
    	replace = true
    	current = $6
    }
    user.SetAuthOption(ast.NewAuthOption(true, true, replace, $5, current, ""))
    $$ = &ast.SetPasswordStmt{User: user}
  }
| SET opt_comment PASSWORD FOR user '=' STRING opt_replace_password
  {
    user := $5.(*ast.Principal)
    replace := false
    current := ""
    if $8 != "" {
    	replace = true
    	current = $8
    }
    user.SetAuthOption(ast.NewAuthOption(true, true, replace, $7, current, ""))
    $$ = &ast.SetPasswordStmt{User: user}
  }

select_statement:
  select_no_parens
| select_with_parens
| SELECT opt_comment NEXT num_val FOR table_name
  {
    comments, _ := getComments($2)
    seqName := &ast.ColName{Qualifier: ast.TableName{Name: $6.(ast.TableName).Qualifier}, Name: ast.NewColIdent($6.(ast.TableName).Name.String())}
    nextval := &ast.FuncExpr{Name: ast.NewColIdent("nextval"), Exprs: ast.SelectExprs{&ast.AliasedExpr{Expr: seqName, OptAs: false}}}
    setHasSequenceUpdateNode(yylex, true)
    selectExpr := &ast.AliasedExpr{Expr: nextval, OptAs: false}
    dual := ast.TableExprs{&ast.AliasedTableExpr{Expr: ast.TableName{Name: ast.NewTableIdent("dual")}}}
    $$ = &ast.Select{
    	Comments:    comments,
    	SelectExprs: ast.SelectExprs{selectExpr},
    	From:        dual,
    }
  }

select_with_parens:
  '(' select_no_parens ')'
  {
    $$ = &ast.ParenSelect{Select: $2.(ast.SelectStatement)}
  }
| '(' select_with_parens ')'
  {
    $$ = &ast.ParenSelect{Select: $2.(ast.SelectStatement)}
  }

/*
 * This rule parses the equivalent of the standard's <query expression>.
 * The duplicative productions are annoying, but hard to get rid of without
 * creating shift/reduce conflicts.
 *
 *	The locking clause (FOR UPDATE etc) may be before or after LIMIT/OFFSET.
 *	In <=7.2.X, LIMIT/OFFSET had to be after FOR UPDATE
 *	We now support both orderings, but prefer LIMIT/OFFSET before the locking
 * clause.
 *	2002-08-28 bjm
 */
select_no_parens:
  simple_select
| select_clause sort_clause
  {
    sel := $1.(ast.SelectStatement)
    orderBy := $2.(ast.OrderBy)
    sel.AddOrderBy(orderBy)
    $$ = sel
  }
| select_clause opt_order_by for_locking_clause opt_limit
  {
    sel := $1.(ast.SelectStatement)
    var orderBy ast.OrderBy
    if $2 != nil {
    	orderBy = $2.(ast.OrderBy)
    }
    sel.AddOrderBy(orderBy)
    sel.AddLock($3)
    var limit *ast.Limit
    if $4 != nil {
    	limit = $4.(*ast.Limit)
    }
    sel.SetLimit(limit)
    $$ = sel
  }
| select_clause opt_order_by select_limit opt_lock
  {
    sel := $1.(ast.SelectStatement)
    var orderBy ast.OrderBy
    if $2 != nil {
    	orderBy = $2.(ast.OrderBy)
    }
    sel.AddOrderBy(orderBy)
    var limit *ast.Limit
    if $3 != nil {
    	limit = $3.(*ast.Limit)
    }
    sel.SetLimit(limit)
    if $4 != "" {
    	sel.AddLock($4)
    }
    $$ = sel
  }

select_clause:
  simple_select
| select_with_parens

/*
 * This rule parses SELECT statements that can appear within set operations,
 * including UNION, INTERSECT and EXCEPT.  '(' and ')' can be used to specify
 * the ordering of the set operations.	Without '(' and ')' we want the
 * operations to be ordered per the precedence specs at the head of this file.
 *
 * As with select_no_parens, simple_select cannot have outer parentheses,
 * but can have parenthesized subclauses.
 *
 * Note that sort clauses cannot be included at this level --- SQL requires
 *		SELECT foo UNION SELECT bar ORDER BY baz
 * to be parsed as
 *		(SELECT foo UNION SELECT bar) ORDER BY baz
 * not
 *		SELECT foo UNION (SELECT bar ORDER BY baz)
 * Likewise for WITH, FOR UPDATE and LIMIT.  Therefore, those clauses are
 * described as part of the select_no_parens production, not simple_select.
 * This does not limit functionality, because you can reintroduce these
 * clauses inside parentheses.
 *
 * NOTE: only the leftmost component SelectStmt should have INTO.
 * However, this is not checked by the grammar; parse analysis must check it.
 */
simple_select:
  base_select
| with_clause base_select
  {
     sel := $2.(ast.SelectStatement)
     sel.SetWith($1.(*ast.WithClause))
     $$ = sel
  }
| select_clause set_op select_clause %prec SET
  {
    $$ = &ast.SetOp{Type: $2, Left: $1.(ast.SelectStatement), Right: $3.(ast.SelectStatement)}
  }

opt_nocycle:
  {
    $$ = ""
  }
| NOCYCLE

start_part:
  START WITH condition
  {
    $$ = $3
  }

opt_start_part:
  {
    $$ = nil
  }
| start_part

opt_hierarchical_query_clause:
  {
    $$ = nil
  }
| CONNECT BY opt_nocycle condition opt_start_part
  {
    $$ = &ast.HierarchicalQueryClause{IsStartFirstly: false, OptNocycle: $3, Condition: $4, OptStartPart: $5}
  }
| start_part CONNECT BY opt_nocycle condition
  {
    $$ = &ast.HierarchicalQueryClause{IsStartFirstly: true, OptStartPart: $1, OptNocycle: $4, Condition: $5}
  }

// base_select is an unparenthesized SELECT with no order by clause or beyond.
base_select:
  SELECT opt_comment opt_cache opt_distinct opt_straight_join opt_hint_list select_expression_list opt_into_clause opt_from_clause opt_where_expression opt_hierarchical_query_clause opt_group_by opt_having
  {
    comments, _ := getComments($2)
    var hints ast.Hints
    if $6 != nil {
    	hints = $6.(ast.Hints)
    }
    var d8 *ast.IntoClause
    if $8 != nil {
    	d8 = $8.(*ast.IntoClause)
    }
   var d9 ast.TableExprs
    if $9 != nil {
      d9 = $9.(ast.TableExprs)
    }
    var hierarchical *ast.HierarchicalQueryClause
    if $11 != nil {
    	hierarchical = $11.(*ast.HierarchicalQueryClause)
    }
    var d12 ast.Exprs
    if $12 != nil {
    	d12 = $12.(ast.Exprs)
    }
    groupBy := ast.NewGroupBy(d12, false)
    $$ = &ast.Select{Comments: comments, Cache: $3, Distinct: $4, Hints: $5, ExtraHints: hints, SelectExprs: $7.(ast.SelectExprs), IntoClause: d8, From: d9, Where: ast.NewWhere(ast.TypWhere, $10), Hierarchical: hierarchical, GroupBy: groupBy, Having: ast.NewWhere(ast.TypHaving, $13)}
  }

with_clause:
  WITH with_list
  {
    $$ = &ast.WithClause{OptRecursive: false, CommonTableExprs: $2.(ast.CommonTableExprs)}
  }
| WITH RECURSIVE with_list
  {
    $$ = &ast.WithClause{OptRecursive: true, CommonTableExprs: $3.(ast.CommonTableExprs)}
  }

with_list:
  common_table_expr
  {
    $$ = ast.CommonTableExprs{$1.(*ast.CommonTableExpr)}
  }
| with_list ',' common_table_expr
  {
    $$ = append($1.(ast.CommonTableExprs), $3.(*ast.CommonTableExpr))
  }

common_table_expr:
  ident opt_derived_column_list AS subquery
  {
    $$ = &ast.CommonTableExpr{Name: string($1), ColNames: $2.([]string), Subquery: $4.(*ast.Subquery)}
  }

opt_derived_column_list:
  /*empty*/
  {
    $$ = []string{};
  }
| openb ident_string_list closeb
  {
    $$ = $2;
  }

insert_statement:
  base_insert dml_return
  {
    insert := $1.(*ast.Insert)
    insert.OptReturnInto = $2.(*ast.DMLReturnInto)
    $$ = insert
  }
| base_insert

base_insert:
  insert_or_replace opt_comment opt_ignore into_table_name insert_data opt_on_dup
  {
    // insert_data returns a *ast.Insert pre-filled with Columns & Values
    comments, _ := getComments($2)
    ins := $5.(*ast.Insert)
    ins.Action = $1
    ins.Comments = comments
    ins.Ignore = $3
    ins.Table = $4.(ast.TableName)
    var updateExprs ast.UpdateExprs
    if $6 != nil {
    	updateExprs = $6.(ast.UpdateExprs)
    }
    ins.OnDup = ast.OnDup(updateExprs)
    $$ = ins
  }
| insert_or_replace opt_comment opt_ignore into_table_name SET update_list opt_on_dup
  {
    comments, _ := getComments($2)
    cols := make(ast.Columns, 0, len($6.(ast.UpdateExprs)))
    var updateExprs ast.UpdateExprs
    if $7 != nil {
    	updateExprs = $7.(ast.UpdateExprs)
    }
    vals := make(ast.ValTuple, 0, len(updateExprs))
    for _, updateList := range $6.(ast.UpdateExprs) {
    	cols = append(cols, updateList.Name.Name)
    	vals = append(vals, updateList.Expr)
    }
    $$ = &ast.Insert{Action: $1, Comments: comments, Ignore: $3, Table: $4.(ast.TableName), Columns: cols, Rows: ast.Values{vals}, OnDup: ast.OnDup(updateExprs)}
  }

insert_or_replace:
  INSERT
  {
    $$ = ast.InsertStr
  }
| REPLACE
  {
    $$ = ast.ReplaceStr
  }

opt_with_clause:
  {
    $$ = nil
  }
| with_clause
  {
    $$ = $1.(*ast.WithClause)
  }


update_statement:
  base_update
| base_update dml_return
  {
    update := $1.(*ast.Update)
    update.OptReturnInto = $2.(*ast.DMLReturnInto)
    $$ = update
  }

base_update:
  opt_with_clause UPDATE opt_comment table_references SET update_list opt_where_expression opt_order_by opt_limit
  {
    var with *ast.WithClause
    if $1 != nil {
	with = $1.(*ast.WithClause)
    }
    comments, _ := getComments($3)
    var orderBy ast.OrderBy
    if $8 != nil {
    	orderBy = $8.(ast.OrderBy)
    }
    var limit *ast.Limit
    if $9 != nil {
    	limit = $9.(*ast.Limit)
    }
    $$ = &ast.Update{Comments: comments, TableExprs: $4.(ast.TableExprs), Exprs: $6.(ast.UpdateExprs), Where: ast.NewWhere(ast.TypWhere, $7), OrderBy: orderBy, Limit: limit, With: with}
  }

delete_statement:
  opt_with_clause base_delete dml_return
  {
    var with *ast.WithClause
    if $1 != nil {
    	with = $1.(*ast.WithClause)
    }
    delete := $2.(*ast.Delete)
    delete.OptReturnInto = $3.(*ast.DMLReturnInto)
    delete.With = with
    $$ = delete
  }
| opt_with_clause base_delete
 {
    var with *ast.WithClause
    if $1 != nil {
    	with = $1.(*ast.WithClause)
    }
    delete := $2.(*ast.Delete)
    delete.With = with
    $$ = delete
  }


base_delete:
  DELETE opt_comment FROM table_name opt_table_alias opt_where_expression opt_order_by opt_limit
  {
    comments, _ := getComments($2)
    var orderBy ast.OrderBy
    if $7 != nil {
    	orderBy = $7.(ast.OrderBy)
    }
    var limit *ast.Limit
    if $8 != nil {
    	limit = $8.(*ast.Limit)
    }
    $$ = &ast.Delete{Comments: comments, TableExprs: ast.TableExprs{&ast.AliasedTableExpr{Expr: $4.(ast.SimpleTableExpr), As: $5.(ast.TableIdent)}}, Where: ast.NewWhere(ast.TypWhere, $6), OrderBy: orderBy, Limit: limit}
  }
| DELETE opt_comment table_name opt_table_alias opt_where_expression opt_order_by opt_limit
  {
     comments, _ := getComments($2)
     var orderBy ast.OrderBy
     if $6 != nil {
    	orderBy = $6.(ast.OrderBy)
     }
     var limit *ast.Limit
     if $7 != nil {
        limit = $7.(*ast.Limit)
     }
     $$ = &ast.Delete{Comments: comments, TableExprs: ast.TableExprs{&ast.AliasedTableExpr{Expr: $3.(ast.SimpleTableExpr), As: $4.(ast.TableIdent)}}, Where: ast.NewWhere(ast.TypWhere, $5), OrderBy: orderBy, Limit: limit}
   }
| DELETE opt_comment FROM table_name_list USING table_references opt_where_expression
  {
    comments, _ := getComments($2)
    $$ = &ast.Delete{Comments: comments, Targets: $4.(ast.TableNames), TableExprs: $6.(ast.TableExprs), Where: ast.NewWhere(ast.TypWhere, $7)}
  }
| DELETE opt_comment FROM delete_table_list USING table_references opt_where_expression
  {
    comments, _ := getComments($2)
    $$ = &ast.Delete{Comments: comments, Targets: $4.(ast.TableNames), TableExprs: $6.(ast.TableExprs), Where: ast.NewWhere(ast.TypWhere, $7)}
  }
| DELETE opt_comment table_name_list from_or_using table_references opt_where_expression
  {
    comments, _ := getComments($2)
    $$ = &ast.Delete{Comments: comments, Targets: $3.(ast.TableNames), TableExprs: $5.(ast.TableExprs), Where: ast.NewWhere(ast.TypWhere, $6)}
  }
| DELETE opt_comment delete_table_list from_or_using table_references opt_where_expression
  {
    comments, _ := getComments($2)
    $$ = &ast.Delete{Comments: comments, Targets: $3.(ast.TableNames), TableExprs: $5.(ast.TableExprs), Where: ast.NewWhere(ast.TypWhere, $6)}
  }

from_or_using:
  FROM
| USING

opt_table_name_list:
  {
    $$ = nil
  }
| table_name_list

table_name_list:
  table_name
  {
    $$ = ast.TableNames{$1.(ast.TableName)}
  }
| table_name_list ',' table_name
  {
    dd := $$.(ast.TableNames)
    d3 := $3.(ast.TableName)
    dd = append(dd, d3)
    $$ = dd
  }

delete_table_list:
  delete_table_name
  {
    $$ = ast.TableNames{$1.(ast.TableName)}
  }
| delete_table_list ',' delete_table_name
  {
    dd := $$.(ast.TableNames)
    d3 := $3.(ast.TableName)
    dd = append(dd, d3)
    $$ = dd
  }

/********************ast.Set Statement*******************************/
set_statement:
  SET opt_comment set_spec
  {
    comments, _ := getComments($2)
    $$ = &ast.Set{Comments: comments, Exprs: $3.(ast.SetExprs)}
  }

opt_replace_password:
  {
    $$ = ""
  }
| REPLACE STRING
  {
    $$ = $2
  }

set_spec:
  set_list
| GLOBAL TRANSACTION transaction_chars
  {
    vars := $3.(ast.SetExprs)
    for _, v := range vars {
    	v.IsGlobal = true
    }
    $$ = vars
  }
| SESSION TRANSACTION transaction_chars
  {
    $$ = $3
  }
| TRANSACTION transaction_chars
  {
    vars := $2.(ast.SetExprs)
    for _, v := range vars {
    	v.IsImplicit = true
    }
    $$ = vars
  }

transaction_chars:
  transaction_char
  {
    $$ = ast.SetExprs{$1.(*ast.SetExpr)}
  }
| transaction_chars ',' transaction_char
  {
    dd := $$.(ast.SetExprs)
    d3 := $3.(*ast.SetExpr)
    dd = append(dd, d3)
    $$ = dd
  }

transaction_char:
  ISOLATION LEVEL isolation_level
  {
    $$ = &ast.SetExpr{Name: ast.NewColIdent(ast.TransactionIsolationLevelStr), Value: ast.NewStrValV2($3), IsSystem: true}
  }
| READ ONLY
  {
    $$ = &ast.SetExpr{Name: ast.NewColIdent(ast.TransactionStr), Value: ast.NewStrValV2(ast.TxReadOnly), IsSystem: true}
  }
| READ WRITE
  {
    $$ = &ast.SetExpr{Name: ast.NewColIdent(ast.TransactionStr), Value: ast.NewStrValV2(ast.TxReadWrite), IsSystem: true}
  }

isolation_level:
  REPEATABLE READ
  {
    $$ = ast.IsolationLevelRepeatableRead
  }
| READ COMMITTED
  {
    $$ = ast.IsolationLevelReadCommitted
  }
| READ UNCOMMITTED
  {
    $$ = ast.IsolationLevelReadUncommitted
  }
| SERIALIZABLE
  {
    $$ = ast.IsolationLevelSerializable
  }

session_or_global:
  LOCAL
  {
    $$ = false
  }
| SESSION
  {
    $$ = false
  }
| GLOBAL
  {
    $$ = true
  }

opt_default_keyword:
  {
    $$ = ""
  }
| DEFAULT

opt_equal:
  {
    $$ = ""
  }
| '='

opt_database_option:
  {
    $$ = nil
  }
| database_option

database_option:
  opt_default_keyword CHARACTER SET opt_equal database_opt_value
  {
    $$ = ast.SchemaOptions{&ast.SchemaOption{OptionName: $2, OptionValue: $5}}
  }
| opt_default_keyword CHARSET opt_equal database_opt_value
  {
    $$ = ast.SchemaOptions{&ast.SchemaOption{OptionName: $2, OptionValue: $4}}
  }
| opt_default_keyword COLLATE opt_equal database_opt_value
  {
    $$ = ast.SchemaOptions{&ast.SchemaOption{OptionName: $2, OptionValue: $4}}
  }
| opt_default_keyword ENCRYPTION opt_equal database_opt_value
  {
    $$ = ast.SchemaOptions{&ast.SchemaOption{OptionName: $2, OptionValue: $4}}
  }
| database_option opt_default_keyword CHARACTER SET opt_equal database_opt_value
  {
    $$ = append($1.(ast.SchemaOptions), &ast.SchemaOption{OptionName: $3, OptionValue: $6})
  }
| database_option opt_default_keyword CHARSET opt_equal database_opt_value
  {
    $$ = append($1.(ast.SchemaOptions), &ast.SchemaOption{OptionName: $3, OptionValue: $5})
  }
| database_option opt_default_keyword COLLATE opt_equal database_opt_value
  {
    $$ = append($1.(ast.SchemaOptions), &ast.SchemaOption{OptionName: $3, OptionValue: $5})
  }
| database_option opt_default_keyword ENCRYPTION opt_equal database_opt_value
  {
    $$ = append($1.(ast.SchemaOptions), &ast.SchemaOption{OptionName: $3, OptionValue: $5})
  }

database_opt_value:
  reserved_sql_id
  {
    $$ = $1.(ast.ColIdent).String()
  }
| STRING
  {
    $$ = "'" + $1 + "'"
  }

create_statement:
  create_database_statement
| create_table_statement
| create_index_statement
| create_indextype_statement
| create_view_statement
| create_sequence_statement
| create_trigger_statement
| create_server_statement
| create_synonym_statement
| create_type_statement
| create_type_body_statement
| create_package_statement
| create_package_body_statement
| create_function_statement
| create_procedure_statement
| create_operator_statement

create_table_statement:
  CREATE opt_temporary TABLE opt_comment opt_not_exists table_name '(' table_element_list ')' create_table_options_etc opt_distribution
  {
    var temporaryExist bool
    if $2 != "false" {
    	temporaryExist = true
    }
    comments, _ := getComments($4)
    var notExists bool
    if $5 != "false" {
    	notExists = true
    }
    createTableTail := $10.(ast.CreateTableTail)
    var optDistribute *ast.DistributionOption
    if $11 != nil {
    	optDistribute = $11.(*ast.DistributionOption)
    }
    ct := &ast.CreateTableStmt{
    	Name:         $6.(ast.TableName),
    	IsTemporary:  temporaryExist,
    	IfNotExists:  notExists,
    	TableSpec:    &ast.TableSpec{TableElements: $8.(ast.TableElements)},
    	TableOptions: createTableTail.TableOptions,
    	OptPartition: createTableTail.OptPartition,
    	OptDistribution: optDistribute,
    	OptQueryExpr: createTableTail.OptQueryExpr,
    	Comments:     comments,
    }
    $$ = ct
  }
| CREATE opt_temporary TABLE opt_comment opt_not_exists table_name '(' table_element_list ')' opt_distribution
  {
    var temporaryExist bool
    if $2 != "false" {
    	temporaryExist = true
    }
    comments, _ := getComments($4)
    var notExists bool
    if $5 != "false" {
    	notExists = true
    }
    createTableTail :=ast.CreateTableTail{}
    var optDistribute *ast.DistributionOption
    if $10!= nil {
    	optDistribute = $10.(*ast.DistributionOption)
    }
    ct := &ast.CreateTableStmt{
    	Name:         $6.(ast.TableName),
    	IsTemporary:  temporaryExist,
    	IfNotExists:  notExists,
    	TableSpec:    &ast.TableSpec{TableElements: $8.(ast.TableElements)},
    	TableOptions: createTableTail.TableOptions,
    	OptPartition: createTableTail.OptPartition,
    	OptDistribution: optDistribute,
    	OptQueryExpr: createTableTail.OptQueryExpr,
    	Comments:     comments,
    }
    $$ = ct
  }
 | CREATE opt_temporary TABLE opt_comment opt_not_exists table_name '(' table_element_list ')' distributed_by create_table_options_etc
  {
    var temporaryExist bool
    if $2 != "false" {
    	temporaryExist = true
    }
    comments, _ := getComments($4)
    var notExists bool
    if $5 != "false" {
    	notExists = true
    }
    createTableTail := $11.(ast.CreateTableTail)
    ct := &ast.CreateTableStmt{
    	Name:         $6.(ast.TableName),
    	IsTemporary:  temporaryExist,
    	IfNotExists:  notExists,
    	TableSpec:    &ast.TableSpec{TableElements: $8.(ast.TableElements)},
    	TableOptions: createTableTail.TableOptions,
    	OptPartition: createTableTail.OptPartition,
    	OptDistribution: $10.(*ast.DistributionOption),
    	OptQueryExpr: createTableTail.OptQueryExpr,
    	Comments:     comments,
    }
    $$ = ct
  }
| CREATE opt_temporary TABLE opt_comment opt_not_exists table_name opt_create_table_options_etc
  {
    var temporaryExist bool
    if $2 != "false" {
    	temporaryExist = true
    }
    comments, _ := getComments($4)
    var notExists bool
    if $5 != "false" {
    	notExists = true
    }
    createTableTail := $7.(ast.CreateTableTail)
    ct := &ast.CreateTableStmt{
    	Name:         $6.(ast.TableName),
    	IsTemporary:  temporaryExist,
    	IfNotExists:  notExists,
    	TableOptions: createTableTail.TableOptions,
    	OptPartition: createTableTail.OptPartition,
    	OptQueryExpr: createTableTail.OptQueryExpr,
    	Comments:     comments,
    }
    $$ = ct
  }
| CREATE opt_temporary TABLE opt_comment opt_not_exists table_name create_like
  {
    var temporaryExist bool
    if $2 != "false" {
    	temporaryExist = true
    }
    comments, _ := getComments($4)
    var notExists bool
    if $5 != "false" {
    	notExists = true
    }
    $$ = &ast.CreateTableStmt{Name: $6.(ast.TableName), IsTemporary: temporaryExist, IfNotExists: notExists, OptLike: $7.(*ast.OptLike), Comments: comments}
  }

create_operator_statement:
  CREATE OPERATOR table_name binding_clause
  {
    $$ = &ast.CreateOperatorStmt{Name: $3.(ast.TableName), BindingElements: $4.([]*ast.BindingElement)}
  }
| CREATE OR REPLACE OPERATOR table_name binding_clause
  {
    $$ = &ast.CreateOperatorStmt{Name: $5.(ast.TableName), BindingElements: $6.([]*ast.BindingElement), CreateOrReplace: true}
  }

binding_clause:
  BINDING binding_element_list
  {
    $$ = $2.([]*ast.BindingElement)
  }

binding_element_list:
  binding_element
  {
    $$ = []*ast.BindingElement{$1.(*ast.BindingElement)}
  }
|
  binding_element_list ',' binding_element
  {
    dd := $1.([]*ast.BindingElement)
    dd = append(dd, $3.(*ast.BindingElement))
    $$ = dd
  }

binding_element:
  openb datatype_list closeb RETURN native_datatype_element opt_implementation_clause USING proc_or_func_name
  {
    var dd *ast.Implementation
    if $6 !=nil{
      dd = $6.(*ast.Implementation)
    }
    $$ = &ast.BindingElement{ParamTypes: $2.([]string), ReturnType: $5, Implementation: dd, Name: $8.(ast.ProcOrFuncName)}
  }

datatype_list:
  native_datatype_element
  {
    $$ = []string{$1}
  }
| datatype_list ',' native_datatype_element
  {
    dd := $1.([]string)
    dd = append(dd, $3)
    $$ = dd
  }

opt_implementation_clause:
  {
    $$ = nil
  }
| implementation_clause
  {
    $$ = $1.(*ast.Implementation)
  }

implementation_clause:
  ANCILLARY TO operator_spec_list
  {
    $$ = &ast.Implementation{PrimOps: $3.([]*ast.OperatorAttr)}
  }
| WITH COLUMN CONTEXT
  {
    $$ = &ast.Implementation{WithColContext: true}
  }
| WITH INDEX CONTEXT ',' SCAN CONTEXT ID opt_compute_ancillary_data
  {
    $$ = &ast.Implementation{WithIdxContext: true, TypeName: $7, NeedComputeData: $8.(bool)}
  }

operator_spec_list:
  operator_spec
  {
    $$ = []*ast.OperatorAttr{$1.(*ast.OperatorAttr)}
  }
|
  operator_spec_list ',' operator_spec
  {
    dd := $1.([]*ast.OperatorAttr)
    dd = append(dd, $3.(*ast.OperatorAttr))
    $$ = dd
  }

operator_spec:
  table_name openb datatype_list closeb
  {
    $$ = &ast.OperatorAttr{Name: $1.(ast.TableName), ParamTypes: $3.([]string)}
  }

opt_compute_ancillary_data:
  {
    $$ = false
  }
|
  COMPUTE ANCILLARY DATA
  {
    $$ = true
  }

create_index_statement:
  CREATE GLOBAL INDEX ID opt_index_type ON table_name openb key_list_with_expression closeb opt_index_option opt_index_lock_and_algorithm
  {
    tempInfo := &ast.IndexInfo{Type: ast.IndexTypeNormal, Name: ast.NewTableIdent($4)}
    tempIdxDef := &ast.IndexDefinition{Info: tempInfo, Using: $5, TblName: $7.(ast.TableName), KeyPartSpecs: $9.(ast.KeyPartSpecs)}
    tempIndexSpec := &ast.IndexSpec{IdxDef: tempIdxDef, Global: true}
    $$ = &ast.CreateIndexStmt{Name: ast.NewTableIdent($4), IndexSpec: tempIndexSpec}
  }
| CREATE GLOBAL UNIQUE INDEX ID opt_index_type ON table_name openb key_list_with_expression closeb opt_index_option opt_index_lock_and_algorithm
  {
    tempInfo := &ast.IndexInfo{Type: ast.IndexTypeUnique, Name: ast.NewTableIdent($5), Unique: true}
    tempIdxDef := &ast.IndexDefinition{Info: tempInfo, Using: $6, TblName: $8.(ast.TableName), KeyPartSpecs: $10.(ast.KeyPartSpecs)}
    tempIndexSpec := &ast.IndexSpec{IdxDef: tempIdxDef, Global: true}
    $$ = &ast.CreateIndexStmt{Name: ast.NewTableIdent($5), IndexSpec: tempIndexSpec}
  }
| CREATE LOCAL opt_constraint INDEX ID opt_index_type ON table_name openb key_list_with_expression closeb opt_index_option opt_index_lock_and_algorithm
  {
    var tempInfo *ast.IndexInfo
    indexName := ast.NewTableIdent($5)
    if strings.EqualFold($3, "unique") {
    	tempInfo = &ast.IndexInfo{Type: ast.IndexTypeUnique, Name: indexName, Unique: true}
    } else if strings.EqualFold($3, "spatial") {
    	tempInfo = &ast.IndexInfo{Type: ast.IndexTypeSpatial, Name: indexName, Spatial: true}
    } else if strings.EqualFold($3, "fulltext") {
    	tempInfo = &ast.IndexInfo{Type: ast.IndexTypeFulltext, Name: indexName, Fulltext: true}
    } else {
    	tempInfo = &ast.IndexInfo{Type: ast.IndexTypeNormal, Name: indexName}
    }
    var idxOpt *ast.IndexOption
    if $12 != nil {
    	idxOpt = $12.(*ast.IndexOption)
    }
    algo := $13.(*ast.AlgoLockValidation).Algo.GetOrDefault()
    lock := $13.(*ast.AlgoLockValidation).Lock.GetOrDefault()
    tempIdxDef := &ast.IndexDefinition{Info: tempInfo, Using: $6, TblName: $8.(ast.TableName), KeyPartSpecs: $10.(ast.KeyPartSpecs), IndexOpts: []*ast.IndexOption{idxOpt}, Algo: algo.(ast.AlterTableAlgorithm), Lock: lock.(ast.AlterTableLock)}
    tempIndexSpec := &ast.IndexSpec{IdxDef: tempIdxDef, Global: false}
    $$ = &ast.CreateIndexStmt{Name: indexName, IndexSpec: tempIndexSpec}
  }
| CREATE opt_constraint INDEX ID opt_index_type ON table_name openb key_list_with_expression closeb opt_index_option opt_index_lock_and_algorithm
  {
    var tempInfo *ast.IndexInfo
    indexName := ast.NewTableIdent($4)
    if strings.EqualFold($2, "unique") {
    	tempInfo = &ast.IndexInfo{Type: ast.IndexTypeUnique, Name: indexName, Unique: true}
    } else if strings.EqualFold($2, "spatial") {
    	tempInfo = &ast.IndexInfo{Type: ast.IndexTypeSpatial, Name: indexName, Spatial: true}
    } else if strings.EqualFold($2, "fulltext") {
    	tempInfo = &ast.IndexInfo{Type: ast.IndexTypeFulltext, Name: indexName, Fulltext: true}
    } else if strings.EqualFold($2, "bitmap") {
        tempInfo = &ast.IndexInfo{Type: ast.IndexTypeNormal, Name: indexName, Bitmap: true}
    } else if strings.EqualFold($2, "multivalue") {
        tempInfo = &ast.IndexInfo{Type: ast.IndexTypeNormal, Name: indexName, Multivalue: true}
    } else {
    	tempInfo = &ast.IndexInfo{Type: ast.IndexTypeNormal, Name: indexName}
    }
    var idxOpt *ast.IndexOption
    if $11 != nil {
    	idxOpt = $11.(*ast.IndexOption)
    }
    algo := $12.(*ast.AlgoLockValidation).Algo.GetOrDefault()
    lock := $12.(*ast.AlgoLockValidation).Lock.GetOrDefault()
    tempIdxDef := &ast.IndexDefinition{Info: tempInfo, Using: $5, TblName: $7.(ast.TableName), KeyPartSpecs: $9.(ast.KeyPartSpecs), IndexOpts: []*ast.IndexOption{idxOpt}, Algo: algo.(ast.AlterTableAlgorithm), Lock: lock.(ast.AlterTableLock)}
    tempIndexSpec := &ast.IndexSpec{IdxDef: tempIdxDef, Global: false}
    $$ = &ast.CreateIndexStmt{Name: indexName, IndexSpec: tempIndexSpec}
  }

create_indextype_statement:
  CREATE INDEXTYPE table_name FOR operator_spec_list USING table_name opt_partition_storage_table_clause
  {
    var d8 *ast.PartitionStorageAttr
    if $8 !=nil{
      d8 = $8.(*ast.PartitionStorageAttr)
    }
    $$ = &ast.CreateIndexTypeStmt{Name: $3.(ast.TableName), OperatorAttrs: $5.([]*ast.OperatorAttr), UsingTypeAttr: &ast.UsingTypeAttr{Name: $7.(ast.TableName)}, PartitionStorageAttr: d8}
  }
| CREATE INDEXTYPE table_name FOR operator_spec_list USING table_name array_DML_clause opt_partition_storage_table_clause
    {
      var d9 *ast.PartitionStorageAttr
      if $9 !=nil{
        d9 = $9.(*ast.PartitionStorageAttr)
      }
      $$ = &ast.CreateIndexTypeStmt{Name: $3.(ast.TableName), OperatorAttrs: $5.([]*ast.OperatorAttr), UsingTypeAttr: &ast.UsingTypeAttr{Name: $7.(ast.TableName), ArrayDMLAttr: $8.(*ast.ArrayDMLAttr)}, PartitionStorageAttr: d9}
    }
| CREATE OR REPLACE INDEXTYPE table_name FOR operator_spec_list USING table_name opt_partition_storage_table_clause
  {
    var d10 *ast.PartitionStorageAttr
    if $10 !=nil{
      d10 = $10.(*ast.PartitionStorageAttr)
    }
    $$ = &ast.CreateIndexTypeStmt{Name: $5.(ast.TableName), CreateOrReplace: true, OperatorAttrs: $7.([]*ast.OperatorAttr), UsingTypeAttr: &ast.UsingTypeAttr{Name: $9.(ast.TableName)}, PartitionStorageAttr: d10}
  }
| CREATE OR REPLACE INDEXTYPE table_name FOR operator_spec_list USING table_name array_DML_clause opt_partition_storage_table_clause
  {
    var d11 *ast.PartitionStorageAttr
    if $11 !=nil{
      d11 = $11.(*ast.PartitionStorageAttr)
    }
    $$ = &ast.CreateIndexTypeStmt{Name: $5.(ast.TableName), CreateOrReplace: true, OperatorAttrs: $7.([]*ast.OperatorAttr), UsingTypeAttr: &ast.UsingTypeAttr{Name: $9.(ast.TableName), ArrayDMLAttr: $10.(*ast.ArrayDMLAttr)}, PartitionStorageAttr: d11}
  }

array_DML_clause:
  ARRAY DML opt_varray_type_list
  {
    var dd []ast.VarrayType
    if $3 !=nil{
      dd = $3.([]ast.VarrayType)
    }
    $$ = &ast.ArrayDMLAttr{VarrayTypes: dd}
  }
| WITH ARRAY DML opt_varray_type_list
  {
    var dd []ast.VarrayType
    if $4 !=nil{
      dd = $4.([]ast.VarrayType)
    }
    $$ = &ast.ArrayDMLAttr{WithOrWithout: "WITH", VarrayTypes: dd}
  }
| WITHOUT ARRAY DML opt_varray_type_list
  {
    var dd []ast.VarrayType
    if $4 !=nil{
      dd = $4.([]ast.VarrayType)
    }
    $$ = &ast.ArrayDMLAttr{WithOrWithout: "WITHOUT", VarrayTypes: dd}
  }

opt_varray_type_list:
  {
    $$ = nil
  }
| varray_type_list
  {
    $$ = $1.([]ast.VarrayType)
  }

varray_type_list:
  varray_type_element
  {
    $$ = []ast.VarrayType{$1.(ast.VarrayType)}
  }
| varray_type_list ',' varray_type_element
  {
    dd := $1.([]ast.VarrayType)
    dd = append(dd, $3.(ast.VarrayType))
    $$ = dd
  }

varray_type_element:
  table_name
  {
    $$ = ast.VarrayType{TypeName: $1.(ast.TableName)}
  }

opt_partition_storage_table_clause:
  {
    $$ = nil
  }
| with_partition
  {
    $$ = &ast.PartitionStorageAttr{PartitionAttr: $1}
  }
| with_partition storage_table_clause
  {
    $$ = &ast.PartitionStorageAttr{PartitionAttr: $1, StorageAttr: $2}
  }
| storage_table_clause
  {
    $$ = &ast.PartitionStorageAttr{StorageAttr: $1}
  }

with_partition:
  WITH LOCAL PARTITION
  {
    $$ = "LOCAL"
  }
| WITH LOCAL RANGE PARTITION
  {
    $$ = "LOCAL RANGE"
  }

storage_table_clause:
  WITH SYSTEM MANAGED STORAGE TABLES
  {
    $$ = "SYSTEM"
  }
| WITH USER MANAGED STORAGE TABLES
   {
     $$ = "USER"
   }

create_database_statement:
  CREATE database_or_schema opt_not_exists table_id opt_database_option
  {
    var notExists bool
    if $3 != "false" {
    	notExists = true
    }
    var d5 ast.SchemaOptions
    if $5 != nil {
    	d5 = $5.(ast.SchemaOptions)
    }
    $$ = &ast.CreateDatabaseStmt{IfNotExists: notExists, Name: $4.(ast.TableIdent), Options: d5}
  }

create_view_statement:
  CREATE opt_view_force_edition_option VIEW table_name opt_sharing_clause view_clause_option opt_default_bequeath view_as_clause
  {
    var sharingClause *ast.SharingClause
    if $5 != nil {
    	sharingClause = $5.(*ast.SharingClause)
    }
    var viewClauseOption []ast.ViewClauseOption
    var columnNames ast.Columns
    if $6 != nil {
        viewClauseOption = $6.([]ast.ViewClauseOption)
        for _, v := range viewClauseOption {
            if !v.AliasName.IsEmpty(){
    	        columnNames = append(columnNames, v.AliasName)
            }
        }
    }
    var forceEditionOption *ast.ForceEditionOption
    if $2 != nil {
        forceEditionOption = $2.(*ast.ForceEditionOption)
    }
    tmpViewSpec := &ast.ViewSpec{ViewName: $4.(ast.TableName).ToViewName(), Sharing: sharingClause, ColumnNames: columnNames, ViewClauseOption: viewClauseOption, DefaultBequeath: $7.(string),  ViewASClause: $8.(*ast.ViewASClause), Select: $8.(*ast.ViewASClause).Select}
    $$ = &ast.CreateViewStmt{Name: $4.(ast.TableName).ToViewName(), CreateOrReplace: false, ViewSpec: tmpViewSpec, ForceEditionOption: forceEditionOption}
  }
| CREATE OR REPLACE opt_view_force_edition_option VIEW table_name opt_sharing_clause view_clause_option opt_default_bequeath view_as_clause
  {
    var sharingClause *ast.SharingClause
    if $7 != nil {
    	sharingClause = $7.(*ast.SharingClause)
    }
    var viewClauseOption []ast.ViewClauseOption
    var columnNames ast.Columns
    if $8 != nil {
        viewClauseOption = $8.([]ast.ViewClauseOption)
        for _, v := range viewClauseOption {
            if !v.AliasName.IsEmpty(){
    	        columnNames = append(columnNames, v.AliasName)
            }
        }
    }
    var forceEditionOption *ast.ForceEditionOption
    if $4 != nil {
        forceEditionOption = $4.(*ast.ForceEditionOption)
    }
    tmpViewSpec := &ast.ViewSpec{ViewName: $6.(ast.TableName).ToViewName(), Sharing: sharingClause, ColumnNames: columnNames, ViewClauseOption: viewClauseOption, DefaultBequeath: $9.(string),  ViewASClause: $10.(*ast.ViewASClause), Select: $10.(*ast.ViewASClause).Select}
    $$ = &ast.CreateViewStmt{Name: $6.(ast.TableName).ToViewName(), CreateOrReplace: true, ViewSpec: tmpViewSpec, ForceEditionOption: forceEditionOption}
  }

opt_sharing_clause:
  {
    $$ = nil
  }
| sharing_clause

sharing_clause:
  SHARING '=' sharing_value
  {
    $$ = &ast.SharingClause{SharingValue: $3}
  }

sharing_value:
  METADATA
| DATA
| EXTENDED DATA
| NONE
  
view_column_list:
  {
    $$ = nil
  }
| '(' column_list ')'
  {
    $$ = $2
  }

view_clause_option:
  {
    $$ = nil
  }
| '(' in_or_out_of_line_constraint_list ')'
  {
    $$ = $2.([]ast.ViewClauseOption)
  }
| object_view_clause
  {
    d1 := ast.ViewClauseOption{ObjectViewClause: $1.(*ast.ObjectViewClause)}
    $$ = []ast.ViewClauseOption{d1}
  }
| XMLType_view_clause
  {
    d1 := ast.ViewClauseOption{XMLTypeViewClause: $1.(*ast.XMLTypeViewClause)}
    $$ = []ast.ViewClauseOption{d1}
  }

in_or_out_of_line_constraint_list:
  in_or_out_of_line_constraint
  {
    $$ = []ast.ViewClauseOption{$1.(ast.ViewClauseOption)}
  }
| in_or_out_of_line_constraint_list ',' in_or_out_of_line_constraint
  {
    $$ = append($1.([]ast.ViewClauseOption), $3.(ast.ViewClauseOption))
  }

in_or_out_of_line_constraint:
  sql_id opt_visibility opt_inline_constraint_list
  {
    var d3 []ast.InlineConstraint
    if $3 != nil {
        d3 = $3.([]ast.InlineConstraint)
    }
    $$ = ast.ViewClauseOption{AliasName:$1.(ast.ColIdent), Visibility: $2, InlineConstraint: d3}
  }
| out_of_line_constraint
  {
    $$ = ast.ViewClauseOption{OutofLineConstraint: $1.(*ast.OutofLineConstraint)}
  }

opt_visibility:
  {
    $$ = ""
  }
| VISIBLE
| INVISIBLE

opt_inline_constraint_list:
  {
    $$ = nil
  }
| inline_constraint_list

inline_constraint_list:
  inline_constraint
  {
    $$ = []ast.InlineConstraint{$1.(ast.InlineConstraint)}
  }
| inline_constraint_list inline_constraint
  {
    $$ = append($1.([]ast.InlineConstraint), $2.(ast.InlineConstraint))
  }

inline_constraint:
  CONSTRAINT ident inline_constraint_options opt_constraint_state
  {
    var d4 *ast.ConstraintState
    if $4 != nil {
        d4 = $4.(*ast.ConstraintState)
    }
    $$ = ast.InlineConstraint{Name: $2, ConstraintOptions: $3.(ast.ConstraintOptions), ConstraintState: d4}
  }
| inline_constraint_options opt_constraint_state
  {
    var d2 *ast.ConstraintState
    if $2 != nil {
        d2 = $2.(*ast.ConstraintState)
    }
    $$ = ast.InlineConstraint{ConstraintOptions: $1.(ast.ConstraintOptions), ConstraintState: d2}
  }

inline_constraint_options:
  NULL
  {
    $$ = ast.ConstraintOptions{IsInline: true, IfNull: true}
  }
| NOT NULL
  {
    $$ = ast.ConstraintOptions{IsInline: true, IfNotNull: true}
  }
| constraint_key_type
  {
    $$ = ast.ConstraintOptions{IsInline: true, ConstraintKeyType: $1.(ast.KeyType)}
  }
| references
  {
    $$ = ast.ConstraintOptions{IsInline: true, Reference: $1.(ast.Reference)}
  }
| check_constraint
  {
    $$ = ast.ConstraintOptions{IsInline: true, CheckCondition: $1.(*ast.CheckCondition)}
  }

opt_constraint_state:
  {
    $$ = nil
  }
| constraint_state

constraint_state:
  DEFERRABLE opt_initially_option opt_rely_norely opt_using_index_clause opt_enable_disable opt_validate_novalidate opt_exceptions_clause
  {
    var d4 ast.UsingIndexClause
    if $4 != nil {
        d4 = $4.(ast.UsingIndexClause)
    }
    $$ = &ast.ConstraintState{DeferrableOption: $1, InitiallyOption: $2.(string), RelyNorely: $3, UsingIndewClause: d4, IsEnableStr:$5, IsValidateStr: $6, Exceptions: $7}
  }
| NO DEFERRABLE opt_initially_option opt_rely_norely opt_using_index_clause opt_enable_disable opt_validate_novalidate opt_exceptions_clause
  {
    var d5 ast.UsingIndexClause
    if $5 != nil {
        d5 = $5.(ast.UsingIndexClause)
    }
    $$ = &ast.ConstraintState{DeferrableOption: $1 + $2, InitiallyOption: $3.(string), RelyNorely: $4, UsingIndewClause: d5, IsEnableStr:$6, IsValidateStr: $7, Exceptions: $8}
  }
| initially_option deferrable_option opt_rely_norely opt_using_index_clause opt_enable_disable opt_validate_novalidate opt_exceptions_clause
  {
    var d4 ast.UsingIndexClause
    if $4 != nil {
        d4 = $4.(ast.UsingIndexClause)
    }
    $$ = &ast.ConstraintState{DeferrableOption: $2.(string), InitiallyOption: $1.(string), RelyNorely: $3, UsingIndewClause: d4, IsEnableStr:$5, IsValidateStr: $6, Exceptions: $7}
  }

opt_enable_disable:
  {
    $$ = ""
  }
| ENABLE
| DISABLE

opt_validate_novalidate:
  {
    $$ = ""
  }
| VALIDATE
| NOVALIDATE

opt_exceptions_clause:
  {
    $$ = ""
  }
| EXCEPTIONS INTO ident
  {
    $$ = $1 + " " + $2 + " " + $3
  }

deferrable_option:
  DEFERRABLE
  {
    $$ = $1
  }
| NOT DEFERRABLE
  {
    $$ = $1 + " " + $2
  }

opt_initially_option:
  {
    $$ = ""
  }
| initially_option
  {
    $$ = $1
  }

initially_option:
  INITIALLY IMMEDIATE
  {
    $$ = $1 + " " + $2
  }
| INITIALLY DEFERRED
  {
    $$ = $1 + " " + $2
  }

out_of_line_constraint:
  opt_constraint_name opt_constraint_option opt_constraint_state
  {
    var d3 *ast.ConstraintState
    if $3 != nil {
        d3 = $3.(*ast.ConstraintState)
    }
    $$ = &ast.OutofLineConstraint{Name: $1, ConstraintOptions: $2.(ast.ConstraintOptions), ConstraintState: d3}
  }

opt_constraint_option:
  UNIQUE '(' column_list ')'
  {
    $$ = ast.ConstraintOptions{IsInline: false, OptionType: ast.UniqueStr, ColumnList: $3.(ast.Columns)}
  }
| PRIMARY KEY '(' column_list ')'
  {
    $$ = ast.ConstraintOptions{IsInline: false, OptionType: ast.PrimaryKeyStr, ColumnList: $4.(ast.Columns)}
  }
| FOREIGN KEY '(' column_list ')' references
  {
    $$ = ast.ConstraintOptions{IsInline: false, OptionType: ast.ForeignKeyStr, ColumnList: $4.(ast.Columns)}
  }
| check_constraint
  {
    $$ = ast.ConstraintOptions{IsInline: false, CheckCondition: $1.(*ast.CheckCondition)}
  }

opt_rely_norely:
  {
    $$ = ""
  }
| RELY
| NORELY

opt_using_index_clause:
  {
    $$ = nil
  }
| using_index_clause
  {
    $$ = $1.(ast.UsingIndexClause)
  }

using_index_clause:
  USING INDEX ID
  {
    $$ = ast.UsingIndexClause{Name: $3}
  }
| USING INDEX '(' create_index_statement ')'
  {
    $$ = ast.UsingIndexClause{CreateIndexStmt: $4.(*ast.CreateIndexStmt)}
  }
| USING INDEX index_properites
  {
    $$ = ast.UsingIndexClause{IndexProperites: $3.([]ast.IndexProperites)}
  }

index_properites:
  {
    $$ = nil
  }
| index_properites global_partitioned_index
  {
    $$ = append($1.([]ast.IndexProperites), $2.(ast.IndexProperites))
  }

global_partitioned_index:
  GLOBAL PARTITION BY RANGE paren_column_list '(' index_partitioning_clause ')'
  {
    $$ = ast.IndexProperites{IsGlobal: true, PartionType: $4, ParenColumnList: $5.(*ast.ParenColumnList), IndexPartition: $7.(ast.IndexPartitionClause)}
  }
| GLOBAL PARTITION BY HASH paren_column_list individual_hash_partitions
  {
    $$ = ast.IndexProperites{IsGlobal: true, PartionType: $4, ParenColumnList: $5.(*ast.ParenColumnList), IndividualPartition: $6.(ast.IndividualPartition)}
  }
| GLOBAL PARTITION BY HASH paren_column_list hash_partitions_by_quantity
  {
    $$ = ast.IndexProperites{IsGlobal: true, PartionType: $4, ParenColumnList: $5.(*ast.ParenColumnList), QuantityPartition: $6.(ast.QuantityPartition)}
  }

index_partitioning_clause:
  PARTITION opt_ident VALUES LESS THAN '(' range_expression_list ')' opt_segment_attributes_clause
  {
    var d9 []ast.SegmentAttributes
    if $9!= nil {
        d9 = $9.([]ast.SegmentAttributes)
    }
    $$ = ast.IndexPartitionClause{PartitionName: $2, ValueList: $7.(ast.Exprs), SegmentAttributes: d9}
  }

individual_hash_partitions:
  '(' individual_hash_partition_list ')'
  {
    $$ = ast.IndividualPartition{PartionList: $2.([]ast.HashPartion)}
  }
individual_hash_partition_list:
  individual_hash_partition
  {
    $$ = []ast.HashPartion{$1.(ast.HashPartion)}
  }
| individual_hash_partition_list individual_hash_partition
  {
    $$ = append($1.([]ast.HashPartion), $2.(ast.HashPartion))
  }

individual_hash_partition:
  PARTITION opt_partition opt_read_only_clause opt_indexing_clause opt_partitioning_storage_clause
  {
    var d5 []ast.PartioningStorage
    if $5 != nil {
        $$ = $5.([]ast.PartioningStorage)
    }
    $$ = ast.HashPartion{PartionName: $2, ReadOnly: $3.(string), IndexClause: $4.(string), PartitioningStorageClause: d5}
  }

opt_partition:
  {
    $$ = ""
  }
| ID
  {
    $$ = $1
  }

opt_read_only_clause:
  {
    $$ = ""
  }
| READ ONLY
  {
    $$ = "READ ONLY"
  }
| READ WRITE
  {
    $$ = "READ WRITE"
  }

opt_indexing_clause:
  {
    $$ = ""
  }
| INDEXING ON
  {
    $$ = "INDEXING ON"
  }
| INDEXING OFF
  {
    $$ = "INDEXING OFF"
  }

opt_partitioning_storage_clause:
  {
    $$ = nil
  }
| partitioning_storage_list
  {
    $$ = $1.([]ast.PartioningStorage)
  }

partitioning_storage_list:
  partitioning_storage_spec
  {
    $$ = []ast.PartioningStorage{$1.(ast.PartioningStorage)}
  }
| partitioning_storage_list partitioning_storage_spec
  {
    $$ = append($1.([]ast.PartioningStorage), $2.(ast.PartioningStorage))
  }

partitioning_storage_spec:
  tablespace_set_clause
  {
    $$ = ast.PartioningStorage{StorageSpec: $1.(string)}
  }
| OVERFLOW tablespace_set_clause
  {
    $$ = ast.PartioningStorage{Type: $1, StorageSpec: $2.(string)}
  }
| table_compression
  {
    $$ = ast.PartioningStorage{StorageSpec: $1.(string)}
  }
| index_compression
  {
    $$ = ast.PartioningStorage{StorageSpec: $1.(string)}
  }
| inmemory_clause
  {
    $$ = ast.PartioningStorage{StorageSpec: $1.(string)}
  }
| ilm_clause
  {
    $$ = ast.PartioningStorage{StorageSpec: $1.(string)}
  }
| lob_partitioning_storage
  {
    $$ = ast.PartioningStorage{LobPartitioningStorage: $1.(*ast.LobPartitioningStorage)}
  }
| VARRAY varray_item STORE AS opt_securefile_basicfile LOB lob_item
  {
    dd := &ast.VarryStorageClause{VarryName: $2.([]string), SecurefileBasicfile: $5, LOBName: $7.(string)}
    $$ = ast.PartioningStorage{VarryStorageClause: dd}
  }

varray_item:
  ident_string_list

opt_securefile_basicfile:
  {
    $$ = ""
  }
| SECUREFILE
| BASICFILE

opt_tablespace_set_clause:
  {
    $$ = ""
  }
| '(' tablespace_set_clause ')'
  {
    $$ = $2.(string)
  }

tablespace_set_clause:
  TABLESPACE tablespace
  {
    $$ = $1 + " " + $2.(string)
  }
| TABLESPACE SET tablespace
  {
    $$ = $1 + " " + $2 + " " + $3.(string)
  }

tablespace:
  ident
  {
    $$ = $1
  }

table_compression:
  COMPRESS
  {
    $$ = $1
  }
| ROW STORE COMPRESS opt_basic_advanced
  {
    $$ = "ROW STORE COMPRESS " + $4
  }
| COLUMN STORE COMPRESS opt_for_auery_archive
  {
    $$ = "COLUMN STORE COMPRESS " + $4.(string)
  }
| NOCOMPRESS
  {
    $$ = $1
  }

ilm_time_period:
  INTEGRAL ilm_time_period_option
  {
    $$ = $1 + " " + $2
  }

ilm_time_period_option:
  DAY 
| DAYS
| MONTH
| MONTHS
| YEAR
| YEARS

opt_basic_advanced:
  {
    $$ = ""
  }
| BASIC
| ADVANCED

opt_for_auery_archive:
  {
    $$ = ""
  }
| FOR QUERY opt_low_high opt_no_row_level
  {
    $$ = "FOR QUERY " + $3 + " " + $4.(string)
  }

opt_no_row_level:
  NO ROW LEVEL LOCKING
  {
    $$ = "NO ROW LEVEL LOCKING"
  }
| ROW LEVEL LOCKING
  {
    $$ = "ROW LEVEL LOCKING"
  }

opt_low_high:
  {
    $$ = ""
  }
| LOW
| HIGH

index_compression:
  COMPRESS INTEGRAL
  {
    $$ = $1 + " " + $2
  }
| COMPRESS ADVANCED opt_low_high
  {
    $$ = "COMPRESS ADVANCED " + $3
  }

inmemory_clause:
  INMEMORY inmemory_attributes
  {
    $$ = $1 + " " + $2.(string)
  }
| NO INMEMORY
  {
    $$ = $1 + " " + $2
  }

opt_inmemory_attributes:
  {
    $$ = ""
  }
| inmemory_attributes
  {
    $$ = $1
  }

inmemory_attributes:
  MEMCOMPRESS opt_for_auery_archive
  {
    $$ = $1 + " " + $2.(string)
  }
| MEMCOMPRESS FOR CAPACITY opt_low_high
  {
    $$ = "MEMCOMPRESS FOR CAPACITY " + $4
  }
| NO MEMCOMPRESS
  {
    $$ = "NO MEMCOMPRESS"
  }

ilm_clause:
  ILM ADD POLICY ilm_policy_clause
  {
    $$ = "ILM ADD POLICY " + $4.(string)
  }
| ILM ilm_policy_option POLICY ilm_policy_name
  {
    $$ = $1 + " " + $2 + " " + $3 + " " + $4
  }
| DELETE_ALL
  {
    $$ = $1
  }
| ENABLE_ALL
  {
    $$ = $1
  }
| DISABLE_ALL
  {
    $$ = $1
  }

ilm_policy_name:
  ident

ilm_policy_option:
  DELETE 
| ENABLE
| DISABLE

ilm_policy_clause:
  ilm_compression_policy
  {
    $$ = $1.(string)
  }
| ilm_tiering_policy
  {
    $$ = $1.(string)
  }
| ilm_inmemory_policy
  {
    $$ = $1.(string)
  }

ilm_compression_policy:
  table_compression segment_group AFTER ilm_time_period OF ilm_time_period_option
  {
    $$ = $1.(string) + " " + $2 + " " + $3 + " " + $4.(string) + " " + $5 + " " + $6
  }
| table_compression segment_group ON function_name
  {
    $$ = $1.(string) + " " + $2 + " " + $3 + " " + $4.(string)
  }
| ROW STORE COMPRESS ADVANCED ROW AFTER ilm_time_period OF NO MODIFICATION
  {
    $$ = "ROW STORE COMPRESS ADVANCED ROW AFTER " + $7.(string) + " OF NO MODIFICATION"
  }
| table_compression AFTER ilm_time_period OF NO MODIFICATION
  {
    $$ = $1.(string) + " " + $2 + " " + $3.(string) + " " + $4 + " " + $5 + " " + $6
  }

opt_segment_group:
  {
    $$ = ""
  }
| segment_group
  {
    $$ = $1
  }

segment_group:
  SEGMENT
| GROUP

ilm_time_period_option:
  NO ACCESS
  {
    $$ = $1 + " " + $2
  }
| NO MODIFICATION
  {
    $$ = $1 + " " + $2
  }
| CREATION
  {
    $$ = $1
  }

opt_on_function:
  {
    $$ = ""
  }
| ON function_name
  {
    $$ = $1 + " " + $2.(string)
  }

function_name:
  ident
  {
    $$ = $1
  }

ilm_alter_or_on_clause:
  AFTER ilm_time_period OF ilm_time_period_option
  {
    $$ = $1 + " " + $2.(string) + " " + $3 + " " + $4
  }
| ON function_name
  {
    $$ = $1 + " " + $2.(string)
  }

ilm_tiering_policy:
  TIER TO tablespace opt_segment_group opt_on_function
  {
    $$ = "TIER TO " + $3.(string) + " " + $4.(string) + " " + $5.(string)
  }
| TIER TO tablespace READ ONLY opt_segment_group ilm_alter_or_on_clause
  {
    $$ = "TIER TO " + $3.(string) + " READ ONLY " + $6.(string) + " " + $7.(string)
  }

ilm_inmemory_policy:
  SET INMEMORY opt_inmemory_attributes opt_segment ilm_alter_or_on_clause
  {
    $$ = "SET INMEMORY " + $3.(string) + " " + $4 + " " + $5.(string)
  }
| MODIFY INMEMORY inmemory_attributes opt_segment ilm_alter_or_on_clause
  {
    $$ = "MODIFY INMEMORY " + $3.(string) + " " + $4 + " " + $5.(string)
  }
| NO INMEMORY opt_segment ilm_alter_or_on_clause
  {
    $$ = "NO INMEMORY " + $3 + " " + $4.(string)
  }

opt_segment:
  {
    $$ = ""
  }
| SEGMENT

hash_partitions_by_quantity:
  PARTITIONS hash_partition_quantity opt_quantity_store_clause opt_quantity_compression_option opt_quantity_over_store_clause
  {
    $$ = ast.QuantityPartition{PartitionsName: $2.(string), QuantityStore: $3.([]string), QuantityCompression: $4.(string), QuantityOver: $5.([]string)}
  }

hash_partition_quantity:
  INTEGRAL
  {
    $$ = $1
  }

opt_quantity_store_clause:
  {
    $$ = nil
  }
| STORE IN '(' tablespace_list ')'
  {
    $$ = $4.([]string)
  }

tablespace_list:
  tablespace
  {
    $$ = []string{$1.(string)}
  }
| tablespace_list ',' tablespace
  {
    $$ = append($1.([]string), $3.(string))
  }

opt_quantity_compression_option:
  {
    $$ = ""
  }
| table_compression
| index_compression

opt_quantity_over_store_clause:
  {
    $$ = nil
  }
| OVERFLOW STORE IN '(' tablespace_list ')'
  {
    $$ = $5.([]string)
  }

lob_partitioning_storage:
  LOB '(' lob_item ')' STORE AS opt_securefile_basicfile opt_lob_tablespace_clause
  {
    $$ = &ast.LobPartitioningStorage{LOBName: $3.(string), SecurefileBasicfile: $7, LOBTablespace: $8.(string)}
  }

opt_lob_tablespace_clause:
  lob_item opt_tablespace_set_clause
  {
    $$ = $1.(string) + " " + $2.(string)
  }
| opt_tablespace_set_clause
  {
    $$ = $1.(string)
  }

lob_item:
  ID
  {
    $$ = $1
  }

opt_segment_attributes_clause:
  {
    $$ = nil
  }
| segment_attributes_clause

segment_attributes_clause:
  segment_attributes
  {
    $$ = []ast.SegmentAttributes{$1.(ast.SegmentAttributes)}
  }
| segment_attributes_clause segment_attributes
  {
    $$ = append($1.([]ast.SegmentAttributes), $2.(ast.SegmentAttributes))
  }

segment_attributes:
  physical_attributes_clause
  {
    var d1 []ast.PhysicalAttributes
    if $1 != nil {
        d1 = $1.([]ast.PhysicalAttributes)
    }
    $$ = ast.SegmentAttributes{PhysicalAttributes: d1}
  }
| TABLESPACE tablespace
  {
    $$ = ast.SegmentAttributes{IsSet: false, TablespaceName:$2.(string)}
  }
| TABLESPACE SET tablespace
  {
    $$ = ast.SegmentAttributes{IsSet: true, TablespaceName:$3.(string)}
  }
| logging_clause
  {
    $$ = ast.SegmentAttributes{LoggingClause: $1}
  }

logging_clause:
  LOGGING
| NOLOGGING
| FILESYSTEM_LIKE_LOGGING

physical_attributes_clause:
  physical_attributes
  {
    $$ = []ast.PhysicalAttributes{$1.(ast.PhysicalAttributes)}
  }
| physical_attributes_clause ',' physical_attributes
  {
    $$ = append($1.([]ast.PhysicalAttributes), $3.(ast.PhysicalAttributes))
  }

physical_attributes:
  PCTFREE INTEGRAL
  {
    $$ = ast.PhysicalAttributes{Type: $1, Value: $2}
  }
| PCTUSED INTEGRAL
  {
    $$ = ast.PhysicalAttributes{Type: $1, Value: $2}
  }
| INITRANS INTEGRAL
  {
    $$ = ast.PhysicalAttributes{Type: $1, Value: $2}
  }
| storage_clause
  {
    $$ = ast.PhysicalAttributes{Type: "STORAGE", StorageValue: $1.(ast.StorageClause)}
  }

storage_clause:
  STORAGE '(' storage_list ')'
  {
    $$ = ast.StorageClause{StroageOption: $3.([]string)}
  }

storage_list:
  storage_option
  {
    $$ = []string{$1}
  }
| storage_list storage_option
  {
    $$ = append($1.([]string), $2)
  }

storage_option:
  INITIAL size_clause
| NEXT size_clause
| MINEXTENTS INTEGRAL
| MAXEXTENTS INTEGRAL
| MAXEXTENTS UNLIMITED
| MAXSIZE UNLIMITED
| MAXSIZE size_clause
| PCTINCREASE INTEGRAL
| FREELISTS INTEGRAL
| FREELIST GROUPS INTEGRAL
| OPTIMAL
| OPTIMAL size_clause 
| OPTIMAL NULL
| BUFFER_POOL KEEP 
| BUFFER_POOL RECYCLE 
| BUFFER_POOL DEFAULT
| FLASH_CACHE KEEP 
| FLASH_CACHE NONE 
| FLASH_CACHE DEFAULT
| ENCRYPT

size_clause:
  INTEGRAL
| INTEGRAL ID

opt_default_bequeath:
  {
    $$ = ""
  }
| opt_default_collation opt_bequeath_option
  {
    $$ = $1.(string) + " " + $2.(string)
  }
| opt_default_collation
  {
    $$ = $1.(string)
  }
| opt_bequeath_option
  {
    $$ = $1.(string)
  }

opt_default_collation:
  DEFAULT COLLATION collation_name
  {
    $$ = $1 + " " + $2 + " " + $3
  }

opt_bequeath_option:
  BEQUEATH CURRENT_USER
  {
    $$ = $1 + " " + $2
  }
| BEQUEATH DEFINER
  {
    $$ = $1 + " " + $2
  }

view_as_clause:
  AS select_statement opt_subquery_restriction_clause opt_container
  {
    $$ = &ast.ViewASClause{Select: $2.(ast.SelectStatement), Restriction: $3, Container: $4}
  }

opt_container:
  {
    $$ = ""
  }
| CONTAINER_MAP
| CONTAINERS_DEFAULT

object_view_clause:
  OF ident WITH OBJECT object_name object_attribute_list opt_object_constraint_list
  {
    var d7 []ast.ObjectConstraint
    if $7 != nil {
        d7 = $7.([]ast.ObjectConstraint)
    }
    $$ = &ast.ObjectViewClause{Name: $2, Type: $3+" "+$4, ObjectName: $5.(string), AttributeList: $6.([]string), Constraintlist: d7}
  }
| OF ident UNDER object_name opt_object_constraint_list
  {
    var d5 []ast.ObjectConstraint
    if $5 != nil {
        d5 = $5.([]ast.ObjectConstraint)
    }
    $$ = &ast.ObjectViewClause{Name: $2, Type: $3, ObjectName: $4.(string), Constraintlist: d5}
  }

object_name:
  ID
  {
    $$ = $1
  }
| IDENTIFIER
  {
    $$ = $1
  }

object_attribute_list:
  DEFAULT
  {
    $$ = []string{$1}
  }
| attribute_list
  {
    $$ = $1.([]string)
  }

attribute:
  text_string
  {
    $$ = $1
  }

attribute_list:
  text_string_list
  {
    $$ = $1.([]string)
  }

opt_object_constraint_list:
  {
    $$ = nil
  }
| '(' object_constraint_list ')'
  {
    $$ = $2.([]ast.ObjectConstraint)
  }

object_constraint_list:
  object_constraint
  {
    $$ = []ast.ObjectConstraint{$1.(ast.ObjectConstraint)}
  }
| object_constraint_list ',' object_constraint
  {
    $$ = append($1.([]ast.ObjectConstraint), $3.(ast.ObjectConstraint))
  }

object_constraint:
  attribute inline_constraint_list
  {
    $$ = ast.ObjectConstraint{Attribute: $1.(string), InlineConstraintList: $2.([]ast.InlineConstraint)}
  }
| out_of_line_constraint
  {
    $$ = ast.ObjectConstraint{OutofLineConstraint: $1.(*ast.OutofLineConstraint)}
  }

XMLType_view_clause:
  OF XMLTYPE opt_XMLSchema_spec WITH OBJECT object_name XMLType_view_expr_list
  {
    var d3 *ast.XMLSchemaSpec
    if $3 != nil {
        d3 = $3.(*ast.XMLSchemaSpec)
    }
    $$ = &ast.XMLTypeViewClause{XMLSchemaSpec: d3, ObjectName: $6.(string), ExprList: $7.(ast.Exprs)}
  }
| OF XMLTYPE opt_XMLSchema_spec WITH OBJECT object_name DEFAULT
  {
    var d3 *ast.XMLSchemaSpec
    if $3 != nil {
        d3 = $3.(*ast.XMLSchemaSpec)
    }
    $$ = &ast.XMLTypeViewClause{XMLSchemaSpec: d3, ObjectName: $6.(string), DefaultValue: $7}
  }

XMLType_view_expr_list:
  '(' expression_list ')'
  {
    $$ = $2.(ast.Exprs)
  }

opt_XMLSchema_spec:
  {
    $$ = nil
  }
| XMLSchema_spec
  {
    $$ = $1.(*ast.XMLSchemaSpec)
  }

XMLSchema_spec:
  opt_XMLSchema_url ELEMENT XMLSchema_element opt_XMLSchema_store opt_XMLSchema_nonschema_options
  {
    $$ = &ast.XMLSchemaSpec{XMLSchemaUrl: $1.(string), Element: $3.(string), StoreValue: $4.(string), NonschemaValue: $5.(string)}
  }

opt_XMLSchema_url:
  {
    $$ = ""
  }
| XMLSCHEMA XMLSchema_URL
  {
    $$ = $1 + " " + $2.(string)
  }

XMLSchema_element:
  element
  {
    $$ = $1
  }
| XMLSchema_URL '#' element 
  {
    $$ = $1.(string) + " " + $2 + " " + $3.(string)
  }

XMLSchema_URL:
  text_string
  {
    $$ = $1
  }

element:
  text_string
  {
    $$ = $1
  }

opt_XMLSchema_store:
  {
    $$ = ""
  }
| STORE ALL VARRAYS AS lobs_or_tables
  {
    $$ = "STORE ALL VARRAYS AS " + $5
  }

lobs_or_tables:
  LOBS
| TABLES

Is_allow:
  ALLOW
| DISALLOW

opt_XMLSchema_nonschema_options:
  {
    $$ = ""
  }
| Is_allow NONSCHEMA
  {
    $$ = $1 + " " + $2
  }
| Is_allow ANYSCHEMA
  {
    $$ = $1 + " " + $2
  }
| Is_allow NONSCHEMA Is_allow ANYSCHEMA
  {
    $$ = $1 + " " + $2 + " " + $3 + " " + $4
  }

database_or_schema:
  DATABASE
| SCHEMA

opt_subquery_restriction_clause:
  {
    $$ = ""
  }
| WITH view_check_option CONSTRAINT ident
  {
    $$ = $1 + " " + $2 + " " + $3 + " " + $4
  }
| WITH view_check_option
  {
    $$ = $1 + " " + $2
  }

view_check_option:
  READ ONLY
| CHECK OPTION

create_sequence_statement:
  CREATE SEQUENCE opt_not_exists table_name opt_sequence_options
  {
    var notExists bool
    if $3 != "false" {
    	notExists = true
    }
    var d5 ast.SequenceOptions
    if $5 != nil {
    	d5 = $5.(ast.SequenceOptions)
    }
    $$ = &ast.CreateSequenceStmt{Name: $4.(ast.TableName), IfNotExists: notExists, Options: d5}
  }
| CREATE OR REPLACE SEQUENCE opt_not_exists table_name opt_sequence_options
  {
    var notExists bool
    if $5 != "false" {
    	notExists = true
    }
    var d7 ast.SequenceOptions
    if $7 != nil {
    	d7 = $7.(ast.SequenceOptions)
    }
    $$ = &ast.CreateSequenceStmt{Name: $6.(ast.TableName), CreateOrReplace: true, IfNotExists: notExists, Options: d7}
  }

opt_sequence_options:
  {}
| sequence_options

sequence_options:
  sequence_option_def
  {
    var dd ast.SequenceOptions
    if $1 != nil {
    	dd = append(dd, $1.(*ast.SequenceOption))
    }
    $$ = dd
  }
| sequence_options sequence_option_def
  {
    d1 := $1.(ast.SequenceOptions)
    if $2 != nil {
    	$$ = append(d1, $2.(*ast.SequenceOption))
    } else {
    	$$ = d1
    }
  }

sequence_option_def:
  sequence_option_key sequence_option_value
  {
    if $1.(ast.SequenceConfig) == ast.SeqConfigIgnore {
    	$$ = nil
    } else {
    	$$ = &ast.SequenceOption{OptionName: $1.(ast.SequenceConfig), OptionValue: $2}
    }
  }
| sequence_option_key '=' sequence_option_value
  {
    if $1.(ast.SequenceConfig) == ast.SeqConfigIgnore {
    	$$ = nil
    } else {
    	$$ = &ast.SequenceOption{OptionName: $1.(ast.SequenceConfig), OptionValue: $3}
    }
  }
| sequence_option_ignore_key '=' sequence_option_ignore_value
  {
    $$ = nil
  }
| NOCACHE
  {
    $$ = &ast.SequenceOption{OptionName: ast.SeqConfigCacheSize, OptionValue: "1"}
  }
| NO MINVALUE
  {
    $$ = nil
  }
| NOMINVALUE
  {
    $$ = nil
  }
| NO MAXVALUE
  {
    $$ = nil
  }
| NOMAXVALUE
  {
    $$ = nil
  }
| CYCLE
  {
    $$ = &ast.SequenceOption{OptionName: ast.SeqConfigCycle, OptionValue: "1"}
  }
| NO CYCLE
  {
    $$ = &ast.SequenceOption{OptionName: ast.SeqConfigCycle, OptionValue: "0"}
  }

sequence_option_key:
  INCREMENT
  {
    $$ = ast.SeqConfigIncrement
  }
| INCREMENT BY
  {
    $$ = ast.SeqConfigIncrement
  }
| START
  {
    $$ = ast.SeqConfigStartValue
  }
| START WITH
  {
    $$ = ast.SeqConfigStartValue
  }
| CACHE
  {
    $$ = ast.SeqConfigCacheSize
  }
| MINVALUE
  {
    $$ = ast.SeqConfigMinValue
  }
| MAXVALUE
  {
    $$ = ast.SeqConfigMaxValue
  }

sequence_option_value:
  '-' INTEGRAL
  {
    $$ = $1 + $2
  }
| INTEGRAL

sequence_option_ignore_key:
  DEFAULT CHARSET
  {
    $$ = ast.SeqConfigIgnore
  }
| CONNECTION
  {
    $$ = ast.SeqConfigIgnore
  }
| ENGINE
  {
    $$ = ast.SeqConfigIgnore
  }
| REMOTE_SEQ
  {
    $$ = ast.SeqConfigIgnore
  }

sequence_option_ignore_value:
  ID
  {}
| STRING
  {}
| INTEGRAL
  {}

create_trigger_statement:
  CREATE opt_edition_option TRIGGER table_name simple_dml_trigger
  {
    $$ = &ast.CreateTriggerStmt{CreateOrReplace: false, EditionOption: $2.(ast.EditionOption), Name: $4.(ast.TableName), DMLTrigger: $5.(*ast.DMLTrigger), IsOracle: true}
  }
| CREATE OR REPLACE opt_edition_option TRIGGER table_name simple_dml_trigger
  {
    $$ = &ast.CreateTriggerStmt{CreateOrReplace: true, EditionOption: $4.(ast.EditionOption), Name: $6.(ast.TableName), DMLTrigger: $7.(*ast.DMLTrigger), IsOracle: true}
  }
| CREATE opt_edition_option TRIGGER table_name compound_dml_trigger
  {
    $$ = &ast.CreateTriggerStmt{CreateOrReplace: false, EditionOption: $2.(ast.EditionOption), Name: $4.(ast.TableName), DMLTrigger: $5.(*ast.DMLTrigger), IsOracle: true}
  }
| CREATE OR REPLACE opt_edition_option TRIGGER table_name compound_dml_trigger
  {
    $$ = &ast.CreateTriggerStmt{CreateOrReplace: true, EditionOption: $4.(ast.EditionOption), Name: $6.(ast.TableName), DMLTrigger: $7.(*ast.DMLTrigger), IsOracle: true}
  }

simple_dml_trigger:
  BEFORE dml_event_clause opt_referencing_clause opt_for_each_row opt_trigger_ordering_clause opt_trigger_state opt_trigger_when_clause trigger_body
  {
    var tp ast.TimingPoint
    if $4 != 0 {
      tp = ast.TimingPoint_BEFORE_EACH_ROW
    } else {
      tp = ast.TimingPoint_BEFORE_STATEMENT
    }
    var reference *ast.ReferencingClause
    if $3 != nil {
      reference = $3.(*ast.ReferencingClause)
    }
    var order *ast.TriggerOrderingClause
    if $5 != nil {
      order = $5.(*ast.TriggerOrderingClause)
    }
    var when ast.Expr
    if $7 != nil {
      when = $7.(ast.Expr)
    }
    $$ = &ast.DMLTrigger{TimingPoint: tp, DMLEvent: $2.(*ast.DMLEventClause), Reference: reference, Order: order, State: $6.(ast.TriggerState), When: when, SimpleTriggerBody: $8.(*ast.SimpleDMLTriggerBody)}
  }
| AFTER dml_event_clause opt_referencing_clause opt_for_each_row opt_trigger_ordering_clause opt_trigger_state opt_trigger_when_clause trigger_body
  {
    var tp ast.TimingPoint
    if $4 != 0 {
      tp = ast.TimingPoint_AFTER_EACH_ROW
    } else {
      tp = ast.TimingPoint_AFTER_STATEMENT
    }
    var reference *ast.ReferencingClause
    if $3 != nil {
      reference = $3.(*ast.ReferencingClause)
    }
    var order *ast.TriggerOrderingClause
    if $5 != nil {
      order = $5.(*ast.TriggerOrderingClause)
    }
    var when ast.Expr
    if $7 != nil {
      when = $7.(ast.Expr)
    }
    $$ = &ast.DMLTrigger{TimingPoint: tp, DMLEvent: $2.(*ast.DMLEventClause), Reference: reference, Order: order, State: $6.(ast.TriggerState), When: when, SimpleTriggerBody: $8.(*ast.SimpleDMLTriggerBody)}
  }

compound_dml_trigger:
  FOR dml_event_clause opt_referencing_clause opt_trigger_ordering_clause opt_trigger_state opt_trigger_when_clause compound_dml_block
  {
    var reference *ast.ReferencingClause
    if $3 != nil {
      reference = $3.(*ast.ReferencingClause)
    }
    var order *ast.TriggerOrderingClause
    if $4 != nil {
      order = $4.(*ast.TriggerOrderingClause)
    }
    var when ast.Expr
    if $6 != nil {
      when = $6.(ast.Expr)
    }
    $$ = &ast.DMLTrigger{DMLEvent: $2.(*ast.DMLEventClause), Reference: reference, Order: order, State: $5.(ast.TriggerState), When: when, CompoundTriggerBlock: $7.(*ast.CompoundDMLBlock)}
  }

dml_event_clause:
  dml_event_list ON opt_dml_event_nested_clause table_name
  {
    $$ = &ast.DMLEventClause{DMLEvents: $1.([]*ast.DMLEventElement), NestedTable: $3.(ast.TableName), TableOrView: $4.(ast.TableName)}
  }

dml_event_list:
  dml_event_element
  {
    $$ = []*ast.DMLEventElement{$1.(*ast.DMLEventElement)}
  }
| dml_event_list OR dml_event_element
  {
    $$ = append($1.([]*ast.DMLEventElement), $3.(*ast.DMLEventElement))
  }

dml_event_element:
  DELETE
  {
    $$ = &ast.DMLEventElement{Event: ast.DMLEvent_DELETE}
  }
| INSERT
  {
    $$ = &ast.DMLEventElement{Event: ast.DMLEvent_INSERT}
  }
| UPDATE
  {
    $$ = &ast.DMLEventElement{Event: ast.DMLEvent_UPDATE}
  }
| UPDATE OF ins_column_list
  {
    $$ = &ast.DMLEventElement{Event: ast.DMLEvent_UPDATE_COLUMNS, UpdateColumns: $3.(ast.Columns)}
  }

opt_dml_event_nested_clause:
  {
    $$ = ast.TableName{Name: ast.NewTableIdent("")}
  }
| NESTED TABLE table_name OF
  {
    $$ = $3
  }

opt_referencing_clause:
  {
    $$ = nil
  }
| REFERENCING referencing_element_list
  {
    $$ = &ast.ReferencingClause{References: $2.([]*ast.ReferencingElement)}
  }

referencing_element_list:
  referencing_element
  {
    $$ = []*ast.ReferencingElement{$1.(*ast.ReferencingElement)}
  }
| referencing_element_list referencing_element
  {
    $$ = append($1.([]*ast.ReferencingElement), $2.(*ast.ReferencingElement))
  }

referencing_element:
  OLD opt_as table_id
  {
    $$ = &ast.ReferencingElement{Record: ast.PseudoRecord_OLD, Alias: $3.(ast.TableIdent)}
  }
| NEW opt_as table_id
  {
    $$ = &ast.ReferencingElement{Record: ast.PseudoRecord_NEW, Alias: $3.(ast.TableIdent)}
  }
| PARENT opt_as table_id
  {
    $$ = &ast.ReferencingElement{Record: ast.PseudoRecord_PARENT, Alias: $3.(ast.TableIdent)}
  }

opt_for_each_row:
  {
    $$ = 0
  }
| FOR EACH ROW
  {
    $$ = 1
  }

opt_trigger_ordering_clause:
  {
    $$ = nil
  }
| FOLLOWS table_name_list
  {
    $$ = &ast.TriggerOrderingClause{Follows: $2.(ast.TableNames)}
  }
| PRECEDES table_name_list
  {
    $$ = &ast.TriggerOrderingClause{Precedes: $2.(ast.TableNames)}
  }

opt_trigger_state:
  {
    $$ = ast.TriggerState_ENABLE
  }
| ENABLE
  {
    $$ = ast.TriggerState_ENABLE
  }
| DISABLE
  {
    $$ = ast.TriggerState_DISABLE
  }

opt_trigger_when_clause:
  {
    $$ = nil
  }
| WHEN '(' expression ')'
  {
    $$ = $3
  }

trigger_body:
  block
  {
    $$ = &ast.SimpleDMLTriggerBody{Block: $1.(*ast.Block)}
  }
| call_statement
  {
    $$ = &ast.SimpleDMLTriggerBody{Routine: $1.(*ast.Call)}
  }

compound_dml_block:
  COMPOUND TRIGGER declare_spec timing_point_sections END opt_name
  {
    $$ = &ast.CompoundDMLBlock{DeclareSpecs: $3.(*ast.DeclareSpec), Sections: $4.([]*ast.TimingPointSection), OptEndName: $6}
  }
| COMPOUND TRIGGER timing_point_sections END opt_name
  {
    $$ = &ast.CompoundDMLBlock{Sections: $3.([]*ast.TimingPointSection), OptEndName: $5}
  }

timing_point_sections:
  timing_point_section
  {
    $$ = []*ast.TimingPointSection{$1.(*ast.TimingPointSection)}
  }
| timing_point_sections timing_point_section
  {
    $$ = append($1.([]*ast.TimingPointSection), $2.(*ast.TimingPointSection))
  }

timing_point_section:
  timing_point IS BEGIN tps_body END timing_point ';'
  {
    $$ = &ast.TimingPointSection{TimingPoint: $1.(ast.TimingPoint), TpsBody: $4.(*ast.Body)}
  }

tps_body:
  seq_of_statements
  {
    $$ = &ast.Body{SeqOfStatement: $1.(*ast.SeqOfStatement)}
  }
| seq_of_statements exception_handler_list
  {
    $$ = &ast.Body{SeqOfStatement: $1.(*ast.SeqOfStatement), OptExceptionHandlers: $2.(ast.ExceptionHandlerList)}
  }

timing_point:
  BEFORE STATEMENT
  {
    $$ = ast.TimingPoint_BEFORE_STATEMENT
  }
| BEFORE EACH ROW
  {
    $$ = ast.TimingPoint_BEFORE_EACH_ROW
  }
| AFTER EACH ROW
  {
    $$ = ast.TimingPoint_AFTER_EACH_ROW
  }
| AFTER STATEMENT
  {
    $$ = ast.TimingPoint_AFTER_STATEMENT
  }
| INSTEAD OF EACH ROW
  {
    $$ = ast.TimingPoint_INSTEAD_OF_EACH_ROW
  }

create_server_statement:
  CREATE SERVER table_id ddl_force_eof
  {
    $$ = &ast.CreateServerStmt{Name: $3.(ast.TableIdent)}
  }

create_synonym_statement:
  CREATE opt_edition_option opt_public SYNONYM table_name opt_sharing_clause FOR table_name
  {
    var sharingClause *ast.SharingClause
    if $6 != nil {
        sharingClause = $6.(*ast.SharingClause)
    }
    $$ = &ast.CreateSynonymStmt{Name: $5.(ast.TableName), IsPublic: $3.(bool), TargetName: $8.(ast.TableName), CreateOrReplace: false, EditionOption: $2.(ast.EditionOption), Sharing: sharingClause}
  }
| CREATE OR REPLACE opt_edition_option opt_public SYNONYM table_name opt_sharing_clause FOR table_name
  {
    var sharingClause *ast.SharingClause
    if $8 != nil {
        sharingClause = $8.(*ast.SharingClause)
    }
    $$ = &ast.CreateSynonymStmt{Name: $7.(ast.TableName), IsPublic: $5.(bool), TargetName: $10.(ast.TableName), CreateOrReplace: true, EditionOption: $4.(ast.EditionOption), Sharing: sharingClause}
  }

/* Oracle PL/SQL Type Support */
create_type_statement:
  CREATE type_declaration_no_semicolon
  {
    $$ = &ast.CreateTypeStmt{CreateOrReplace: false, TypeDecl: $2.(*ast.TypeDeclaration), ObjDecl: nil}
  }
| CREATE OR REPLACE type_declaration_no_semicolon
  {
    $$ = &ast.CreateTypeStmt{CreateOrReplace: true, TypeDecl: $4.(*ast.TypeDeclaration), ObjDecl: nil}
  }
| CREATE object_declaration
  {
    $$ = &ast.CreateTypeStmt{CreateOrReplace: false, TypeDecl: nil, ObjDecl: $2.(*ast.ObjectDeclaration)}
  }
| CREATE OR REPLACE object_declaration
  {
    $$ = &ast.CreateTypeStmt{CreateOrReplace: true, TypeDecl: nil, ObjDecl: $4.(*ast.ObjectDeclaration)}
  }

/* Oracle PL/SQL Type Body Support */
create_type_body_statement:
  CREATE object_body_declaration
  {
    $$ = &ast.CreateTypeBodyStmt{ObjBodyDecl: $2.(*ast.ObjBodyDecl), CreateOrReplace: false}
  }
| CREATE OR REPLACE object_body_declaration
  {
    $$ = &ast.CreateTypeBodyStmt{ObjBodyDecl: $4.(*ast.ObjBodyDecl), CreateOrReplace: false}
  }

/* Oracle PL/SQL Package Support */
create_package_statement:
  CREATE opt_edition_option package_spec
  {
    $$ = &ast.CreatePackageStmt{PackageSpec: $3.(*ast.PackageSpec), CreateOrReplace: false, EditionOption: $2.(ast.EditionOption), IsOracle: true}
  }
| CREATE OR REPLACE opt_edition_option package_spec
  {
    $$ = &ast.CreatePackageStmt{PackageSpec: $5.(*ast.PackageSpec), CreateOrReplace: true, EditionOption: $4.(ast.EditionOption), IsOracle: true}
  }

/* Oracle PL/SQL Package Body Support */
create_package_body_statement:
  CREATE opt_edition_option package_body
  {
    $$ = &ast.CreatePackageBodyStmt{PackageBody: $3.(*ast.PackageBody), CreateOrReplace: false, EditionOption: $2.(ast.EditionOption), IsOracle: true}
  }
| CREATE OR REPLACE opt_edition_option package_body
  {
    $$ = &ast.CreatePackageBodyStmt{PackageBody: $5.(*ast.PackageBody), CreateOrReplace: true, EditionOption: $4.(ast.EditionOption), IsOracle: true}
  }

opt_distribution:
  {
    $$ = nil
  }
| distributed_by
  {
    $$ = $1
  }

distributed_by:
  DISTRIBUTED BY HASH '(' sql_id ')' opt_partition_using
  {
    var ShardFunc ast.ColIdent
    if $7 != nil {
    	ShardFunc = $7.(ast.ColIdent)
    }
    $$ = &ast.DistributionOption{OptUsing: ast.NewColIdent(ast.HashPartition), Column: $5.(ast.ColIdent), ShardFunc: ShardFunc}
  }
| DISTRIBUTED BY REPLICATION
  {
    $$ = &ast.DistributionOption{OptUsing: ast.NewColIdent(ast.ReplicationPartition)}
  }

partition_clause_opt:
  opt_partitions_num opt_subpartition_by opt_partition_definitions
  {
    var optSubpartition *ast.SubPrtitionBy
    if $2 != nil {
       optSubpartition = $2.(*ast.SubPrtitionBy)
    }
    $$ = &ast.PartitionOpt{OptPartitionValue: $1, OptSubBy: optSubpartition, OptPartitionDef: $3.([]*ast.PartitionDefinition)}
  }

partition_clause:
  PARTITION BY opt_linear HASH list_value_tuple partition_clause_opt opt_partition_using
  {
    var PartitionOpt *ast.PartitionOpt
    if $6 != nil {
    	PartitionOpt = $6.(*ast.PartitionOpt)
    }
    var ShardFunc ast.ColIdent
    if $7 != nil {
    	ShardFunc = $7.(ast.ColIdent)
    }
    $$ = &ast.Partition{OptLinear: $3.(bool), PartitionValues: $5.(ast.ValTuple), ShardFunc: ShardFunc, OptUsing: ast.NewColIdent(ast.HashPartition), PartitionOpt: PartitionOpt}
  }
| PARTITION BY opt_linear KEY opt_key_algo '(' opt_part_list ')' partition_clause_opt
  {
    var d7 []ast.ColIdent
    if $7 != nil {
        d7 = $7.([]ast.ColIdent)
    }
    $$ = &ast.Partition{OptLinear: $3.(bool), Column: d7, KeyAlgo: $5, OptUsing: ast.NewColIdent(ast.KeyPartition), PartitionOpt: $9.(*ast.PartitionOpt)}
  }
| PARTITION BY REFERENCE '(' ident ')' partition_clause_opt
  {
    tmpCloumn := []ast.ColIdent{}
    tmpCloumn = append(tmpCloumn, ast.NewColIdent($5))
    $$ = &ast.Partition{Column: tmpCloumn, OptUsing: ast.NewColIdent(ast.ReferencePartition), PartitionOpt: $7.(*ast.PartitionOpt)}
  }
| PARTITION BY RANGE range_value_tuple opt_interval partition_clause_opt
  {
    tmpUsing := ast.NewColIdent(ast.RangePartition)
    if $5 != nil {
    	tmpUsing = ast.NewColIdent(ast.IntervalPartition)
    }
    $$ = &ast.Partition{PartitionValues: $4.(ast.ValTuple), OptUsing: tmpUsing, OptInterval: $5, PartitionOpt: $6.(*ast.PartitionOpt)}
  }
| PARTITION BY range_type '(' part_list ')' opt_interval partition_clause_opt
  {
    tmpUsing := ast.NewColIdent(ast.RangePartition)
    if $7 != nil {
    	tmpUsing = ast.NewColIdent(ast.IntervalPartition)
    }
    $$ = &ast.Partition{Column: $5.([]ast.ColIdent), OptUsing: tmpUsing, OptInterval: $7, PartitionOpt: $8.(*ast.PartitionOpt)}
  }
| PARTITION BY LIST list_value_tuple partition_clause_opt
  {
    $$ = &ast.Partition{PartitionValues: $4.(ast.ValTuple), OptUsing: ast.NewColIdent(ast.ListPartition), PartitionOpt: $5.(*ast.PartitionOpt)}
  }
| PARTITION BY list_type '(' part_list ')' partition_clause_opt
  {
    $$ = &ast.Partition{Column: $5.([]ast.ColIdent), OptUsing: ast.NewColIdent(ast.ListPartition), PartitionOpt: $7.(*ast.PartitionOpt)}
  }

opt_partitions_num:
  /* EMPTY */
  {
    $$ = ""
  }
| PARTITIONS INTEGRAL
  {
    $$ = $2
  }

opt_subpartitions_num:
  /* EMPTY */
  {
    $$ = ""
  }
| SUBPARTITIONS INTEGRAL
  {
    $$ = $2
  }

opt_subpartition_by:
  /* EMPTY */
  {
    $$ = nil
  }
| SUBPARTITION BY opt_linear HASH '(' value_expression ')' opt_subpartitions_num
  {
    $$ = &ast.SubPrtitionBy{OptLinear: $3.(bool), Type: $4, SubValue: $6, SubPartitionValue: $8}
  }
| SUBPARTITION BY opt_linear KEY opt_key_algo '(' part_list ')' opt_subpartitions_num
  {
    $$ = &ast.SubPrtitionBy{OptLinear: $3.(bool), Type: $4, KeyAlgo: $5, PartListValue: $7.([]ast.ColIdent), SubPartitionValue: $9}
  }

opt_partition_definitions:
  /* EMPTY */ %prec LOWER_THAN_CREATE_TABLE_SELECT
  {
    $$ = []*ast.PartitionDefinition{}
  }
| '(' partition_definitions ')'
  {
    $$ = $2
  }

range_type:
  RANGE COLUMNS
  {
    $$ = struct{}{}
  }

list_type:
  LIST COLUMNS
  {
    $$ = struct{}{}
  }

opt_linear:
  {
    $$ = false
  }
| LINEAR
  {
    $$ = true
  }

opt_key_algo:
  /* EMPTY */
  {
    $$ = ""
  }
| ALGORITHM '=' INTEGRAL
  {
    $$ = $3
  }

opt_part_list:
  /* EMPTY */
  {
    $$ = nil
  }
| part_list
  {
    $$ = $1.([]ast.ColIdent)
  }

create_like:
  LIKE table_name
  {
    $$ = &ast.OptLike{LikeTable: $2.(ast.TableName)}
  }
| openb LIKE table_name closeb
  {
    $$ = &ast.OptLike{LikeTable: $3.(ast.TableName)}
  }

table_element_list:
  table_element
  {
    $$ = ast.TableElements{$1.(ast.TableElement)}
  }
| table_element_list ',' table_element
  {
    d1 := $1.(ast.TableElements)
    d1 = append(d1, $3.(ast.TableElement))
    $$ = d1
  }

table_element:
  column_definition
| table_constraint_def

opt_column_attribute_list:
  {
    $$ = nil
  }
| column_attribute_list

column_attribute_list:
  column_attribute_list column_attribute
  {
    dd := $$.(ast.ColumnAttrList)
    d2 := $2.(ast.ColumnAttr)
    dd = append(dd, d2)
    $$ = dd
  }
| column_attribute
  {
    $$ = ast.ColumnAttrList{$1.(ast.ColumnAttr)}
  }

column_attribute:
  default_attribute
| null_attribute
| on_update_attribute
| auto_increment_attribute
| column_key
| column_comment_attribute
| identity_attribute
| encrypt_attribute
| COLLATE collation_name
  {
    $$ = ast.CollateAttr{Name: $2}
  }
| COLUMN_FORMAT column_format
  {
    $$ = ast.ColumnFormat{Name: $2}
  }
| STORAGE storage_media
  {
    $$ = ast.ColumnStorage{Name: $2}
  }
| ENGINE_ATTRIBUTE opt_equal json_attribute
  {
    $$ = ast.ColumnEngine{Name: $3}
  }
| SECONDARY_ENGINE_ATTRIBUTE opt_equal json_attribute
  {
    $$ = ast.SecondaryEngine{Name: $3}
  }
| SORT
  {
    $$ = ast.SortAttr{Name: $1}
  }
| visibility
  {
    $$ = ast.VisibilityAttr{Name: $1}
  }
| opt_constraint_name check_constraint
  {
    $$ = &ast.ColumnConstraint{Name: $1, Detail: $2.(*ast.CheckCondition)}
  }

column_format:
  DEFAULT
| FIXED
| DYNAMIC

storage_media:
  DEFAULT
| DISK
| MEMORY

default_attribute:
  DEFAULT now_or_signed_literal
  {
    $$ = &ast.DefaultAttr{Attr: $2}
  }
| DEFAULT openb expression closeb
  {
    $$ = &ast.DefaultAttr{Attr: $3, HasParentheses: true}
  }
| DEFAULT function_call_keyword
  {
    $$ = &ast.DefaultAttr{Attr: $2, HasParentheses: true}
  }

identity_attribute:
  GENERATED AS IDENTITY opt_identity_options
  {
    $$ = &ast.IdentityAttr{IdentityOption: $4.([]string)}
  }
| GENERATED ALWAYS AS IDENTITY opt_identity_options
  {
    $$ = &ast.IdentityAttr{IdentityOption: $5.([]string), Type: $2}
  }
| GENERATED BY DEFAULT opt_not_null AS IDENTITY opt_identity_options
  {
    $$ = &ast.IdentityAttr{IdentityOption: $7.([]string), Type: $3, NullValue: $4}
  }

opt_identity_options:
  {
    $$ = nil
  }
| '(' identity_options ')'
  {
    $$ = $2.([]string)
  }

identity_options:
  identity_option
  {
    $$ = []string{$1.(string)}
  }
| identity_options identity_option
  {
    $$ = append($1.([]string), $2.(string))
  }

identity_option:
  START WITH INTEGRAL
  {
    $$ = "START WITH " + $3
  }
| START WITH LIMIT VALUE
  {
    $$ = "START WITH LIMIT VALUE"
  }
| INCREMENT BY INTEGRAL
  {
    $$ = "INCREMENT BY " + $3
  }
| MAXVALUE INTEGRAL
  {
    $$ = "MAXVALUE " + $2
  }
| MAXVALUE NOMAXVALUE
  {
    $$ = "MAXVALUE NOMAXVALUE"
  }
| MINVALUE INTEGRAL
  {
    $$ = "MINVALUE " + $2
  }
| MINVALUE NOMINVALUE
  {
    $$ = "MINVALUE " + $2
  }
| CYCLE
  {
    $$ = $1
  }
| NOCYCLE
  {
    $$ = $1
  }
| CACHE INTEGRAL
  {
    $$ = "CACHE " + $2
  }
| NOCACHE
  {
    $$ = $1
  }
| ORDER
  {
    $$ = $1
  }
| NOORDER
  {
    $$ = $1
  }

field_def:
  column_type opt_column_attribute_list
  {
    var d2 ast.ColumnAttrList
    if $2 != nil {
    	d2 = $2.(ast.ColumnAttrList)
    }
    $$ = ast.NewFieldDef($1.(ast.ColumnType), d2)
  }

column_definition:
  sql_id field_def opt_references column_definition_constraint
  {
    var d3 *ast.Reference
    if $3 != nil {
    	tmp := $3.(ast.Reference)
    	d3 = &tmp
    }
    $$ = &ast.ColumnDefinition{Name: $1.(ast.ColIdent), Field: $2.(ast.Field), Refs: d3}
  }

encrypt_attribute:
  ENCRYPT opt_using_encrypt_algorithm opt_identified_by opt_integrity_algorithm opt_no_salt
  {
    $$ = &ast.EncryptAttr{Encrypt: $2.(string), IdentifiedBy: $3.(string), Integrity: $4.(string), Salt: $5.(string)}
  }

opt_using_encrypt_algorithm:
  {
    $$ = ""
  }
| USING STRING
  {
    $$ = $1 + " " + $2
  }

opt_identified_by:
  {
    $$ = ""
  }
| IDENTIFIED BY STRING
  {
    $$ = "IDENTIFIED BY " + $3
  }

opt_integrity_algorithm:
  {
    $$ = ""
  }
| STRING
  {
    $$ = $1
  }

opt_no_salt:
  {
    $$ = ""
  }
| SALT
  {
    $$ = $1
  }
| NO SALT
  {
    $$ = $1 + " " + $2
  }

column_definition_constraint:
  {
    $$ = nil
  }
| inline_ref_constraint
  {
    $$ = []ast.InlineConstraint{$1.(ast.InlineConstraint)}
  }

inline_ref_constraint:
  SCOPE IS ident
  {
    $$ = ast.InlineConstraint{IsRef: true, Name: $3, Type: $1}
  }

column_type:
  data_type
  {
    dd := ast.ColumnType{}
    d1 := $1.(*ast.DataType)

    var nativeType string
    if d1.TypeWithPrecision != nil {
        switch strings.ToLower(d1.TypeWithPrecision.NativeType) {
        case "number":
            nativeType = "numeric"
        case "dec":
            nativeType = "decimal"
        case "varchar2":
            nativeType = "varchar"
        case "nvarchar2":
            nativeType = "varchar"
        case "binary_float":
            nativeType = "float"
        case "binary_double":
            nativeType = "float"
        case "nclob":
            nativeType = "text"
        case "bfile":
            nativeType = "blob"
        case "clob":
            nativeType = "text"
        case "raw":
            nativeType = "varchar"
        case "long raw":
            nativeType = "blob"
        case "long":
            nativeType = "text"
        case "rowid":
            nativeType = "varchar"
        case "urowid":
            nativeType = "varchar"
        case "double precision":
            nativeType = "float"
        default:
            nativeType = d1.TypeWithPrecision.NativeType
        }
        dd.Type = nativeType
        if d1.TypeWithPrecision.OptPrecision != nil {
            dd.Length = ast.NewIntValV2(d1.TypeWithPrecision.OptPrecision.OptLength)
            dd.OptScale = d1.TypeWithPrecision.OptPrecision.OptScale
            dd.CharByte = d1.TypeWithPrecision.OptPrecision.OptCharByte
        }
        dd.OptCharSet = d1.OptCharSet
        dd.OptWith = d1.OptWith
        dd.OptLocal = d1.OptLocal
    } else {
        dd.FromTimePeriod = d1.FromTimePeriod
        dd.OptIntervalFrom = d1.OptIntervalFrom
        dd.ToTimePeriod = d1.ToTimePeriod
        dd.OptIntervalTo = d1.OptIntervalTo
    }
    $$ = dd
  }

text_string_list:
  text_string
  {
    dd := make([]string, 0, 4)
    dd = append(dd, "'"+$1+"'")
    $$ = dd
  }
| text_string_list ',' text_string
  {
    dd := $1.([]string)
    dd = append(dd, "'"+$3+"'")
    $$ = dd
  }

text_string:
  STRING
| HEX
  {
    dd, err := ast.NewHexLiteral($1)
    if err != nil {
    	yylex.Error(err.Error())
    	return 1
    }
    $$ = string(dd)
  }
| HEXNUM
  {
    dd, err := ast.NewHexLiteral($1)
    if err != nil {
    	yylex.Error(err.Error())
    	return 1
    }
    $$ = string(dd)
  }
| BIT_LITERAL
  {
    dd, err := ast.NewBitLiteral($1)
    if err != nil {
    	yylex.Error(err.Error())
    	return 1
    }
    $$ = string(dd)
  }

null_attribute:
  NULL
  {
    $$ = &ast.NullAttr{Attr: $1}
  }
| NOT NULL
  {
    $$ = &ast.NullAttr{Attr: $1 + " " + $2}
  }

on_update_attribute:
  ON UPDATE now
  {
    $$ = &ast.OnUpdateAttr{Attr: $3}
  }

now_or_signed_literal:
  now
| signed_literal

signed_literal:
  STRING
  {
    $$ = ast.NewStrValV2($1)
  }
| INTEGRAL
  {
    $$ = ast.NewIntValV2($1)
  }
| '-' INTEGRAL
  {
    $$ = ast.NewIntValV2("-" + $2)
  }
| FLOAT
  {
    $$ = ast.NewFloatValV2($1)
  }
| '-' FLOAT
  {
    $$ = ast.NewFloatValV2("-" + $2)
  }
| NULL
  {
    $$ = ast.NewValArgV2($1)
  }
| boolean_value
  {
    $$ = ast.NewSQLBoolVal($1.(ast.BoolVal))
  }
| BIT_LITERAL
  {
    $$ = ast.NewBitValV2($1)
  }

now:
  NOW opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
| CURRENT_TIMESTAMP opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
// now
| LOCALTIME opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
// now
| LOCALTIMESTAMP opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }

auto_increment_attribute:
  AUTO_INCREMENT
  {
    $$ = &ast.AutoIncAttr{Attr: ast.BoolVal(true)}
  }

opt_collate:
  {
    $$ = ""
  }
| COLLATE collation_name
  {
    $$ = $2
  }

column_key:
  PRIMARY KEY
  {
    $$ = ast.ColKeyPrimary
  }
| KEY
  {
    $$ = ast.ColKey
  }
| UNIQUE KEY
  {
    $$ = ast.ColKeyUniqueKey
  }
| UNIQUE
  {
    $$ = ast.ColKeyUnique
  }

column_comment_attribute:
  COMMENT_KEYWORD STRING
  {
    $$ = &ast.ColumnComment{Attr: ast.NewStrValV2($2)}
  }

index_or_key:
  INDEX
| KEY

indexes_or_keys:
  INDEX
| INDEXES
| KEYS

opt_index_or_key:
  {
    $$ = ""
  }
| index_or_key

key_list_with_expression:
  key_list_with_expression ',' key_part_with_expression
  {
    dd := $$.(ast.KeyPartSpecs)
    dd = append(dd, $3.(*ast.KeyPartSpec))
    $$ = dd
  }
| key_part_with_expression
  {
    $$ = ast.KeyPartSpecs{$1.(*ast.KeyPartSpec)}
  }

key_part_with_expression:
  key_part
| openb expression closeb opt_ordering_direction
  {
    $$ = &ast.KeyPartSpec{Expr: $2, Order: $4}
  }

key_list:
  key_list ',' key_part
  {
    dd := $$.(ast.KeyPartSpecs)
    dd = append(dd, $3.(*ast.KeyPartSpec))
    $$ = dd
  }
| key_part
  {
    $$ = ast.KeyPartSpecs{$1.(*ast.KeyPartSpec)}
  }

key_part:
  sql_id opt_ordering_direction
  {
    $$ = &ast.KeyPartSpec{Name: $1.(ast.ColIdent), Order: $2}
  }
| sql_id openb INTEGRAL closeb opt_ordering_direction
  {
    $$ = &ast.KeyPartSpec{Name: $1.(ast.ColIdent), Length: ast.NewIntValV2($3), Order: $5}
  }

opt_ordering_direction:
  {
    $$ = ""
  }
| ordering_direction

ordering_direction:
  ASC
| DESC

check_constraint:
  CHECK openb expression closeb
  {
    $$ = &ast.CheckCondition{CheckExpr: $3}
  }

opt_references:
  {
    $$ = nil
  }
| references

references:
  REFERENCES table_name opt_ref_list opt_match_clause opt_on_update_delete
  {
    var d5 *ast.OnUpdateDelete
    if $5 != nil {
    	tmp := $5.(ast.OnUpdateDelete)
    	d5 = &tmp
    }
    var d3 ast.Columns
    if $3 != nil {
    	d3 = $3.(ast.Columns)
    }
    $$ = ast.Reference{ReferencedTable: $2.(ast.TableName), ReferencedColumns: d3, MatchOption: $4.(ast.FKMatchOption), Actions: d5}
  }

opt_match_clause:
  {
    $$ = ast.FKMatchUndef
  }
| MATCH FULL
  {
    $$ = ast.FKMatchFull
  }
| MATCH PARTIAL
  {
    $$ = ast.FKMatchPartial
  }
| MATCH SIMPLE
  {
    $$ = ast.FKMatchSimple
  }

opt_ref_list:
  {
    $$ = nil
  }
| openb column_list closeb
  {
    $$ = $2
  }

column_list:
  sql_id
  {
    $$ = ast.Columns{$1.(ast.ColIdent)}
  }
| column_list ',' sql_id
  {
    dd := $$.(ast.Columns)
    dd = append(dd, $3.(ast.ColIdent))
    $$ = dd
  }

opt_on_update_delete:
  {
    var dd ast.OnUpdateDelete
    dd.OnDelete = ast.FKOptionUndef
    dd.OnUpdate = ast.FKOptionUndef
    $$ = dd
  }
| fk_on_delete
  {
    var dd ast.OnUpdateDelete
    dd.OnDelete = $1.(ast.FKOption)
    dd.OnUpdate = ast.FKOptionUndef
    $$ = dd
  }
| fk_on_update
  {
    var dd ast.OnUpdateDelete
    dd.OnDelete = ast.FKOptionUndef
    dd.OnUpdate = $1.(ast.FKOption)
    $$ = dd
  }
| fk_on_delete fk_on_update
  {
    var dd ast.OnUpdateDelete
    dd.OnDelete = $1.(ast.FKOption)
    dd.OnUpdate = $2.(ast.FKOption)
    $$ = dd
  }
| fk_on_update fk_on_delete
  {
    var dd ast.OnUpdateDelete
    dd.OnDelete = $2.(ast.FKOption)
    dd.OnUpdate = $1.(ast.FKOption)
    $$ = dd
  }

fk_on_delete:
  ON DELETE fk_reference_action
  {
    $$ = $3.(ast.FKOption)
  }

fk_on_update:
  ON UPDATE fk_reference_action
  {
    $$ = $3.(ast.FKOption)
  }

fk_reference_action:
  RESTRICT
  {
    $$ = ast.FKOptionRestrict
  }
| CASCADE
  {
    $$ = ast.FKOptionCascade
  }
| NO ACTION
  {
    $$ = ast.FKOptionNoAction
  }
| SET DEFAULT
  {
    $$ = ast.FKOptionDefault
  }
| SET NULL
  {
    $$ = ast.FKOptionSetNull
  }

opt_create_table_options_etc:
  {
    $$ = ast.CreateTableTail{}
  }
| create_table_options_etc
  {
    $$ = $1
  }

create_table_options_etc:
  create_table_options create_partitioning_etc
  {
    dd := $2.(ast.CreateTableTail)
    if $1 != nil {
    	dd.TableOptions = $1.(ast.TableOptions)
    }
    $$ = dd
  }
| create_table_options
  {
    $$ = ast.CreateTableTail{TableOptions: $1.(ast.TableOptions)}
  }
| create_partitioning_etc

create_partitioning_etc:
  partition_clause opt_duplicate_as_qe
  {
    dd := $2.(ast.CreateTableTail)
    if $1 != nil {
    	dd.OptPartition = $1.(*ast.Partition)
    }
    $$ = dd
  }
| partition_clause %prec LOWER_THAN_KEYWORD
  {
    $$ = ast.CreateTableTail{OptPartition: $1.(*ast.Partition)}
  }
| opt_duplicate_as_qe

opt_duplicate_as_qe:
  as_create_query_expression
  {
    $$ = ast.CreateTableTail{OptQueryExpr: $1.(ast.SelectStatement)}
  }
| duplicate as_create_query_expression
  {
    $$ = ast.CreateTableTail{OnDuplicate: $1, OptQueryExpr: $2.(ast.SelectStatement)}
  }

duplicate:
  IGNORE
| REPLACE

as_create_query_expression:
  select_statement
| AS select_statement
  {
    $$ = $2
  }

create_table_options:
  create_table_option
  {
    $$ = ast.TableOptions{$1.(*ast.TableOption)}
  }
| create_table_options opt_comma create_table_option
  {
    d1 := $1.(ast.TableOptions)
    d3 := $3.(*ast.TableOption)
    $$ = append(d1, d3)
  }

opt_comma:
  {
    $$ = ""
  }
| ','

create_table_option:
  ENGINE opt_equal ident_or_text
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| MAX_ROWS opt_equal INTEGRAL
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| MIN_ROWS opt_equal INTEGRAL
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| AVG_ROW_LENGTH opt_equal INTEGRAL
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| PASSWORD opt_equal STRING
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| COMMENT_KEYWORD opt_equal STRING
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| COMPRESSION opt_equal STRING
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| ENCRYPTION opt_equal STRING
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| AUTO_INCREMENT opt_equal INTEGRAL
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| PACK_KEYS opt_equal int_or_default
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| STATS_AUTO_RECALC opt_equal int_or_default
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| STATS_PERSISTENT opt_equal int_or_default
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| STATS_SAMPLE_PAGES opt_equal int_or_default
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| CHECKSUM opt_equal INTEGRAL
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| DELAY_KEY_WRITE opt_equal INTEGRAL
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| ROW_FORMAT opt_equal row_types
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| UNION opt_equal openb opt_table_name_list closeb
  {
    var d4 ast.TableNames
    if $4 != nil {
    	d4 = $4.(ast.TableNames)
    }
    $$ = &ast.TableOption{OptionName: $1, TableNames: d4}
  }
| default_charset
  {
    $$ = $1.(*ast.TableOption)
  }
| default_collation
  {
    $$ = $1.(*ast.TableOption)
  }
| INSERT_METHOD opt_equal merge_insert_types
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| DATA DIRECTORY opt_equal STRING
  {
    $$ = &ast.TableOption{OptionName: $1 + " " + $2, OptionValue: $4}
  }
| INDEX DIRECTORY opt_equal STRING
  {
    $$ = &ast.TableOption{OptionName: $1 + " " + $2, OptionValue: $4}
  }
| TABLESPACE opt_equal ident
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| STORAGE DISK
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $2}
  }
| STORAGE MEMORY
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $2}
  }
| CONNECTION opt_equal STRING
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| KEY_BLOCK_SIZE opt_equal INTEGRAL
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| ENGINE_ATTRIBUTE opt_equal json_attribute
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| SECONDARY_ENGINE_ATTRIBUTE opt_equal json_attribute
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }
| REMOTE_SEQ opt_equal INTEGRAL
  {
    $$ = &ast.TableOption{OptionName: $1, OptionValue: $3}
  }

merge_insert_types:
  NO
| FIRST
| LAST

json_attribute:
  STRING

row_types:
  DEFAULT
| FIXED
| DYNAMIC
| COMPRESSED
| REDUNDANT
| COMPACT

default_charset:
  opt_default_keyword charset_keywords opt_equal charset_name
  {
    var d1 string
    if $1 != "" {
    	d1 = $1 + " "
    }
    $$ = &ast.TableOption{OptionName: d1 + $2, OptionValue: $4}
  }

default_collation:
  opt_default_keyword COLLATE opt_equal collation_name
  {
    var d1 string
    if $1 != "" {
    	d1 = $1 + " "
    }
    $$ = &ast.TableOption{OptionName: d1 + $2, OptionValue: $4}
  }

int_or_default:
  INTEGRAL
| DEFAULT

ident_or_text:
  STRING
| ident

opt_index_option_list:
  {
    $$ = nil
  }
| index_option_list

index_option_list:
  index_option
  {
    $$ = ast.IndexOptions{$1.(*ast.IndexOption)}
  }
| index_option_list index_option
  {
    dd := $$.(ast.IndexOptions)
    dd = append(dd, $2.(*ast.IndexOption))
    $$ = dd
  }

index_option:
  KEY_BLOCK_SIZE opt_equal INTEGRAL
  {
    $$ = &ast.IndexOption{KeyBlockSize: ast.NewIntValV2($3)}
  }
| USING BTREE
  {
    $$ = &ast.IndexOption{Using: $2}
  }
| USING HASH
  {
    $$ = &ast.IndexOption{Using: $2}
  }
| USING RTREE
  {
    $$ = &ast.IndexOption{Using: $2}
  }
| WITH PARSER ID
  {
    $$ = &ast.IndexOption{PaserName: $3}
  }
| COMMENT_KEYWORD STRING
  {
    $$ = &ast.IndexOption{Comment: ast.NewStrValV2($2)}
  }

opt_index_option:
  {
    $$ = nil
  }
| index_option

alter_statement:
  alter_database_statement
| alter_table_statement
| alter_view_statement
| alter_trigger_statement
| alter_function_statement
| alter_procedure_statement
| alter_package_statement
| alter_server_statement
| alter_indextype_statement
| alter_operator_statement

alter_database_statement:
  ALTER database_or_schema table_id database_option
  {
    $$ = &ast.AlterDatabaseStmt{Name: $3.(ast.TableIdent), Options: $4.(ast.SchemaOptions)}
  }

alter_table_statement:
  ALTER TABLE table_name opt_alter_table_actions
  {
    d4 := $4.(*ast.AlterList)
    actions := d4.Actions
    algo := d4.Flags.Algo.GetOrDefault()
    lock := d4.Flags.Lock.GetOrDefault()
    validation := d4.Flags.Validation.GetOrDefault()
    $$ = &ast.AlterTableStmt{Name: $3.(ast.TableName), Actions: actions, Algo: algo.(ast.AlterTableAlgorithm), Lock: lock.(ast.AlterTableLock), Validation: validation.(ast.WithValidation)}
  }
| ALTER TABLE table_name standalone_alter_table_action
  {
    d4 := $4.(*ast.AlterList)
    actions := d4.Actions
    algo := d4.Flags.Algo.GetOrDefault()
    lock := d4.Flags.Lock.GetOrDefault()
    validation := d4.Flags.Validation.GetOrDefault()
    $$ = &ast.AlterTableStmt{Name: $3.(ast.TableName), Actions: actions, Algo: algo.(ast.AlterTableAlgorithm), Lock: lock.(ast.AlterTableLock), Validation: validation.(ast.WithValidation)}
  }

standalone_alter_table_action:
  standalone_alter_commands
  {
    var dd ast.AlterList
    dd.Flags.Init()
    dd.Actions = append(dd.Actions, $1.(ast.DDLTableOption))
    $$ = &dd
  }
| alter_commands_modifier_list ',' standalone_alter_commands
  {
    var dd ast.AlterList
    dd.Flags = *$1.(*ast.AlgoLockValidation)
    dd.Actions = append(dd.Actions, $3.(ast.DDLTableOption))
    $$ = &dd
  }

standalone_alter_commands:
  partition_operation
| ADD PARTITION '(' partition_definitions ')'
  {
    $$ = &ast.PartitionSpec{Action: ast.AddInt, Definitions: $4.([]*ast.PartitionDefinition)}
  }
| DROP PARTITION ident_string_list
  {
    dd := ast.AlterTableDropPartition{Name: $3.([]string)}
    dd.SetAlterFlag(ast.AlterDropPartition)
    $$ = dd
  }
| RENAME PARTITION ID TO ID
  {
    // mysql has no support for renaming a partition
    // this is kundb's spec
    dd := ast.AlterTableRenamePartition{OldName: $3, NewName: $5}
    $$ = dd
  }
| TRUNCATE PARTITION partition_names_or_all
  {
    dd := ast.AlterTableTruncatePartition{Names: $3.(ast.PartitionNames)}
    dd.SetAlterFlag(ast.AlterTruncatePartition)
    $$ = dd
  }
| ADD PARTITION PARTITIONS INTEGRAL
  {
    dd := ast.AlterTableAddPartition{Partitions: ast.NewIntValV2($4)}
    dd.SetAlterFlag(ast.AlterAddPartition)
    $$ = dd
  }
| REORGANIZE PARTITION opt_partition_names
  {
    $$ = ast.ReorganizeInt
    dd := ast.AlterTableReorganizePartition{Partitions: $3.(ast.PartitionNames)}
    dd.SetAlterFlag(ast.AlterReorganizePartition)
    $$ = dd
  }

opt_partition_names:
  /* EMPTY */
  {
    $$ = ast.PartitionNames{}
  }
| partition_names

partition_names_or_all:
  ALL
  {
    $$ = ast.PartitionNames{ast.AllStr}
  }
| partition_names
  {
    $$ = $1
  }

partition_names:
  ID
  {
    $$ = ast.PartitionNames{$1}
  }
| partition_names ',' ID
  {
    $$ = append($1.(ast.PartitionNames), $3)
  }

opt_alter_table_actions:
  opt_alter_command_list
| opt_alter_command_list alter_table_partition_options
  {
    d1 := $1.(*ast.AlterList)
    d1.Actions = append(d1.Actions, $2.(ast.DDLTableOption))
    $$ = d1
  }

opt_alter_command_list:
  {
    var dd ast.AlterList
    dd.Flags.Init()
    $$ = &dd
  }
| alter_commands_modifier_list
  {
    var dd ast.AlterList
    dd.Flags = *$1.(*ast.AlgoLockValidation)
    $$ = &dd
  }
| alter_list
| alter_commands_modifier_list ',' alter_list
  {
    d3 := $3.(*ast.AlterList)
    flag := $1.(*ast.AlgoLockValidation)
    d3.Flags.Merge(flag)
    $$ = d3
  }

alter_commands_modifier_list:
  alter_commands_modifier
| alter_commands_modifier_list ',' alter_commands_modifier
  {
    d1 := $1.(*ast.AlgoLockValidation)
    d1.Merge($3.(*ast.AlgoLockValidation))
    $$ = d1
  }

alter_commands_modifier:
  alter_algorithm_option
  {
    var dd ast.AlgoLockValidation
    dd.Init()
    dd.Algo.Set($1)
    $$ = &dd
  }
| alter_lock_option
  {
    var dd ast.AlgoLockValidation
    dd.Init()
    dd.Lock.Set($1)
    $$ = &dd
  }
| with_validation
  {
    var dd ast.AlgoLockValidation
    dd.Init()
    dd.Validation.Set($1)
    $$ = &dd
  }

opt_index_lock_and_algorithm:
  {
    var dd ast.AlgoLockValidation
    dd.Init()
    $$ = &dd
  }
| alter_lock_option
  {
    var dd ast.AlgoLockValidation
    dd.Init()
    dd.Lock.Set($1)
    $$ = &dd
  }
| alter_algorithm_option
  {
    var dd ast.AlgoLockValidation
    dd.Init()
    dd.Algo.Set($1)
    $$ = &dd
  }
| alter_lock_option alter_algorithm_option
  {
    var dd ast.AlgoLockValidation
    dd.Init()
    dd.Lock.Set($1)
    dd.Algo.Set($2)
  }
| alter_algorithm_option alter_lock_option
  {
    var dd ast.AlgoLockValidation
    dd.Init()
    dd.Algo.Set($1)
    dd.Lock.Set($2)
  }

alter_algorithm_option:
  ALGORITHM opt_equal alter_algorithm_option_value
  {
    $$ = ast.NewAlterTableAlgo($3)
  }

alter_algorithm_option_value:
  DEFAULT
| ident
  {
    if !ast.IsValidAlterAlgo($1) {
    	yylex.Error("Unknown ALGORITHM " + $1)
    }
    $$ = $1
  }

alter_lock_option:
  LOCK opt_equal alter_lock_option_value
  {
    $$ = ast.NewAlterTableLock($3)
  }

alter_lock_option_value:
  DEFAULT
| ident
  {
    if !ast.IsValidAlterLock($1) {
    	yylex.Error("Unknown LOCK Type " + $1)
    }
    $$ = $1
  }

with_validation:
  WITH VALIDATION
  {
    $$ = ast.AlterWithValidation
  }
| WITHOUT VALIDATION
  {
    $$ = ast.AlterWithoutValidation
  }

alter_list:
  alter_list_item
  {
    var dd ast.AlterList
    dd.Flags.Init()
    d1 := $1.(ast.DDLTableOption)
    dd.Actions = append(dd.Actions, d1)
    $$ = &dd
  }
| alter_list ',' alter_list_item
  {
    d1 := $1.(*ast.AlterList)
    d3 := $3.(ast.DDLTableOption)
    d1.Actions = append(d1.Actions, d3)
    $$ = d1
  }
| alter_list ',' alter_commands_modifier
  {
    d1 := $1.(*ast.AlterList)
    d3 := $3.(*ast.AlgoLockValidation)
    d1.Flags.Merge(d3)
    $$ = d1
  }
| create_table_options_space_separated
  {
    var dd ast.AlterList
    dd.Flags.Init()
    d1 := $1.(ast.TableOptions)
    for _, option := range d1 {
    	dd.Actions = append(dd.Actions, option)
    }
    $$ = &dd
  }
| alter_list ',' create_table_options_space_separated
  {
    d1 := $1.(*ast.AlterList)
    for _, option := range $3.(ast.TableOptions) {
    	d1.Actions = append(d1.Actions, option)
    }
    $$ = d1
  }

alter_view_statement:
  ALTER VIEW table_name view_column_list AS select_statement opt_subquery_restriction_clause
  {
    var columnNames ast.Columns
    if $4 != nil {
    	columnNames = $4.(ast.Columns)
    }
    tmpViewSpec := &ast.ViewSpec{ViewName: $3.(ast.TableName).ToViewName(), ColumnNames: columnNames, Select: $6.(ast.SelectStatement), WithCheckOption: $7}
    $$ = &ast.AlterViewStmt{Name: $3.(ast.TableName).ToViewName(), ViewSpec: tmpViewSpec, IsOracle: true}
  }
| ALTER VIEW table_name alter_view_option
  {
    tmpViewSpec := &ast.ViewSpec{ViewName: $3.(ast.TableName).ToViewName(), IsNotformat: true}
    $$ = &ast.AlterViewStmt{Name: $3.(ast.TableName).ToViewName(), AlterViewOption: $4.(string), ViewSpec: tmpViewSpec, IsOracle: true}
  }
| ALTER VIEW table_name ADD out_of_line_constraint
  {
    tmpViewSpec := &ast.ViewSpec{ViewName: $3.(ast.TableName).ToViewName(), IsNotformat: true}
    $$ = &ast.AlterViewStmt{Name: $3.(ast.TableName).ToViewName(), OutofLineConstraint: $5.(*ast.OutofLineConstraint),ViewSpec: tmpViewSpec, IsOracle: true}
  }
| ALTER VIEW table_name DROP UNIQUE column_list
  {
    tmpViewSpec := &ast.ViewSpec{ViewName: $3.(ast.TableName).ToViewName(), IsNotformat: true}
    $$ = &ast.AlterViewStmt{Name: $3.(ast.TableName).ToViewName(), ColumnList: $3.(ast.Columns), ViewSpec: tmpViewSpec, IsOracle: true}
  }

alter_view_option:
  MODIFY CONSTRAINT ident opt_rely_norely
  {
    $$ = "MODIFY CONSTRAINT " + $3 + " " + $4
  }
| DROP CONSTRAINT ident
  {
    $$ = "DROP CONSTRAINT " + $3
  }
| DROP PRIMARY KEY
  {
    $$ = "DROP PRIMARY KEY"
  }
| COMPILE
  {
    $$ = "COMPILE"
  }
| opt_read_only_clause
  {
    $$ = $1.(string)
  }
| edition_option
  {
    if $1 == ast.EditionOption_EDITIONABLE {
      $$ = "EDITIONABLE"
    } else {
      $$ = "NONEDITIONABLE"
    }
  }

create_table_options_space_separated:
  create_table_option
  {
    var dd ast.TableOptions
    d1 := $1.(*ast.TableOption)
    dd = append(dd, d1)
    $$ = dd
  }
| create_table_options_space_separated create_table_option
  {
    dd := $$.(ast.TableOptions)
    dd = append(dd, $2.(*ast.TableOption))
    $$ = dd
  }

alter_list_item:
  ADD opt_column sql_id field_def opt_references opt_place
  {
    var d5 *ast.Reference
    if $5 != nil {
    	temp := $5.(ast.Reference)
    	d5 = &temp
    }
    dd := ast.AlterTableAddColumn{ColDef: ast.ColumnDefinition{Name: $3.(ast.ColIdent), Field: $4.(ast.Field), Refs: d5, Place: $6}}
    dd.SetAlterFlag(ast.AlterAddColumn)
    $$ = dd
  }
| ADD opt_column '(' table_element_list ')'
  {
    dd := ast.AlterTableAddColumns{Columns: $4.(ast.TableElements)}
    dd.SetAlterFlag(ast.AlterAddColumn)
    $$ = dd
  }
| ADD table_constraint_def
  {
    dd := ast.AlterTableAddConstraint{TblConstraintDef: $2.(ast.TableConstraintDef)}
    dd.SetAlterFlag(ast.AlterAddIndex)
    $$ = dd
  }
| CHANGE opt_column sql_id sql_id field_def opt_place
  {
    dd := ast.AlterTableChangeColumn{OldName: $3.(ast.ColIdent), NewName: $4.(ast.ColIdent), Field: $5.(ast.Field), Place: $6}
    dd.SetAlterFlag(ast.AlterChangeColumn)
    $$ = dd
  }
| MODIFY opt_column sql_id field_def opt_place
  {
    dd := ast.AlterTableChangeColumn{IsModify: true, OldName: $3.(ast.ColIdent), NewName: $3.(ast.ColIdent), Field: $4.(ast.Field), Place: $5}
    dd.SetAlterFlag(ast.AlterChangeColumn)
    $$ = dd
  }
| DROP opt_column ident opt_restrict
  {
    // Note: opt_restrict ($4) is ignored!
    dd := ast.NewAlterTableDropColumn($3, ast.DTColumn)
    dd.SetAlterFlag(ast.AlterDropColumn)
    $$ = dd
  }
| DROP FOREIGN KEY ident
  {
    dd := ast.NewAlterTableDropForeignKey($4, ast.DTForeignKey)
    dd.SetAlterFlag(ast.DropForeignKey)
    $$ = dd
  }
| DROP PRIMARY KEY
  {
    dd := ast.NewAlterTableDropKey(ast.PrimaryKeyName, ast.DTKey)
    dd.SetAlterFlag(ast.AlterDropIndex)
    $$ = dd
  }
| DROP index_or_key ident
  {
    dd := ast.NewAlterTableDropKey($3, ast.DTKey)
    dd.SetAlterFlag(ast.AlterDropIndex)
    $$ = dd
  }
| DROP CHECK ident
  {
    dd := ast.NewAlterTableDropCheckConstraint($3, ast.DTCheckConstraint)
    dd.SetAlterFlag(ast.DropCheckConstraint)
    $$ = dd
  }
| DROP CONSTRAINT ident
  {
    dd := ast.NewAlterTableDropConstraint($3, ast.DTAnyConstraint)
    dd.SetAlterFlag(ast.DropAnyConstraint)
    $$ = dd
  }
| DISABLE KEYS
  {
    dd := ast.AlterTableEnableKeys{EnableKeys: false}
    dd.SetAlterFlag(ast.AlterKeysOnOff)
    $$ = dd
  }
| ENABLE KEYS
  {
    dd := ast.AlterTableEnableKeys{EnableKeys: true}
    dd.SetAlterFlag(ast.AlterKeysOnOff)
    $$ = dd
  }
| ALTER opt_column ident SET DEFAULT signed_literal
  {
    dd := ast.AlterTableSetDefault{Name: $3, DefaultVal: $6.(*ast.SQLVal)}
    dd.SetAlterFlag(ast.AlterChangeColumnDefault)
    $$ = dd
  }
| ALTER opt_column ident SET DEFAULT '(' expression ')'
  {
    dd := ast.AlterTableSetDefault{Name: $3, DefaultExpr: $7}
    dd.SetAlterFlag(ast.AlterChangeColumnDefault)
    $$ = dd
  }
| ALTER opt_column ident DROP DEFAULT
  {
    dd := ast.AlterTableSetDefault{Name: $3}
    dd.SetAlterFlag(ast.AlterChangeColumnDefault)
    $$ = dd
  }
| ALTER INDEX ident visibility
  {
    $$ = ast.AlterTableNotSupport{Info: "ALTER INDEX xx VISIBLE/NOT VISIBLE is not support"}
  }
| ALTER CHECK ident constraint_enforcement
  {
    $$ = ast.AlterTableNotSupport{Info: "ALTER CHECK xx ENFORCE/NOT ENFORCE is not support"}
  }
| ALTER CONSTRAINT ident constraint_enforcement
  {
    $$ = ast.AlterTableNotSupport{Info: "ALTER CONSTRAINT xx ENFORCE/NOT ENFORCE is not support"}
  }
| RENAME opt_to table_name
  {
    dd := ast.AlterTableRename{Name: $3.(ast.TableName)}
    dd.SetAlterFlag(ast.AlterRenameV2)
    $$ = dd
  }
| RENAME index_or_key ident TO ident
  {
    dd := ast.AlterTableRenameKey{OldName: $3, NewName: $5}
    dd.SetAlterFlag(ast.AlterRenameIndex)
    $$ = dd
  }
| RENAME COLUMN ident TO ident
  {
    dd := ast.AlterTableRenameColumn{OldName: $3, NewName: $5}
    dd.SetAlterFlag(ast.AlterChangeColumn)
    $$ = dd
  }
| CONVERT TO charset_keywords charset_name opt_collate
  {
    dd := ast.AlterTableConvertToCharset{Charset: $4, Collate: $5}
    dd.SetAlterFlag(ast.AlterOptions)
    $$ = dd
  }
| CONVERT TO charset_keywords DEFAULT opt_collate
  {
    dd := ast.AlterTableConvertToCharset{Charset: $4, Collate: $5}
    dd.SetAlterFlag(ast.AlterOptions)
    $$ = dd
  }
| FORCE
  {
    $$ = ast.AlterTableNotSupport{Info: "ALTER TABLE FORCE is not support"}
  }
| ORDER BY alter_order_list %prec LOWERTHANORDER
  {
    dd := ast.AlterTableOrder{OrderList: $3.(ast.AlterOrderList)}
    dd.SetAlterFlag(ast.AlterOrder)
    $$ = dd
  }

alter_order_list:
  alter_order_list ',' alter_order_item
  {
    d1 := $1.(ast.AlterOrderList)
    d1 = append(d1, $3.(ast.AlterOrderItem))
    $$ = d1
  }
| alter_order_item
  {
    dd := ast.AlterOrderList{$1.(ast.AlterOrderItem)}
    $$ = dd
  }

alter_order_item:
  column_name opt_ordering_direction
  {
    d1 := $1.(*ast.ColName)
    $$ = ast.AlterOrderItem{ColName: *d1, Direction: $2}
  }

visibility:
  VISIBLE
| INVISIBLE

opt_not:
  {
    $$ = ""
  }
| NOT

constraint_enforcement:
  opt_not ENFORCED
  {
    if $1 == "" {
    	$$ = true
    } else {
    	$$ = false
    }
  }

table_constraint_def:
  index_or_key opt_index_name_and_type '(' key_list_with_expression ')' opt_index_option_list
  {
    var d6 ast.IndexOptions
    if $6 != nil {
    	d6 = $6.(ast.IndexOptions)
    }
    $$ = ast.IndexDef{KeyType: ast.KeytypeMultiple, Name: $2.(ast.IndexNameAndType).Name, Type: $2.(ast.IndexNameAndType).Type, Columns: $4.(ast.KeyPartSpecs), Options: d6}
  }
| FULLTEXT opt_index_or_key opt_ident '(' key_list_with_expression ')' opt_fulltext_index_options
  {
    var d7 ast.IndexOptions
    if $7 != nil {
    	d7 = $7.(ast.IndexOptions)
    }
    $$ = ast.IndexDef{KeyType: ast.KeytypeFulltext, Name: $3, Type: "", Columns: $5.(ast.KeyPartSpecs), Options: d7}
  }
| SPATIAL opt_index_or_key opt_ident '(' key_list_with_expression ')' opt_spatial_index_options
  {
    var d7 ast.IndexOptions
    if $7 != nil {
    	d7 = $7.(ast.IndexOptions)
    }
    $$ = ast.IndexDef{KeyType: ast.KeytypeSpatial, Name: $3, Type: "", Columns: $5.(ast.KeyPartSpecs), Options: d7}
  }
| opt_constraint_name constraint_key_type opt_index_name_and_type '(' key_list_with_expression ')' opt_index_option_list
  {
    /*
       Constraint-implementing indexes are named by the constraint type
       by default.
    */
    d3 := $3.(ast.IndexNameAndType)
    var name string
    if d3.Name != "" {
    	name = d3.Name
    } else {
    	name = $1
    }
    var d7 ast.IndexOptions
    if $7 != nil {
    	d7 = $7.(ast.IndexOptions)
    }
    $$ = ast.IndexDef{KeyType: $2.(ast.KeyType), Name: name, Type: d3.Type, Columns: $5.(ast.KeyPartSpecs), Options: d7}
  }
| opt_constraint_name FOREIGN KEY opt_ident '(' key_list ')' references
  {
    fkUpdate, fkDelete := ast.FKOptionUndef, ast.FKOptionUndef
    d8 := $8.(ast.Reference)
    if d8.Actions != nil {
    	fkUpdate = d8.Actions.OnUpdate
    	fkDelete = d8.Actions.OnDelete
    }
    $$ = ast.ForeignKeyDef{ConstraintName: $1, KeyName: $4, Columns: $6.(ast.KeyPartSpecs), RefTable: d8.ReferencedTable, RefList: d8.ReferencedColumns, FKMatchOption: d8.MatchOption, FKUpdateOpt: fkUpdate, FKDeleteOpt: fkDelete}
  }
| opt_constraint_name check_constraint opt_constraint_enforcement
  {
    $$ = ast.CheckConstraint{Name: $1, CheckExpr: $2.(*ast.CheckCondition).CheckExpr, IsEnforced: $3.(bool)}
  }
| CONSTRAINT ident PARTITION KEY openb sql_id closeb REFERENCES table_name openb sql_id closeb
  {
    $$ = &ast.PartitionKeyDetail{Name: $2, Source: $6.(ast.ColIdent), ReferencedTable: $9.(ast.TableName), ReferencedColumn: $11.(ast.ColIdent)}
  }

opt_fulltext_index_options:
  opt_index_option_list
  {
    // todo: fulltext should be different from index option
    $$ = $1
  }

opt_spatial_index_options:
  opt_index_option_list
  {
    // todo: spatial should be different from index option
    $$ = $1
  }

constraint_key_type:
  PRIMARY KEY
  {
    $$ = ast.KeytypePrimary
  }
| UNIQUE opt_index_or_key
  {
    $$ = ast.KeytypeUnique
  }

opt_index_name_and_type:
  opt_ident
  {
    $$ = ast.IndexNameAndType{Name: $1}
  }
| opt_ident USING index_type
  {
    $$ = ast.IndexNameAndType{Name: $1, Type: $3}
  }
| ident TYPE index_type
  {
    $$ = ast.IndexNameAndType{Name: $1, Type: $3}
  }

index_type:
  BTREE
| RTREE
| HASH

alter_table_partition_options:
  partition_clause
| REMOVE PARTITIONING
  {
    dd := ast.AlterTableRemovePartitioning{}
    dd.SetAlterFlag(ast.AlterRemovePartition)
    $$ = dd
  }

opt_constraint_enforcement:
  {
    $$ = true
  }
| constraint_enforcement
  {
    $$ = $1.(bool)
  }

opt_place:
  {
    $$ = ""
  }
| AFTER ident
  {
    $$ = "AFTER " + $2
  }
| FIRST

alter_trigger_statement:
  ALTER TRIGGER table_name RENAME opt_to table_name
  {
    $$ = &ast.AlterTriggerStmt{Name: $3.(ast.TableName), NewName: $6.(ast.TableName)}
  }

alter_server_statement:
  ALTER SERVER table_id ddl_force_eof
  {
    $$ = &ast.AlterServerStmt{Name: $3.(ast.TableIdent)}
  }

alter_indextype_statement:
  ALTER INDEXTYPE table_name alter_indextype_action_list opt_partition_storage_table_clause
  {
    var dd *ast.PartitionStorageAttr
    if $5 !=nil{
      dd = $5.(*ast.PartitionStorageAttr)
    }
    $$ = &ast.AlterIndexTypeStmt{Name: $3.(ast.TableName), AlterIndexTypeActions: $4.([]*ast.AlterIndexTypeAction), PartitionStorageAttr: dd}
  }
| ALTER INDEXTYPE table_name alter_indextype_action_list USING table_name opt_partition_storage_table_clause
  {
    var dd *ast.PartitionStorageAttr
    if $7 !=nil{
      dd = $7.(*ast.PartitionStorageAttr)
    }
    $$ = &ast.AlterIndexTypeStmt{Name: $3.(ast.TableName), AlterIndexTypeActions: $4.([]*ast.AlterIndexTypeAction), UsingTypeAttr: &ast.UsingTypeAttr{Name: $6.(ast.TableName)}, PartitionStorageAttr: dd}
  }
| ALTER INDEXTYPE table_name alter_indextype_action_list USING table_name array_DML_clause opt_partition_storage_table_clause
  {
    var dd *ast.PartitionStorageAttr
    if $8 !=nil{
      dd = $8.(*ast.PartitionStorageAttr)
    }
    $$ = &ast.AlterIndexTypeStmt{Name: $3.(ast.TableName), AlterIndexTypeActions: $4.([]*ast.AlterIndexTypeAction), UsingTypeAttr: &ast.UsingTypeAttr{Name: $6.(ast.TableName), ArrayDMLAttr: $7.(*ast.ArrayDMLAttr)}, PartitionStorageAttr: dd}
  }
| ALTER INDEXTYPE table_name COMPILE opt_partition_storage_table_clause
  {
    var dd *ast.PartitionStorageAttr
    if $5 !=nil{
      dd = $5.(*ast.PartitionStorageAttr)
    }
    $$ = &ast.AlterIndexTypeStmt{Name: $3.(ast.TableName), IsCompile: true, PartitionStorageAttr: dd}
  }

alter_indextype_action_list:
  alter_indextype_action
  {
    $$ = []*ast.AlterIndexTypeAction{$1.(*ast.AlterIndexTypeAction)}
  }
| alter_indextype_action_list ',' alter_indextype_action
  {
    dd := $1.([]*ast.AlterIndexTypeAction)
    dd = append(dd, $3.(*ast.AlterIndexTypeAction))
    $$ = dd
  }

alter_indextype_action:
  ADD operator_spec
  {
    $$ = &ast.AlterIndexTypeAction{Action: "ADD", OperatorAttr: $2.(*ast.OperatorAttr)}
  }
| DROP operator_spec
  {
    $$ = &ast.AlterIndexTypeAction{Action: "DROP", OperatorAttr: $2.(*ast.OperatorAttr)}
  }

alter_operator_statement:
  ALTER OPERATOR table_name add_binding_clause
  {
    $$ = &ast.AlterOperatorStmt{Name: $3.(ast.TableName), AddBindingElement: $4.(*ast.BindingElement)}
  }
| ALTER OPERATOR table_name drop_binding_clause
  {
    $$ = &ast.AlterOperatorStmt{Name: $3.(ast.TableName), DropBindigElement: $4.(*ast.DropBindingElement)}
  }
| ALTER OPERATOR table_name COMPILE
  {
    $$ = &ast.AlterOperatorStmt{Name: $3.(ast.TableName), IsCompile: true}
  }

add_binding_clause:
  ADD BINDING binding_element
  {
    $$ = $3.(*ast.BindingElement)
  }

drop_binding_clause:
  DROP BINDING openb datatype_list closeb opt_force
  {
    $$ = &ast.DropBindingElement{ParamTypes: $4.([]string), IsForce: $6.(bool)}
  }

opt_column:
  {
    $$ = ""
  }
| COLUMN

opt_interval:
  {
    $$ = nil
  }
| INTERVAL '(' value ')'
  {
    $$ = $3
  }

partition_operation:
  REORGANIZE PARTITION partition_names INTO '(' partition_definitions ')'
  {
    $$ = &ast.PartitionSpec{Action: ast.ReorganizeInt, Names: $3.(ast.PartitionNames), Definitions: $6.([]*ast.PartitionDefinition)}
  }
| DISCARD PARTITION partition_names_or_all TABLESPACE
  {
    $$ = &ast.PartitionSpec{Action: ast.DiscardInt, Names: $3.(ast.PartitionNames)}
  }
| IMPORT PARTITION partition_names_or_all TABLESPACE
  {
    $$ = &ast.PartitionSpec{Action: ast.ImportInt, Names: $3.(ast.PartitionNames)}
  }
| COALESCE PARTITION INTEGRAL
  {
    $$ = &ast.PartitionSpec{Action: ast.CoalesceInt, CoalesceValue: $3}
  }
| EXCHANGE PARTITION ID WITH TABLE ID opt_with_validation
  {
    $$ = &ast.PartitionSpec{Action: ast.ExchangeInt, ExchangePname: $3, ExchangeTname: $6, ExchangeWithOpt: $7.(ast.WithValidation)}
  }
| partition_operation_keyword partition_names_or_all
  {
    $$ = &ast.PartitionSpec{Action: $1.(int), Names: $2.(ast.PartitionNames)}
  }

partition_operation_keyword:
  ANALYZE PARTITION
  {
    $$ = ast.AnalyzeInt
  }
| CHECK PARTITION
  {
    $$ = ast.CheckInt
  }
| OPTIMIZE PARTITION
  {
    $$ = ast.OptimizeInt
  }
| REBUILD PARTITION
  {
    $$ = ast.RebuildInt
  }
| REPAIR PARTITION
  {
    $$ = ast.RepairInt
  }

partition_definitions:
  partition_definition
  {
    $$ = []*ast.PartitionDefinition{$1.(*ast.PartitionDefinition)}
  }
| partition_definitions ',' partition_definition
  {
    $$ = append($1.([]*ast.PartitionDefinition), $3.(*ast.PartitionDefinition))
  }

partition_definition:
  PARTITION sql_id partition_def_option_list opt_sub_partition
  {
    var d3 []*ast.PartitionOption
    if $3 != nil {
        d3 = $3.([]*ast.PartitionOption)
    }
    var d4 []*ast.Subpartition
    if $4 != nil {
        d4 = $4.([]*ast.Subpartition)
    }
    $$ = &ast.PartitionDefinition{Name: $2.(ast.ColIdent), PartitionOption: d3, Subpartition: d4}
  }
| PARTITION sql_id VALUES LESS THAN range_value_tuple partition_def_option_list opt_sub_partition
  {
    var d7 []*ast.PartitionOption
    if $7 != nil {
        d7 = $7.([]*ast.PartitionOption)
    }
    var d8 []*ast.Subpartition
    if $8 != nil {
        d8 = $8.([]*ast.Subpartition)
    }
    $$ = &ast.PartitionDefinition{Name: $2.(ast.ColIdent), Type: ast.NewColIdent(ast.RangePartition), Limit: $6.(ast.ValTuple), PartitionOption: d7, Subpartition: d8}
  }
| PARTITION sql_id VALUES LESS THAN MAXVALUE partition_def_option_list opt_sub_partition
  {
    var d7 []*ast.PartitionOption
    if $7 != nil {
        d7 = $7.([]*ast.PartitionOption)
    }
    var d8 []*ast.Subpartition
    if $8 != nil {
        d8 = $8.([]*ast.Subpartition)
    }
    $$ = &ast.PartitionDefinition{Name: $2.(ast.ColIdent), Type: ast.NewColIdent(ast.RangePartition), Maxvalue: true, PartitionOption: d7, Subpartition: d8}
  }
| PARTITION sql_id VALUES IN range_value_tuple partition_def_option_list opt_sub_partition
  {
    var d6 []*ast.PartitionOption
    if $6 != nil {
        d6 = $6.([]*ast.PartitionOption)
    }
    var d7 []*ast.Subpartition
    if $7 != nil {
        d7 = $7.([]*ast.Subpartition)
    }
    $$ = &ast.PartitionDefinition{Name: $2.(ast.ColIdent), Type: ast.NewColIdent(ast.ListPartition), Limit: $5.(ast.ValTuple), PartitionOption: d6, Subpartition: d7}
  }

opt_sub_partition:
  /* EMPTY */
  {
    $$ = nil
  }
| '(' sub_part_list ')' 
  {
    $$ = $2.([]*ast.Subpartition)
  }

sub_part_list:
  sub_part_definition
  {
    $$ = []*ast.Subpartition{$1.(*ast.Subpartition)}
  }
| sub_part_list ',' sub_part_definition
  {
    $$ = append($1.([]*ast.Subpartition), $3.(*ast.Subpartition))
  }

sub_part_definition:
  SUBPARTITION ident_or_text partition_def_option_list
  {
    var d3 *ast.PartitionOption
    if $3 != nil {
        d3 = $3.(*ast.PartitionOption)
    }
    $$ = &ast.Subpartition{SubName: $2, PartitionOption: d3}
  }

opt_with_validation:
  /* EMPTY */
  {
    $$ = ast.AlterValidationUndef
  }
| with_validation
  {
    $$ = $1
  }

partition_def_option_list:
  /* EMPTY */
  {
    $$ = nil
  }
| partition_def_option_list partition_def_option

partition_def_option:
  ENGINE opt_equal ident_or_text
  {
    $$ = &ast.PartitionOption{OptionName: $1, OptionValue: $3}
  }
| STORAGE ENGINE opt_equal ident_or_text
  {
    $$ = &ast.PartitionOption{OptionName: $2, OptionValue: $4}
  }
| MAX_ROWS opt_equal INTEGRAL
  {
    $$ = &ast.PartitionOption{OptionName: $1, OptionValue: $3}
  }
| MIN_ROWS opt_equal INTEGRAL
  {
    $$ = &ast.PartitionOption{OptionName: $1, OptionValue: $3}
  }
| COMMENT_KEYWORD opt_equal STRING
  {
    $$ = &ast.PartitionOption{OptionName: $1, OptionValue: $3}
  }
| DATA DIRECTORY opt_equal STRING
  {
    $$ = &ast.PartitionOption{OptionName: $1 + " " + $2, OptionValue: $4}
  }
| INDEX DIRECTORY opt_equal STRING
  {
    $$ = &ast.PartitionOption{OptionName: $1 + " " + $2, OptionValue: $4}
  }
| TABLESPACE opt_equal ident
  {
    $$ = &ast.PartitionOption{OptionName: $1, OptionValue: $3}
  }
| NODEGROUP opt_equal INTEGRAL
  {
    $$ = &ast.PartitionOption{OptionName: $1, OptionValue: $3}
  }

rename_statement:
  RENAME TABLE table_name TO table_name
  {
    $$ = &ast.RenameStmt{TableToTables: []*ast.TableToTable{
    	{
    		OldTable: $3.(ast.TableName),
    		NewTable: $5.(ast.TableName),
    	}}}
  }

drop_statement:
  drop_database_statement
| drop_table_statement
| drop_index_statement
| drop_indextype_statement
| drop_view_statement
| drop_sequence_statement
| drop_trigger_statement
| drop_server_statement
| drop_synonym_statement
| drop_function_statement
| drop_procedure_statement
| drop_package_statement
| drop_package_body_statement
| drop_type_statement
| drop_type_body_statement
| drop_operator_statement

drop_database_statement:
  DROP database_or_schema opt_exists table_id
  {
    var exists bool
    if $3 != "false" {
    	exists = true
    }
    $$ = &ast.DropDatabaseStmt{IfExists: exists, Name: $4.(ast.TableIdent)}
  }

drop_table_statement:
  DROP opt_temporary TABLE opt_exists table_name_list opt_restrict
  {
    var temporaryExist bool
    if $2 != "false" {
    	temporaryExist = true
    }
    var exists bool
    if $4 != "false" {
    	exists = true
    }
    $$ = &ast.DropTableStmt{IsTemporary: temporaryExist, IfExists: exists, Names: $5.(ast.TableNames), Name: $5.(ast.TableNames)[0]}
  }

drop_index_statement:
  DROP INDEX ID ON table_name
  {
    $$ = &ast.DropIndexStmt{Name: ast.NewTableIdent($3), TableName: $5.(ast.TableName)}
  }

drop_indextype_statement:
  DROP INDEXTYPE table_name opt_force
  {
    $$ = &ast.DropIndexTypeStmt{Name: $3.(ast.TableName), IsForce: $4.(bool)}
  }

opt_force:
  {
    $$ = false
  }
| FORCE
  {
    $$ = true
  }

opt_public:
  {
    $$ = false
  }
| PUBLIC
  {
    $$ = true
  }

drop_operator_statement:
  DROP OPERATOR table_name opt_force
  {
    $$ = &ast.DropOperatorStmt{Name: $3.(ast.TableName), IsForce: $4.(bool)}
  }

drop_view_statement:
  DROP VIEW opt_comment opt_exists table_name_list opt_cascase_constraints
  {
    comments, _ := getComments($3)
    var exists bool
    if $4 != "false" {
    	exists = true
    }
    $$ = &ast.DropViewStmt{Names: $5.(ast.TableNames), Comments: comments, IfExists: exists, DropOption:$6.(string)}
  }

opt_restrict:
  {}
| RESTRICT
| CASCADE

opt_cascase_constraints:
  {
    $$ = ""
  }
| CASCADE CONSTRAINTS
  {
    $$ = "CASCADE CONSTRAINTS"
  }

drop_sequence_statement:
  DROP SEQUENCE opt_exists table_name
  {
    var exists bool
    if $3 != "false" {
    	exists = true
    }
    $$ = &ast.DropSequenceStmt{Name: $4.(ast.TableName), IfExists: exists}
  }

drop_trigger_statement:
  DROP TRIGGER opt_comment opt_exists table_name
  {
    comments, _ := getComments($3)
    var exists bool
    if $4 != "false" {
    	exists = true
    }
    $$ = &ast.DropTriggerStmt{Name: $5.(ast.TableName), Comments: comments, IfExists: exists, IsOracle: true}
  }

drop_server_statement:
  DROP SERVER opt_exists table_id
  {
    var exists bool
    if $3 != "false" {
    	exists = true
    }
    $$ = &ast.DropServerStmt{Name: $4.(ast.TableIdent), IfExists: exists}
  }

drop_synonym_statement:
  DROP opt_public SYNONYM table_name opt_force
  {
    $$ = &ast.DropSynonymStmt{Name: $4.(ast.TableName), IsPublic: $2.(bool), IsForce: $5.(bool)}
  }

truncate_statement:
  TRUNCATE TABLE table_name
  {
    $$ = &ast.TruncateStmt{Name: $3.(ast.TableName)}
  }
| TRUNCATE table_name
  {
    $$ = &ast.TruncateStmt{Name: $2.(ast.TableName)}
  }

show_statement:
  SHOW opt_full TABLES opt_db_from_spec opt_show_condition
  {
    var full bool
    if $2 != "false" {
    	full = true
    }
    var dbSpec *ast.DatabaseSpec
    if $4 != nil {
    	dbSpec = $4.(*ast.DatabaseSpec)
    }
    var showCond ast.ShowCondition
    if $5 != nil {
    	showCond = $5.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowTablesStr, FullShow: full, DBSpec: dbSpec, Condition: showCond}
  }
| SHOW TRIGGERS opt_db_from_spec opt_show_condition
  {
    var dbSpec *ast.DatabaseSpec
    if $3 != nil {
    	dbSpec = $3.(*ast.DatabaseSpec)
    }
    var showCond ast.ShowCondition
    if $4 != nil {
    	showCond = $4.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowTriggersStr, DBSpec: dbSpec, Condition: showCond}
  }
| SHOW opt_full COLUMNS tb_from_spec opt_db_from_spec opt_show_condition
  {
    var full bool
    if $2 != "false" {
    	full = true
    }
    var dbSpec *ast.DatabaseSpec
    if $5 != nil {
    	dbSpec = $5.(*ast.DatabaseSpec)
    }
    var showCond ast.ShowCondition
    if $6 != nil {
    	showCond = $6.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowColumnsStr, FullShow: full, TbFromSpec: $4.(*ast.TableFromSpec), DBSpec: dbSpec, Condition: showCond}
  }
| SHOW opt_full FIELDS tb_from_spec opt_db_from_spec opt_show_condition
  {
    var full bool
    if $2 != "false" {
    	full = true
    }
    var dbSpec *ast.DatabaseSpec
    if $5 != nil {
    	dbSpec = $5.(*ast.DatabaseSpec)
    }
    var showCond ast.ShowCondition
    if $6 != nil {
    	showCond = $6.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowColumnsStr, FullShow: full, TbFromSpec: $4.(*ast.TableFromSpec), DBSpec: dbSpec, Condition: showCond}
  }
| SHOW opt_global indexes_or_keys tb_from_spec opt_db_from_spec opt_where_expression
  {
    var isGlobal bool = false
    if $2 != "" {
    	isGlobal = true
    }
    var dbSpec *ast.DatabaseSpec
    if $5 != nil {
    	dbSpec = $5.(*ast.DatabaseSpec)
    }
    $$ = &ast.Show{Type: ast.ShowIndexesStr, TbFromSpec: $4.(*ast.TableFromSpec), DBSpec: dbSpec, Condition: ast.NewWhere(ast.TypWhere, $6), IsGlobal: isGlobal}
  }
| SHOW TABLE STATUS opt_db_from_spec opt_show_condition
  {
    var dbSpec *ast.DatabaseSpec
    if $4 != nil {
    	dbSpec = $4.(*ast.DatabaseSpec)
    }
    var showCond ast.ShowCondition
    if $5 != nil {
    	showCond = $5.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowTableStatusStr, DBSpec: dbSpec, Condition: showCond}
  }
| SHOW PARTITIONS tb_from_spec
  {
    $$ = &ast.Show{Type: ast.ShowPartitionsStr, TbFromSpec: $3.(*ast.TableFromSpec)}
  }
| SHOW FUNCTION STATUS opt_show_condition
  {
    var showCond ast.ShowCondition
    if $4 != nil {
    	showCond = $4.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowFunctionStatusStr, Condition: showCond}
  }
| SHOW PROCEDURE STATUS opt_show_condition
  {
    var showCond ast.ShowCondition
    if $4 != nil {
    	showCond = $4.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowProcedureStatusStr, Condition: showCond}
  }
| SHOW PACKAGE STATUS opt_show_condition
  {
    var showCond ast.ShowCondition
    if $4 != nil {
    	showCond = $4.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowPackageStatusStr, Condition: showCond}
  }
| SHOW PACKAGE BODY STATUS opt_show_condition
  {
    var showCond ast.ShowCondition
    if $5 != nil {
    	showCond = $5.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowPackageBodyStatusStr, Condition: showCond}
  }
| SHOW CREATE SCHEMA table_id
  {
    $$ = &ast.Show{Type: ast.ShowCreateSchemaStr, DBSpec: ast.NewDatabaseSpec($4.(ast.TableIdent))}
  }
| SHOW CREATE DATABASE table_id
  {
    $$ = &ast.Show{Type: ast.ShowCreateDatabaseStr, DBSpec: ast.NewDatabaseSpec($4.(ast.TableIdent))}
  }
| SHOW CREATE TABLE table_name
  {
    $$ = &ast.Show{Type: ast.ShowCreateTableStr, TbFromSpec: ast.NewTableFromSpec($4.(ast.TableName))}
  }
| SHOW CREATE VIEW table_name
  {
    $$ = &ast.Show{Type: ast.ShowCreateViewStr, TbFromSpec: ast.NewTableFromSpec($4.(ast.TableName))}
  }
| SHOW CREATE PROCEDURE table_name
  {
    $$ = &ast.Show{Type: ast.ShowCreateProcedureStr, TbFromSpec: ast.NewTableFromSpec($4.(ast.TableName))}
  }
| SHOW CREATE FUNCTION table_name
  {
    $$ = &ast.Show{Type: ast.ShowCreateFunctionStr, TbFromSpec: ast.NewTableFromSpec($4.(ast.TableName))}
  }
| SHOW CREATE TRIGGER table_name
  {
    $$ = &ast.Show{Type: ast.ShowCreateTriggerStr, TbFromSpec: ast.NewTableFromSpec($4.(ast.TableName))}
  }
| SHOW CREATE PACKAGE table_name
  {
    $$ = &ast.Show{Type: ast.ShowCreatePackageStr, TbFromSpec: ast.NewTableFromSpec($4.(ast.TableName))}
  }
| SHOW CREATE PACKAGE BODY table_name
  {
    $$ = &ast.Show{Type: ast.ShowCreatePackageBodyStr, TbFromSpec: ast.NewTableFromSpec($5.(ast.TableName))}
  }
| SHOW CREATE USER user
  {
    $$ = &ast.Show{Type: ast.ShowCreateUserStr, Principal: $4.(*ast.Principal)}
  }
| SHOW DATABASES force_eof
  {
    $$ = &ast.Show{Type: ast.ShowDatabasesStr}
  }
| SHOW SCHEMAS force_eof
  {
    $$ = &ast.Show{Type: ast.ShowSchemasStr}
  }
| SHOW GRANTS force_eof
  {
    $$ = &ast.Show{Type: ast.ShowGrantsStr}
  }
| SHOW GRANTS FOR principal
  {
    $$ = &ast.Show{Type: ast.ShowGrantsStr, Principal: $4.(*ast.Principal)}
  }
| SHOW KUNDB_KEYSPACES force_eof
  {
    $$ = &ast.Show{Type: ast.ShowKeyspacesStr}
  }
| SHOW KUNDB_SHARDS opt_table_name force_eof
  {
    $$ = &ast.Show{Type: ast.ShowShardsStr, TbFromSpec: ast.NewTableFromSpec($3.(ast.TableName))}
  }
| SHOW SESSION SHARDS force_eof
  {
    $$ = &ast.Show{Type: ast.ShowSessionShardsStr}
  }
| SHOW VSCHEMA_TABLES force_eof
  {
    $$ = &ast.Show{Type: ast.ShowVSchemaTablesStr}
  }
// | SHOW KUNDB_CHECKS FROM table_name
//   {
//     $$ = &ast.Show{Type: ast.ShowKunCheckStr, TbFromSpec: ast.NewTableFromSpec($4.(ast.TableName))}
//   }
| SHOW KUNDB_RANGE_INFO table_name
  {
    $$ = &ast.Show{Type: ast.ShowRangeInfoStr, TbFromSpec: ast.NewTableFromSpec($3.(ast.TableName))}
  }
| SHOW KUNDB_VINDEXES tb_from_spec
  {
    $$ = &ast.Show{Type: ast.ShowVindexesStr, TbFromSpec: $3.(*ast.TableFromSpec)}
  }
| SHOW PRIVILEGES force_eof
  {
    $$ = &ast.Show{Type: ast.ShowPrivilegesStr}
  }
| SHOW variable_scope VARIABLES opt_show_condition
  {
    var showCond ast.ShowCondition
    if $4 != nil {
    	showCond = $4.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowVariablesStr, Condition: showCond}
  }
| SHOW variable_scope STATUS opt_show_condition
  {
    var showCond ast.ShowCondition
    if $4 != nil {
    	showCond = $4.(ast.ShowCondition)
    }
    $$ = &ast.Show{Type: ast.ShowStatusStr, Condition: showCond, IsGlobal: $2.(bool)}
  }
| SHOW opt_full PROCESSLIST
  {
    $$ = &ast.Show{Type: ast.ShowProcesslistStr}
  }
| SHOW ENGINE force_eof
  {
    $$ = &ast.Show{Type: ast.ShowEngineStr}
  }
| SHOW opt_storage ENGINES force_eof
  {
    $$ = &ast.Show{Type: ast.ShowEnginesStr}
  }
| SHOW WARNINGS force_eof
  {
    $$ = &ast.Show{Type: ast.ShowWarningsStr}
  }
| SHOW ERRORS force_eof
  {
    $$ = &ast.Show{Type: ast.ShowErrorsStr}
  }
| SHOW CHARACTER SET force_eof
  {
    $$ = &ast.Show{Type: ast.ShowCharacterSetStr}
  }
| SHOW COLLATION force_eof
  {
    $$ = &ast.Show{Type: ast.ShowCollation}
  }
| SHOW unsupported_show_keyword force_eof
  {
    $$ = &ast.Show{Type: ast.ShowUnsupportedStr}
  }
| SHOW ID force_eof
  {
    typ := strings.ToLower($2)
    if _, ok := ast.ShowKeywordMap[typ]; !ok {
    	typ = ast.ShowUnsupportedStr
    }
    $$ = &ast.Show{Type: typ}
  }

opt_global:
  {
    $$ = ""
  }
| GLOBAL

variable_scope:
  {
    $$ = false
  }
| session_or_global
  {
    $$ = $1.(bool)
  }

opt_full:
  {
    $$ = "false"
  }
| FULL
  {
    $$ = "true"
  }

opt_storage:
  {
    $$ = "false"
  }
| STORAGE
  {
    $$ = "true"
  }

opt_db_from_spec:
  {
    $$ = nil
  }
| FROM table_id
  {
    $$ = &ast.DatabaseSpec{DBName: $2.(ast.TableIdent)}
  }
| IN table_id
  {
    $$ = &ast.DatabaseSpec{DBName: $2.(ast.TableIdent)}
  }

tb_from_spec:
  FROM table_name
  {
    $$ = &ast.TableFromSpec{TbName: $2.(ast.TableName)}
  }
| IN table_name
  {
    $$ = &ast.TableFromSpec{TbName: $2.(ast.TableName)}
  }

opt_show_condition:
  {
    $$ = nil
  }
| LIKE STRING
  {
    $$ = &ast.ShowLikeExpr{LikeStr: $2}
  }
| WHERE expression
  {
    $$ = ast.NewWhere(ast.TypWhere, $2)
  }

use_statement:
  USE table_id
  {
    $$ = &ast.Use{DBName: $2.(ast.TableIdent)}
  }
| USE '@' ID
  {
    $$ = &ast.Use{DBName: ast.NewTableIdent("@" + $3)}
  }

call_statement:
  CALL proc_or_func_name
  {
    $$ = &ast.Call{ProcName: $2.(ast.ProcOrFuncName)}
  }
| CALL proc_or_func_name openb opt_func_arg_list closeb
  {
    $$ = &ast.Call{ProcName: $2.(ast.ProcOrFuncName), OptParameters: $4.(ast.SelectExprs), IsOracle: true}
  }

begin_statement:
  BEGIN
  {
    $$ = &ast.Begin{}
  }
| START TRANSACTION
  {
    $$ = &ast.Begin{}
  }

commit_statement:
  COMMIT
  {
    $$ = &ast.Commit{}
  }

rollback_statement:
  ROLLBACK
  {
    $$ = &ast.Rollback{}
  }

opt_explain_format:
  {
    $$ = ""
  }
| FORMAT '=' JSON
  {
    $$ = ast.JSONStr
  }
| FORMAT '=' TREE
  {
    $$ = ast.TreeStr
  }
| FORMAT '=' TRADITIONAL
  {
    $$ = ast.TraditionalStr
  }

explain_synonyms:
  EXPLAIN
| DESCRIBE
| DESC

explainable_statement:
  select_statement
  {
    $$ = $1.(ast.Statement)
  }
| base_update
| base_insert
| base_delete

opt_wild:
  {
    $$ = ""
  }
| sql_id
  {
    $$ = ""
  }
| STRING
  {
    $$ = ""
  }

explain_statement:
  explain_synonyms table_name opt_wild
  {
    $$ = &ast.OtherRead{OtherReadType: ast.TableOrView, Object: $2.(ast.TableName)}
  }
| explain_synonyms opt_explain_format explainable_statement
  {
    $$ = &ast.Explain{Type: $2, Statement: $3}
  }

other_statement:
  REPAIR force_eof
  {
    $$ = &ast.OtherAdmin{}
  }
| OPTIMIZE opt_analyze_optimize TABLE table_name
  {
    $$ = &ast.OtherAdmin{Action: ast.OptimizeStr, OptAdmin: $2, Table: $4.(ast.TableName)}
  }
| ANALYZE opt_analyze_optimize TABLE table_name
  {
    $$ = &ast.OtherAdmin{Action: ast.AnalyzeStr, OptAdmin: $2, Table: $4.(ast.TableName)}
  }

opt_analyze_optimize:
  {
    $$ = ""
  }
| NO_WRITE_TO_BINLOG
| LOCAL

opt_comment:
  {
    setAllowComments(yylex, true)
  } comment_list
  {
    $$ = $2
    setAllowComments(yylex, false)
  }

comment_list:
  {
    $$ = make([]string, 0)
  }
| comment_list COMMENT
  {
    $$ = append($1.([]string), $2)
  }

set_op:
  UNION
  {
    $$ = ast.SetOpUnionStr
  }
| UNION ALL
  {
    $$ = ast.SetOpUnionAllStr
  }
| UNION DISTINCT
  {
    $$ = ast.SetOpUnionDistinctStr
  }
| INTERSECT
  {
    $$ = ast.SetOpIntersectStr
  }
| INTERSECT ALL
  {
    $$ = ast.SetOpIntersectAllStr
  }
| INTERSECT DISTINCT
  {
    $$ = ast.SetOpIntersectDistinctStr
  }
| MINUS
  {
    $$ = ast.SetOpMinusStr
  }
| MINUS ALL
  {
    $$ = ast.SetOpMinusAllStr
  }
| MINUS DISTINCT
  {
    $$ = ast.SetOpMinusDistinctStr
  }

opt_cache:
  {
    $$ = ""
  }
| SQL_NO_CACHE
  {
    $$ = ast.SQLNoCacheStr
  }
| SQL_CACHE
  {
    $$ = ast.SQLCacheStr
  }

opt_distinct:
  {
    $$ = ""
  }
| DISTINCT
  {
    $$ = ast.DistinctStr
  }

opt_straight_join:
  {
    $$ = ""
  }
| STRAIGHT_JOIN
  {
    $$ = ast.StraightJoinHint
  }

opt_hint_list:
  {
    $$ = nil
  }
| hint_list

hint_list:
  hint
  {
    $$ = ast.Hints{$1.(ast.Hint)}
  }
| hint_list hint
  {
    dd := $$.(ast.Hints)
    dd = append(dd, $2.(ast.Hint))
    $$ = dd
  }

hint:
  BACKEND backend
  {
    $$ = &ast.BackendHint{Backend: $2}
  }
| GLKJOIN '(' table_name_list ')'
  {
    $$ = &ast.GlkjoinHint{TableNames: $3.(ast.TableNames)}
  }

backend:
  INCEPTOR
  {
    $$ = ast.Inceptor
  }
| MFED
  {
    $$ = ast.Mfed
  }

opt_select_expression_list:
  {
    $$ = ast.SelectExprs{}
  }
| select_expression_list

opt_func_arg_list:
  {
    $$ = ast.SelectExprs{}
  }
| func_arg_list

func_arg_list:
  func_arg_expr
  {
    $$ = ast.SelectExprs{$1.(ast.SelectExpr)}
  }
| func_arg_list ',' func_arg_expr
  {
    $$ = append($1.(ast.SelectExprs), $3.(ast.SelectExpr))
  }

func_arg_expr:
  select_expression
  {
    $$ = $1
  }
| ID EG select_expression
  {
    argName := $1
    arg := $3.(ast.SelectExpr)
    namedArg := &ast.NamedArgExpr{
    	Arg:  arg,
    	Name: argName,
    }
    $$ = &ast.AliasedExpr{Expr: namedArg, OptAs: false, As: nil}
  }

select_expression_list:
  select_expression
  {
    $$ = ast.SelectExprs{$1.(ast.SelectExpr)}
  }
| select_expression_list ',' select_expression
  {
    dd := $$.(ast.SelectExprs)
    dd = append(dd, $3.(ast.SelectExpr))
    $$ = dd
  }

select_expression:
  '*'
  {
    $$ = &ast.StarExpr{}
  }
| '+'
  {
      $$ = &ast.PlusExpr{}
  }
| expression opt_as_ci
  {
    var OptAs bool = false
    if $2 != nil {
    	OptAs = true
    }
    $$ = &ast.AliasedExpr{Expr: $1, OptAs: OptAs, As: $2}
  }
| table_id '.' '*'
  {
    $$ = &ast.StarExpr{TableName: ast.TableName{Name: $1.(ast.TableIdent)}}
  }
| table_id '.' reserved_table_id '.' '*'
  {
    $$ = &ast.StarExpr{TableName: ast.TableName{Qualifier: $1.(ast.TableIdent), Name: $3.(ast.TableIdent)}}
  }

opt_as_ci:
  {
    $$ = nil
  }
| col_alias
| AS col_alias
  {
    $$ = $2
  }

col_alias:
  sql_id
  {
    $$ = ast.NewStrValV2($1.(ast.ColIdent).String())
  }
| STRING
  {
    $$ = ast.NewStrValV2($1)
  }
| VALUE_ARG
  {
    $$ = ast.NewValArgV2($1)
  }

opt_from_clause:
  {
    $$ = nil
  }
| FROM table_references
  {
    $$ = $2
  }

table_references:
  table_reference
  {
    $$ = ast.TableExprs{$1.(ast.TableExpr)}
  }
| table_references ',' table_reference
  {
    d3 := $3.(ast.TableExpr)
    dd := $$.(ast.TableExprs)
    dd = append(dd, d3)
    $$ = dd
  }

table_reference:
  table_factor
| join_table

table_factor:
  aliased_table_name
| subquery opt_as table_id
  {
    $$ = &ast.AliasedTableExpr{Expr: $1.(ast.SimpleTableExpr), As: $3.(ast.TableIdent)}
  }
| subquery
  {
    $$ = &ast.AliasedTableExpr{Expr: $1.(ast.SimpleTableExpr), As: ast.NewTableIdent(nextAliasId(yylex))}
  }
| openb table_references closeb
  {
    $$ = &ast.ParenTableExpr{Exprs: $2.(ast.TableExprs)}
  }
| openb table_references closeb opt_as table_id
  {
    $$ = &ast.AliasedTableExpr{Expr: &ast.ParenTableExpr{Exprs: $2.(ast.TableExprs)}, As: $5.(ast.TableIdent)}
  }

aliased_table_name:
  table_name opt_table_alias opt_index_hint_list opt_scan_mode_hint
  {
    var idxHints []*ast.IndexHints
    if $3 != nil {
    	idxHints = append(idxHints,$3.(*ast.IndexHints))
    }
    var sm *ast.ScanMode
    if $4 != nil {
    	sm = $4.(*ast.ScanMode)
    }
    $$ = &ast.AliasedTableExpr{Expr: $1.(ast.SimpleTableExpr), As: $2.(ast.TableIdent), Hints: idxHints, ScanMode: sm}
  }
| table_name opt_partition_select opt_table_alias opt_index_hint_list opt_scan_mode_hint
  {
    var idxHints []*ast.IndexHints
    if $4 != nil {
    	idxHints = append(idxHints,$4.(*ast.IndexHints))
    }
    var sm *ast.ScanMode
    if $5 != nil {
    	sm = $5.(*ast.ScanMode)
    }
    $$ = &ast.AliasedTableExpr{Expr: $1.(ast.SimpleTableExpr), Partition: $2.([]ast.ColIdent), As: $3.(ast.TableIdent), Hints: idxHints, ScanMode: sm}
  }

// There is a grammar conflict here:
// 1: INSERT INTO a SELECT *ast. FROM b JOIN c ON b.i = c.i
// 2: INSERT INTO a SELECT *ast. FROM b JOIN c ON DUPLICATE KEY UPDATE a.i = 1
// When yacc encounters the ON clause, it cannot determine which way to
// resolve. The %prec override below makes the parser choose the
// first construct, which automatically makes the second construct a
// syntax error. This is the same behavior as MySQL.
join_table:
  table_reference inner_join table_factor %prec JOIN
  {
    $$ = &ast.JoinTableExpr{LeftExpr: $1.(ast.TableExpr), Join: $2, RightExpr: $3.(ast.TableExpr)}
  }
| table_reference inner_join table_factor ON expression
  {
    $$ = &ast.JoinTableExpr{LeftExpr: $1.(ast.TableExpr), Join: $2, RightExpr: $3.(ast.TableExpr), On: $5}
  }
| table_reference outer_join table_reference ON expression
  {
    $$ = &ast.JoinTableExpr{LeftExpr: $1.(ast.TableExpr), Join: $2, RightExpr: $3.(ast.TableExpr), On: $5}
  }
| table_reference natural_join table_factor
  {
    $$ = &ast.JoinTableExpr{LeftExpr: $1.(ast.TableExpr), Join: $2, RightExpr: $3.(ast.TableExpr)}
  }
| table_reference full_join table_factor ON expression
  {
    $$ = &ast.JoinTableExpr{LeftExpr: $1.(ast.TableExpr), Join: $2, RightExpr: $3.(ast.TableExpr), On: $5}
  }

opt_as:
  {
    $$ = struct{}{}
  }
| AS
  {
    $$ = struct{}{}
  }

opt_partition_select:
  PARTITION '(' part_list ')'
  {
    $$ = $3.([]ast.ColIdent)
  }

opt_table_alias:
  {
    $$ = ast.NewTableIdent("")
  }
| table_alias
| AS table_alias
  {
    $$ = $2
  }

table_alias:
  table_id
| STRING
  {
    $$ = ast.NewTableIdent($1)
  }

inner_join:
  JOIN
  {
    $$ = ast.JoinStr
  }
| INNER JOIN
  {
    $$ = ast.JoinStr
  }
| CROSS JOIN
  {
    $$ = ast.JoinStr
  }
| STRAIGHT_JOIN
  {
    $$ = ast.StraightJoinStr
  }

outer_join:
  LEFT JOIN
  {
    $$ = ast.LeftJoinStr
  }
| LEFT OUTER JOIN
  {
    $$ = ast.LeftJoinStr
  }
| RIGHT JOIN
  {
    $$ = ast.RightJoinStr
  }
| RIGHT OUTER JOIN
  {
    $$ = ast.RightJoinStr
  }

natural_join:
  NATURAL JOIN
  {
    $$ = ast.NaturalJoinStr
  }
| NATURAL outer_join
  {
    if $2 == ast.LeftJoinStr {
    	$$ = ast.NaturalLeftJoinStr
    } else {
    	$$ = ast.NaturalRightJoinStr
    }
  }

full_join:
  FULL JOIN
  {
     $$ = ast.FullJoinStr
  }
| FULL OUTER JOIN
  {
    $$ = ast.FullJoinStr
  }

into_table_name:
  INTO table_name
  {
    $$ = $2
  }
| table_name

opt_table_name:
  {
    $$ = ast.TableName{
    	SqlNodeBase: ast.SqlNodeBase{LineNum: getLineNum(yylex)},
    	Name: ast.NewTableIdent(""),
    }
  }
| table_name

table_name:
  table_id
  {
    $$ = ast.TableName{
    	SqlNodeBase: ast.SqlNodeBase{LineNum: getLineNum(yylex)},
    	Name: $1.(ast.TableIdent),
    }
  }
| table_id '.' reserved_table_id
  {
    $$ = ast.TableName{
    	SqlNodeBase: ast.SqlNodeBase{LineNum: getLineNum(yylex)},
    	Qualifier: $1.(ast.TableIdent),
    	Name: $3.(ast.TableIdent),
    }
  }

delete_table_name:
  table_id '.' '*'
  {
    $$ = ast.TableName{
    	SqlNodeBase: ast.SqlNodeBase{LineNum: getLineNum(yylex)},
    	Name: $1.(ast.TableIdent),
    }
  }

proc_or_func_name:
  table_id
  {
    $$ = ast.ProcOrFuncName{Name: $1.(ast.TableIdent)}
  }
| table_id '.' reserved_table_id
  {
    $$ = ast.ProcOrFuncName{Qualifier: $1.(ast.TableIdent), Name: $3.(ast.TableIdent)}
  }
| table_id '.' table_id '.' reserved_table_id
  {
    $$ = ast.ProcOrFuncName{Qualifier: $1.(ast.TableIdent), Package: $3.(ast.TableIdent), Name: $5.(ast.TableIdent)}
  }

opt_index_hint_list:
  {
    $$ = nil
  }
| USE INDEX openb index_list closeb
  {
    $$ = &ast.IndexHints{Type: ast.UseStr, Indexes: $4.([]ast.ColumnDetail)}
  }
| IGNORE INDEX openb index_list closeb
  {
    $$ = &ast.IndexHints{Type: ast.IgnoreStr, Indexes: $4.([]ast.ColumnDetail)}
  }
| FORCE INDEX openb index_list closeb
  {
    $$ = &ast.IndexHints{Type: ast.ForceStr, Indexes: $4.([]ast.ColumnDetail)}
  }

opt_scan_mode_hint:
  {
    $$ = nil
  }
| FETCH MODE STRING
  {
    $$ = &ast.ScanMode{Mode: ast.NewStrValV2($3)}
  }

index_list:
  sql_id
  {
    $$ = []ast.ColumnDetail{ast.NewColumnDetail($1.(ast.ColIdent), "")}
  }
| index_id
  {
    $$ = []ast.ColumnDetail{$1.(ast.ColumnDetail)}
  }
| index_list ',' sql_id
  {
    $$ = append($1.([]ast.ColumnDetail), ast.NewColumnDetail($3.(ast.ColIdent), ""))
  }
| index_list ',' index_id
  {
    $$ = append($1.([]ast.ColumnDetail), $3.(ast.ColumnDetail))
  }

index_id:
  ID '(' opt_index_length ')'
  {
    $$ = ast.NewColumnDetail(ast.NewColIdent($1), $3)
  }

opt_index_length:
  INTEGRAL

part_list:
  sql_id
  {
    $$ = []ast.ColIdent{$1.(ast.ColIdent)}
  }
| part_list ',' sql_id
  {
    dd := $1.([]ast.ColIdent)
    dd = append(dd, $3.(ast.ColIdent))
    $$ = dd
  }

opt_where_expression:
  {
    $$ = nil
  }
| WHERE expression
  {
    $$ = $2
  }

expression:
  condition
| expression ASSIGN expression
  {
    $$ = &ast.AssignExpr{Left: $1, Right: $3}
  }
| expression AND expression
  {
    $$ = &ast.AndExpr{Left: $1, Right: $3}
  }
| expression OR expression
  {
    $$ = &ast.OrExpr{Left: $1, Right: $3}
  }
| NOT expression
  {
    if exists, ok := $2.(*ast.ExistsExpr); ok {
      exists.Not = !exists.Not
      $$ = exists
    } else {
      $$ = &ast.NotExpr{Expr: $2}
    }

  }
| expression IS is_suffix
  {
    $$ = &ast.IsExpr{Operator: $3, Expr: $1}
  }
| expression IS opt_not JSON opt_unique_keys
  {
    var not string
    if len($3)>0 {
       not = $3 + " "
    }
    d5 := &ast.Options{WithUniqueKeys: $5.(ast.BoolVal)}
    $$ = &ast.IsExpr{Operator: $2 + " " + not + $4 , Expr: $1, Options: d5}
  }
| value_expression
| DEFAULT opt_default
  {
    $$ = &ast.Default{ColName: $2}
  }
| MAXVALUE
  {
    $$ = ast.NewStrValV2("maxvalue")
  }

opt_default:
  {
    $$ = ""
  }
| openb ID closeb
  {
    $$ = $2
  }

boolean_value:
  TRUE
  {
    $$ = ast.BoolVal(true)
  }
| FALSE
  {
    $$ = ast.BoolVal(false)
  }

condition:
  value_expression compare value_expression
  {
    $$ = &ast.ComparisonExpr{Left: $1, Operator: $2, Right: $3}
  }
| value_expression IN col_tuple
  {
    $$ = &ast.ComparisonExpr{Left: $1, Operator: ast.InStr, Right: $3.(ast.Expr)}
  }
| value_expression NOT IN col_tuple
  {
    $$ = &ast.ComparisonExpr{Left: $1, Operator: ast.NotInStr, Right: $4.(ast.Expr)}
  }
| value_expression member_of nested_tab
  {
    $$ = &ast.ComparisonExpr{Left: $1, Operator: ast.InStr, Right: $3.(ast.Expr)}
  }
| value_expression NOT member_of nested_tab
  {
    $$ = &ast.ComparisonExpr{Left: $1, Operator: ast.NotInStr, Right: $4.(ast.Expr)}
  }
| value_expression LIKE value_expression opt_like_escape
  {
    $$ = &ast.ComparisonExpr{Left: $1, Operator: ast.LikeStr, Right: $3, Escape: $4}
  }
| value_expression NOT LIKE value_expression opt_like_escape
  {
    $$ = &ast.ComparisonExpr{Left: $1, Operator: ast.NotLikeStr, Right: $4, Escape: $5}
  }
| value_expression REGEXP value_expression
  {
    $$ = &ast.ComparisonExpr{Left: $1, Operator: ast.RegexpStr, Right: $3}
  }
| value_expression NOT REGEXP value_expression
  {
    $$ = &ast.ComparisonExpr{Left: $1, Operator: ast.NotRegexpStr, Right: $4}
  }
| value_expression BETWEEN value_expression AND value_expression
  {
    $$ = &ast.RangeCond{Left: $1, Operator: ast.BetweenStr, From: $3, To: $5}
  }
| value_expression NOT BETWEEN value_expression AND value_expression
  {
    $$ = &ast.RangeCond{Left: $1, Operator: ast.NotBetweenStr, From: $4, To: $6}
  }
| EXISTS subquery
  {
    $$ = &ast.ExistsExpr{Subquery: $2.(*ast.Subquery)}
  }
| value_expression cursor_attribute
  {
    $$ = &ast.CursorAttributeExpr{CursorName: $1, Attribute: $2, IsCompare: false}
  }
| value_expression cursor_attribute compare expression %prec OP_CONCAT
  {
     $$ = &ast.CursorAttributeExpr{CursorName: $1, Attribute: $2, IsCompare: true, ResultCompareStr:$4.(ast.Expr)}
  }

opt_unique_keys:
  WITH UNIQUE KEYS
  {
    $$ = ast.BoolVal(true)
  }
| WITHOUT UNIQUE KEYS
  {
    $$ = ast.BoolVal(false)
  }

member_of:
  MEMBER
| MEMBER OF

nested_tab:
  general_element
  {
    $$ = &ast.NestedTableExpr{Name: $1.(ast.GeneralElement)}
  }
| openb general_element closeb
  {
    $$ = &ast.NestedTableExpr{Name: $2.(ast.GeneralElement)}
  }

is_suffix:
  NULL
  {
    $$ = ast.IsNullStr
  }
| NOT NULL
  {
    $$ = ast.IsNotNullStr
  }
| NAN
  {
    $$ = ast.IsNaNStr
  }
| NOT NAN
  {
    $$ = ast.IsNotNaNStr
  }
| TRUE
  {
    $$ = ast.IsTrueStr
  }
| NOT TRUE
  {
    $$ = ast.IsNotTrueStr
  }
| FALSE
  {
    $$ = ast.IsFalseStr
  }
| NOT FALSE
  {
    $$ = ast.IsNotFalseStr
  }

compare:
  '='
  {
    $$ = ast.EqualStr
  }
| '<'
  {
    $$ = ast.LessThanStr
  }
| '>'
  {
    $$ = ast.GreaterThanStr
  }
| LE
  {
    $$ = ast.LessEqualStr
  }
| GE
  {
    $$ = ast.GreaterEqualStr
  }
| NE
  {
    $$ = ast.NotEqualStr
  }
| NULL_SAFE_EQUAL
  {
    $$ = ast.NullSafeEqualStr
  }

opt_like_escape:
  {
    $$ = nil
  }
| ESCAPE value_expression
  {
    $$ = $2
  }

col_tuple:
  row_tuple
| subquery
| LIST_ARG
  {
    $$ = ast.ListArg($1)
  }

subquery:
  select_with_parens %prec SUBQUERY_AS_EXPR
  {
    $$ = &ast.Subquery{Select: $1.(ast.SelectStatement)}
  }

expression_list:
  expression
  {
    $$ = ast.Exprs{$1}
  }
| expression_list ',' expression
  {
    $$ = append($1.(ast.Exprs), $3.(ast.Expr))
  }

range_value_tuple:
  openb range_expression_list closeb
  {
    $$ = ast.ValTuple($2.(ast.Exprs))
  }

range_expression_list:
  range_expression
  {
    $$ = ast.Exprs{$1}
  }
| range_expression_list ',' range_expression
  {
    $$ = append($1.(ast.Exprs), $3.(ast.Expr))
  }

list_value_tuple:
  openb list_expression_list closeb
  {
    $$ = ast.ValTuple($2.(ast.Exprs))
  }

list_expression_list:
  list_expression
  {
    $$ = ast.Exprs{$1}
  }
| list_expression_list ',' list_expression
  {
    $$ = append($1.(ast.Exprs), $3.(ast.Expr))
  }

range_expression:
  value_expression
| MAXVALUE
  {
    $$ = &ast.MaxValueExpr{Value: $1}
  }

list_expression:
  value_expression
| DEFAULT
  {
    $$ = ast.NewStrValV2("default")
  }

value_expression:
  value_expression OP_CONCAT value_expression
  {
    $$ = &ast.ConcatExpr{Exprs: ast.Exprs{$1, $3}}
  }
|
  value_expression '&' value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.BitAndStr, Right: $3}
  }
| value_expression '|' value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.BitOrStr, Right: $3}
  }
| value_expression '^' value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.BitXorStr, Right: $3}
  }
| value_expression '+' value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.PlusStr, Right: $3}
  }
| value_expression '-' value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.MinusStr, Right: $3}
  }
| value_expression '*' value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.MultStr, Right: $3}
  }
| value_expression DOUBLE_STAR value_expression
  {
    selExprs := ast.SelectExprs{ast.AliasedExpr{}.Wrap($1), ast.AliasedExpr{}.Wrap($3)}
    $$ = &ast.FuncExpr{Name: ast.NewColIdent("power"), Exprs: selExprs}
  }
| value_expression '/' value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.DivStr, Right: $3}
  }
| value_expression DIV value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.IntDivStr, Right: $3}
  }
| value_expression '%' value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.ModStr, Right: $3}
  }
| value_expression MOD value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.ModStr, Right: $3}
  }
| value_expression SHIFT_LEFT value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.ShiftLeftStr, Right: $3}
  }
| value_expression SHIFT_RIGHT value_expression
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.ShiftRightStr, Right: $3}
  }
| column_name JSON_EXTRACT_OP value
  {
    $$ = &ast.BinaryExpr{Left: $1.(ast.Expr), Operator: ast.JSONExtractOp, Right: $3}
  }
| column_name JSON_UNQUOTE_EXTRACT_OP value
  {
    $$ = &ast.BinaryExpr{Left: $1.(ast.Expr), Operator: ast.JSONUnquoteExtractOp, Right: $3}
  }
| value_expression COLLATE charset
  {
    $$ = &ast.CollateExpr{Expr: $1, Charset: $3}
  }
| BINARY value_expression %prec UNARY
  {
    $$ = &ast.UnaryExpr{Operator: ast.BinaryStr, Expr: $2}
  }
| UNDERSCORECS value_expression %prec UNARY
  {
    $$ = &ast.UnaryExpr{Operator: $1, Expr: $2}
  }
| INTERVAL value_expression sql_id
  {
    // This rule prevents the usage of INTERVAL
    // as a function. If support is needed for that,
    // we'll need to revisit this. The solution
    // will be non-trivial because of grammar conflicts.
    $$ = &ast.IntervalExpr{Exprs: ast.Exprs{$2}, Unit: $3.(ast.ColIdent)}
  }
| value_expression '%' ROWCOUNT
  {
    $$ = &ast.CursorAttributeExpr{CursorName: $1, Attribute: ast.RowcountStr}
  }
| simple_expr

simple_expr:
  value
| boolean_value
  {
    $$ = $1.(ast.Expr)
  }
| column_name
  {
    $$ = $1.(ast.Expr)
  }
| general_element_value
  {
    $$ = $1.(ast.Expr)
  }
| rownum
  {
    $$ = $1.(ast.Expr)
  }
| '(' expression ')'
  {
    $$ = &ast.ParenExpr{Expr: $2.(ast.Expr)}
  }
| '(' expression ',' expression_list ')'
  {
    var valTuple ast.ValTuple
    valTuple = append(valTuple, $2)
    valTuple = append(valTuple, $4.(ast.Exprs)...)
    $$ = valTuple
  }
| subquery
  {
    $$ = $1.(ast.Expr)
  }
| function_call_generic
| function_call_keyword
| function_call_nonkeyword
| function_call_conflict
| variable
| '!' value_expression %prec UNARY
  {
    $$ = &ast.UnaryExpr{Operator: ast.BangStr, Expr: $2}
  }
| '~' value_expression
  {
    $$ = &ast.UnaryExpr{Operator: ast.TildaStr, Expr: $2}
  }
| '-' value_expression %prec UNARY
  {
    if num, ok := $2.(*ast.SQLVal); ok && num.Type == ast.IntVal {
    	// Handle double negative
    	if num.Val[0] == '-' {
    		num.Val = num.Val[1:]
    		$$ = num
    	} else {
    		$$ = ast.NewIntValV2("-" + string(num.Val))
    	}
    } else {
    	$$ = &ast.UnaryExpr{Operator: ast.UMinusStr, Expr: $2}
    }
  }
| '+' value_expression %prec UNARY
  {
    if num, ok := $2.(*ast.SQLVal); ok && num.Type == ast.IntVal {
    	$$ = num
    } else {
    	$$ = &ast.UnaryExpr{Operator: ast.UPlusStr, Expr: $2}
    }
  }
| cursor_expression
  {
    $$ = $1.(ast.Expr)
  }

variable:
  system_variable
| user_variable

system_variable:
  DOUBLE_AT_ID
  {
    v := strings.ToLower($1)
    var isGlobal bool
    isImplicit := false
    if strings.HasPrefix(v, "@@global.") {
    	isGlobal = true
    	v = strings.TrimPrefix(v, "@@global.")
    } else if strings.HasPrefix(v, "@@session.") {
    	v = strings.TrimPrefix(v, "@@session.")
    } else if strings.HasPrefix(v, "@@local.") {
    	v = strings.TrimPrefix(v, "@@local.")
    } else if strings.HasPrefix(v, "@@") {
    	v, isImplicit = strings.TrimPrefix(v, "@@"), true
    }
    $$ = &ast.VariableExpr{Name: ast.NewColIdent(v), IsGlobal: isGlobal, IsSystem: true, IsImplicit: isImplicit}
  }

user_variable:
  SINGLE_AT_ID
  {
    $$ = &ast.VariableExpr{Name: ast.NewColIdent(strings.TrimPrefix($1, "@")), IsGlobal: false, IsSystem: false}
  }

/*
  Regular function calls without special token or syntax, guaranteed to not
  introduce side effects due to being a simple identifier
*/
function_call_generic:
  sql_id openb opt_func_arg_list closeb
  {
    if $1.(ast.ColIdent).Lowered() == "get_lock" {
    	setHasGetLockNode(yylex, true)
    }
    var selExprs ast.SelectExprs
    if $3 != nil {
    	selExprs = $3.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: $1.(ast.ColIdent), Exprs: selExprs}
  }
| sql_id openb DISTINCT func_arg_list closeb
  {
    $$ = &ast.FuncExpr{Name: $1.(ast.ColIdent), Distinct: true, Exprs: $4.(ast.SelectExprs)}
  }
| table_id '.' reserved_sql_id openb opt_func_arg_list closeb
  {
    var selExprs ast.SelectExprs
    if $5 != nil {
    	selExprs = $5.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Qualifier: $1.(ast.TableIdent), Name: $3.(ast.ColIdent), Exprs: selExprs}
  }

/*
 * TODO; oracle function grammar
  Function calls using reserved keywords, with dedicated grammar rules
  as a result
*/
function_call_keyword:
  LEFT openb func_arg_list closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent("left"), Exprs: ast.TransExprsToSelExprs($3.(ast.Exprs))}
  }
| RIGHT openb func_arg_list closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent("right"), Exprs: ast.TransExprsToSelExprs($3.(ast.Exprs))}
  }
| INSERT openb func_arg_list closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent("insert"), Exprs: ast.TransExprsToSelExprs($3.(ast.Exprs))}
  }
| CAST openb expression AS type_spec closeb
  {
    asType := &ast.ConvertType{
      TypeSpec: $5.(*ast.TypeSpec),
    }
    $$ = &ast.ConvertExpr{Expr: $3, Type: asType, IsCast: true}
  }
| CONVERT openb expression USING charset closeb
  {
    $$ = &ast.ConvertUsingExpr{Expr: $3, Type: $5}
  }
| MATCH openb select_expression_list closeb AGAINST openb value_expression match_option closeb
  {
    $$ = &ast.MatchExpr{Columns: $3.(ast.SelectExprs), Expr: $7, Option: $8}
  }
| WM_CONCAT openb opt_distinct select_expression_list opt_order_by opt_separator closeb
  {
    var orderBy ast.OrderBy
    if $5 != nil {
    	orderBy = $5.(ast.OrderBy)
    }
    $$ = &ast.GroupConcatExpr{Distinct: $3, Exprs: $4.(ast.SelectExprs), OrderBy: orderBy, Separator: $6, IsWmConcat: true}
  }
| GROUP_CONCAT openb opt_distinct select_expression_list opt_order_by opt_separator closeb
  {
    var orderBy ast.OrderBy
    if $5 != nil {
    	orderBy = $5.(ast.OrderBy)
    }
    $$ = &ast.GroupConcatExpr{Distinct: $3, Exprs: $4.(ast.SelectExprs), OrderBy: orderBy, Separator: $6}
  }
| CASE opt_expression when_expression_list opt_else_expression END
  {
    $$ = &ast.CaseExpr{Expr: $2, Whens: $3.([]*ast.When), Else: $4}
  }
| VALUES openb column_name closeb
  {
    $$ = &ast.ValuesFuncExpr{Name: $3.(*ast.ColName)}
  }
| CONCAT openb expression_list closeb
  {
    $$ = &ast.ConcatExpr{Exprs: $3.(ast.Exprs)}
  }
| TO_NUMBER openb expression opt_convert_default_value opt_fmt closeb
  {
    var format *ast.OracleFormat
    if $5 != nil {
    	format = $5.(*ast.OracleFormat)
    }
    $$ = &ast.TypeConvertExpr{Name: ast.NewColIdent($1), Expr: $3, DefaultValue: $4, Fmt: format}
  }
| TO_DATE openb expression opt_convert_default_value opt_fmt closeb
  {
    var format *ast.OracleFormat
    if $5 != nil {
    	format = $5.(*ast.OracleFormat)
    }
    $$ = &ast.TypeConvertExpr{Name: ast.NewColIdent($1), Expr: $3, DefaultValue: $4, Fmt: format}
  }
| TO_TIMESTAMP openb expression opt_convert_default_value opt_fmt closeb
  {
    var format *ast.OracleFormat
    if $5 != nil {
    	format = $5.(*ast.OracleFormat)
    }
    $$ = &ast.TypeConvertExpr{Name: ast.NewColIdent($1), Expr: $3, DefaultValue: $4, Fmt: format}
  }
| NEW_TIME openb func_arg_list closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: $3.(ast.SelectExprs)}
  }
| TO_CHAR openb expression opt_convert_default_value opt_fmt closeb
  {
    var format *ast.OracleFormat
    if $5 != nil {
    	format = $5.(*ast.OracleFormat)
    }
    $$ = &ast.TypeConvertExpr{Name: ast.NewColIdent($1), Expr: $3, DefaultValue: $4, Fmt: format}
  }
| SYSDATE
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), NoParenthesis: true}
  }
| SYSTIMESTAMP
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), NoParenthesis: true}
  }
| SESSIONTIMEZONE
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), NoParenthesis: true}
  }
| TRIM openb expression closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{ast.NewStrVal([]byte(" ")), $3, ast.NewStrVal([]byte(ast.BothStr))}), TrimType: ""}
  }
| TRIM openb LEADING expression FROM expression closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{$4, $6, ast.NewStrVal([]byte(ast.LeadingStr))}), TrimType: ast.LeadingStr}
  }
| TRIM openb TRAILING expression FROM expression closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{$4, $6, ast.NewStrVal([]byte(ast.TrailingStr))}), TrimType: ast.TrailingStr}
  }
| TRIM openb BOTH expression FROM expression closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{$4, $6, ast.NewStrVal([]byte(ast.BothStr))}), TrimType: ast.BothStr}
  }
| TRIM openb LEADING FROM expression closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{ast.NewStrVal([]byte(" ")), $5, ast.NewStrVal([]byte(ast.LeadingStr))}), TrimType: ast.LeadingStr}
  }
| TRIM openb TRAILING FROM expression closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{ast.NewStrVal([]byte(" ")), $5, ast.NewStrVal([]byte(ast.TrailingStr))}), TrimType: ast.TrailingStr}
  }
| TRIM openb BOTH FROM expression closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{ast.NewStrVal([]byte(" ")), $5, ast.NewStrVal([]byte(ast.BothStr))}), TrimType: ast.BothStr}
  }
| TRIM openb expression FROM expression closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{$3, $5, ast.NewStrVal([]byte(ast.BothStr))}), TrimType: ""}
  }

opt_convert_default_value:
  {
    $$ = nil
  }
| DEFAULT expression ON CONVERSION ERROR
  {
    $$ = $2
  }

opt_fmt:
  {
    $$ = nil
  }
| ',' expression opt_nls_param
  {
    $$ = &ast.OracleFormat{Fmt: $2, NLSParam: $3}
  }

opt_nls_param:
  {
    $$ = nil
  }
| ',' expression
  {
    $$ = $2
  }

/*
  Function calls using non reserved keywords but with special syntax forms.
  Dedicated grammar rules are needed because of the special syntax
*/
function_call_nonkeyword:
  CURRENT_TIMESTAMP opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
| UTC_TIMESTAMP opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
| UTC_TIME opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
| UTC_DATE opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
// now
| LOCALTIME opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
// now
| LOCALTIMESTAMP opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
// curdate
| CURRENT_DATE
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), NoParenthesis: true}
  }
// curtime
| CURRENT_TIME opt_func_datetime_precision
  {
    var expr ast.SelectExprs
    if $2 != nil {
    	expr = $2.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: expr}
  }
| EXTRACT openb datetime_unit FROM expression closeb
  {
    $$ = &ast.ExtractExpr{Field: $3.(ast.Expr), Expr: $5}
  }
| ASCII openb opt_func_arg_list closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: $3.(ast.SelectExprs)}
  }
| JSON_VALUE '(' simple_expr ',' value opt_returning_spec opt_on_empty_or_error ')'
  {
    var d6 *ast.ReturningSpec
    if $6 != nil {
      d6 = $6.(*ast.ReturningSpec)
    }
    var d7 *ast.JsonOnEmptyOrErrResp
    if $7 != nil {
    	d7 = $7.(*ast.JsonOnEmptyOrErrResp)
    }
    var dd *ast.JsonOptions
    if d6 != nil || d7 != nil {
       dd = &ast.JsonOptions{ReturningSpec: d6, JsonOnEmptyErrResp: d7}
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{$3, $5}), JsonOptions: dd}
  }
| JSON_QUERY '(' simple_expr ',' value opt_returning_spec opt_wrapper opt_on_empty_or_error ')'
  {
    var d6 *ast.ReturningSpec
    if $6 != nil {
      d6 = $6.(*ast.ReturningSpec)
    }
    var d8 *ast.JsonOnEmptyOrErrResp
    if $8 != nil {
       d8 = $8.(*ast.JsonOnEmptyOrErrResp)
    }
    dd := &ast.JsonOptions{ReturningSpec: d6, JsonWrapperTyp: $7.(ast.JsonWrapperTyp), JsonOnEmptyErrResp: d8}
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{$3, $5}), JsonOptions: dd}
  }
| JSON_EXISTS '(' expression ',' value opt_on_empty_or_error ')'
  {
    var d6 *ast.JsonOnEmptyOrErrResp
    if $6 != nil {
      d6 = $6.(*ast.JsonOnEmptyOrErrResp)
    }
    dd := &ast.JsonOptions{JsonOnEmptyErrResp: d6}
    $$ = &ast.FuncExpr{Name: ast.NewColIdent($1), Exprs: ast.TransExprsToSelExprs(ast.Exprs{$3, $5}), JsonOptions: dd}
  }

opt_returning_spec:
  opt_returning_type opt_ascii opt_pretty
  {
    var d1 *ast.ConvertType
    if $1 != nil {
      d1 = $1.(*ast.ConvertType)
    }
    $$ = &ast.ReturningSpec{ReturningTyp: d1, Ascii: $2.(bool), Pretty: $3.(bool)}
  }

opt_returning_type:
  {
    $$ = nil
  }
| RETURNING native_type_with_precision
  {
    dd := &ast.TypeSpec{DataType: &ast.DataType{TypeWithPrecision: $2.(*ast.PlsqlNativeType)}}
    $$ = &ast.ConvertType{TypeSpec: dd}
  }

opt_ascii:
  {
    $$ = false
  }
| ASCII
  {
    $$ = true
  }

opt_pretty:
  {
    $$ = false
  }
| PRETTY
  {
    $$ = true
  }

opt_on_empty_or_error:
  /* empty */
  {
    $$ = nil
  }
| on_empty
  {
    $$ = &ast.JsonOnEmptyOrErrResp{EmptyResp: $1.(*ast.JsonOnResp)}
  }
| on_error
  {
    $$ = &ast.JsonOnEmptyOrErrResp{ErrorResp: $1.(*ast.JsonOnResp)}
  }
| on_empty on_error
  {
    $$ = &ast.JsonOnEmptyOrErrResp{EmptyResp: $1.(*ast.JsonOnResp), ErrorResp: $2.(*ast.JsonOnResp)}
  }
| on_error on_empty
  {
    $$ = &ast.JsonOnEmptyOrErrResp{ErrorResp: $1.(*ast.JsonOnResp), EmptyResp: $2.(*ast.JsonOnResp)}
  }

on_empty:
  json_on_response ON EMPTY

on_error:
  json_on_response ON ERROR

json_on_response:
  ERROR
  {
    $$ = &ast.JsonOnResp{Typ: ast.JsonRespError}
  }
| NULL
  {
    $$ = &ast.JsonOnResp{Typ: ast.JsonRespNull}
  }
| DEFAULT signed_literal
  {
    $$ = &ast.JsonOnResp{Typ: ast.JsonRespDefault, Value: $2.(*ast.SQLVal)}
  }
| EMPTY
  {
    $$ = &ast.JsonOnResp{Typ: ast.JsonRespEmptyArray}
  }
| EMPTY ARRAY
  {
    $$ = &ast.JsonOnResp{Typ: ast.JsonRespEmptyArray}
  }
| EMPTY OBJECT
  {
    $$ = &ast.JsonOnResp{Typ: ast.JsonRespEmptyObject}
  }
| TRUE
  {
    $$ = &ast.JsonOnResp{Typ: ast.JsonRespTrue}
  }
| FALSE
  {
    $$ = &ast.JsonOnResp{Typ: ast.JsonRespFalse}
  }

opt_wrapper:
  {
    $$ = ast.JsonWrapperNone
  }
| WITHOUT opt_array WRAPPER
  {
    $$ = ast.JsonWrapperNone
  }
| WITH opt_conditional opt_array WRAPPER
  {
    d2 := $2.(bool)
    if d2 {
      $$ = ast.JsonWrapperConditional
    } else {
      $$ = ast.JsonWrapperUnconditional
    }
  }

opt_array:
  {
    $$ = ""
  }
| ARRAY

opt_conditional:
  {
    $$ = false
  }
| UNCONDITIONAL
  {
    $$ = false
  }
| CONDITIONAL
  {
    $$ = true
  }

opt_func_datetime_precision:
  {
    $$ = nil
  }
| openb closeb
  {
    $$ = nil
  }
/* support time func with precision like current_timestamp(6) */
| openb INTEGRAL closeb
  {
    err := ast.CheckDateTimePrecisionOption(ast.NewIntValV2($2))
    if err == nil {
    	$$ = ast.SelectExprs{&ast.AliasedExpr{Expr: ast.NewIntValV2($2)}}
    } else {
    	yylex.Error(err.Error())
    	return 1
    }
  }

datetime_unit:
  datetime_field
  {
    $$ = ast.NewStrValV2($1)
  }

datetime_field:
  YEAR
| MONTH
| DAY
| HOUR
| MINUTE
| SECOND
| TIMEZONE_HOUR
| TIMEZONE_MINUTE
| TIMEZONE_REGION
| TIMEZONE_ABBR

/*
  Function calls using non reserved keywords with *ast.normal*ast. syntax forms. Because
  the names are non-reserved, they need a dedicated rule so as not to conflict
*/
function_call_conflict:
  IF openb func_arg_list closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent("if"), Exprs: $3.(ast.SelectExprs)}
  }
| DATABASE openb opt_func_arg_list closeb
  {
    var selExprs ast.SelectExprs
    if $3 != nil {
    	selExprs = $3.(ast.SelectExprs)
    }
    $$ = &ast.FuncExpr{Name: ast.NewColIdent("database"), Exprs: selExprs}
  }
| MOD openb func_arg_list closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent("mod"), Exprs: $3.(ast.SelectExprs)}
  }
| REPLACE openb func_arg_list closeb
  {
    $$ = &ast.FuncExpr{Name: ast.NewColIdent("replace"), Exprs: $3.(ast.SelectExprs)}
  }

match_option:
  {
    $$ = ""
  }
| IN BOOLEAN MODE
  {
    $$ = ast.BooleanModeStr
  }
| IN NATURAL LANGUAGE MODE
  {
    $$ = ast.NaturalLanguageModeStr
  }
| IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION
  {
    $$ = ast.NaturalLanguageModeWithQueryExpansionStr
  }
| WITH QUERY EXPANSION
  {
    $$ = ast.QueryExpansionStr
  }

charset:
  ID
| STRING

opt_expression:
  {
    $$ = nil
  }
| expression

opt_separator:
  {
    $$ = ""
  }
| SEPARATOR STRING
  {
    $$ = $2
  }

when_expression_list:
  when_expression
  {
    $$ = []*ast.When{$1.(*ast.When)}
  }
| when_expression_list when_expression
  {
    $$ = append($1.([]*ast.When), $2.(*ast.When))
  }

when_expression:
  WHEN expression THEN expression
  {
    $$ = &ast.When{Cond: $2, Val: $4}
  }

opt_else_expression:
  {
    $$ = nil
  }
| ELSE expression
  {
    $$ = $2
  }

rownum:
  ROWNUM
  {
    setHasRownum(yylex, true)
    $$ = &ast.RownumExpr{}
  }

column_name:
  sql_id
  {
    $$ = &ast.ColName{Name: $1.(ast.ColIdent)}
  }
| table_id '.' reserved_sql_id
  {
    $$ = &ast.ColName{Qualifier: ast.TableName{Name: $1.(ast.TableIdent)}, Name: $3.(ast.ColIdent)}
  }
| table_id '.' reserved_table_id '.' reserved_sql_id
  {
    $$ = &ast.ColName{Qualifier: ast.TableName{Qualifier: $1.(ast.TableIdent), Name: $3.(ast.TableIdent)}, Name: $5.(ast.ColIdent)}
  }

value:
  string_list %prec LOWTHANSTRING
  {
    $$ = ast.NewStrValV2($1)
  }
| temporal_literal
| HEX
  {
    $$ = ast.NewHexValV2($1)
  }
| BIT_LITERAL
  {
    $$ = ast.NewBitValV2($1)
  }
| INTEGRAL
  {
    $$ = ast.NewIntValV2($1)
  }
| FLOAT
  {
    $$ = ast.NewFloatValV2($1)
  }
| HEXNUM
  {
    $$ = ast.NewHexNumV2($1)
  }
| VALUE_ARG
  {
    $$ = ast.NewValArgV2($1)
  }
| NULL
  {
    $$ = &ast.NullVal{}
  }

string_list:
  STRING
| string_list STRING
  {
    $$ = $1 + $2
  }

temporal_literal:
  DATE STRING
  {
    $$ = ast.NewDateValV2($2)
  }
| TIME STRING
  {
    $$ = ast.NewTimeValV2($2)
  }
| TIMESTAMP STRING
  {
    $$ = ast.NewTimestampValV2($2)
  }

num_val:
  sql_id
  {
    // TODO(sougou): Deprecate this construct.
    if $1.(ast.ColIdent).Lowered() != "value" {
    	yylex.Error("expecting value after next")
    	return 1
    }
    $$ = ast.NewIntValV2("1")
  }

opt_group_by:
  {
    $$ = nil
  }
| GROUP BY expression_list
  {
    $$ = $3
  }

opt_having:
  {
    $$ = nil
  }
| HAVING expression
  {
    $$ = $2
  }

opt_order_by:
  {
    $$ = nil
  }
| sort_clause

sort_clause:
  ORDER BY order_list
  {
    $$ = $3
  }

order_list:
  order
  {
    $$ = ast.OrderBy{$1.(*ast.Order)}
  }
| order_list ',' order
  {
    $$ = append($1.(ast.OrderBy), $3.(*ast.Order))
  }

order:
  expression opt_asc_desc
  {
    $$ = &ast.Order{Expr: $1, Direction: $2}
  }

opt_asc_desc:
  {
    $$ = ast.AscScr
  }
| ASC
  {
    $$ = ast.AscScr
  }
| DESC
  {
    $$ = ast.DescScr
  }

opt_limit:
  {
    $$ = nil
  }
| select_limit

select_limit:
  LIMIT expression
  {
    setHasLimit(yylex, true)
    $$ = &ast.Limit{Rowcount: $2}
  }
| LIMIT expression ',' expression
  {
    setHasLimit(yylex, true)
    $$ = &ast.Limit{Offset: $2, Rowcount: $4}
  }
| LIMIT expression OFFSET expression
  {
    setHasLimit(yylex, true)
    $$ = &ast.Limit{Offset: $4, Rowcount: $2}
  }

opt_lock:
  {
    $$ = ""
  }
| for_locking_clause

for_locking_clause:
  FOR UPDATE
  {
    $$ = ast.ForUpdateStr
  }
| LOCK IN SHARE MODE
  {
    $$ = ast.ShareModeStr
  }

// insert_data expands all combinations into a single rule.
// This avoids a shift/reduce conflict while encountering the
// following two possible constructs:
// insert into t1(a, b) (select *ast. from t2)
// insert into t1(select *ast. from t2)
// Because the rules are together, the parser can keep shifting
// the tokens until it disambiguates a as sql_id and select as keyword.
insert_data:
  VALUES tuple_list
  {
    $$ = &ast.Insert{Rows: $2.(ast.InsertRows)}
  }
| select_statement
  {
    $$ = &ast.Insert{Rows: $1.(ast.InsertRows)}
  }
| openb ins_column_list closeb VALUES tuple_list
  {
    $$ = &ast.Insert{Columns: $2.(ast.Columns), Rows: $5.(ast.InsertRows)}
  }
| openb ins_column_list closeb select_statement
  {
    $$ = &ast.Insert{Columns: $2.(ast.Columns), Rows: $4.(ast.InsertRows)}
  }

ins_column_list:
  sql_id
  {
    $$ = ast.Columns{$1.(ast.ColIdent)}
  }
| sql_id '.' sql_id
  {
    $$ = ast.Columns{$3.(ast.ColIdent)}
  }
| ins_column_list ',' sql_id
  {
    dd := $1.(ast.Columns)
    dd = append(dd, $3.(ast.ColIdent))
    $$ = dd
  }
| ins_column_list ',' sql_id '.' sql_id
  {
    dd := $1.(ast.Columns)
    dd = append(dd, $5.(ast.ColIdent))
    $$ = dd
  }

opt_on_dup:
  {
    $$ = nil
  }
| ON DUPLICATE KEY UPDATE update_list
  {
    $$ = $5
  }

tuple_list:
  tuple_or_empty
  {
    $$ = ast.Values{$1.(ast.ValTuple)}
  }
| tuple_list ',' tuple_or_empty
  {
    $$ = append($1.(ast.Values), $3.(ast.ValTuple))
  }

tuple_or_empty:
  row_tuple
| openb closeb
  {
    $$ = ast.ValTuple{}
  }

row_tuple:
  openb expression_list closeb
  {
    $$ = ast.ValTuple($2.(ast.Exprs))
  }

tuple_expression:
  row_tuple
  {
    if len($1.(ast.ValTuple)) == 1 {
    	$$ = &ast.ParenExpr{Expr:$1.(ast.ValTuple)[0]}
    } else {
    	$$ = $1.(ast.ValTuple)
    }
  }

update_list:
  update_expression
  {
    $$ = ast.UpdateExprs{$1.(*ast.UpdateExpr)}
  }
| update_list ',' update_expression
  {
    $$ = append($1.(ast.UpdateExprs), $3.(*ast.UpdateExpr))
  }

update_expression:
  column_name '=' expression
  {
    $$ = &ast.UpdateExpr{Name: $1.(*ast.ColName), Expr: $3}
  }

set_list:
  set_expression
  {
    $$ = ast.SetExprs{$1.(*ast.SetExpr)}
  }
| set_list ',' set_expression
  {
    $$ = append($1.(ast.SetExprs), $3.(*ast.SetExpr))
  }

set_expression:
  var_name eq_or_assigneq set_expr_or_default
  {
    $$ = &ast.SetExpr{Name: $1.(ast.ColIdent), Value: $3, IsImplicit: true, IsSystem: true}
  }
| GLOBAL var_name eq_or_assigneq set_expr_or_default
  {
    $$ = &ast.SetExpr{Name: $2.(ast.ColIdent), Value: $4, IsGlobal: true, IsSystem: true}
  }
| SESSION var_name eq_or_assigneq set_expr_or_default
  {
    $$ = &ast.SetExpr{Name: $2.(ast.ColIdent), Value: $4, IsSystem: true}
  }
| LOCAL var_name eq_or_assigneq expression
  {
    $$ = &ast.SetExpr{Name: $2.(ast.ColIdent), Value: $4, IsSystem: true}
  }
| DOUBLE_AT_ID eq_or_assigneq set_expr_or_default
  {
    v := strings.ToLower($1)
    var isGlobal, isImplicit bool
    if strings.HasPrefix(v, "@@global.") {
    	isGlobal = true
    	v = strings.TrimPrefix(v, "@@global.")
    } else if strings.HasPrefix(v, "@@session.") {
    	v = strings.TrimPrefix(v, "@@session.")
    } else if strings.HasPrefix(v, "@@local.") {
    	v = strings.TrimPrefix(v, "@@local.")
    } else if strings.HasPrefix(v, "@@") {
    	isImplicit = true
    	v = strings.TrimPrefix(v, "@@")
    }
    $$ = &ast.SetExpr{Name: ast.NewColIdent(v), Value: $3, IsImplicit: isImplicit, IsGlobal: isGlobal, IsSystem: true}
  }
| SINGLE_AT_ID eq_or_assigneq expression
  {
    $$ = &ast.SetExpr{Name: ast.NewColIdent(strings.TrimPrefix($1, "@")), Value: $3}
  }
| NAMES charset_name
  {
    $$ = &ast.SetExpr{Name: ast.NewColIdent(SetNames), Value: ast.NewStrValV2($2)}
  }
| NAMES charset_name COLLATE DEFAULT
  {
    $$ = &ast.SetExpr{Name: ast.NewColIdent(SetNames), Value: ast.NewStrValV2($2)}
  }
| NAMES charset_name COLLATE ident_or_text
  {
    $$ = &ast.SetExpr{Name: ast.NewColIdent(SetNames), Value: ast.NewStrValV2($2)}
  }
| NAMES DEFAULT
  {
    $$ = &ast.SetExpr{Name: ast.NewColIdent(SetNames), Value: ast.NewStrValV2($2)}
  }
| charset_keywords charset_name_or_default
  {
    $$ = &ast.SetExpr{Name: ast.NewColIdent(SetCharset), Value: $2}
  }

var_name:
  reserved_sql_id
| reserved_ident '.' reserved_ident
  {
    $$ = ast.NewColIdent($1 + "." + $3)
  }

set_expr_or_default:
  ON
  {
    $$ = ast.NewStrValV2("on")
  }
| OFF
  {
    $$ = ast.NewStrValV2("off")
  }
/* expression contains default, we use it */
| expression

charset_keywords:
  CHARACTER SET
  {
    $$ = "CHARACTER SET"
  }
| CHARSET
| CHAR SET
  {
    $$ = "CHAR SET"
  }

charset_name_or_default:
  charset_name
  {
    $$ = ast.NewStrValV2($1)
  }
| DEFAULT
  {
    $$ = &ast.Default{}
  }

charset_name:
  ident_or_text
| BINARY

collation_name:
  ident_or_text
| BINARY

eq_or_assigneq:
  '='
| ASSIGN

opt_exists:
  {
    $$ = "false"
  }
| IF EXISTS
  {
    $$ = "true"
  }

opt_not_exists:
  {
    $$ = "false"
  }
| IF NOT EXISTS
  {
    $$ = "true"
  }

opt_temporary:
  {
    $$ = "false"
  }
| TEMPORARY
  {
    $$ = "true"
  }

opt_ignore:
  {
    $$ = ""
  }
| IGNORE
  {
    $$ = ast.IgnoreStr
  }

opt_to:
  {
    $$ = struct{}{}
  }
| TO
  {
    $$ = struct{}{}
  }
| AS
  {
    $$ = struct{}{}
  }

opt_constraint_name:
  {
    $$ = ""
  }
| CONSTRAINT opt_ident
  {
    $$ = $2
  }

opt_constraint:
  {
    $$ = ""
  }
| UNIQUE
| FULLTEXT
| SPATIAL
| BITMAP
| MULTIVALUE

opt_index_type:
  {
    $$ = ""
  }
| USING BTREE
  {
    $$ = $2
  }
| USING HASH
  {
    $$ = $2
  }

opt_partition_using:
  /* EMPTY */
  {
    $$ = nil
  }
| USING sql_id
  {
    $$ = $2
  }

sql_id:
  ident
  {
    $$ = ast.NewColIdentWithLineNum($1, getLineNum(yylex))
  }

reserved_sql_id:
  sql_id
| reserved_keyword
  {
    $$ = ast.NewColIdentWithLineNum($1, getLineNum(yylex))
  }

table_id:
  ident
  {
    $$ = ast.NewTableIdentWithLineNum($1, getLineNum(yylex))
  }

reserved_table_id:
  table_id
| reserved_keyword
  {
    $$ = ast.NewTableIdentWithLineNum($1, getLineNum(yylex))
  }

opt_ident:
  {
    $$ = ""
  }
| ident

/*
	This token is a string type that can match identifier and non-reserved keywords.
	Import: It should be formatted properly when using as name of Schema Object.

	More Info about Schema Object: https://dev.mysql.com/doc/refman/8.0/en/identifiers.html
*/

ident_string_list:
  ident
  {
    $$ = []string{$1}
  }
| ident_string_list ',' ident
  {
    $$ = append($1.([]string), $3)
  }

ident:
  ID
| non_reserved_keyword

reserved_ident:
  ident
| reserved_keyword

/*
  These are not all necessarily reserved in MySQL, but some are.

  These are more importantly reserved because they may conflict with our grammar.
  If you want to move one that is not reserved in MySQL (i.e. ESCAPE) to the
  non_reserved_keyword, you'll need to deal with any conflicts.

  Sorted alphabetically
*/
reserved_keyword:
  ACCESS
| ADD
| ALL
| ALTER
| AND
| AS
| ASC
| ASCII
| BACKEND
| BEGIN
| BETWEEN
| BFILE
| BINARY
| BINARY_DOUBLE
| BINARY_FLOAT
| BINARY_INTEGER
| BLOB
| BODY
| BOOL
| BOOLEAN
| BY
| CASE
| CAST
| CHAR
| CHECK
| CLOB
| COLLATE
| COLUMN
| COMMIT
| COMPRESS
| CONCAT
| CONSTRAINT
| CONVERT
| CREATE
| CROSS
| CURRENT_DATE
| CURRENT_TIME
| CURRENT_TIMESTAMP
| DATABASE
| DATABASES
| DATE
| DEC
| DECLARE
| DECIMAL
| DEFAULT
| DELETE
| DESC
| DESCRIBE
| DISTINCT
| DISTRIBUTED
| DIV
| DOUBLE
| DROP
| ELSE
| END
| ESCAPE
| EXISTS
| EXPLAIN
| FALSE
| FLOAT_TYPE
| FOR
| FORCE
| FOREIGN
| FROM
| FULL
| FUNCTION
| GENERATED
| GLKJOIN
| GRANT
| GROUP
| HAVING
| IF
| IGNORE
| IN
| INDEX
| INNER
| INSERT
| INT
| INTEGER
| INTERSECT
| INTERVAL
| INTO
| IS
| JOIN
| JSON
| KEY
| KEYS
| LEADING
| LEFT
| LIKE
| LIMIT
| LOCALTIME
| LOCALTIMESTAMP
| LOCK
| MATCH
| MAXVALUE
| MAXEXTENTS
| MEMBER
| MINUS
| MOD
| NATURAL
| NATURALN
| NCHAR
| NCLOB
// next should be doable as non-reserved, but is not due to the special `select next num_val` query that vitess supports
| NEXT
| NEW_TIME
| NOCOMPRESS
| NOT
| NULL
| NUMBER
| NUMERIC
| NVARCHAR
| NVARCHAR2
| OFF
| ON
| OR
| ORDER
| OUTER
| PACKAGE
| PACKAGES
| PARTITION
| POSITIVE
| POSITIVEN
| PRIMARY
| PROCEDURE
| RAW
| REAL
| REFERENCES
| REGEXP
| RENAME
| REPLACE
| REUSE
| REVERSE
| RIGHT
| ROLLBACK
| ROWID
| ROWNUM
| SAVEPOINT
| SCHEMA
| SCHEMAS
| SELECT
| SEPARATOR
| SESSIONTIMEZONE
| SET
| SHOW
| SMALLINT
| SPATIAL
| STRAIGHT_JOIN
| SYNONYM
| SYSDATE
| SYSTIMESTAMP
| TABLE
| TEXT
| THEN
| TIMESTAMP
| TO
| TO_CHAR
| TO_DATE
| TO_NUMBER
| TO_TIMESTAMP
| TRIGGER
| TRIM
| TRUE
| UNION
| UNIQUE
| UROWID
| UNSIGNED
| UPDATE
| USAGE
| USE
| USING
| UTC_DATE
| UTC_TIME
| UTC_TIMESTAMP
| VALUES
| VARCHAR
| VARCHAR2
| VARCHARACTER
| VIEW
| WHEN
| WHERE
| WITH
| YEAR

/*
  These are non-reserved Vitess, because they don't cause conflicts in the grammar.
  Some of them may be reserved in MySQL. The good news is we backtick quote them
  when we rewrite the query, so no issue should arise.

  Sorted alphabetically
*/
non_reserved_keyword:
  non_reserved_keyword_unambiguous
| non_reserved_keyword_ambiguous_1_roles_and_labels
| non_reserved_keyword_ambiguous_2_labels
| non_reserved_keyword_ambiguous_3_roles
| non_reserved_keyword_ambiguous_4_system_variables

/*
  These non-reserved words cannot be used as role names and SP label names:
*/
non_reserved_keyword_ambiguous_1_roles_and_labels:
  EXECUTE
| SHUTDOWN

/*
  These non-reserved keywords cannot be used as unquoted SP label names:
*/
non_reserved_keyword_ambiguous_2_labels:
  CACHE
| CHARSET
| CHECKSUM
| NO
| REPAIR
| SIGNED
| SLAVE
| TRUNCATE

/*
  These non-reserved keywords cannot be used as unquoted role names:
*/
non_reserved_keyword_ambiguous_3_roles:
  EVENT
| FILE
| NONE
| PROCESS
| RELOAD
| REPLICATION
| SUPER

/*
  These non-reserved keywords cannot be used as unquoted unprefixed
  variable names and unquoted variable prefixes in the left side of
  assignments in SET statements:
*/
non_reserved_keyword_ambiguous_4_system_variables:
  GLOBAL
| LOCAL
| SESSION

non_reserved_keyword_unambiguous:
  ACCESSIBLE
| ACCOUNT
| ACTION
| ADMIN
| ADVANCED
| AFTER
| AGAINST
| AGGREGATE
| ALGORITHM
| ALLOW
| ALWAYS
| ANALYZE
| ANCILLARY
| ANY
| ANYSCHEMA
| ARRAY
| ASSIGN_OP
| AUTHID
| AUTO_INCREMENT
| AVG_ROW_LENGTH
| BASIC
| BASICFILE
| BATCH
| BEFORE
| BEQUEATH
| BIGINT
| BINARY_MD5
| BINDING
| BINDVAR
| BIT
| BITMAP
| BTREE
| BUFFER_POOL
| BYTE
| CALL
| CAPACITY
| CASCADE
| CASCADED
| CHANGE
| CHARACTER
| CLIENT
| CLOSE
| COALESCE
| COLLATION
| COLUMNS
| COLUMN_FORMAT
| COMMENT_KEYWORD
| COMMITTED
| COMPACT
| COMPILE
| COMPOUND
| COMPRESSED
| COMPRESSION
| COMPUTE
| CONDITIONAL
| CONNECTION
| CONTAINER
| CONTEXT
| CONVERSION
| CREATION
| CURRENT
| CURRENT_USER
| CYCLE
| C_LETTER
| DATA
| DATETIME
| DAY
| DAYS
| DEFINER
| DELAY_KEY_WRITE
| DELETE_ALL
| DEFERRABLE
| DEFERRED
| DETERMINISTIC
| DIRECTORY
| DISABLE
| DISABLE_ALL
| DISALLOW
| DISCARD
| DISK
| DML
| DUPLICATE
| DYNAMIC
| EACH
| ELEMENT
| ENABLE
| ENCRYPT
| ENCRYPTION
| ENFORCED
| ENGINE
| ENGINES
| ENGINE_ATTRIBUTE
| EDITIONABLE
| EDITIONING
| ENABLE_ALL
| ENUM
| ERROR
| ERRORS
| EXCEPT
| EXCEPTIONS
| EXCEPTION_INIT
| EXCHANGE
| EXPANSION
| EXPIRE
| EXTENDED
| EXTERNAL
| EXTERNALLY
| FAILED_LOGIN_ATTEMPTS
| FIELDS
| FILESYSTEM_LIKE_LOGGING
| FIRST
| FIXED
| FLASH_CACHE
| FORALL
| FORMAT
| FREELIST
| FREELISTS
| GEOMETRY
| GEOMETRYCOLLECTION
| GOTO
| GRANTS
| GROUPS
| HASH
| HIGH
| HISTORY
| GLOBALLY
| HOUR
| IDENTIFIED
| IDENTIFIER
| IDENTITY
| ILM
| IMMEDIATE
| IMPORT
| INCEPTOR
| INCREMENT
| INDEXED
| INDEXES
| INDEXING
| INDICES
| INITIAL
| INITIALLY
| INITRANS
| INMEMORY
| INDEXTYPE
| INSERT_METHOD
| INVISIBLE
| INVOKER
| ISOLATION
| ISSUER
| JAVA
| KEEP
| KEY_BLOCK_SIZE
| KUNDB_CHECKS
| KUNDB_KEYSPACES
| KUNDB_RANGE_INFO
| KUNDB_SHARDS
| KUNDB_VINDEXES
| LANGUAGE
| LAST
| LAST_INSERT_ID
| LESS
| LINEAR
| LEVEL
| LINESTRING
| LIST
| LOCATE
| LONGBLOB
| LONGTEXT
| MANAGED
| LOB
| LOBS
| LOCKING
| LOGGING
| LOW
| MAX_ROWS
| MAXSIZE
| MEDIUMBLOB
| MEDIUMINT
| MEDIUMTEXT
| MEMORY
| MEMCOMPRESS
| METADATA
| MERGE
| MFED
| MINEXTENTS
| MINUTE
| MINVALUE
| MIN_ROWS
| MODE
| MODIFICATION
| MODIFY
| MONTH
| MONTHS
| MULTILINESTRING
| MULTIPOINT
| MULTIPOLYGON
| MULTIVALUE
| NAME
| NAMES
| NAN
| NATIONAL
| NEVER
| NEW
| NOCACHE
| NODEGROUP
| NOLOGGING
| NOMAXVALUE
| NOMINVALUE
| NONEDITIONABLE
| NONSCHEMA
| NOORDER
| NORELY
| NOVALIDATE
| NOW
| NOWAIT
| NO_WRITE_TO_BINLOG
| NUMERIC_STATIC_MAP
| OBJECT
| OFFSET
| OLD
| ONLY
| OPEN
| OPERATOR
| OPTIMAL
| OPTIMIZE
| OPTION
| OPTIONAL
| OVERFLOW
| PACK_KEYS
| PARALLEL_ENABLE
| PARENT
| PARSER
| PARTIAL
| PARTITIONING
| PARTITIONS
| PASSWORD %prec KEYWORD_USED_AS_IDENT
| PASSWORD_LOCK_TIME
| PCTINCREASE
| PCTFREE
| PCTUSED
| PIPE
| PIPELINED
| POINT
| POLICY
| POLYGON
| PRECISION
| PRETTY
| PRIVILEGES
| PROCESSLIST
| QUERY
| RANGE
| READ
| REBUILD
| RECYCLE
| RECORD
| RECURSIVE
| REDUNDANT
| REFERENCE
| REFERENCING
| RELIES_ON
| RELY
| REMOTE_SEQ
| REMOVE
| REORGANIZE
| REPEATABLE
| REQUIRE
| RESTRICT
| RESULT_CACHE
| REVERSE_BITS
| REVOKE
| ROLE
| ROUTINE
| ROW
| ROW_FORMAT
| PRAGMA
| RTREE
| SALT
| SCAN
| SCOPE
| SECOND
| SECONDARY_ENGINE_ATTRIBUTE
| SECUREFILE
| SECURITY
| SEGMENT
| SEQUENCE
| SERIAL
| SERIALIZABLE
| SERVER
| SETTINGS
| SHARDS
| SHARE
| SHARING
| SIMPLE
| SORT
| SQL
| SSL
| STATEMENT
| STATS_AUTO_RECALC
| STATS_PERSISTENT
| STATS_SAMPLE_PAGES
| STATIC
| STATUS
| STORAGE
| STORE
| STORED
| SUBJECT
| SUBPARTITION
| SUBPARTITIONS
| SUBTYPE
| SYSTEM
| TABLES
| TABLESPACE
| TEMPORARY
| TEMPTABLE
| THAN
| TIME %prec KEYWORD_USED_AS_IDENT
| TIMEZONE_HOUR
| TIMEZONE_MINUTE
| TIMEZONE_REGION
| TIMEZONE_ABBR
| TINYBLOB
| TINYINT
| TINYTEXT
| TIER
| TRADITIONAL
| TRANSACTION
| TREE
| TRIGGERS
| TYPE
| UNBOUNDED
| UNCOMMITTED
| UNCONDITIONAL
| UNDEFINED
| UNDER
| UNICODE_LOOSE_MD5
| UNLIMITED
| UNLOCK
| UNSIGNED_INTEGER
| UNUSED
| USER
| USING_NLS_COMP
| VALIDATE
| VALIDATION
| VALUE
| VARBINARY
| VARIABLES
| VARRAY
| VARRAYS
| VARYING
| VIRTUAL
| VISIBLE
| VSCHEMA_TABLES
| WAIT
| WARNINGS
| WRAPPER
| WITHOUT
| WORK
| WRITE
| X509
| XMLSCHEMA
| YEARS
| ZEROFILL
| ZONE

unsupported_show_keyword:
  ACCESS
| ACCESSIBLE
| ADVANCED
| AFTER
| AGAINST
| ASSIGN_OP
| AUTHID
| AVG_ROW_LENGTH
| BACKEND
| BASIC
| BASICFILE
| BATCH
| BEFORE
| BEQUEATH
| BETWEEN
| BIGINT
| BINARY
| BINARY_MD5
| BINDVAR
| BIT
| BITMAP
| BLOB
| BOOL
| BUFFER_POOL
| BY
| BYTE
| CACHE
| CALL
| CAPACITY
| CASCADE
| CASE
| CAST
| CHANGE
| CHAR
| CHARSET
| CHECKSUM
| CLOB
| COLUMN
| COMMENT_KEYWORD
| COMPILE
| COMPRESS
| COMPRESSION
| CONNECTION
| CONCAT
| CONDITIONAL
| CONSTRAINT
| CONTAINER
| CONTAINER_MAP
| CONVERT
| CONVERSION
| CREATION
| CROSS
| CURRENT_DATE
| CURRENT_TIME
| CURRENT_TIMESTAMP
| C_LETTER
| DATA
| DATABASE
| DATE
| DATETIME
| DAY
| DAYS
| DECIMAL
| DEFAULT
| DEFERRABLE
| DEFERRED
| DELAY_KEY_WRITE
| DELETE
| DELETE_ALL
| DESC
| DESCRIBE
| DETERMINISTIC
| DIRECTORY
| DISABLE_ALL
| DISCARD
| DISK
| DISTINCT
| DIV
| DOUBLE
| DROP
| DUPLICATE
| EACH
| ELEMENT
| ELSE
| ENABLE_ALL
| ENCRYPT
| ENCRYPTION
| END
| ENUM
| ERROR
| ESCAPE
| EXCEPTIONS
| EXCEPTION_INIT
| EXCHANGE
| EXISTS
| EXPANSION
| EXPLAIN
| EXTERNAL
| EXTERNALLY
| FALSE
| FILESYSTEM_LIKE_LOGGING
| FLOAT_TYPE
| FOR
| FORALL
| FORCE
| FREELIST
| FREELISTS
| FROM
| FLASH_CACHE
| FULLTEXT
| GLKJOIN
| GLOBAL
| GLOBALLY
| GOTO
| GROUP
| GROUPS
| HASH
| HAVING
| IDENTIFIER
| IDENTITY
| IF
| IGNORE
| ILM
| IMPORT
| IN
| INCEPTOR
| INDEXING
| INDICES
| INITIAL
| INITIALLY
| INITRANS
| INMEMORY
| INNER
| INSERT
| INSERT_METHOD
| INT
| INTEGER
| INTERSECT
| INTERVAL
| INTO
| IS
| JAVA
| JOIN
| JSON
| KEEP
| KEY
| KEY_BLOCK_SIZE
| LANGUAGE
| LAST_INSERT_ID
| LEADING
| LEFT
| LESS
| LIKE
| LIMIT
| LINEAR
| LIST
| LOB
| LOBS
| LOCAL
| LOCALTIME
| LOCALTIMESTAMP
| LOCK
| LOCKING
| LOGGING
| LONGBLOB
| LONGTEXT
| MATCH
| MAXEXTENTS
| MAXSIZE
| MAXVALUE
| MAX_ROWS
| MEDIUMBLOB
| MEDIUMINT
| MEDIUMTEXT
| MEMBER
| MEMCOMPRESS
| MEMORY
| METADATA
| MFED
| MINEXTENTS
| MINUS
| MIN_ROWS
| MOD
| MODE
| MODIFICATION
| MONTHS
| MULTIVALUE
| NAMES
| NAN
| NATURAL
| NCHAR
| NEXT
| NOCOMPRESS
| NODEGROUP
| NOLOGGING
| NONEDITIONABLE
| NOORDER
| NOT
| NULL
| NUMERIC
| NUMERIC_STATIC_MAP
| OBJECT
| OFFSET
| ON
| OPTIMAL
| OPTIMIZE
| OR
| ORDER
| OVERFLOW
| OUTER
| PACK_KEYS
| PARALLEL_ENABLE
| PARTITION
| PASSWORD
| PCTINCREASE
| PIPE
| PIPELINED
| PRAGMA
| PRECISION
| PRETTY
| PRIMARY
| POLICY
| QUERY
| RANGE
| REAL
| REBUILD
| RECORD
| RECURSIVE
| RECYCLE
| REFERENCE
| REFERENCES
| REGEXP
| RELIES_ON
| RENAME
| REORGANIZE
| REPAIR
| REPLACE
| REQUIRE
| RESTRICT
| RESULT_CACHE
| REVERSE_BITS
| RIGHT
| ROW
| ROWNUM
| SALT
| SCOPE
| SECUREFILE
| SEGMENT
| SELECT
| SEPARATOR
| SEQUENCE
| SET
| SETTINGS
| SHARE
| SHARING
| SHOW
| SIGNED
| SMALLINT
| SORT
| SPATIAL
| SSL
| START
| STATS_AUTO_RECALC
| STATS_PERSISTENT
| STATS_SAMPLE_PAGES
| STRAIGHT_JOIN
| STORE
| STORED
| SUBTYPE
| SYSTEM
| TABLESPACE
| TEMPORARY
| TEXT
| THAN
| THEN
| TIME
| TIMESTAMP
| TINYBLOB
| TINYINT
| TINYTEXT
| TIER
| TO
| TRANSACTION
| TRIGGER
| TRIM
| TRUE
| UNCONDITIONAL
| UNDER
| UNICODE_LOOSE_MD5
| UNION
| UNIQUE
| UNLIMITED
| UNLOCK
| UNSIGNED
| UNSIGNED_INTEGER
| UNUSED
| UPDATE
| USE
| USING
| USING_NLS_COMP
| UTC_DATE
| UTC_TIME
| UTC_TIMESTAMP
| VALUES
| VARBINARY
| VARCHAR
| VARRAY
| VARRAYS
| VARYING
| VIEW
| VIRTUAL
| WHEN
| WHERE
| WITH
| WRAPPER
| XMLSCHEMA
| XMLTYPE
| YEAR
| YEARS
| ZEROFILL

openb:
  '('
  {
    if incNesting(yylex) {
    	yylex.Error("max nesting level reached")
    	return 1
    }
  }

closeb:
  ')'
  {
    decNesting(yylex)
  }

force_eof:
  {
    forceEOF(yylex)
  }

ddl_force_eof:
  {
    forceEOF(yylex)
  }
| openb
  {
    forceEOF(yylex)
  }
| reserved_sql_id
  {
    forceEOF(yylex)
  }

/* Oracle PL/SQL Procedure Support */
create_procedure_statement:
  CREATE opt_edition_option procedure_body
  {
    $$ = &ast.CreateProcedureStmt{CreateOrReplace: false, EditionOption: $2.(ast.EditionOption), ProcedureBody: $3.(*ast.ProcedureBody), IsOracle: true}
  }
| CREATE OR REPLACE opt_edition_option procedure_body
  {
    $$ = &ast.CreateProcedureStmt{CreateOrReplace: true, EditionOption: $4.(ast.EditionOption), ProcedureBody: $5.(*ast.ProcedureBody), IsOracle: true}
  }

procedure_body:
  PROCEDURE table_name opt_parameter_list opt_proc_return_suffixs is_or_as block
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $4 != nil {
    	retSuffixs = $4.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.ProcedureBody{AsIs:$5, BaseBody: ast.BaseBody{OptParameters: d3, Block: $6.(*ast.Block)}, ProcName: $2.(ast.TableName), RetSuffixs: retSuffixs}
  }
| PROCEDURE table_name opt_parameter_list opt_proc_return_suffixs is_or_as call_spec
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $4 != nil {
    	retSuffixs = $4.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.ProcedureBody{BaseBody: ast.BaseBody{OptParameters: d3}, ProcName: $2.(ast.TableName), RetSuffixs: retSuffixs, CallSpec: $6.(*ast.CallSpec)}
  }
| PROCEDURE table_name opt_parameter_list opt_proc_return_suffixs is_or_as EXTERNAL
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $4 != nil {
    	retSuffixs = $4.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.ProcedureBody{BaseBody: ast.BaseBody{OptParameters: d3}, ProcName: $2.(ast.TableName), RetSuffixs: retSuffixs, External: $6}
  }

opt_proc_return_suffixs:
  {
    $$ = nil
  }
| proc_return_suffixs

proc_return_suffixs:
  proc_return_suffix
  {
    $$ = ast.FuncReturnSuffixList{$1.(ast.FuncReturnSuffix)}
  }
| proc_return_suffixs proc_return_suffix
  {
    $$ = append($1.(ast.FuncReturnSuffixList), $2.(ast.FuncReturnSuffix))
  }

proc_return_suffix:
  invoker_rights_clause
| accessible_by_clause
| default_collation_clause

drop_procedure_statement:
  DROP PROCEDURE opt_exists table_name
  {
    var exists bool
    if $3 != "false" {
    	exists = true
    }
    $$ = &ast.DropProcedureStmt{Name: $4.(ast.TableName), IfExists: exists, IsOracle: true}
  }

alter_procedure_statement:
  ALTER procedure_alter_body
  {
    $$ = &ast.AlterProcedureStmt{ProcedureAlterBody: $2.(*ast.ProcedureAlterBody), IsOracle: true}
  }

procedure_alter_body:
  PROCEDURE proc_or_func_name COMPILE opt_debug opt_compiler_parameter_list opt_reuse_settings
  {
    var pList ast.CompilerParameterList
    if $5 != nil {
    	pList = $5.(ast.CompilerParameterList)
    }
    $$ = &ast.ProcedureAlterBody{ProcName: $2.(ast.ProcOrFuncName), OptDebug: $4, OptCompilerParameters: pList, OptReuseSettings: $6}
  }
| PROCEDURE proc_or_func_name edition_option
  {
    $$ = &ast.ProcedureAlterBody{ProcName: $2.(ast.ProcOrFuncName), EditionOption: $3.(ast.EditionOption)}
  }

/* Oracle PL/SQL Function Support */
create_function_statement:
  CREATE opt_edition_option function_body
  {
    $$ = &ast.CreateFunctionStmt{CreateOrReplace: false, EditionOption: $2.(ast.EditionOption), FunctionBody: $3.(*ast.FunctionBody), IsOracle: true}
  }
| CREATE OR REPLACE opt_edition_option function_body
  {
    $$ = &ast.CreateFunctionStmt{CreateOrReplace: true, EditionOption: $4.(ast.EditionOption), FunctionBody: $5.(*ast.FunctionBody), IsOracle: true}
  }

opt_edition_option:
  {
    $$ = ast.EditionOption_EMPTY
  }
| edition_option
  {
    $$ = $1
  }

edition_option:
  EDITIONABLE
  {
    $$ = ast.EditionOption_EDITIONABLE
  }
| NONEDITIONABLE
  {
    $$ = ast.EditionOption_NONEDITIONABLE
  }

opt_view_force_edition_option:
  {
    $$ = nil
  }
| EDITIONING
  {
    $$ = &ast.ForceEditionOption{IsEditioning: true}
  }
| EDITIONABLE
  {
    $$ = &ast.ForceEditionOption{IsEditionable: true}
  }
| EDITIONABLE EDITIONING
  {
    $$ = &ast.ForceEditionOption{IsEditionable: true, IsEditioning: true}
  }
| NONEDITIONABLE
  {
    $$ = &ast.ForceEditionOption{IsNonEditionable: true}
  }
| if_force
  {
    $$ = &ast.ForceEditionOption{ForceOption: $1.(string)}
  }
| if_force EDITIONING
  {
    $$ = &ast.ForceEditionOption{ForceOption: $1.(string), IsEditioning: true}
  }
| if_force EDITIONABLE
  {
    $$ = &ast.ForceEditionOption{ForceOption: $1.(string), IsEditionable: true}
  }
| if_force EDITIONABLE EDITIONING
  {
    $$ = &ast.ForceEditionOption{ForceOption: $1.(string), IsEditionable: true, IsEditioning: true}
  }
| if_force NONEDITIONABLE
  {
    $$ = &ast.ForceEditionOption{ForceOption: $1.(string), IsNonEditionable: true}
  }

opt_identified_option:
  {
    $$ = &ast.IdentifiedOption{IdentifiedOption: ast.IdentifiedOption_EMPTY}
  }
| NOT IDENTIFIED
  {
    $$ = &ast.IdentifiedOption{IdentifiedOption: ast.IdentifiedOption_NOT_IDENTIFIED}
  }
| IDENTIFIED BY ident
  {
    $$ = &ast.IdentifiedOption{IdentifiedOption: ast.IdentifiedOption_BY_PASSWORD, Password: $3}
  }
| IDENTIFIED USING table_name
  {
    $$ = &ast.IdentifiedOption{IdentifiedOption: ast.IdentifiedOption_USING_PACKAGE, Packagename: $3.(ast.TableName)}
  }
| IDENTIFIED EXTERNALLY
  {
    $$ = &ast.IdentifiedOption{IdentifiedOption: ast.IdentifiedOption_EXTERNALLY}
  }
| IDENTIFIED GLOBALLY
  {
    $$ = &ast.IdentifiedOption{IdentifiedOption: ast.IdentifiedOption_GLOBALLY}
  }

opt_container_option:
  {
    $$ = ast.ContainerOption_EMPTY
  }
| CONTAINER '=' CURRENT
  {
    $$ = ast.ContainerOption_CURRENT
  }
| CONTAINER '=' ALL
  {
    $$ = ast.ContainerOption_ALL
  }

if_force:
  FORCE
  {
    $$ = ast.ForceStr
  }
| NO FORCE
  {
    $$ = ast.NoForceStr
  }

function_body:
  FUNCTION table_name opt_parameter_list RETURN type_spec opt_func_return_suffixs opt_pipelined is_or_as block
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $6 != nil {
    	retSuffixs = $6.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.FunctionBody{BaseBody: ast.BaseBody{OptParameters: d3, Block: $9.(*ast.Block)}, FuncName: $2.(ast.TableName), ReturnType: $5.(*ast.TypeSpec), FuncReturnSuffixs: retSuffixs, OptPipelined: $7}
  }
| FUNCTION table_name opt_parameter_list RETURN type_spec opt_func_return_suffixs opt_pipelined is_or_as call_spec
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $6 != nil {
    	retSuffixs = $6.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.FunctionBody{BaseBody: ast.BaseBody{OptParameters: d3}, FuncName: $2.(ast.TableName), ReturnType: $5.(*ast.TypeSpec), FuncReturnSuffixs: retSuffixs, OptPipelined: $7, CallSpec: $9.(*ast.CallSpec)}
  }
| FUNCTION table_name opt_parameter_list RETURN type_spec opt_func_return_suffixs pipelined_aggregate USING index_name
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $6 != nil {
    	retSuffixs = $6.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.FunctionBody{BaseBody: ast.BaseBody{OptParameters: d3}, FuncName: $2.(ast.TableName), ReturnType: $5.(*ast.TypeSpec), FuncReturnSuffixs: retSuffixs, PipelinedAggregate: $7, UsingImpleType: $9.(*ast.IndexName)}
  }

drop_function_statement:
  DROP FUNCTION opt_exists table_name
  {
    var exists bool
    if $3 != "false" {
    	exists = true
    }
    $$ = &ast.DropFunctionStmt{Name: $4.(ast.TableName), IfExists: exists, IsOracle: true}
  }

alter_function_statement:
  ALTER function_alter_body
  {
    $$ = &ast.AlterFunctionStmt{FunctionAlterBody: $2.(*ast.FunctionAlterBody), IsOracle: true}
  }

function_alter_body:
  FUNCTION proc_or_func_name COMPILE opt_debug opt_compiler_parameter_list opt_reuse_settings ';'
  {
    var pList ast.CompilerParameterList
    if $5 != nil {
    	pList = $5.(ast.CompilerParameterList)
    }
    $$ = &ast.FunctionAlterBody{FuncName: $2.(ast.ProcOrFuncName), OptDebug: $4, OptCompilerParameters: pList, OptReuseSettings: $6}
  }
| FUNCTION proc_or_func_name edition_option
  {
    $$ = &ast.FunctionAlterBody{FuncName: $2.(ast.ProcOrFuncName), EditionOption: $3.(ast.EditionOption)}
  }

opt_specification:
  {
    $$ = ""
  }
| PACKAGE
| BODY
| SPECIFICATION

opt_debug:
  {
    $$ = ""
  }
| DEBUG

opt_compiler_parameter_list:
  {
    $$ = nil
  }
| compiler_parameter_list

compiler_parameter_list:
  compiler_parameter_clause
  {
    $$ = ast.CompilerParameterList{$1.(*ast.CompilerParameter)}
  }
| compiler_parameter_list compiler_parameter_clause
  {
    $$ = append($1.(ast.CompilerParameterList), $2.(*ast.CompilerParameter))
  }

compiler_parameter_clause:
  identifier '=' expression
  {
    $$ = &ast.CompilerParameter{Identifier: $1.(*ast.Identifier), Expression: $3.(ast.Expr)}
  }

opt_reuse_settings:
  {
    $$ = ""
  }
| REUSE SETTINGS
  {
    $$ = $1 + " " + $2
  }

/* Oracle PL/SQL Package Support */
alter_package_statement:
  ALTER package_alter_body
  {
    $$ = &ast.AlterPackageStmt{PackageAlterBody: $2.(*ast.PackageAlterBody), IsOracle: true}
  }

package_alter_body:
  PACKAGE table_name COMPILE opt_debug opt_specification opt_compiler_parameter_list opt_reuse_settings
  {
    var pList ast.CompilerParameterList
    if $6 != nil {
    	pList = $6.(ast.CompilerParameterList)
    }
    $$ = &ast.PackageAlterBody{PackageName: $2.(ast.TableName), OptDebug: $4, OptSpecification: $5, OptCompilerParameters: pList, OptReuseSettings: $7}
  }
| PACKAGE table_name edition_option
  {
    $$ = &ast.PackageAlterBody{PackageName: $2.(ast.TableName), EditionOption: $3.(ast.EditionOption)}
  }

drop_package_statement:
  DROP PACKAGE table_name
  {
    $$ = &ast.DropPackageStmt{Name: $3.(ast.TableName), IfExists: false, IsOracle: true}
  }
| DROP PACKAGE IF EXISTS table_name
  {
    $$ = &ast.DropPackageStmt{Name: $5.(ast.TableName), IfExists: true, IsOracle: true}
  }

drop_package_body_statement:
  DROP PACKAGE BODY opt_exists table_name
  {
    var exists bool
    if $4 != "false" {
    	exists = true
    }
    $$ = &ast.DropPackageBodyStmt{Name: $5.(ast.TableName), IfExists: exists, IsOracle: true}
  }

drop_type_statement:
  DROP TYPE table_name
  {
    $$ = &ast.DropTypeStmt{Name: $3.(ast.TableName), IfExists: false}
  }
| DROP TYPE IF EXISTS table_name
  {
    $$ = &ast.DropTypeStmt{Name: $5.(ast.TableName), IfExists: true}
  }

drop_type_body_statement:
  DROP TYPE BODY opt_exists table_name
  {
    var exists bool
    if $4 != "false" {
    	exists = true
    }
    $$ = &ast.DropTypeBodyStmt{Name: $5.(ast.TableName), IfExists: exists}
  }

package_spec:
  PACKAGE table_name opt_sharing_clause opt_proc_return_suffixs is_or_as END opt_name
  {
    dd := &ast.PackageSpec{}
    dd.PackageName = $2.(ast.TableName)
    if $3!= nil {
    	dd.Sharing = $3.(*ast.SharingClause)
    }
    if $4 != nil {
    	dd.RetSuffixs = $4.(ast.FuncReturnSuffixList)
    }
    $$ = dd
  }
| PACKAGE table_name opt_sharing_clause opt_proc_return_suffixs is_or_as package_obj_spec_list END opt_name
  {
    dd := $6.(*ast.PackageSpec)
    dd.PackageName = $2.(ast.TableName)
    if $3 != nil {
    	dd.Sharing = $3.(*ast.SharingClause)
    }
    if $4 != nil {
    	dd.RetSuffixs = $4.(ast.FuncReturnSuffixList)
    }
    $$ = dd
  }

pl_declaration:
  procedure_spec
| function_spec
| variable_declaration
| subtype_declaration
| cursor_declaration
| exception_declaration
| pragma_declaration
| type_declaration
| procedure_definition
| function_definition

package_obj_spec:
  pragma_declaration
| variable_declaration
| subtype_declaration
| cursor_declaration
| exception_declaration
| type_declaration
| procedure_spec
| function_spec

package_obj_spec_list:
  package_obj_spec
  {
    dd := &ast.PackageSpec{}
    dd.PLDeclarations = append(dd.PLDeclarations, $1.(ast.PLDeclaration))
    $$ = dd
  }
| package_obj_spec_list package_obj_spec
  {
    dd := $1.(*ast.PackageSpec)
    dd.PLDeclarations = append(dd.PLDeclarations, $2.(ast.PLDeclaration))
    $$ = dd
  }

package_body:
  PACKAGE BODY table_name is_or_as END opt_name
  {
    dd := &ast.PackageBody{}
    dd.PackageName = $3.(ast.TableName)
    $$ = dd
  }
| PACKAGE BODY table_name is_or_as package_obj_body_list END opt_name
  {
    dd := $5.(*ast.PackageBody)
    dd.PackageName = $3.(ast.TableName)
    $$ = dd
  }
| PACKAGE BODY table_name is_or_as package_obj_body_list body
  {
    dd := $5.(*ast.PackageBody)
    dd.PackageName = $3.(ast.TableName)
    dd.OptSuffixBody = $6.(*ast.Body)
    $$ = dd
  }
| PACKAGE BODY table_name is_or_as body
  {
    dd := &ast.PackageBody{}
    dd.PackageName = $3.(ast.TableName)
    dd.OptSuffixBody = $5.(*ast.Body)
    $$ = dd
  }

package_obj_body:
  procedure_spec
| function_spec
| variable_declaration
| subtype_declaration
| cursor_declaration
| exception_declaration
| type_declaration
| procedure_definition
| function_definition

package_obj_body_list:
  package_obj_body
  {
    dd := &ast.PackageBody{}
    dd.PLDeclarations = append(dd.PLDeclarations, $1.(ast.PLDeclaration))
    $$ = dd
  }
| package_obj_body_list package_obj_body
  {
    dd := $1.(*ast.PackageBody)
    dd.PLDeclarations = append(dd.PLDeclarations, $2.(ast.PLDeclaration))
    $$ = dd
  }

procedure_spec:
  PROCEDURE table_name opt_parameter_list ';'
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    $$ = &ast.ProcedureSpec{ProcName: $2.(ast.TableName), OptParameters: d3}
  }

variable_declaration:
  ID opt_constant type_spec opt_not_null opt_default_value_part ';'
  {
    var d5 *ast.DefaultValuePart
    if $5 != nil {
    	d5 = $5.(*ast.DefaultValuePart)
    }
    $$ = &ast.VariableDeclaration{VariableName: $1, IsConstant: $2!="", TypeSpec: $3.(*ast.TypeSpec), OptNull: $4, OptDefaultValuePart: d5}
  }

subtype_declaration:
  SUBTYPE ID IS type_spec opt_subtype_range opt_not_null ';'
  {
    var d5 *ast.SubTypeRange
    if $5 != nil {
    	d5 = $5.(*ast.SubTypeRange)
    }
    $$ = &ast.SubTypeDeclaration{SubTypeName: $2, Type: $4.(*ast.TypeSpec), OptRange: d5, OptNull: $6}
  }

cursor_declaration:
  CURSOR id_expression '(' parameter_list ')' opt_cursor_return opt_is_select ';'
  {
    var d4 ast.ParameterList
    if $4 != nil {
    	d4 = $4.(ast.ParameterList)
    }
    var d6 *ast.TypeSpec
    if $6 != nil {
    	d6 = $6.(*ast.TypeSpec)
    }
    var d7 ast.SelectStatement
    if $7 != nil {
    	d7 = $7.(ast.SelectStatement)
    }
    $$ = &ast.CursorDeclaration{CursorName: $2.(*ast.IdExpression), OptParameters: d4, OptReturnType: d6, OptIsStatement: d7}
  }
| CURSOR id_expression opt_cursor_return opt_is_select ';'
  {
    var d3 *ast.TypeSpec
    if $3 != nil {
    	d3 = $3.(*ast.TypeSpec)
    }
    var d4 ast.SelectStatement
    if $4 != nil {
    	d4 = $4.(ast.SelectStatement)
    }
    $$ = &ast.CursorDeclaration{CursorName: $2.(*ast.IdExpression), OptReturnType: d3, OptIsStatement: d4}
  }

exception_declaration:
  ID EXCEPTION ';'
  {
    $$ = &ast.ExceptionDeclaration{ExceptionName: $1}
  }

pragma_declaration:
  PRAGMA EXCEPTION_INIT '(' ID ',' expression ')' ';'
  {
    $$ = &ast.PragmaDeclaration{ExceptionInit: &ast.ExceptionInit{
    	ExceptionName: $4,
    	Code:          $6.(ast.Expr),
    }}
  }

type_declaration:
  TYPE ID IS table_type_def ';'
  {
    $$ = &ast.TypeDeclaration{TypeName: $2, TableType: $4.(*ast.TableTypeDef)}
  }
| TYPE ID IS varray_type_def ';'
  {
    $$ = &ast.TypeDeclaration{TypeName: $2, VarrayType: $4.(*ast.VarrayTypeDef)}
  }
| TYPE ID IS record_type_def ';'
  {
    $$ = &ast.TypeDeclaration{TypeName: $2, RecordType: $4.(*ast.RecordTypeDef)}
  }
| TYPE ID IS cursor_type_def ';'
  {
    $$ = &ast.TypeDeclaration{TypeName: $2, CursorType: $4.(*ast.CursorTypeDef)}
  }

type_declaration_no_semicolon:
  TYPE ID IS table_type_def
  {
    $$ = &ast.TypeDeclaration{TypeName: $2, TableType: $4.(*ast.TableTypeDef)}
  }
| TYPE ID IS varray_type_def
  {
    $$ = &ast.TypeDeclaration{TypeName: $2, VarrayType: $4.(*ast.VarrayTypeDef)}
  }
| TYPE ID IS record_type_def
  {
    $$ = &ast.TypeDeclaration{TypeName: $2, RecordType: $4.(*ast.RecordTypeDef)}
  }
| TYPE ID IS cursor_type_def
  {
    $$ = &ast.TypeDeclaration{TypeName: $2, CursorType: $4.(*ast.CursorTypeDef)}
  }

object_declaration:
  TYPE ID AS object_type_def
  {
    $$ = &ast.ObjectDeclaration{TypeName: $2, ObjectType: $4.(*ast.ObjectTypeDef)}
  }

object_body_declaration:
  TYPE BODY table_name is_or_as object_body_def_list END ';'
  {
    dd := $5.(*ast.ObjBodyDecl)
    dd.ObjecteName = $3.(ast.TableName)
    $$ = dd
  }
| TYPE BODY table_name is_or_as object_body_def_list body ';'
  {
    dd := $5.(*ast.ObjBodyDecl)
    dd.ObjecteName = $3.(ast.TableName)
    dd.OptSuffixBody = $6.(*ast.Body)
    $$ = dd
  }
| TYPE BODY table_name is_or_as body ';'
  {
    dd := &ast.ObjBodyDecl{}
    dd.ObjecteName = $3.(ast.TableName)
    dd.OptSuffixBody = $5.(*ast.Body)
    $$ = dd
  }

object_body_def:
  STATIC function_definition
  {
    $$ = &ast.PLObjectTypeFuncDecl{FunBodyName: $1, FuncTypeName: "", PLObjBodyDecl: $2.(ast.PLObjBodyDecl)}
  }
| MEMBER function_definition
  {
    $$ = &ast.PLObjectTypeFuncDecl{FunBodyName: $1, FuncTypeName: "", PLObjBodyDecl: $2.(ast.PLObjBodyDecl)}
  }
| STATIC procedure_definition
  {
    $$ = &ast.PLObjectTypeFuncDecl{FunBodyName: $1, FuncTypeName: "", PLObjBodyDecl: $2.(ast.PLObjBodyDecl)}
  }
| MEMBER procedure_definition
  {
    $$ = &ast.PLObjectTypeFuncDecl{FunBodyName: $1, FuncTypeName: "", PLObjBodyDecl: $2.(ast.PLObjBodyDecl)}
  }

object_type_spec_def:
  STATIC function_spec
  {
    $$ = &ast.PLObjectTypeFuncDecl{FuncTypeName: $1, FunBodyName: "", PLObjTypeDecl: $2.(ast.PLObjTypeDecl)}
  }
| MEMBER function_spec
  {
    $$ = &ast.PLObjectTypeFuncDecl{FuncTypeName: $1, FunBodyName: "", PLObjTypeDecl: $2.(ast.PLObjTypeDecl)}
  }
| STATIC procedure_spec
  {
    $$ = &ast.PLObjectTypeFuncDecl{FuncTypeName: $1, FunBodyName: "", PLObjTypeDecl: $2.(ast.PLObjTypeDecl)}
  }
| MEMBER procedure_spec
  {
    $$ = &ast.PLObjectTypeFuncDecl{FuncTypeName: $1, FunBodyName: "", PLObjTypeDecl: $2.(ast.PLObjTypeDecl)}
  }

object_type_list:
  object_type_spec_def
  {
    dd := &ast.ObjTypeDecl{}
    dd.PLObjTypeFunc = append(dd.PLObjTypeFunc, $1.(*ast.PLObjectTypeFuncDecl))
    $$ = dd
  }
| object_type_list ',' object_type_spec_def
  {
    dd := $1.(*ast.ObjTypeDecl)
    dd.PLObjTypeFunc = append(dd.PLObjTypeFunc, $3.(*ast.PLObjectTypeFuncDecl))
    $$ = dd
  }

object_body_def_list:
  object_body_def
  {
    dd := &ast.ObjBodyDecl{}
    dd.PLObjTypeFunc = append(dd.PLObjTypeFunc, $1.(*ast.PLObjectTypeFuncDecl))
    $$ = dd
  }
| object_body_def_list object_body_def
  {
    dd := $1.(*ast.ObjBodyDecl)
    dd.PLObjTypeFunc = append(dd.PLObjTypeFunc, $2.(*ast.PLObjectTypeFuncDecl))
    $$ = dd
  }

procedure_definition:
  PROCEDURE table_name opt_parameter_list is_or_as block ';'
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    $$ = &ast.ProcedureDefinition{ProcName: $2.(ast.TableName), OptParameters: d3, Block: $5.(*ast.Block)}
  }
| PROCEDURE table_name opt_parameter_list is_or_as call_spec ';'
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    $$ = &ast.ProcedureDefinition{ProcName: $2.(ast.TableName), OptParameters: d3, CallSpec: $5.(*ast.CallSpec)}
  }
| PROCEDURE table_name opt_parameter_list is_or_as EXTERNAL ';'
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    $$ = &ast.ProcedureDefinition{ProcName: $2.(ast.TableName), OptParameters: d3, External: $5}
  }

function_spec:
  FUNCTION table_name opt_parameter_list RETURN type_spec opt_func_return_suffixs ';'
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $6 != nil {
    	retSuffixs = $6.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.FunctionSpec{FullName: $2.(ast.TableName), OptParameters: d3, ReturnType: $5.(*ast.TypeSpec), OptReturn: retSuffixs}
  }
| FUNCTION table_name opt_parameter_list RETURN type_spec opt_func_return_suffixs
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $6 != nil {
    	retSuffixs = $6.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.FunctionSpec{FullName: $2.(ast.TableName), OptParameters: d3, ReturnType: $5.(*ast.TypeSpec), OptReturn: retSuffixs}
  }

function_definition:
  FUNCTION table_name opt_parameter_list RETURN type_spec opt_func_return_suffixs opt_pipelined is_or_as block ';'
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $6 != nil {
    	retSuffixs = $6.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.FunctionDefinition{FuncName: $2.(ast.TableName), OptParameters: d3, ReturnType: $5.(*ast.TypeSpec), FuncReturnSuffixs: retSuffixs, OptPipelined: $7, Block: $9.(*ast.Block)}
  }
| FUNCTION table_name opt_parameter_list RETURN type_spec opt_func_return_suffixs opt_pipelined is_or_as call_spec ';'
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $6 != nil {
    	retSuffixs = $6.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.FunctionDefinition{FuncName: $2.(ast.TableName), OptParameters: d3, ReturnType: $5.(*ast.TypeSpec), FuncReturnSuffixs: retSuffixs, OptPipelined: $7, CallSpec: $9.(*ast.CallSpec)}
  }
| FUNCTION table_name opt_parameter_list RETURN type_spec opt_func_return_suffixs pipelined_aggregate USING index_name ';'
  {
    var d3 ast.ParameterList
    if $3 != nil {
    	d3 = $3.(ast.ParameterList)
    }
    var retSuffixs ast.FuncReturnSuffixList
    if $6 != nil {
    	retSuffixs = $6.(ast.FuncReturnSuffixList)
    }
    $$ = &ast.FunctionDefinition{FuncName: $2.(ast.TableName), OptParameters: d3, ReturnType: $5.(*ast.TypeSpec), FuncReturnSuffixs: retSuffixs, PipelinedAggregate: $7, UsingImpleType: $9.(*ast.IndexName)}
  }

/* Common PL/SQL Named Elements */
opt_func_return_suffixs:
  {
    $$ = nil
  }
| func_return_suffixs

func_return_suffixs:
  func_return_suffix
  {
    $$ = ast.FuncReturnSuffixList{$1.(ast.FuncReturnSuffix)}
  }
| func_return_suffixs func_return_suffix
  {
    $$ = append($1.(ast.FuncReturnSuffixList), $2.(ast.FuncReturnSuffix))
  }

func_return_suffix:
  invoker_rights_clause
| accessible_by_clause
| deterministic
| parallel_enable_clause
| result_cache_clause
| default_collation_clause

invoker_rights_clause:
  AUTHID CURRENT_USER
  {
    $$ = &ast.InvokerRightsClause{KeyWord: $1 + " " + $2}
  }
| AUTHID DEFINER
  {
    $$ = &ast.InvokerRightsClause{KeyWord: $1 + " " + $2}
  }

accessible_by_clause:
  ACCESSIBLE BY '(' accessor_list ')'
  {
    $$ = &ast.AccessibleByClause{AssessorList: $4.([]ast.Accessor)}
  }

accessor_list:
  accessor
  {
    $$ = []ast.Accessor{$1.(ast.Accessor)}
  }
| accessor_list ',' accessor
  {
    $$ = append($1.([]ast.Accessor), $3.(ast.Accessor))
  }

accessor:
  opt_unit_kind ID
  {
    $$ = ast.Accessor{UnitKind: $1, AccessorName: $2}
  }

opt_unit_kind:
  {
    $$ = ""
  }
| unit_kind

unit_kind:
  FUNCTION
| PROCEDURE 
| PACKAGE 
| TRIGGER
| TYPE

default_collation_clause:
  DEFAULT COLLATION collation_option
  {
    $$ = &ast.DefaultCollationClause{CollationOption: $3}
  }

collation_option:
  USING_NLS_COMP

parallel_enable_clause:
  PARALLEL_ENABLE opt_partition_by_clause
  {
    var d2 *ast.PartitionByClause
    if $2 != nil {
    	d2 = $2.(*ast.PartitionByClause)
    }
    $$ = &ast.ParallelEnableClause{PartitionByClause: d2}
  }

result_cache_clause:
  RESULT_CACHE opt_relies_on_part
  {
    var relies *ast.ReliesOnPart
    if $2 != nil {
    	relies = $2.(*ast.ReliesOnPart)
    }
    $$ = &ast.ResultCacheClause{ReliesOnPart: relies}
  }

opt_relies_on_part:
  {
    $$ = nil
  }
| relies_on_part

relies_on_part:
  RELIES_ON '(' table_view_names ')'
  {
    $$ = &ast.ReliesOnPart{TableViewNames: $3.(ast.TableViewNameList)}
  }

opt_for:
  {
    $$ = ""
  }
| FOR

partition_extension:
  SUBPARTITION opt_for '(' opt_expression_list ')'
  {
    var d4 ast.Exprs
    if $4 != nil {
    	d4 = $4.(ast.Exprs)
    }
    $$ = &ast.PartitionExtension{PartitionMode: $1, OptFor: $2, OptExpressions: d4}
  }
| PARTITION opt_for '(' opt_expression_list ')'
  {
    var d4 ast.Exprs
    if $4 != nil {
    	d4 = $4.(ast.Exprs)
    }
    $$ = &ast.PartitionExtension{PartitionMode: $1, OptFor: $2, OptExpressions: d4}
  }

opt_id_expression:
  {
    $$ = nil
  }
| '.' id_expression
  {
    $$ = $2
  }

table_view_name:
  identifier opt_id_expression
  {
    var d2 *ast.IdExpression
    if $2 != nil {
    	d2 = $2.(*ast.IdExpression)
    }
    $$ = &ast.TableViewName{Identifier: $1.(*ast.Identifier), OptIdExpression: d2}
  }
| identifier opt_id_expression '@' identifier
  {
    var d2 *ast.IdExpression
    if $2 != nil {
    	d2 = $2.(*ast.IdExpression)
    }
    $$ = &ast.TableViewName{Identifier: $1.(*ast.Identifier), OptIdExpression: d2, LinkName: $4.(*ast.Identifier)}
  }
| identifier opt_id_expression partition_extension
  {
    var d2 *ast.IdExpression
    if $2 != nil {
    	d2 = $2.(*ast.IdExpression)
    }
    $$ = &ast.TableViewName{Identifier: $1.(*ast.Identifier), OptIdExpression: d2, PartitionExpten: $3.(*ast.PartitionExtension)}
  }

table_view_names:
  table_view_name
  {
    $$ = ast.TableViewNameList{$1.(*ast.TableViewName)}
  }
| table_view_names ',' table_view_name
  {
    $$ = append($1.(ast.TableViewNameList), $3.(*ast.TableViewName))
  }

deterministic:
  DETERMINISTIC
  {
    $$ = &ast.DeterministicClause{KeyWord: $1}
  }

paren_column_list:
  '(' column_list ')'
  {
    $$ = &ast.ParenColumnList{ColumnList: $2.(ast.Columns)}
  }

opt_stream_clause:
  {
    $$ = nil
  }
| stream_clause

stream_clause:
  ORDER expression BY paren_column_list
  {
    $$ = &ast.StreamingClause{Type: $1, Expression: $2.(ast.Expr), ParenColumnList: $4.(*ast.ParenColumnList)}
  }
| CLUSTER expression BY paren_column_list
  {
    $$ = &ast.StreamingClause{Type: $1, Expression: $2.(ast.Expr), ParenColumnList: $4.(*ast.ParenColumnList)}
  }

opt_partition_by_clause:
  {
    $$ = nil
  }
| partition_by_clause

hash_range_value:
  HASH
| RANGE
| VALUE

partition_by_clause:
  '(' PARTITION expression BY ANY ')' opt_stream_clause
  {
    var d7 *ast.StreamingClause
    if $7 != nil {
    	d7 = $7.(*ast.StreamingClause)
    }
    $$ = &ast.PartitionByClause{Expression: $3.(ast.Expr), Any: $5, StreamingClause: d7}
  }
| '(' PARTITION expression BY hash_range_value paren_column_list ')' opt_stream_clause
  {
    var d8 *ast.StreamingClause
    if $8 != nil {
    	d8 = $8.(*ast.StreamingClause)
    }
    $$ = &ast.PartitionByClause{Expression: $3.(ast.Expr), Type: $5, ParenColumnList: $6.(*ast.ParenColumnList), StreamingClause: d8}
  }

pipelined_aggregate:
  PIPELINED
| AGGREGATE

opt_pipelined:
  {
    $$ = ""
  }
| PIPELINED

body:
  BEGIN seq_of_statements END opt_name
  {
    $$ = &ast.Body{SeqOfStatement: $2.(*ast.SeqOfStatement), OptEndName: $4}
  }
| BEGIN seq_of_statements exception_handler_list END opt_name
  {
    $$ = &ast.Body{SeqOfStatement: $2.(*ast.SeqOfStatement), OptExceptionHandlers: $3.(ast.ExceptionHandlerList), OptEndName: $5}
  }

dml_return:
  RETURN select_expression_list into_clause
  {
    $$ = &ast.DMLReturnInto{ReturnKeyWord: string($1), Columns: $2.(ast.SelectExprs), IntoClause: $3.(*ast.IntoClause)}
  }
| RETURNING select_expression_list into_clause
  {
    $$ = &ast.DMLReturnInto{ReturnKeyWord: string($1), Columns: $2.(ast.SelectExprs), IntoClause: $3.(*ast.IntoClause)}
  }

opt_dynamic_return:
  {
    $$ = nil
  }
| dynamic_return

dynamic_return:
  RETURN opt_select_expression_list into_clause
  {
    $$ = &ast.DynamicReturn{ReturnName: $1, OptColumns: $2.(ast.SelectExprs), IntoClause: $3.(*ast.IntoClause)}
  }
| RETURNING opt_select_expression_list into_clause
  {
    $$ = &ast.DynamicReturn{ReturnName: $1, OptColumns: $2.(ast.SelectExprs), IntoClause: $3.(*ast.IntoClause)}
  }

using_return:
  using_clause opt_dynamic_return
  {
    var d2 *ast.DynamicReturn
    if $2 != nil {
    	d2 = $2.(*ast.DynamicReturn)
    }
    $$ = &ast.UsingReturn{UsingClause: $1.(*ast.UsingClause), OptReturn: d2}
  }

variable_name:
  id_expression_list
  {
    $$ = &ast.VariableName{Name: $1.(ast.IdExpressionList)}
  }
| bind_variable
  {
    $$ = &ast.VariableName{BindVariable: $1.(*ast.BindVariable)}
  }

opt_into_clause:
  {
    $$ = nil
  }
| into_clause

into_clause:
  BULK COLLECT INTO expression_list
  {
    $$ = &ast.IntoClause{OptBulk: true, IntoValues: $4.(ast.Exprs)}
  }
| INTO expression_list
  {
    $$ = &ast.IntoClause{OptExpr: true, IntoValues: $2.(ast.Exprs)}
  }

opt_scope:
  {
    $$ = ""
  }
| IN
| IN OUT
  {
    $$ = $1 + " " + $2
  }
| OUT

using_element:
  opt_scope select_element
  {
    $$ = &ast.UsingElement{OptParameter: $1, SelectElement: $2.(*ast.SelectElement)}
  }
| opt_scope select_element AS col_alias
  {
    $$ = &ast.UsingElement{OptParameter: $1, SelectElement: $2.(*ast.SelectElement), OptAlias: $4.String()}
  }

select_element:
  expression
  {
    $$ = &ast.SelectElement{Element: $1.(ast.Expr)}
  }

using_elements:
  using_element
  {
    $$ = ast.UsingElementList{$1.(*ast.UsingElement)}
  }
| using_elements ',' using_element
  {
    $$ = append($1.(ast.UsingElementList), $3.(*ast.UsingElement))
  }

using_clause:
  USING using_elements
  {
    $$ = &ast.UsingClause{UsingElements: $2.(ast.UsingElementList)}
  }
| USING '*'
  {
    $$ = &ast.UsingClause{All: "*ast."}
  }

into_using:
  into_clause
  {
    $$ = &ast.IntoUsing{IntoClause: $1.(*ast.IntoClause)}
  }
| into_clause using_clause
  {
    $$ = &ast.IntoUsing{IntoClause: $1.(*ast.IntoClause), OptUsing: $2.(*ast.UsingClause)}
  }

execute_immediate:
  EXECUTE IMMEDIATE expression
  {
    $$ = &ast.ExecuteImmediate{DynamicSQL: $3.(ast.Expr)}
  }
| EXECUTE IMMEDIATE expression into_using
  {
    $$ = &ast.ExecuteImmediate{DynamicSQL: $3.(ast.Expr), Suffix: $4.(ast.ExecuteImmediateSuffix)}
  }
| EXECUTE IMMEDIATE expression using_return
  {
    $$ = &ast.ExecuteImmediate{DynamicSQL: $3.(ast.Expr), Suffix: $4.(ast.ExecuteImmediateSuffix)}
  }
| EXECUTE IMMEDIATE expression dynamic_return
  {
    $$ = &ast.ExecuteImmediate{DynamicSQL: $3.(ast.Expr), Suffix: $4.(ast.ExecuteImmediateSuffix)}
  }

close_statement:
  CLOSE variable_name
  {
    $$ = &ast.CloseStatement{CursorName: $2.(*ast.VariableName)}
  }

open_statement:
  OPEN variable_name '(' func_arg_list ')'
  {
    cursorArgs := &ast.CursorArgumentsExpr{Arguments: $4.(ast.SelectExprs)}
    $$ = &ast.OpenStatement{CursorName: $2.(*ast.VariableName), Arguments: cursorArgs}
  }
| OPEN variable_name
  {
    $$ = &ast.OpenStatement{CursorName: $2.(*ast.VariableName)}
  }
| OPEN variable_name '(' ')'
  {
    $$ = &ast.OpenStatement{CursorName: $2.(*ast.VariableName)}
  }

fetch_statement:
  FETCH variable_name into_clause
  {
    $$ = &ast.FetchStatement{CursorName: $2.(*ast.VariableName), Into: $3.(*ast.IntoClause)}
  }

open_for_statement:
  OPEN variable_name FOR expression using_clause
  {
    $$ = &ast.OpenForStatement{VariableName: $2.(*ast.VariableName), OptExpression: $4.(ast.Expr), UsingClause: $5.(*ast.UsingClause)}
  }
| OPEN variable_name FOR expression
  {
    $$ = &ast.OpenForStatement{VariableName: $2.(*ast.VariableName), OptExpression: $4.(ast.Expr)}
  }
| OPEN variable_name FOR base_select opt_order_by opt_limit opt_lock using_clause
  {
    sel := $4.(*ast.Select)
    var orderBy ast.OrderBy
    if $5 != nil {
    	orderBy = $5.(ast.OrderBy)
    }
    sel.OrderBy = orderBy
    var limit *ast.Limit
    if $6 != nil {
    	limit = $6.(*ast.Limit)
    }
    sel.Limit = limit
    sel.Lock = $7
    $$ = &ast.OpenForStatement{VariableName: $2.(*ast.VariableName), OptSelStatement: sel, UsingClause: $8.(*ast.UsingClause)}
  }
| OPEN variable_name FOR base_select opt_order_by opt_limit opt_lock
  {
    sel := $4.(*ast.Select)
    var orderBy ast.OrderBy
    if $5 != nil {
    	orderBy = $5.(ast.OrderBy)
    }
    sel.OrderBy = orderBy
    var limit *ast.Limit
    if $6 != nil {
    	limit = $6.(*ast.Limit)
    }
    sel.Limit = limit
    sel.Lock = $7
    $$ = &ast.OpenForStatement{VariableName: $2.(*ast.VariableName), OptSelStatement: sel}
  }

cursor_manu_statement:
  close_statement
  {
    $$ = &ast.CursorManuStatement{CloseStatement: $1.(*ast.CloseStatement)}
  }
| open_statement
  {
    $$ = &ast.CursorManuStatement{OpenStatement: $1.(*ast.OpenStatement)}
  }
| fetch_statement
  {
    $$ = &ast.CursorManuStatement{FetchStatement: $1.(*ast.FetchStatement)}
  }
| open_for_statement
  {
    $$ = &ast.CursorManuStatement{OpenForStatement: $1.(*ast.OpenForStatement)}
  }

only_write:
  ONLY
| WRITE

opt_name_quoted:
  {
    $$ = ""
  }
| NAME quoted_string
  {
    $$ = $2
  }

serializable_read_committed:
  SERIALIZABLE
| READ COMMITTED
  {
    $$ = $1 + " " + $2
  }

set_trans_command:
  SET TRANSACTION READ only_write opt_name_quoted
  {
    $$ = &ast.Begin{}
  }
| SET TRANSACTION ISOLATION LEVEL serializable_read_committed opt_name_quoted
  {
    $$ = &ast.Begin{}
  }
| SET TRANSACTION USE ROLLBACK SEGMENT sql_id opt_name_quoted
  {
    $$ = &ast.Begin{}
  }

constraint_name:
  sql_id id_expression_list opt_link_name
  {
    $$ = &ast.ConstraintName{Prefix: $1.(ast.ColIdent), Expressions: $2.(ast.IdExpressionList), OptLinkName: $3}
  }

constraint_names:
  constraint_name
  {
    $$ = ast.ConstraintNameList{$1.(*ast.ConstraintName)}
  }
| constraint_names ',' constraint_name
  {
    $$ = append($1.(ast.ConstraintNameList), $3.(*ast.ConstraintName))
  }

constraint_constraints:
  CONSTRAINT
| CONSTRAINTS

immediate_deferred:
  IMMEDIATE
| DEFERRED

set_const_command:
  SET constraint_constraints ALL immediate_deferred
  {
    $$ = &ast.SetConstCommand{OptConstraint: $2, All: $3, Suffix: $4}
  }
| SET constraint_constraints constraint_names immediate_deferred
  {
    $$ = &ast.SetConstCommand{OptConstraint: $2, ConstraintNames: $3.(ast.ConstraintNameList), Suffix: $4}
  }

wait_nowait:
  WAIT
| NOWAIT

immediate_batch:
  IMMEDIATE
| BATCH

opt_write_clause:
  WRITE wait_nowait immediate_batch
  {
    $$ = $1 + " " + $2 + " " + $3
  }

plsql_commit_statement:
  //  COMMIT opt_work COMMENT expression opt_write_clause  todo COMMENT TOKEN
  //  {
  //    $$ = &CommitStatement{OptWork: $2, Comment: $4, WriteClause: $5}
  //  }
  COMMIT
  {
    $$ = &ast.Commit{}
  }
| COMMIT opt_work FORCE CORRUPT_XID expression opt_write_clause
  {
    $$ = &ast.Commit{}
  }
| COMMIT opt_work FORCE expression_list opt_write_clause
  {
    $$ = &ast.Commit{}
  }
| COMMIT opt_work FORCE CORRUPT_XID_ALL opt_write_clause
  {
    $$ = &ast.Commit{}
  }

opt_work:
  {
    $$ = ""
  }
| WORK

opt_savepoint:
  {
    $$ = ""
  }
| SAVEPOINT

quoted_string:
  STRING
  {
    $$ = "'" + $1 + "'"
  }

identifier:
  INTRODUCER id_expression_list id_expression
  {
    $$ = &ast.Identifier{OptCharSetName: $2.(ast.IdExpressionList), IdExpression: $3.(*ast.IdExpression)}
  }
| id_expression
  {
    $$ = &ast.Identifier{IdExpression: $1.(*ast.IdExpression)}
  }

plsql_rollback_statement:
  ROLLBACK opt_work TO opt_savepoint identifier
  {
    $$ = &ast.Rollback{}
  }
| ROLLBACK opt_work FORCE quoted_string
  {
    $$ = &ast.Rollback{}
  }
| ROLLBACK WORK
  {
    $$ = &ast.Rollback{}
  }
| ROLLBACK
  {
    $$ = &ast.Rollback{}
  }

save_point_statement:
  SAVEPOINT identifier
  {
    $$ = &ast.SavePointStatement{SavePointName: $2.(*ast.Identifier)}
  }

trans_ctrl_statement:
  set_trans_command
  {
    $$ = &ast.TransCtrlStatement{SetTransCommand: $1.(*ast.Begin)}
  }
| set_const_command
  {
    $$ = &ast.TransCtrlStatement{SetConstCommand: $1.(*ast.SetConstCommand)}
  }
| plsql_commit_statement
  {
    $$ = &ast.TransCtrlStatement{CommitStatement: $1.(*ast.Commit)}
  }
| plsql_rollback_statement
  {
    $$ = &ast.TransCtrlStatement{RollbackStatement: $1.(*ast.Rollback)}
  }
| save_point_statement
  {
    $$ = &ast.TransCtrlStatement{SavePointStatement: $1.(*ast.SavePointStatement)}
  }

dml_statement:
  select_statement
  {
    $$ = &ast.DmlStatement{SelectStatement: $1.(ast.SelectStatement)}
  }
| update_statement
  {
    $$ = &ast.DmlStatement{UpdateStatement: $1}
  }
| delete_statement
  {
    $$ = &ast.DmlStatement{DeleteStatement: $1}
  }
| insert_statement
  {
    $$ = &ast.DmlStatement{InsertStatement: $1}
  }
| explain_statement
  {
    $$ = &ast.DmlStatement{ExplainStatement: $1}
  }

sql_statement:
  execute_immediate
  {
    $$ = &ast.SqlStatement{ExecuteImmediate: $1.(*ast.ExecuteImmediate)}
  }
| cursor_manu_statement
  {
    $$ = &ast.SqlStatement{CursorManuStatement: $1.(*ast.CursorManuStatement)}
  }
| trans_ctrl_statement
  {
    $$ = &ast.SqlStatement{TransCtrlStatement: $1.(*ast.TransCtrlStatement)}
  }
| dml_statement
  {
    $$ = &ast.SqlStatement{DmlStatement: $1.(*ast.DmlStatement)}
  }

simple_case_when_part:
  WHEN expression THEN seq_of_statements
  {
    $$ = &ast.SimpleCaseWhenPart{WhenCondition: $2.(ast.Expr), SeqOfStatement: $4.(*ast.SeqOfStatement)}
  }

simple_case_when_parts:
  simple_case_when_part
  {
    $$ = ast.SimpleCaseWhenPartList{$1.(*ast.SimpleCaseWhenPart)}
  }
| simple_case_when_parts simple_case_when_part
  {
    $$ = append($1.(ast.SimpleCaseWhenPartList), $2.(*ast.SimpleCaseWhenPart))
  }

opt_case_else_part:
  {
    $$ = nil
  }
| ELSE seq_of_statements
  {
    $$ = &ast.CaseElsePart{SeqOfStatement: $2.(*ast.SeqOfStatement)}
  }

simple_case_statement:
  CASE expression simple_case_when_parts opt_case_else_part END CASE opt_label_name
  {
    var optElse *ast.CaseElsePart
    if $4 != nil {
    	optElse = $4.(*ast.CaseElsePart)
    }
    $$ = &ast.SimpleCaseStatement{CaseCondition: $2.(ast.Expr), CaseWhenPart: $3.(ast.SimpleCaseWhenPartList), OptCaseElsePart: optElse, EndLabelName: $7}
  }

search_case_when_part:
  WHEN expression THEN seq_of_statements
  {
    $$ = &ast.SearchCaseWhenPart{WhenCondition: $2.(ast.Expr), SeqOfStatement: $4.(*ast.SeqOfStatement)}
  }

search_case_when_parts:
  search_case_when_part
  {
    $$ = ast.SearchCaseWhenPartList{$1.(*ast.SearchCaseWhenPart)}
  }
| search_case_when_parts search_case_when_part
  {
    $$ = append($1.(ast.SearchCaseWhenPartList), $2.(*ast.SearchCaseWhenPart))
  }

search_case_statement:
  CASE search_case_when_parts opt_case_else_part END CASE opt_label_name
  {
    var optElse *ast.CaseElsePart
    if $3 != nil {
    	optElse = $3.(*ast.CaseElsePart)
    }
    $$ = &ast.SearchCaseStatement{CaseWhenPart: $2.(ast.SearchCaseWhenPartList), OptCaseElsePart: optElse, EndLabelName: $6}
  }

case_statement:
  simple_case_statement
  {
    $$ = &ast.CaseStatement{SimpleCase: $1.(*ast.SimpleCaseStatement)}
  }
| search_case_statement
  {
    $$ = &ast.CaseStatement{SearchCase: $1.(*ast.SearchCaseStatement)}
  }

opt_label_name:
  {
    $$ = ""
  }
| id_expression
  {
    $$ = $1.(*ast.IdExpression).String()
  }

opt_expression_list:
  {
    $$ = nil
  }
| expression_list

upper_bound:
  value
| boolean_value
  {
    $$ = $1.(ast.Expr)
  }
| column_name
  {
    $$ = $1.(ast.Expr)
  }
| tuple_expression
| upper_bound '&' upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.BitAndStr, Right: $3}
  }
| upper_bound '|' upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.BitOrStr, Right: $3}
  }
| upper_bound '^' upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.BitXorStr, Right: $3}
  }
| upper_bound '+' upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.PlusStr, Right: $3}
  }
| upper_bound '-' upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.MinusStr, Right: $3}
  }
| upper_bound '*' upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.MultStr, Right: $3}
  }
| upper_bound '/' upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.DivStr, Right: $3}
  }
| upper_bound DIV upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.IntDivStr, Right: $3}
  }
| upper_bound '%' upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.ModStr, Right: $3}
  }
| upper_bound MOD upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.ModStr, Right: $3}
  }
| upper_bound SHIFT_LEFT upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.ShiftLeftStr, Right: $3}
  }
| upper_bound SHIFT_RIGHT upper_bound
  {
    $$ = &ast.BinaryExpr{Left: $1, Operator: ast.ShiftRightStr, Right: $3}
  }
| upper_bound DOUBLE_STAR upper_bound
  {
    selExprs := ast.SelectExprs{ast.AliasedExpr{}.Wrap($1), ast.AliasedExpr{}.Wrap($3)}
    $$ = &ast.FuncExpr{Name: ast.NewColIdent("power"), Exprs: selExprs}
  }

loop_id:
  identifier
  {
    $$ = &ast.LoopId{IndexOrRecordName: $1.(*ast.Identifier)}
  }
| bind_variable
  {
    $$ = &ast.LoopId{BindVariable: $1.(*ast.BindVariable)}
  }

loop_param:
  loop_id IN REVERSE expression DOUBLE_POINT expression
  {
    $$ = &ast.IndexLoopParam{IndexName: $1.(*ast.LoopId), OptReverse: $3, LowerBound: $4, UpperBound: $6}
  }
| loop_id IN expression DOUBLE_POINT expression
  {
    $$ = &ast.IndexLoopParam{IndexName: $1.(*ast.LoopId), LowerBound: $3, UpperBound: $5}
  }
| loop_id IN expression
  {
    $$ = &ast.RecordLoopParam{RecordName: $1.(*ast.LoopId), CursorExpr: $3.(ast.Expr)}
  }

loop_statement:
  WHILE expression LOOP seq_of_statements END LOOP opt_label_name
  {
    $$ = &ast.LoopStatement{WhileCondition: $2.(ast.Expr), SeqOfStatement: $4.(*ast.SeqOfStatement), OptEndLabelName: $7}
  }
| label_declaration WHILE expression LOOP seq_of_statements END LOOP opt_label_name
  {
    $$ = &ast.LoopStatement{OptLabelDeclaration: $1.(*ast.LabelDeclaration), WhileCondition: $3.(ast.Expr), SeqOfStatement: $5.(*ast.SeqOfStatement), OptEndLabelName: $8}
  }
| LOOP seq_of_statements END LOOP opt_label_name
  {
    $$ = &ast.LoopStatement{SeqOfStatement: $2.(*ast.SeqOfStatement), OptEndLabelName: $5}
  }
| label_declaration LOOP seq_of_statements END LOOP opt_label_name
  {
    $$ = &ast.LoopStatement{OptLabelDeclaration: $1.(*ast.LabelDeclaration), SeqOfStatement: $3.(*ast.SeqOfStatement), OptEndLabelName: $6}
  }
| FOR loop_param LOOP seq_of_statements END LOOP opt_label_name
  {
    $$ = &ast.LoopStatement{ForLoopParam: $2.(ast.LoopParam), SeqOfStatement: $4.(*ast.SeqOfStatement), OptEndLabelName: $7}
  }
| label_declaration FOR loop_param LOOP seq_of_statements END LOOP opt_label_name
  {
    $$ = &ast.LoopStatement{OptLabelDeclaration: $1.(*ast.LabelDeclaration), ForLoopParam: $3.(ast.LoopParam), SeqOfStatement: $5.(*ast.SeqOfStatement), OptEndLabelName: $8}
  }

general_element:
  id_expression
  {
    $$ = ast.GeneralElement{&ast.GeneralElementSegment{IdExpression: $1.(*ast.IdExpression)}}
  }
| general_element general_element_segment
  {
    $$ = append($1.(ast.GeneralElement), $2.(*ast.GeneralElementSegment))
  }

general_element_segment:
  '.' reserved_id_expression
  {
    $$ = &ast.GeneralElementSegment{IdExpression: $2.(*ast.IdExpression)}
  }
| '(' opt_func_arg_list ')'
  {
    $$ = &ast.GeneralElementSegment{OptFuncArgument: $2.(ast.SelectExprs)}
  }

general_element_value:
  general_element_value_prefix general_element_segment
  {
    $$ = append($1.(ast.GeneralElement), $2.(*ast.GeneralElementSegment))
  }
| general_element_value general_element_segment
  {
    $$ = append($1.(ast.GeneralElement), $2.(*ast.GeneralElementSegment))
  }

general_element_value_prefix:
  table_id '.' reserved_table_id '.' reserved_sql_id
  {
    $$ = ast.GeneralElement{
    	&ast.GeneralElementSegment{IdExpression: &ast.IdExpression{RegularId: $1.(ast.TableIdent).String()}},
    	&ast.GeneralElementSegment{IdExpression: &ast.IdExpression{RegularId: $3.(ast.TableIdent).String()}},
    	&ast.GeneralElementSegment{IdExpression: &ast.IdExpression{RegularId: $5.(ast.ColIdent).String()}},
    }
  }
| function_call_generic
  {
    ge := ast.GeneralElement{}
    funcExpr, _ := $1.(*ast.FuncExpr)
    Qualifier, Name, Exprs := funcExpr.Qualifier, funcExpr.Name, funcExpr.Exprs
    if !Qualifier.IsEmpty() {
    	ge = append(ge, &ast.GeneralElementSegment{IdExpression: &ast.IdExpression{RegularId: Qualifier.String()}})
    }
    if !Name.IsEmpty() {
    	ge = append(ge, &ast.GeneralElementSegment{IdExpression: &ast.IdExpression{RegularId: Name.String()}})
    }
    ge = append(ge, &ast.GeneralElementSegment{OptFuncArgument: Exprs})
    $$ = ge
  }

//bind_variable_prefix:
//  BINDVAR
//  {
//    $$ = $1
//  }
//| UNSIGNED_INTEGER
//  {
//    $$ = $1
//  }
//
bind_variable:
  VALUE_ARG
  {
    $$ = &ast.BindVariable{VariableName: string($1)}
  }

assignment_target:
  general_element
  {
    $$ = &ast.AssignmentTarget{GeneralElement: $1.(ast.GeneralElement)}
  }
| bind_variable
  {
    $$ = &ast.AssignmentTarget{BindVariable: $1.(*ast.BindVariable)}
  }

assignment_statement:
  assignment_target opt_assignment_right
  {
    $$ = &ast.AssignmentStatement{AssignmentTarget: $1.(*ast.AssignmentTarget), Expression: $2}
  }

opt_assignment_right:
  {
    $$ = nil
  }
| ASSIGN expression
  {
    $$ = $2
  }

continue_statement:
  CONTINUE opt_name
  {
    $$ = &ast.ContinueStatement{OptLabelName: $2}
  }
| CONTINUE opt_name WHEN expression
  {
    $$ = &ast.ContinueStatement{OptLabelName: $2, OptCondition: $4.(ast.Expr)}
  }

exit_statement:
  EXIT opt_name
  {
    $$ = &ast.ExitStatement{OptLabelName: $2}
  }
| EXIT opt_name WHEN expression
  {
    $$ = &ast.ExitStatement{OptLabelName: $2, OptCondition: $4.(ast.Expr)}
  }

go_to_statement:
  GOTO sql_id
  {
    $$ = &ast.GoToStatement{LabelName: $2.(ast.ColIdent).String()}
  }

else_part:
  ELSE seq_of_statements
  {
    $$ = &ast.ElsePart{SeqOfStatement: $2.(*ast.SeqOfStatement)}
  }

else_if:
  ELSIF expression THEN seq_of_statements
  {
    $$ = &ast.ElseIf{Condition: $2.(ast.Expr), SeqOfStatement: $4.(*ast.SeqOfStatement)}
  }

else_if_list:
  else_if
  {
    $$ = ast.ElseIfList{$1.(*ast.ElseIf)}
  }
| else_if_list else_if
  {
    $$ = append($1.(ast.ElseIfList), $2.(*ast.ElseIf))
  }

if_statement:
  IF expression THEN seq_of_statements else_if_list else_part END IF
  {
    $$ = &ast.IfStatement{Condition: $2.(ast.Expr), SeqOfStatement: $4.(*ast.SeqOfStatement), ElseIfsPart: $5.(ast.ElseIfList), OptElsePart: $6.(*ast.ElsePart)}
  }
| IF expression THEN seq_of_statements else_part END IF
  {
    $$ = &ast.IfStatement{Condition: $2.(ast.Expr), SeqOfStatement: $4.(*ast.SeqOfStatement), OptElsePart: $5.(*ast.ElsePart)}
  }
| IF expression THEN seq_of_statements else_if_list END IF
  {
    $$ = &ast.IfStatement{Condition: $2.(ast.Expr), SeqOfStatement: $4.(*ast.SeqOfStatement), ElseIfsPart: $5.(ast.ElseIfList)}
  }
| IF expression THEN seq_of_statements END IF
  {
    $$ = &ast.IfStatement{Condition: $2.(ast.Expr), SeqOfStatement: $4.(*ast.SeqOfStatement)}
  }

null_statement:
  NULL
  {
    $$ = &ast.NullStatement{Null: $1}
  }

raise_statement:
  RAISE id_expression_list
  {
    $$ = &ast.RaiseStatement{OptExcetionName: $2.(ast.IdExpressionList)}
  }
| RAISE
  {
    $$ = &ast.RaiseStatement{}
  }

return_statement:
  RETURN
  {
    $$ = &ast.ReturnStatement{OptExpression: nil}
  }
| RETURN expression
  {
    $$ = &ast.ReturnStatement{OptExpression: $2.(ast.Expr)}
  }

pipe_row_statement:
  PIPE ROW '(' expression ')'
  {
    $$ = &ast.PipeRowStatement{Expression: $4.(ast.Expr)}
  }

label_declaration:
  SHIFT_LEFT id_expression SHIFT_RIGHT
  {
    $$ = &ast.LabelDeclaration{LabelName: $2.(*ast.IdExpression).String()}
  }

between_bound:
  BETWEEN upper_bound AND upper_bound
  {
    $$ = &ast.BetweenBound{LowerBound: $2, UpperBound: $4}
  }

opt_between_bound:
  {
    $$ = nil
  }
| between_bound

index_name:
  identifier
  {
    $$ = &ast.IndexName{Identifier: $1.(*ast.Identifier)}
  }
| identifier '.' id_expression
  {
    $$ = &ast.IndexName{Identifier: $1.(*ast.Identifier), OptIdExpression: $3.(*ast.IdExpression)}
  }

bounds_clause:
  upper_bound DOUBLE_POINT upper_bound
  {
    $$ = &ast.BoundsClause{LowerBound: $1, UpperBound: $3}
  }
| INDICES OF index_name opt_between_bound
  {
    var d4 *ast.BetweenBound
    if $4 != nil {
    	d4 = $4.(*ast.BetweenBound)
    }
    $$ = &ast.BoundsClause{IndicesOf: $3.(*ast.IndexName), OptBetweenBound: d4}
  }
| VALUES OF index_name
  {
    $$ = &ast.BoundsClause{ValuesOf: $3.(*ast.IndexName)}
  }

forall_statement:
  FORALL index_name IN bounds_clause sql_statement
  {
    $$ = &ast.ForAllStatement{IndexName: $2.(*ast.IndexName), BoundsClause: $4.(*ast.BoundsClause), SqlStatement: $5.(*ast.SqlStatement)}
  }
| FORALL index_name IN bounds_clause sql_statement SAVE EXCEPTIONS
  {
    $$ = &ast.ForAllStatement{IndexName: $2.(*ast.IndexName), BoundsClause: $4.(*ast.BoundsClause), SqlStatement: $5.(*ast.SqlStatement), OptSaveExceptions: $6 + " " + $7}
  }

pl_statement:
  assignment_statement
| continue_statement
| exit_statement
| go_to_statement
| if_statement
| null_statement
| raise_statement
| return_statement
| pipe_row_statement
| case_statement
| sql_statement
| forall_statement
| nested_block

opt_label_declaration:
  {
    $$ = nil
  }
| label_declaration

pl_statements:
  opt_label_declaration pl_statement ';'
  {
    if $1 != nil {
    	$$ = ast.PLStatements{$1.(ast.PLStatement), $2.(ast.PLStatement)}
    } else {
    	$$ = ast.PLStatements{$2.(ast.PLStatement)}
    }
  }
| loop_statement ';'
  {
    $$ = ast.PLStatements{$1.(ast.PLStatement)}
  }
| pl_statements opt_label_declaration pl_statement ';'
  {
    if $2 != nil {
    	tmp := append($1.(ast.PLStatements), $2.(*ast.LabelDeclaration))
    	$$ = append(tmp, $3.(ast.PLStatement))
    } else {
    	$$ = append($1.(ast.PLStatements), $3.(ast.PLStatement))
    }
  }
| pl_statements loop_statement ';'
  {
    $$ = append($1.(ast.PLStatements), $2.(*ast.LoopStatement))
  }

seq_of_statements:
  pl_statements
  {
    $$ = &ast.SeqOfStatement{PlStatements: $1.(ast.PLStatements)}
  }

exception_handler:
  WHEN exception_handler_entry THEN seq_of_statements
  {
    $$ = &ast.ExceptionHandler{ExceptionNames: $2.([]ast.IdExpressionList), SeqOfStatement: $4.(*ast.SeqOfStatement)}
  }

exception_handler_entry:
  id_expression_list
  {
    $$ = []ast.IdExpressionList{$1.(ast.IdExpressionList)}
  }
| exception_handler_entry OR id_expression_list
  {
    $$ = append($1.([]ast.IdExpressionList), $3.(ast.IdExpressionList))
  }

exception_handler_list:
  EXCEPTION exception_handler
  {
    $$ = ast.ExceptionHandlerList{$2.(*ast.ExceptionHandler)}
  }
| exception_handler_list exception_handler
  {
    $$ = append($1.(ast.ExceptionHandlerList), $2.(*ast.ExceptionHandler))
  }

opt_declare_spec:
  {
    $$ = &ast.DeclareSpec{}
  }
| declare_spec

declare_spec:
  pl_declaration
  {
    dd := &ast.DeclareSpec{}
    dd.PLDeclaration = append(dd.PLDeclaration, $1.(ast.PLDeclaration))
    $$ = dd
  }
| declare_spec pl_declaration
  {
    dd := $1.(*ast.DeclareSpec)
    dd.PLDeclaration = append(dd.PLDeclaration, $2.(ast.PLDeclaration))
    $$ = dd
  }

anonymous_statement:
  nested_block
  {
    $$ = &ast.Anonymous{Block: $1.(*ast.Block)}
  }

nested_block:
  DECLARE opt_declare_spec body
  {
    $$ = &ast.Block{OptDeclareSpecs: $2.(*ast.DeclareSpec), Body: $3.(*ast.Body)}
  }
| body
  {
    $$ = &ast.Block{Body: $1.(*ast.Body)}
  }

block:
  declare_spec body
  {
    $$ = &ast.Block{OptDeclareSpecs: $1.(*ast.DeclareSpec), Body: $2.(*ast.Body)}
  }
| nested_block
  {
    $$ = $1.(*ast.Block)
  }

c_spec:
  C_LETTER force_eof
  {
    $$ = nil
  }

call_spec:
  LANGUAGE JAVA NAME STRING
  {
    $$ = &ast.CallSpec{JavaSpec: $2 + " " + $3 + " " + $4}
  }
| LANGUAGE c_spec
  {
    var d2 *ast.CSpec
    if $2 != nil {
    	d2 = $2.(*ast.CSpec)
    }
    $$ = &ast.CallSpec{CSpec: d2}
  }

id_expression_list:
  id_expression
  {
    $$ = ast.IdExpressionList{$1.(*ast.IdExpression)}
  }
| id_expression_list '.' id_expression
  {
    $$ = append($1.(ast.IdExpressionList), $3.(*ast.IdExpression))
  }

opt_link_name:
  {
    $$ = ""
  }
| '@' ID
  {
    $$ = "@" + $2
  }

opt_table_index:
  {
    $$ = nil
  }
| INDEX BY type_spec
  {
    $$ = &ast.TableIndex{OptIndex: $1, TypeSepc: $3.(*ast.TypeSpec)}
  }
| INDEXED BY type_spec
  {
    $$ = &ast.TableIndex{OptIndex: $1, TypeSepc: $3.(*ast.TypeSpec)}
  }

table_type_def:
  TABLE OF type_spec opt_table_index opt_not_null
  {
    var d4 *ast.TableIndex
    if $4 != nil {
    	d4 = $4.(*ast.TableIndex)
    }
    $$ = &ast.TableTypeDef{Type: $3.(*ast.TypeSpec), OptTableIndex: d4, OptNotNull: $5}
  }

opt_varray_prefix:
  VARRAY
| VARYING ARRAY
  {
    $$ = $1 + " " + $2
  }

varray_type_def:
  opt_varray_prefix '(' expression ')' OF type_spec opt_not_null
  {
    $$ = &ast.VarrayTypeDef{VarrayPrefix: $1, Expression: $3.(ast.Expr), Type: $6.(*ast.TypeSpec), OptNotNull: $7}
  }

field_spec:
  table_name opt_type_spec opt_not_null opt_default_value_part
  {
    var d2 *ast.TypeSpec
    if $2 != nil {
    	d2 = $2.(*ast.TypeSpec)
    }
    var d4 *ast.DefaultValuePart
    if $4 != nil {
    	d4 = $4.(*ast.DefaultValuePart)
    }
    $$ = &ast.FieldSpec{Name: $1.(ast.TableName), OptType: d2, OptNotNull: $3, OptDefaultValue: d4}
  }

field_spec_list:
  field_spec
  {
    $$ = ast.FieldSpecList{$1.(*ast.FieldSpec)}
  }
| field_spec_list ',' field_spec
  {
    $$ = append($1.(ast.FieldSpecList), $3.(*ast.FieldSpec))
  }

record_type_def:
  RECORD '(' field_spec_list ')'
  {
    $$ = &ast.RecordTypeDef{FieldSpecs: $3.(ast.FieldSpecList)}
  }

cursor_type_def:
  REF CURSOR opt_cursor_return
  {
    var d3 *ast.TypeSpec
    if $3 != nil {
    	d3 = $3.(*ast.TypeSpec)
    }
    $$ = &ast.CursorTypeDef{OptReturnType: d3}
  }

cursor_expression:
  CURSOR subquery
  {
    $$ = &ast.CursorExpr{SubQuery: $2.(*ast.Subquery)}
  }

cursor_attribute:
  PERCENT_ISOPEN
  {
    $$ = ast.IsOpenStr
  }
| PERCENT_FOUND
  {
    $$ = ast.FoundStr
  }
| PERCENT_NOTFOUND
  {
    $$ = ast.NotfoundStr
  }

object_type_def:
  OBJECT '(' field_spec_list ')'
  {
    $$ = &ast.ObjectTypeDef{FieldSpecs: $3.(ast.FieldSpecList), OBJDecl: nil}
  }
| OBJECT '(' field_spec_list ',' object_type_list ')'
  {
    $$ = &ast.ObjectTypeDef{FieldSpecs: $3.(ast.FieldSpecList), OBJDecl: $5.(*ast.ObjTypeDecl)}
  }
| OBJECT '(' object_type_list ')'
  {
    $$ = &ast.ObjectTypeDef{FieldSpecs: nil, OBJDecl: $3.(*ast.ObjTypeDecl)}
  }

opt_subtype_range:
  {
    $$ = nil
  }
| RANGE value_expression DOUBLE_POINT value_expression
  {
    $$ = &ast.SubTypeRange{LowValue: $2, HighValue: $4}
  }

opt_is_select:
  {
    $$ = nil
  }
| IS base_select opt_order_by opt_limit opt_lock
  {
    sel := $2.(*ast.Select)
    var orderBy ast.OrderBy
    if $3 != nil {
    	orderBy = $3.(ast.OrderBy)
    }
    sel.OrderBy = orderBy
    var limit *ast.Limit
    if $4 != nil {
    	limit = $4.(*ast.Limit)
    }
    sel.Limit = limit
    sel.Lock = $5
    $$ = sel
  }

opt_cursor_return:
  {
    $$ = nil
  }
| RETURN type_spec
  {
    $$ = $2
  }

opt_parameter_list:
  {
    $$ = nil
  }
| '(' ')'
  {
    $$ = nil
  }
| '(' parameter_list ')'
  {
    $$ = $2
  }

parameter_list:
  parameter
  {
    $$ = ast.ParameterList{$1.(*ast.Parameter)}
  }
| parameter_list ',' parameter
  {
    $$ = append($1.(ast.ParameterList), $3.(*ast.Parameter))
  }

parameter:
  ident opt_mode opt_type_spec opt_default_value_part
  {
    var d3 *ast.TypeSpec
    if $3 != nil {
    	d3 = $3.(*ast.TypeSpec)
    }
    var d4 *ast.DefaultValuePart
    if $4 != nil {
    	d4 = $4.(*ast.DefaultValuePart)
    }
    $$ = &ast.Parameter{ParameterName: $1, Mode: $2, OptType: d3, OptDefaultValuePart: d4}
  }

opt_type_spec:
  {
    $$ = nil
  }
| type_spec

type_spec:
  data_type
  {
    $$ = &ast.TypeSpec{DataType: $1.(*ast.DataType)}
  }
| opt_ref id_expression_list opt_type_attr
  {
    $$ = &ast.TypeSpec{OptRef: $1, TypeName: $2.(ast.IdExpressionList), OptTypeName: $3}
  }
opt_local:
  {
    $$ = ""
  }
| LOCAL

opt_year_day:
  YEAR
| DAY

opt_month_second:
  MONTH
| SECOND

character_datatypes:
  CHAR
| VARCHAR
| VARCHAR2
| NCHAR
| NVARCHAR2
| TEXT
| JSON

numeric_datatypes:
  NUMBER
| NUMERIC
| DEC
| DECIMAL
| BINARY_FLOAT
| BINARY_DOUBLE
| SIGNTYPE
| BOOL
| BOOLEAN
| PLS_INTEGER
| BINARY_INTEGER
| NATURALN
| POSITIVE
| POSITIVEN
| SIMPLE_INTEGER
| REAL
| FLOAT_TYPE
| DOUBLE
| DOUBLE PRECISION
| SMALLINT
| INT
| INTEGER
| UNSIGNED

date_datatypes:
  DATE
| TIMESTAMP
| YEAR

lob_datatypes:
  BLOB
| CLOB
| NCLOB
| BFILE

raw_datatypes:
  RAW
| LONG
| LONG RAW
  {
    $$ = $1 + " " + $2
  }

rowid_datatypes:
  ROWID
| UROWID

native_datatype_element:
  character_datatypes
| numeric_datatypes
| date_datatypes
| lob_datatypes
| raw_datatypes
| rowid_datatypes

opt_char_byte:
  {
    $$ = ""
  }
| CHAR
| BYTE

OptPrecision:
  {
    $$ = nil
  }
| '(' INTEGRAL opt_char_byte ')'
  {
    $$ = &ast.Precision{OptLength: $2, OptCharByte: $3}
  }
| '(' INTEGRAL ',' INTEGRAL opt_char_byte ')'
  {
    $$ = &ast.Precision{OptLength: $2, OptScale: $4, OptCharByte: $5}
  }

native_type_with_precision:
  native_datatype_element OptPrecision
  {
    var d2 *ast.Precision
    if $2 != nil {
    	d2 = $2.(*ast.Precision)
    }
    $$ = &ast.PlsqlNativeType{NativeType: $1, OptPrecision: d2}
  }

data_type:
  native_type_with_precision
  {
    $$ = &ast.DataType{TypeWithPrecision: $1.(*ast.PlsqlNativeType)}
  }
| native_type_with_precision WITH opt_local TIME ZONE
  {
    $$ = &ast.DataType{TypeWithPrecision: $1.(*ast.PlsqlNativeType), OptWith: $2, OptLocal: $3}
  }
| native_type_with_precision CHARACTER SET id_expression_list
  {
    $$ = &ast.DataType{TypeWithPrecision: $1.(*ast.PlsqlNativeType), OptCharSet: $4.(ast.IdExpressionList)}
  }
| INTERVAL opt_year_day '(' expression ')' TO opt_month_second '(' expression ')'
  {
    $$ = &ast.DataType{FromTimePeriod: $2, OptIntervalFrom: $4.(ast.Expr), ToTimePeriod: $7, OptIntervalTo: $9.(ast.Expr)}
  }

opt_type_attr:
  {
    $$ = ""
  }
| PERCENT_ROWTYPE
  {
    $$ = "%ROWTYPE"
  }
| PERCENT_TYPE
  {
    $$ = "%TYPE"
  }

opt_ref:
  {
    $$ = ""
  }
| REF

opt_mode:
  {
    $$ = ast.ModeIn
  }
| IN
  {
    $$ = ast.ModeIn
  }
| OUT
  {
    $$ = ast.ModeOut
  }
| IN OUT
  {
    $$ = ast.ModeInOut
  }
| IN OUT NOCOPY
  {
    $$ = ast.ModeInOutNoCopy
  }
| OUT NOCOPY
  {
    $$ = ast.ModeOutNoCopy
  }

is_or_as:
  IS
| AS

id_expression:
  regular_id
  {
    $$ = &ast.IdExpression{RegularId: $1}
  }

reserved_id_expression:
  id_expression
| reserved_keyword
  {
    $$ = &ast.IdExpression{RegularId: $1}
  }

regular_id:
  ident

opt_name:
  {
    $$ = ""
  }
| ID

opt_constant:
  {
    $$ = ""
  }
| CONSTANT

opt_not_null:
  {
    $$ = ""
  }
| NOT NULL
  {
    $$ = $1 + " " + $2
  }

opt_default_value_part:
  {
    $$ = nil
  }
| ASSIGN expression
  {
    $$ = &ast.DefaultValuePart{AssignExpression: $2.(ast.Expr)}
  }
| DEFAULT expression
  {
    $$ = &ast.DefaultValuePart{DefaultExpression: $2.(ast.Expr)}
  }
%%
