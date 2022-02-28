--[[--------------------------------------------------------------------

  lparser.lua: Lua 5.1 base.parser in Lua
  This file is part of LuaSrcDiet, based on Yueliang material.

  Copyright (c) 2008 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- NOTES:
-- * This is a version of the native 5.1.x base.parser from Yueliang 0.4.0,
--   with significant modifications to handle LuaSrcDiet's needs:
--   (1) needs pre-built token tables instead of a module.method
--   (2) lparser.error is an optional error handler (from llex)
--   (3) not full parsing, currently fakes raw/unlexed constants
--   (4) base.parser() returns globalinfo, localinfo tables
-- * Please read technotes.txt for more technical details.
-- * NO support for 'arg' vararg functions (LUA_COMPAT_VARARG)
-- * A lot of the base.parser is unused, but might later be useful for
--   full-on parsing and analysis for a few measly bytes saved.
----------------------------------------------------------------------]]

local base = {}
-- local base = _G
-- local string = require "string"
-- module "lparser"
-- local _G = base.getfenv()

--[[--------------------------------------------------------------------
-- variable and data structure initialization
----------------------------------------------------------------------]]

----------------------------------------------------------------------
-- initialization: main variables
----------------------------------------------------------------------

local toklist,                  -- grammar-only token tables (token table,
      seminfolist,              -- semantic information table, line number
      toklnlist,                -- table, cross-reference table)
      xreflist,
      tpos,                     -- token position

      line,                     -- start line # for error messages
      lastln,                   -- last line # for ambiguous syntax chk
      tok, seminfo, ln, xref,   -- token, semantic info, line
      nameref,                  -- proper position of <name> token
      fs,                       -- current function state
      top_fs,                   -- top-level function state

      globalinfo,               -- global variable information table
      globallookup,             -- global variable name lookup table
      localinfo,                -- local variable information table
      ilocalinfo,               -- inactive locals (prior to activation)
      ilocalrefs                -- corresponding references to activate

-- forward references for local functions
-- local base.explist1, base.expr, base.block, base.exp1, base.body, base.chunk

----------------------------------------------------------------------
-- initialization: data structures
----------------------------------------------------------------------

local gmatch = string.gmatch

local block_follow = {}         -- lookahead check in base.chunk(), returnstat()
for v in gmatch("else elseif end until <eof>", "%S+") do
  block_follow[v] = true
end

local stat_call = {}            -- lookup for calls in stat()
for v in gmatch("if while do for repeat function local return break", "%S+") do
  stat_call[v] = v.."_stat"
end

local binopr_left = {}          -- binary operators, left priority
local binopr_right = {}         -- binary operators, right priority
for op, lt, rt in gmatch([[
{+ 6 6}{- 6 6}{* 7 7}{/ 7 7}{% 7 7}
{^ 10 9}{.. 5 4}
{~= 3 3}{== 3 3}
{< 3 3}{<= 3 3}{> 3 3}{>= 3 3}
{and 2 2}{or 1 1}
]], "{(%S+)%s(%d+)%s(%d+)}") do
  binopr_left[op] = lt + 0
  binopr_right[op] = rt + 0
end

local unopr = { ["not"] = true, ["-"] = true,
                ["#"] = true, } -- unary operators
local UNARY_PRIORITY = 8        -- priority for unary operators

--[[--------------------------------------------------------------------
-- support functions
----------------------------------------------------------------------]]

----------------------------------------------------------------------
-- formats error message and throws error (duplicated from llex)
-- * a simplified version, does not report what token was responsible
----------------------------------------------------------------------

local function errorline(s, line)
  local e = error or base.error
  e(string.format("(source):%d: %s", line or ln, s))
end

----------------------------------------------------------------------
-- handles incoming token, semantic information pairs
-- * NOTE: 'nextt' is named 'next' originally
----------------------------------------------------------------------

-- reads in next token
local function nextt()
  lastln = toklnlist[tpos]
  tok, seminfo, ln, xref
    = toklist[tpos], seminfolist[tpos], toklnlist[tpos], xreflist[tpos]
  tpos = tpos + 1
end

-- peek at next token (single lookahead for table constructor)
local function lookahead()
  return toklist[tpos]
end

----------------------------------------------------------------------
-- throws a syntax error, or if token expected is not there
----------------------------------------------------------------------

local function syntaxerror(msg)
  local tok = tok
  if tok ~= "<number>" and tok ~= "<string>" then
    if tok == "<name>" then tok = seminfo end
    tok = "'"..tok.."'"
  end
  errorline(msg.." near "..tok)
end

local function error_expected(token)
  syntaxerror("'"..token.."' expected")
end

----------------------------------------------------------------------
-- tests for a token, returns outcome
-- * return value changed to boolean
----------------------------------------------------------------------

local function testnext(c)
  if tok == c then nextt(); return true end
end

----------------------------------------------------------------------
-- check for existence of a token, throws error if not found
----------------------------------------------------------------------

local function check(c)
  if tok ~= c then error_expected(c) end
end

----------------------------------------------------------------------
-- verify existence of a token, then skip it
----------------------------------------------------------------------

local function checknext(c)
  check(c); nextt()
end

----------------------------------------------------------------------
-- throws error if condition not matched
----------------------------------------------------------------------

local function check_condition(c, msg)
  if not c then syntaxerror(msg) end
end

----------------------------------------------------------------------
-- verifies token conditions are met or else throw error
----------------------------------------------------------------------

local function check_match(what, who, where)
  if not testnext(what) then
    if where == ln then
      error_expected(what)
    else
      syntaxerror("'"..what.."' expected (to close '"..who.."' at line "..where..")")
    end
  end
end

----------------------------------------------------------------------
-- expect that token is a name, return the name
----------------------------------------------------------------------

local function str_checkname()
  check("<name>")
  local ts = seminfo
  nameref = xref
  nextt()
  return ts
end

----------------------------------------------------------------------
-- adds given string s in string pool, sets e as VK
----------------------------------------------------------------------

local function codestring(e, s)
  e.k = "VK"
end

----------------------------------------------------------------------
-- consume a name token, adds it to string pool
----------------------------------------------------------------------

local function checkname(e)
  codestring(e, str_checkname())
end

--[[--------------------------------------------------------------------
-- variable (global|local|upvalue) handling
-- * to track locals and globals, we can extend Yueliang's minimal
--   variable management code with little trouble
-- * entry point is singlevar() for variable lookups
-- * lookup tables (bl.locallist) are maintained awkwardly in the basic
--   base.block data structures, PLUS the function data structure (this is
--   an inelegant hack, since bl is nil for the top level of a function)
----------------------------------------------------------------------]]

----------------------------------------------------------------------
-- register a local variable, create local variable object, set in
-- to-activate variable list
-- * used in new_localvarliteral(), parlist(), fornum(), forlist(),
--   localfunc(), localstat()
----------------------------------------------------------------------

local function new_localvar(name, special)
  local bl = fs.bl
  local locallist
  -- locate locallist in current base.block object or function root object
  if bl then
    locallist = bl.locallist
  else
    locallist = fs.locallist
  end
  -- build local variable information object and set localinfo
  local id = #localinfo + 1
  localinfo[id] = {             -- new local variable object
    name = name,                -- local variable name
    xref = { nameref },         -- xref, first value is declaration
    decl = nameref,             -- location of declaration, = xref[1]
  }
  if special then               -- "self" must be not be changed
    localinfo[id].isself = true
  end
  -- this can override a local with the same name in the same scope
  -- but first, keep it inactive until it gets activated
  local i = #ilocalinfo + 1
  ilocalinfo[i] = id
  ilocalrefs[i] = locallist
end

----------------------------------------------------------------------
-- actually activate the variables so that they are visible
-- * remember Lua semantics, e.g. RHS is evaluated first, then LHS
-- * used in parlist(), forbody(), localfunc(), localstat(), base.body()
----------------------------------------------------------------------

local function adjustlocalvars(nvars)
  local sz = #ilocalinfo
  -- i goes from left to right, in order of local allocation, because
  -- of something like: local a,a,a = 1,2,3 which gives a = 3
  while nvars > 0 do
    nvars = nvars - 1
    local i = sz - nvars
    local id = ilocalinfo[i]            -- local's id
    local obj = localinfo[id]
    local name = obj.name               -- name of local
    obj.act = xref                      -- set activation location
    ilocalinfo[i] = nil
    local locallist = ilocalrefs[i]     -- ref to lookup table to update
    ilocalrefs[i] = nil
    local existing = locallist[name]    -- if existing, remove old first!
    if existing then                    -- do not overlap, set special
      obj = localinfo[existing]         -- form of rem, as -id
      obj.rem = -id
    end
    locallist[name] = id                -- activate, now visible to Lua
  end
end

----------------------------------------------------------------------
-- remove (deactivate) variables in current scope (before scope exits)
-- * zap entire locallist tables since we are not allocating registers
-- * used in leaveblock(), close_func()
----------------------------------------------------------------------

local function removevars()
  local bl = fs.bl
  local locallist
  -- locate locallist in current base.block object or function root object
  if bl then
    locallist = bl.locallist
  else
    locallist = fs.locallist
  end
  -- enumerate the local list at current scope and deactivate 'em
  for name, id in pairs(locallist) do
    local obj = localinfo[id]
    obj.rem = xref                      -- set deactivation location
  end
end

----------------------------------------------------------------------
-- creates a new local variable given a name
-- * skips internal locals (those starting with '('), so internal
--   locals never needs a corresponding adjustlocalvars() call
-- * special is true for "self" which must not be optimized
-- * used in fornum(), forlist(), parlist(), base.body()
----------------------------------------------------------------------

local function new_localvarliteral(name, special)
  if string.sub(name, 1, 1) == "(" then  -- can skip internal locals
    return
  end
  new_localvar(name, special)
end

----------------------------------------------------------------------
-- search the local variable namespace of the given fs for a match
-- * returns localinfo index
-- * used only in singlevaraux()
----------------------------------------------------------------------

local function searchvar(fs, n)
  local bl = fs.bl
  local locallist
  if bl then
    locallist = bl.locallist
    while locallist do
      if locallist[n] then return locallist[n] end  -- found
      bl = bl.prev
      locallist = bl and bl.locallist
    end
  end
  locallist = fs.locallist
  return locallist[n] or -1  -- found or not found (-1)
end

----------------------------------------------------------------------
-- handle locals, globals and upvalues and related processing
-- * search mechanism is recursive, calls itself to search parents
-- * used only in singlevar()
----------------------------------------------------------------------

local function singlevaraux(fs, n, var)
  if fs == nil then  -- no more levels?
    var.k = "VGLOBAL"  -- default is global variable
    return "VGLOBAL"
  else
    local v = searchvar(fs, n)  -- look up at current level
    if v >= 0 then
      var.k = "VLOCAL"
      var.id = v
      --  codegen may need to deal with upvalue here
      return "VLOCAL"
    else  -- not found at current level; try upper one
      if singlevaraux(fs.prev, n, var) == "VGLOBAL" then
        return "VGLOBAL"
      end
      -- else was LOCAL or UPVAL, handle here
      var.k = "VUPVAL"  -- upvalue in this level
      return "VUPVAL"
    end--if v
  end--if fs
end

----------------------------------------------------------------------
-- consume a name token, creates a variable (global|local|upvalue)
-- * used in prefixexp(), funcname()
----------------------------------------------------------------------

local function singlevar(v)
  local name = str_checkname()
  singlevaraux(fs, name, v)
  ------------------------------------------------------------------
  -- variable tracking
  ------------------------------------------------------------------
  if v.k == "VGLOBAL" then
    -- if global being accessed, keep track of it by creating an object
    local id = globallookup[name]
    if not id then
      id = #globalinfo + 1
      globalinfo[id] = {                -- new global variable object
        name = name,                    -- global variable name
        xref = { nameref },             -- xref, first value is declaration
      }
      globallookup[name] = id           -- remember it
    else
      local obj = globalinfo[id].xref
      obj[#obj + 1] = nameref           -- add xref
    end
  else
    -- local/upvalue is being accessed, keep track of it
    local id = v.id
    local obj = localinfo[id].xref
    obj[#obj + 1] = nameref             -- add xref
  end
end

--[[--------------------------------------------------------------------
-- state management functions with open/close pairs
----------------------------------------------------------------------]]

----------------------------------------------------------------------
-- enters a code unit, initializes elements
----------------------------------------------------------------------

local function enterblock(isbreakable)
  local bl = {}  -- per-base.block state
  bl.isbreakable = isbreakable
  bl.prev = fs.bl
  bl.locallist = {}
  fs.bl = bl
end

----------------------------------------------------------------------
-- leaves a code unit, close any upvalues
----------------------------------------------------------------------

local function leaveblock()
  local bl = fs.bl
  removevars()
  fs.bl = bl.prev
end

----------------------------------------------------------------------
-- opening of a function
-- * top_fs is only for anchoring the top fs, so that base.parser() can
--   return it to the caller function along with useful output
-- * used in base.parser() and base.body()
----------------------------------------------------------------------

local function open_func()
  local new_fs  -- per-function state
  if not fs then  -- top_fs is created early
    new_fs = top_fs
  else
    new_fs = {}
  end
  new_fs.prev = fs  -- linked list of function states
  new_fs.bl = nil
  new_fs.locallist = {}
  fs = new_fs
end

----------------------------------------------------------------------
-- closing of a function
-- * used in base.parser() and base.body()
----------------------------------------------------------------------

local function close_func()
  removevars()
  fs = fs.prev
end

--[[--------------------------------------------------------------------
-- other parsing functions
-- * for table constructor, parameter list, argument list
----------------------------------------------------------------------]]

----------------------------------------------------------------------
-- parse a function name suffix, for function call specifications
-- * used in primaryexp(), funcname()
----------------------------------------------------------------------

local function field(v)
  -- field -> ['.' | ':'] NAME
  local key = {}
  nextt()  -- skip the dot or colon
  checkname(key)
  v.k = "VINDEXED"
end

----------------------------------------------------------------------
-- parse a table indexing suffix, for constructors, expressions
-- * used in recfield(), primaryexp()
----------------------------------------------------------------------

local function yindex(v)
  -- index -> '[' base.expr ']'
  nextt()  -- skip the '['
  base.expr(v)
  checknext("]")
end

----------------------------------------------------------------------
-- parse a table record (hash) field
-- * used in constructor()
----------------------------------------------------------------------

local function recfield(cc)
  -- recfield -> (NAME | '['base.exp1']') = base.exp1
  local key, val = {}, {}
  if tok == "<name>" then
    checkname(key)
  else-- tok == '['
    yindex(key)
  end
  checknext("=")
  base.expr(val)
end

----------------------------------------------------------------------
-- emit a set list instruction if enough elements (LFIELDS_PER_FLUSH)
-- * note: retained in this skeleton because it modifies cc.v.k
-- * used in constructor()
----------------------------------------------------------------------

local function closelistfield(cc)
  if cc.v.k == "VVOID" then return end  -- there is no list item
  cc.v.k = "VVOID"
end

----------------------------------------------------------------------
-- parse a table list (array) field
-- * used in constructor()
----------------------------------------------------------------------

local function listfield(cc)
  base.expr(cc.v)
end

----------------------------------------------------------------------
-- parse a table constructor
-- * used in funcargs(), simpleexp()
----------------------------------------------------------------------

local function constructor(t)
  -- constructor -> '{' [ field { fieldsep field } [ fieldsep ] ] '}'
  -- field -> recfield | listfield
  -- fieldsep -> ',' | ';'
  local line = ln
  local cc = {}
  cc.v = {}
  cc.t = t
  t.k = "VRELOCABLE"
  cc.v.k = "VVOID"
  checknext("{")
  repeat
    if tok == "}" then break end
    -- closelistfield(cc) here
    local c = tok
    if c == "<name>" then  -- may be listfields or recfields
      if lookahead() ~= "=" then  -- look ahead: expression?
        listfield(cc)
      else
        recfield(cc)
      end
    elseif c == "[" then  -- constructor_item -> recfield
      recfield(cc)
    else  -- constructor_part -> listfield
      listfield(cc)
    end
  until not testnext(",") and not testnext(";")
  check_match("}", "{", line)
  -- lastlistfield(cc) here
end

----------------------------------------------------------------------
-- parse the arguments (parameters) of a function declaration
-- * used in base.body()
----------------------------------------------------------------------

local function parlist()
  -- parlist -> [ param { ',' param } ]
  local nparams = 0
  if tok ~= ")" then  -- is 'parlist' not empty?
    repeat
      local c = tok
      if c == "<name>" then  -- param -> NAME
        new_localvar(str_checkname())
        nparams = nparams + 1
      elseif c == "..." then
        nextt()
        fs.is_vararg = true
      else
        syntaxerror("<name> or '...' expected")
      end
    until fs.is_vararg or not testnext(",")
  end--if
  adjustlocalvars(nparams)
end

----------------------------------------------------------------------
-- parse the parameters of a function call
-- * contrast with parlist(), used in function declarations
-- * used in primaryexp()
----------------------------------------------------------------------

local function funcargs(f)
  local args = {}
  local line = ln
  local c = tok
  if c == "(" then  -- funcargs -> '(' [ base.explist1 ] ')'
    if line ~= lastln then
      syntaxerror("ambiguous syntax (function call x new statement)")
    end
    nextt()
    if tok == ")" then  -- arg list is empty?
      args.k = "VVOID"
    else
      base.explist1(args)
    end
    check_match(")", "(", line)
  elseif c == "{" then  -- funcargs -> constructor
    constructor(args)
  elseif c == "<string>" then  -- funcargs -> STRING
    codestring(args, seminfo)
    nextt()  -- must use 'seminfo' before 'next'
  else
    syntaxerror("function arguments expected")
    return
  end--if c
  f.k = "VCALL"
end

--[[--------------------------------------------------------------------
-- mostly expression functions
----------------------------------------------------------------------]]

----------------------------------------------------------------------
-- parses an expression in parentheses or a single variable
-- * used in primaryexp()
----------------------------------------------------------------------

local function prefixexp(v)
  -- prefixexp -> NAME | '(' base.expr ')'
  local c = tok
  if c == "(" then
    local line = ln
    nextt()
    base.expr(v)
    check_match(")", "(", line)
  elseif c == "<name>" then
    singlevar(v)
  else
    syntaxerror("unexpected symbol")
  end--if c
end

----------------------------------------------------------------------
-- parses a prefixexp (an expression in parentheses or a single
-- variable) or a function call specification
-- * used in simpleexp(), assignment(), base.expr_stat()
----------------------------------------------------------------------

local function primaryexp(v)
  -- primaryexp ->
  --    prefixexp { '.' NAME | '[' exp ']' | ':' NAME funcargs | funcargs }
  prefixexp(v)
  while true do
    local c = tok
    if c == "." then  -- field
      field(v)
    elseif c == "[" then  -- '[' base.exp1 ']'
      local key = {}
      yindex(key)
    elseif c == ":" then  -- ':' NAME funcargs
      local key = {}
      nextt()
      checkname(key)
      funcargs(v)
    elseif c == "(" or c == "<string>" or c == "{" then  -- funcargs
      funcargs(v)
    else
      return
    end--if c
  end--while
end

----------------------------------------------------------------------
-- parses general expression types, constants handled here
-- * used in subexpr()
----------------------------------------------------------------------

local function simpleexp(v)
  -- simpleexp -> NUMBER | STRING | NIL | TRUE | FALSE | ... |
  --              constructor | FUNCTION base.body | primaryexp
  local c = tok
  if c == "<number>" then
    v.k = "VKNUM"
  elseif c == "<string>" then
    codestring(v, seminfo)
  elseif c == "nil" then
    v.k = "VNIL"
  elseif c == "true" then
    v.k = "VTRUE"
  elseif c == "false" then
    v.k = "VFALSE"
  elseif c == "..." then  -- vararg
    check_condition(fs.is_vararg == true,
                    "cannot use '...' outside a vararg function");
    v.k = "VVARARG"
  elseif c == "{" then  -- constructor
    constructor(v)
    return
  elseif c == "function" then
    nextt()
    base.body(v, false, ln)
    return
  else
    primaryexp(v)
    return
  end--if c
  nextt()
end

------------------------------------------------------------------------
-- Parse subexpressions. Includes handling of unary operators and binary
-- operators. A subexpr is given the rhs priority level of the operator
-- immediately left of it, if any (limit is -1 if none,) and if a binop
-- is found, limit is compared with the lhs priority level of the binop
-- in order to determine which executes first.
-- * recursively called
-- * used in base.expr()
------------------------------------------------------------------------

local function subexpr(v, limit)
  -- subexpr -> (simpleexp | unop subexpr) { binop subexpr }
  --   * where 'binop' is any binary operator with a priority
  --     higher than 'limit'
  local op = tok
  local uop = unopr[op]
  if uop then
    nextt()
    subexpr(v, UNARY_PRIORITY)
  else
    simpleexp(v)
  end
  -- expand while operators have priorities higher than 'limit'
  op = tok
  local binop = binopr_left[op]
  while binop and binop > limit do
    local v2 = {}
    nextt()
    -- read sub-expression with higher priority
    local nextop = subexpr(v2, binopr_right[op])
    op = nextop
    binop = binopr_left[op]
  end
  return op  -- return first untreated operator
end

----------------------------------------------------------------------
-- Expression parsing starts here. Function subexpr is entered with the
-- left operator (which is non-existent) priority of -1, which is lower
-- than all actual operators. Expr information is returned in parm v.
-- * used in cond(), base.explist1(), index(), recfield(), listfield(),
--   prefixexp(), base.while_stat(), base.exp1()
----------------------------------------------------------------------

-- this is a forward-referenced local
function base.expr(v)
  -- base.expr -> subexpr
  subexpr(v, 0)
end

--[[--------------------------------------------------------------------
-- third level parsing functions
----------------------------------------------------------------------]]

------------------------------------------------------------------------
-- parse a variable assignment sequence
-- * recursively called
-- * used in base.expr_stat()
------------------------------------------------------------------------

local function assignment(v)
  local e = {}
  local c = v.v.k
  check_condition(c == "VLOCAL" or c == "VUPVAL" or c == "VGLOBAL"
                  or c == "VINDEXED", "syntax error")
  if testnext(",") then  -- assignment -> ',' primaryexp assignment
    local nv = {}  -- expdesc
    nv.v = {}
    primaryexp(nv.v)
    -- lparser.c deals with some register usage conflict here
    assignment(nv)
  else  -- assignment -> '=' base.explist1
    checknext("=")
    base.explist1(e)
    return  -- avoid default
  end
  e.k = "VNONRELOC"
end

----------------------------------------------------------------------
-- parse a for loop base.body for both versions of the for loop
-- * used in fornum(), forlist()
----------------------------------------------------------------------

local function forbody(nvars, isnum)
  -- forbody -> DO base.block
  checknext("do")
  enterblock(false)  -- scope for declared variables
  adjustlocalvars(nvars)
  base.block()
  leaveblock()  -- end of scope for declared variables
end

----------------------------------------------------------------------
-- parse a numerical for loop, calls forbody()
-- * used in base.for_stat()
----------------------------------------------------------------------

local function fornum(varname)
  -- fornum -> NAME = base.exp1, base.exp1 [, base.exp1] DO base.body
  local line = line
  new_localvarliteral("(for index)")
  new_localvarliteral("(for limit)")
  new_localvarliteral("(for step)")
  new_localvar(varname)
  checknext("=")
  base.exp1()  -- initial value
  checknext(",")
  base.exp1()  -- limit
  if testnext(",") then
    base.exp1()  -- optional step
  else
    -- default step = 1
  end
  forbody(1, true)
end

----------------------------------------------------------------------
-- parse a generic for loop, calls forbody()
-- * used in base.for_stat()
----------------------------------------------------------------------

local function forlist(indexname)
  -- forlist -> NAME {, NAME} IN base.explist1 DO base.body
  local e = {}
  -- create control variables
  new_localvarliteral("(for generator)")
  new_localvarliteral("(for state)")
  new_localvarliteral("(for control)")
  -- create declared variables
  new_localvar(indexname)
  local nvars = 1
  while testnext(",") do
    new_localvar(str_checkname())
    nvars = nvars + 1
  end
  checknext("in")
  local line = line
  base.explist1(e)
  forbody(nvars, false)
end

----------------------------------------------------------------------
-- parse a function name specification
-- * used in func_stat()
----------------------------------------------------------------------

local function funcname(v)
  -- funcname -> NAME {field} [':' NAME]
  local needself = false
  singlevar(v)
  while tok == "." do
    field(v)
  end
  if tok == ":" then
    needself = true
    field(v)
  end
  return needself
end

----------------------------------------------------------------------
-- parse the single expressions needed in numerical for loops
-- * used in fornum()
----------------------------------------------------------------------

-- this is a forward-referenced local
function base.exp1()
  -- base.exp1 -> base.expr
  local e = {}
  base.expr(e)
end

----------------------------------------------------------------------
-- parse condition in a repeat statement or an if control structure
-- * used in base.repeat_stat(), test_then_block()
----------------------------------------------------------------------

local function cond()
  -- cond -> base.expr
  local v = {}
  base.expr(v)  -- read condition
end

----------------------------------------------------------------------
-- parse part of an if control structure, including the condition
-- * used in base.if_stat()
----------------------------------------------------------------------

local function test_then_block()
  -- test_then_block -> [IF | ELSEIF] cond THEN base.block
  nextt()  -- skip IF or ELSEIF
  cond()
  checknext("then")
  base.block()  -- 'then' part
end

----------------------------------------------------------------------
-- parse a local function statement
-- * used in base.local_stat()
----------------------------------------------------------------------

local function localfunc()
  -- localfunc -> NAME base.body
  local v, b = {}
  new_localvar(str_checkname())
  v.k = "VLOCAL"
  adjustlocalvars(1)
  base.body(b, false, ln)
end

----------------------------------------------------------------------
-- parse a local variable declaration statement
-- * used in base.local_stat()
----------------------------------------------------------------------

local function localstat()
  -- localstat -> NAME {',' NAME} ['=' base.explist1]
  local nvars = 0
  local e = {}
  repeat
    new_localvar(str_checkname())
    nvars = nvars + 1
  until not testnext(",")
  if testnext("=") then
    base.explist1(e)
  else
    e.k = "VVOID"
  end
  adjustlocalvars(nvars)
end

----------------------------------------------------------------------
-- parse a list of comma-separated expressions
-- * used in base.return_stat(), localstat(), funcargs(), assignment(),
--   forlist()
----------------------------------------------------------------------

-- this is a forward-referenced local
function base.explist1(e)
  -- base.explist1 -> base.expr { ',' base.expr }
  base.expr(e)
  while testnext(",") do
    base.expr(e)
  end
end

----------------------------------------------------------------------
-- parse function declaration base.body
-- * used in simpleexp(), localfunc(), func_stat()
----------------------------------------------------------------------

-- this is a forward-referenced local
function base.body(e, needself, line)
  -- base.body ->  '(' parlist ')' base.chunk END
  open_func()
  checknext("(")
  if needself then
    new_localvarliteral("self", true)
    adjustlocalvars(1)
  end
  parlist()
  checknext(")")
  base.chunk()
  check_match("end", "function", line)
  close_func()
end

----------------------------------------------------------------------
-- parse a code base.block or unit
-- * used in base.do_stat(), base.while_stat(), forbody(), test_then_block(),
--   base.if_stat()
----------------------------------------------------------------------

-- this is a forward-referenced local
function base.block()
  -- base.block -> base.chunk
  enterblock(false)
  base.chunk()
  leaveblock()
end

--[[--------------------------------------------------------------------
-- second level parsing functions, all with '_stat' suffix
-- * since they are called via a table lookup, they cannot be local
--   functions (a lookup table of local functions might be smaller...)
-- * stat() -> *_stat()
----------------------------------------------------------------------]]

----------------------------------------------------------------------
-- initial parsing for a for loop, calls fornum() or forlist()
-- * removed 'line' parameter (used to set debug information only)
-- * used in stat()
----------------------------------------------------------------------

function base.for_stat()
  -- stat -> base.for_stat -> FOR (fornum | forlist) END
  local line = line
  enterblock(true)  -- scope for loop and control variables
  nextt()  -- skip 'for'
  local varname = str_checkname()  -- first variable name
  local c = tok
  if c == "=" then
    fornum(varname)
  elseif c == "," or c == "in" then
    forlist(varname)
  else
    syntaxerror("'=' or 'in' expected")
  end
  check_match("end", "for", line)
  leaveblock()  -- loop scope (`break' jumps to this point)
end

----------------------------------------------------------------------
-- parse a while-do control structure, base.body processed by base.block()
-- * used in stat()
----------------------------------------------------------------------

function base.while_stat()
  -- stat -> base.while_stat -> WHILE cond DO base.block END
  local line = line
  nextt()  -- skip WHILE
  cond()  -- parse condition
  enterblock(true)
  checknext("do")
  base.block()
  check_match("end", "while", line)
  leaveblock()
end

----------------------------------------------------------------------
-- parse a repeat-until control structure, base.body parsed by base.chunk()
-- * originally, repeatstat() calls breakstat() too if there is an
--   upvalue in the scope base.block; nothing is actually lexed, it is
--   actually the common code in breakstat() for closing of upvalues
-- * used in stat()
----------------------------------------------------------------------

function base.repeat_stat()
  -- stat -> base.repeat_stat -> REPEAT base.block UNTIL cond
  local line = line
  enterblock(true)  -- loop base.block
  enterblock(false)  -- scope base.block
  nextt()  -- skip REPEAT
  base.chunk()
  check_match("until", "repeat", line)
  cond()
  -- close upvalues at scope level below
  leaveblock()  -- finish scope
  leaveblock()  -- finish loop
end

----------------------------------------------------------------------
-- parse an if control structure
-- * used in stat()
----------------------------------------------------------------------

function base.if_stat()
  -- stat -> base.if_stat -> IF cond THEN base.block
  --                    {ELSEIF cond THEN base.block} [ELSE base.block] END
  local line = line
  local v = {}
  test_then_block()  -- IF cond THEN base.block
  while tok == "elseif" do
    test_then_block()  -- ELSEIF cond THEN base.block
  end
  if tok == "else" then
    nextt()  -- skip ELSE
    base.block()  -- 'else' part
  end
  check_match("end", "if", line)
end

----------------------------------------------------------------------
-- parse a return statement
-- * used in stat()
----------------------------------------------------------------------

function base.return_stat()
  -- stat -> base.return_stat -> RETURN explist
  local e = {}
  nextt()  -- skip RETURN
  local c = tok
  if block_follow[c] or c == ";" then
    -- return no values
  else
    base.explist1(e)  -- optional return values
  end
end

----------------------------------------------------------------------
-- parse a break statement
-- * used in stat()
----------------------------------------------------------------------

function base.break_stat()
  -- stat -> base.break_stat -> BREAK
  local bl = fs.bl
  nextt()  -- skip BREAK
  while bl and not bl.isbreakable do -- find a breakable base.block
    bl = bl.prev
  end
  if not bl then
    syntaxerror("no loop to break")
  end
end

----------------------------------------------------------------------
-- parse a function call with no returns or an assignment statement
-- * the struct with .prev is used for name searching in lparse.c,
--   so it is retained for now; present in assignment() also
-- * used in stat()
----------------------------------------------------------------------

function base.expr_stat()
  -- stat -> base.expr_stat -> func | assignment
  local v = {}
  v.v = {}
  primaryexp(v.v)
  if v.v.k == "VCALL" then  -- stat -> func
    -- call statement uses no results
  else  -- stat -> assignment
    v.prev = nil
    assignment(v)
  end
end

----------------------------------------------------------------------
-- parse a function statement
-- * used in stat()
----------------------------------------------------------------------

function base.function_stat()
  -- stat -> base.function_stat -> FUNCTION funcname base.body
  local line = line
  local v, b = {}, {}
  nextt()  -- skip FUNCTION
  local needself = funcname(v)
  base.body(b, needself, line)
end

----------------------------------------------------------------------
-- parse a simple base.block enclosed by a DO..END pair
-- * used in stat()
----------------------------------------------------------------------

function base.do_stat()
  -- stat -> base.do_stat -> DO base.block END
  local line = line
  nextt()  -- skip DO
  base.block()
  check_match("end", "do", line)
end

----------------------------------------------------------------------
-- parse a statement starting with LOCAL
-- * used in stat()
----------------------------------------------------------------------

function base.local_stat()
  -- stat -> base.local_stat -> LOCAL FUNCTION localfunc
  --                    -> LOCAL localstat
  nextt()  -- skip LOCAL
  if testnext("function") then  -- local function?
    localfunc()
  else
    localstat()
  end
end

--[[--------------------------------------------------------------------
-- main functions, top level parsing functions
-- * accessible functions are: base.init(lexer), base.parser()
-- * [entry] -> base.parser() -> base.chunk() -> stat()
----------------------------------------------------------------------]]

----------------------------------------------------------------------
-- initial parsing for statements, calls '_stat' suffixed functions
-- * used in base.chunk()
----------------------------------------------------------------------

local function stat()
  -- stat -> base.if_stat base.while_stat base.do_stat base.for_stat base.repeat_stat
  --         base.function_stat base.local_stat base.return_stat base.break_stat
  --         base.expr_stat
  line = ln  -- may be needed for error messages
  local c = tok
  local fn = stat_call[c]
  -- handles: if while do for repeat function local return break
  if fn then
    base[fn]()
    -- return or break must be last statement
    if c == "return" or c == "break" then return true end
  else
    base.expr_stat()
  end
  return false
end

----------------------------------------------------------------------
-- parse a base.chunk, which consists of a bunch of statements
-- * used in base.parser(), base.body(), base.block(), base.repeat_stat()
----------------------------------------------------------------------

-- this is a forward-referenced local
function base.chunk()
  -- base.chunk -> { stat [';'] }
  local islast = false
  while not islast and not block_follow[tok] do
    islast = stat()
    testnext(";")
  end
end

----------------------------------------------------------------------
-- performs parsing, returns parsed data structure
----------------------------------------------------------------------

function base.parser()
  open_func()
  fs.is_vararg = true  -- main func. is always vararg
  nextt()  -- read first token
  base.chunk()
  check("<eof>")
  close_func()
  return globalinfo, localinfo
end

----------------------------------------------------------------------
-- initialization function
----------------------------------------------------------------------

function base.init(tokorig, seminfoorig, toklnorig)
  tpos = 1                      -- token position
  top_fs = {}                   -- reset top level function state
  ------------------------------------------------------------------
  -- set up grammar-only token tables; impedance-matching...
  -- note that constants returned by the lexer is source-level, so
  -- for now, fake(!) constant tokens (TK_NUMBER|TK_STRING|TK_LSTRING)
  ------------------------------------------------------------------
  local j = 1
  toklist, seminfolist, toklnlist, xreflist = {}, {}, {}, {}
  for i = 1, #tokorig do
    local tok = tokorig[i]
    local yep = true
    if tok == "TK_KEYWORD" or tok == "TK_OP" then
      tok = seminfoorig[i]
    elseif tok == "TK_NAME" then
      tok = "<name>"
      seminfolist[j] = seminfoorig[i]
    elseif tok == "TK_NUMBER" then
      tok = "<number>"
      seminfolist[j] = 0  -- fake!
    elseif tok == "TK_STRING" or tok == "TK_LSTRING" then
      tok = "<string>"
      seminfolist[j] = ""  -- fake!
    elseif tok == "TK_EOS" then
      tok = "<eof>"
    else
      -- non-grammar tokens; ignore them
      yep = false
    end
    if yep then  -- set rest of the information
      toklist[j] = tok
      toklnlist[j] = toklnorig[i]
      xreflist[j] = i
      j = j + 1
    end
  end--for
  ------------------------------------------------------------------
  -- initialize data structures for variable tracking
  ------------------------------------------------------------------
  globalinfo, globallookup, localinfo = {}, {}, {}
  ilocalinfo, ilocalrefs = {}, {}
end

return base
