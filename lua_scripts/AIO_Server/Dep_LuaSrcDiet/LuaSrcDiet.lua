#!/usr/bin/env lua
--[[--------------------------------------------------------------------

  LuaSrcDiet
  Compresses Lua source code by removing unnecessary characters.
  For Lua 5.1.x source code.

  Copyright (c) 2008 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- NOTES:
-- * Remember to update version and date information below (MSG_TITLE)
-- * TODO: to implement pcall() to properly handle lexer etc. errors
-- * TODO: verify token stream or double-check binary chunk?
-- * TODO: need some automatic testing for a semblance of sanity
-- * TODO: the plugin module is highly experimental and unstable
----------------------------------------------------------------------]]

-- standard libraries, functions
local string = string
local math = math
local table = table
local require = require
local print = print
local sub = string.sub
local gmatch = string.gmatch

-- support modules
local llex = require "llex"
local lparser = require "lparser"
local optlex = require "optlex"
local optparser = require "optparser"
local plugin

--[[--------------------------------------------------------------------
-- messages and textual data
----------------------------------------------------------------------]]

local MSG_TITLE = [[
LuaSrcDiet: Puts your Lua 5.1 source code on a diet
Version 0.11.2 (20080608)  Copyright (c) 2005-2008 Kein-Hong Man
The COPYRIGHT file describes the conditions under which this
software may be distributed.
]]

local MSG_USAGE = [[
usage: LuaSrcDiet [options] [filenames]

example:
  >LuaSrcDiet myscript.lua -o myscript_.lua

options:
  -v, --version       prints version information
  -h, --help          prints usage information
  -o <file>           specify file name to write output
  -s <suffix>         suffix for output files (default '_')
  --keep <msg>        keep block comment with <msg> inside
  --plugin <module>   run <module> in plugin/ directory
  -                   stop handling arguments

  (optimization levels)
  --none              all optimizations off (normalizes EOLs only)
  --basic             lexer-based optimizations only
  --maximum           maximize reduction of source

  (informational)
  --quiet             process files quietly
  --read-only         read file and print token stats only
  --dump-lexer        dump raw tokens from lexer to stdout
  --dump-parser       dump variable tracking tables from parser
  --details           extra info (strings, numbers, locals)

features (to disable, insert 'no' prefix like --noopt-comments):
%s
default settings:
%s]]

------------------------------------------------------------------------
-- optimization options, for ease of switching on and off
-- * positive to enable optimization, negative (no) to disable
-- * these options should follow --opt-* and --noopt-* style for now
------------------------------------------------------------------------

local OPTION = [[
--opt-comments,'remove comments and block comments'
--opt-whitespace,'remove whitespace excluding EOLs'
--opt-emptylines,'remove empty lines'
--opt-eols,'all above, plus remove unnecessary EOLs'
--opt-strings,'optimize strings and long strings'
--opt-numbers,'optimize numbers'
--opt-locals,'optimize local variable names'
--opt-entropy,'tries to reduce symbol entropy of locals'
]]

-- preset configuration
local DEFAULT_CONFIG = [[
  --opt-comments --opt-whitespace --opt-emptylines
  --opt-numbers --opt-locals
]]
-- override configurations: MUST explicitly enable/disable everything
local BASIC_CONFIG = [[
  --opt-comments --opt-whitespace --opt-emptylines
  --noopt-eols --noopt-strings --noopt-numbers
  --noopt-locals
]]
local MAXIMUM_CONFIG = [[
  --opt-comments --opt-whitespace --opt-emptylines
  --opt-eols --opt-strings --opt-numbers
  --opt-locals --opt-entropy
]]
local NONE_CONFIG = [[
  --noopt-comments --noopt-whitespace --noopt-emptylines
  --noopt-eols --noopt-strings --noopt-numbers
  --noopt-locals
]]

local DEFAULT_SUFFIX = "_"      -- default suffix for file renaming
local PLUGIN_SUFFIX = "plugin/" -- relative location of plugins

--[[--------------------------------------------------------------------
-- startup and initialize option list handling
----------------------------------------------------------------------]]

-- simple error message handler; change to error if traceback wanted
local function die(msg)
  print("LuaSrcDiet: "..msg); os.exit()
end
--die = error--DEBUG

--if not string.match(_VERSION, "5.1", 1, 1) then  -- sanity check
--  die("requires Lua 5.1 to run")
--end

------------------------------------------------------------------------
-- prepares text for list of optimizations, prepare lookup table
------------------------------------------------------------------------

local MSG_OPTIONS = ""
do
  local WIDTH = 24
  local o = {}
  for op, desc in gmatch(OPTION, "%s*([^,]+),'([^']+)'") do
    local msg = "  "..op
    msg = msg..string.rep(" ", WIDTH - #msg)..desc.."\n"
    MSG_OPTIONS = MSG_OPTIONS..msg
    o[op] = true
    o["--no"..sub(op, 3)] = true
  end
  OPTION = o  -- replace OPTION with lookup table
end

MSG_USAGE = string.format(MSG_USAGE, MSG_OPTIONS, DEFAULT_CONFIG)

------------------------------------------------------------------------
-- global variable initialization, option set handling
------------------------------------------------------------------------

local suffix = DEFAULT_SUFFIX           -- file suffix
local option = {}                       -- program options
local stat_c, stat_l                    -- statistics tables

-- function to set option lookup table based on a text list of options
-- note: additional forced settings for --opt-eols is done in optlex.lua
local function set_options(CONFIG)
  for op in gmatch(CONFIG, "(%-%-%S+)") do
    if sub(op, 3, 4) == "no" and        -- handle negative options
       OPTION["--"..sub(op, 5)] then
      option[sub(op, 5)] = false
    else
      option[sub(op, 3)] = true
    end
  end
end

--[[--------------------------------------------------------------------
-- support functions
----------------------------------------------------------------------]]

-- list of token types, parser-significant types are up to TTYPE_GRAMMAR
-- while the rest are not used by parsers; arranged for stats display
local TTYPES = {
  "TK_KEYWORD", "TK_NAME", "TK_NUMBER",         -- grammar
  "TK_STRING", "TK_LSTRING", "TK_OP",
  "TK_EOS",
  "TK_COMMENT", "TK_LCOMMENT",                  -- non-grammar
  "TK_EOL", "TK_SPACE",
}
local TTYPE_GRAMMAR = 7

local EOLTYPES = {                      -- EOL names for token dump
  ["\n"] = "LF", ["\r"] = "CR",
  ["\n\r"] = "LFCR", ["\r\n"] = "CRLF",
}

------------------------------------------------------------------------
-- read source code from file
------------------------------------------------------------------------

local function load_file(fname)
  local INF = io.open(fname, "rb")
  if not INF then die("cannot open \""..fname.."\" for reading") end
  local dat = INF:read("*a")
  if not dat then die("cannot read from \""..fname.."\"") end
  INF:close()
  print("loadf ", type(dat))
  return dat
end

------------------------------------------------------------------------
-- save source code to file
------------------------------------------------------------------------

local function save_file(fname, dat)
  local OUTF = io.open(fname, "wb")
  if not OUTF then die("cannot open \""..fname.."\" for writing") end
  local status = OUTF:write(dat)
  if not status then die("cannot write to \""..fname.."\"") end
  OUTF:close()
  print("loadf ", type(dat))
end

------------------------------------------------------------------------
-- functions to deal with statistics
------------------------------------------------------------------------

-- initialize statistics table
local function stat_init()
  stat_c, stat_l = {}, {}
  for i = 1, #TTYPES do
    local ttype = TTYPES[i]
    stat_c[ttype], stat_l[ttype] = 0, 0
  end
end

-- add a token to statistics table
local function stat_add(tok, seminfo)
  stat_c[tok] = stat_c[tok] + 1
  stat_l[tok] = stat_l[tok] + #seminfo
end

-- do totals for statistics table, return average table
local function stat_calc()
  local function avg(c, l)                      -- safe average function
    if c == 0 then return 0 end
    return l / c
  end
  local stat_a = {}
  local c, l = 0, 0
  for i = 1, TTYPE_GRAMMAR do                   -- total grammar tokens
    local ttype = TTYPES[i]
    c = c + stat_c[ttype]; l = l + stat_l[ttype]
  end
  stat_c.TOTAL_TOK, stat_l.TOTAL_TOK = c, l
  stat_a.TOTAL_TOK = avg(c, l)
  c, l = 0, 0
  for i = 1, #TTYPES do                         -- total all tokens
    local ttype = TTYPES[i]
    c = c + stat_c[ttype]; l = l + stat_l[ttype]
    stat_a[ttype] = avg(stat_c[ttype], stat_l[ttype])
  end
  stat_c.TOTAL_ALL, stat_l.TOTAL_ALL = c, l
  stat_a.TOTAL_ALL = avg(c, l)
  return stat_a
end

--[[--------------------------------------------------------------------
-- main tasks
----------------------------------------------------------------------]]

------------------------------------------------------------------------
-- a simple token dumper, minimal translation of seminfo data
------------------------------------------------------------------------

local function dump_tokens(srcfl)
  --------------------------------------------------------------------
  -- load file and process source input into tokens
  --------------------------------------------------------------------
  local z = load_file(srcfl)
  llex.init(z)
  llex.llex()
  local toklist, seminfolist = llex.tok, llex.seminfo
  --------------------------------------------------------------------
  -- display output
  --------------------------------------------------------------------
  for i = 1, #toklist do
    local tok, seminfo = toklist[i], seminfolist[i]
    if tok == "TK_OP" and string.byte(seminfo) < 32 then
      seminfo = "(".. string.byte(seminfo)..")"
    elseif tok == "TK_EOL" then
      seminfo = EOLTYPES[seminfo]
    else
      seminfo = "'"..seminfo.."'"
    end
    print(tok.." "..seminfo)
  end--for
end

----------------------------------------------------------------------
-- parser dump; dump globalinfo and localinfo tables
----------------------------------------------------------------------

local function dump_parser(srcfl)
  local print = print
  --------------------------------------------------------------------
  -- load file and process source input into tokens
  --------------------------------------------------------------------
  local z = load_file(srcfl)
  llex.init(z)
  llex.llex()
  local toklist, seminfolist, toklnlist
    = llex.tok, llex.seminfo, llex.tokln
  --------------------------------------------------------------------
  -- do parser optimization here
  --------------------------------------------------------------------
  lparser.init(toklist, seminfolist, toklnlist)
  local globalinfo, localinfo = lparser.parser()
  --------------------------------------------------------------------
  -- display output
  --------------------------------------------------------------------
  local hl = string.rep("-", 72)
  print("*** Local/Global Variable Tracker Tables ***")
  print(hl.."\n GLOBALS\n"..hl)
  -- global tables have a list of xref numbers only
  for i = 1, #globalinfo do
    local obj = globalinfo[i]
    local msg = "("..i..") '"..obj.name.."' -> "
    local xref = obj.xref
    for j = 1, #xref do msg = msg..xref[j].." " end
    print(msg)
  end
  -- local tables have xref numbers and a few other special
  -- numbers that are specially named: decl (declaration xref),
  -- act (activation xref), rem (removal xref)
  print(hl.."\n LOCALS (decl=declared act=activated rem=removed)\n"..hl)
  for i = 1, #localinfo do
    local obj = localinfo[i]
    local msg = "("..i..") '"..obj.name.."' decl:"..obj.decl..
                " act:"..obj.act.." rem:"..obj.rem
    if obj.isself then
      msg = msg.." isself"
    end
    msg = msg.." -> "
    local xref = obj.xref
    for j = 1, #xref do msg = msg..xref[j].." " end
    print(msg)
  end
  print(hl.."\n")
end

------------------------------------------------------------------------
-- reads source file(s) and reports some statistics
------------------------------------------------------------------------

local function read_only(srcfl)
  local print = print
  --------------------------------------------------------------------
  -- load file and process source input into tokens
  --------------------------------------------------------------------
  local z = load_file(srcfl)
  llex.init(z)
  llex.llex()
  local toklist, seminfolist = llex.tok, llex.seminfo
  print(MSG_TITLE)
  print("Statistics for: "..srcfl.."\n")
  --------------------------------------------------------------------
  -- collect statistics
  --------------------------------------------------------------------
  stat_init()
  for i = 1, #toklist do
    local tok, seminfo = toklist[i], seminfolist[i]
    stat_add(tok, seminfo)
  end--for
  local stat_a = stat_calc()
  --------------------------------------------------------------------
  -- display output
  --------------------------------------------------------------------
  local fmt = string.format
  local function figures(tt)
    return stat_c[tt], stat_l[tt], stat_a[tt]
  end
  local tabf1, tabf2 = "%-16s%8s%8s%10s", "%-16s%8d%8d%10.2f"
  local hl = string.rep("-", 42)
  print(fmt(tabf1, "Lexical",  "Input", "Input", "Input"))
  print(fmt(tabf1, "Elements", "Count", "Bytes", "Average"))
  print(hl)
  for i = 1, #TTYPES do
    local ttype = TTYPES[i]
    print(fmt(tabf2, ttype, figures(ttype)))
    if ttype == "TK_EOS" then print(hl) end
  end
  print(hl)
  print(fmt(tabf2, "Total Elements", figures("TOTAL_ALL")))
  print(hl)
  print(fmt(tabf2, "Total Tokens", figures("TOTAL_TOK")))
  print(hl.."\n")
end

------------------------------------------------------------------------
-- process source file(s), write output and reports some statistics
------------------------------------------------------------------------

local function process_file(srcfl, destfl)
  local function print(...)             -- handle quiet option
    if option.QUIET then return end
    _G.print(...)
  end
  if plugin and plugin.init then        -- plugin init
    option.EXIT = false
    plugin.init(option, srcfl, destfl)
    if option.EXIT then return end
  end
  print(MSG_TITLE)                      -- title message
  --------------------------------------------------------------------
  -- load file and process source input into tokens
  --------------------------------------------------------------------
  local z = load_file(srcfl)
  if plugin and plugin.post_load then   -- plugin post-load
    z = plugin.post_load(z) or z
    if option.EXIT then return end
  end
  llex.init(z)
  llex.llex()
  local toklist, seminfolist, toklnlist
    = llex.tok, llex.seminfo, llex.tokln
  if plugin and plugin.post_lex then    -- plugin post-lex
    plugin.post_lex(toklist, seminfolist, toklnlist)
    if option.EXIT then return end
  end
  --------------------------------------------------------------------
  -- collect 'before' statistics
  --------------------------------------------------------------------
  stat_init()
  for i = 1, #toklist do
    local tok, seminfo = toklist[i], seminfolist[i]
    stat_add(tok, seminfo)
  end--for
  local stat1_a = stat_calc()
  local stat1_c, stat1_l = stat_c, stat_l
  --------------------------------------------------------------------
  -- do parser optimization here
  --------------------------------------------------------------------
  if option["opt-locals"] then
    optparser.print = print  -- hack
    lparser.init(toklist, seminfolist, toklnlist)
    local globalinfo, localinfo = lparser.parser()
    if plugin and plugin.post_parse then        -- plugin post-parse
      plugin.post_parse(globalinfo, localinfo)
      if option.EXIT then return end
    end
    optparser.optimize(option, toklist, seminfolist, globalinfo, localinfo)
    if plugin and plugin.post_optparse then     -- plugin post-optparse
      plugin.post_optparse()
      if option.EXIT then return end
    end
  end
  --------------------------------------------------------------------
  -- do lexer optimization here, save output file
  --------------------------------------------------------------------
  optlex.print = print  -- hack
  toklist, seminfolist, toklnlist
    = optlex.optimize(option, toklist, seminfolist, toklnlist)
  if plugin and plugin.post_optlex then         -- plugin post-optlex
    plugin.post_optlex(toklist, seminfolist, toklnlist)
    if option.EXIT then return end
  end
  local dat = table.concat(seminfolist)
  -- depending on options selected, embedded EOLs in long strings and
  -- long comments may not have been translated to \n, tack a warning
  if string.find(dat, "\r\n", 1, 1) or
     string.find(dat, "\n\r", 1, 1) then
    optlex.warn.mixedeol = true
  end
  -- save optimized source stream to output file
  save_file(destfl, dat)
  --------------------------------------------------------------------
  -- collect 'after' statistics
  --------------------------------------------------------------------
  stat_init()
  for i = 1, #toklist do
    local tok, seminfo = toklist[i], seminfolist[i]
    stat_add(tok, seminfo)
  end--for
  local stat_a = stat_calc()
  --------------------------------------------------------------------
  -- display output
  --------------------------------------------------------------------
  -- print("Statistics for: "..srcfl.." -> "..destfl.."\n")
  -- local fmt = string.format
  -- local function figures(tt)
  --   return stat1_c[tt], stat1_l[tt], stat1_a[tt],
  --          stat_c[tt],  stat_l[tt],  stat_a[tt]
  -- end
  -- local tabf1, tabf2 = "%-16s%8s%8s%10s%8s%8s%10s",
  --                      "%-16s%8d%8d%10.2f%8d%8d%10.2f"
  -- local hl = string.rep("-", 68)
  -- print("*** lexer-based optimizations summary ***\n"..hl)
  -- print(fmt(tabf1, "Lexical",
  --           "Input", "Input", "Input",
  --           "Output", "Output", "Output"))
  -- print(fmt(tabf1, "Elements",
  --           "Count", "Bytes", "Average",
  --           "Count", "Bytes", "Average"))
  -- print(hl)
  -- for i = 1, #TTYPES do
  --   local ttype = TTYPES[i]
  --   print(fmt(tabf2, ttype, figures(ttype)))
  --   if ttype == "TK_EOS" then print(hl) end
  -- end
  -- print(hl)
  -- print(fmt(tabf2, "Total Elements", figures("TOTAL_ALL")))
  -- print(hl)
  -- print(fmt(tabf2, "Total Tokens", figures("TOTAL_TOK")))
  -- print(hl)
  --------------------------------------------------------------------
  -- report warning flags from optimizing process
  --------------------------------------------------------------------
  if optlex.warn.lstring then
    print("* WARNING: "..optlex.warn.lstring)
  elseif optlex.warn.mixedeol then
    print("* WARNING: ".."output still contains some CRLF or LFCR line endings")
  end
  print()
end

local function process_code(code, config)
    option.QUIET = true
    if config == 1 then
        set_options(DEFAULT_CONFIG)
    elseif config == 2 then
        set_options(BASIC_CONFIG)
    elseif config == 3 then
        set_options(MAXIMUM_CONFIG)
    else
        set_options(NONE_CONFIG)
    end

  local function print(...)             -- handle quiet option
    if option.QUIET then return end
    _G.print(...)
  end
  -- if plugin and plugin.init then        -- plugin init
  --   option.EXIT = false
  --   plugin.init(option, srcfl, destfl)
  --   if option.EXIT then return end
  -- end
  print(MSG_TITLE)                      -- title message
  --------------------------------------------------------------------
  -- load file and process source input into tokens
  --------------------------------------------------------------------
  local z = code -- load_file(srcfl)
  if plugin and plugin.post_load then   -- plugin post-load
    z = plugin.post_load(z) or z
    if option.EXIT then return end
  end
  llex.init(z)
  llex.llex()
  local toklist, seminfolist, toklnlist
    = llex.tok, llex.seminfo, llex.tokln
  if plugin and plugin.post_lex then    -- plugin post-lex
    plugin.post_lex(toklist, seminfolist, toklnlist)
    if option.EXIT then return end
  end
  --------------------------------------------------------------------
  -- collect 'before' statistics
  --------------------------------------------------------------------
  stat_init()
  for i = 1, #toklist do
    local tok, seminfo = toklist[i], seminfolist[i]
    stat_add(tok, seminfo)
  end--for
  local stat1_a = stat_calc()
  local stat1_c, stat1_l = stat_c, stat_l
  --------------------------------------------------------------------
  -- do parser optimization here
  --------------------------------------------------------------------
  if option["opt-locals"] then
    optparser.print = print  -- hack
    lparser.init(toklist, seminfolist, toklnlist)
    local globalinfo, localinfo = lparser.parser()
    if plugin and plugin.post_parse then        -- plugin post-parse
      plugin.post_parse(globalinfo, localinfo)
      if option.EXIT then return end
    end
    optparser.optimize(option, toklist, seminfolist, globalinfo, localinfo)
    if plugin and plugin.post_optparse then     -- plugin post-optparse
      plugin.post_optparse()
      if option.EXIT then return end
    end
  end
  --------------------------------------------------------------------
  -- do lexer optimization here, save output file
  --------------------------------------------------------------------
  optlex.print = print  -- hack
  toklist, seminfolist, toklnlist
    = optlex.optimize(option, toklist, seminfolist, toklnlist)
  if plugin and plugin.post_optlex then         -- plugin post-optlex
    plugin.post_optlex(toklist, seminfolist, toklnlist)
    if option.EXIT then return end
  end
  local dat = table.concat(seminfolist)
  -- depending on options selected, embedded EOLs in long strings and
  -- long comments may not have been translated to \n, tack a warning
  if string.find(dat, "\r\n", 1, 1) or
     string.find(dat, "\n\r", 1, 1) then
    optlex.warn.mixedeol = true
  end
  -- save optimized source stream to output file
  -- save_file(destfl, dat)
  --------------------------------------------------------------------
  -- collect 'after' statistics
  --------------------------------------------------------------------
  -- stat_init()
  -- for i = 1, #toklist do
  --   local tok, seminfo = toklist[i], seminfolist[i]
  --   stat_add(tok, seminfo)
  -- end--for
  -- local stat_a = stat_calc()
  --------------------------------------------------------------------
  -- display output
  --------------------------------------------------------------------
  -- print("Statistics for: "..srcfl.." -> "..destfl.."\n")
  -- local fmt = string.format
  -- local function figures(tt)
  --   return stat1_c[tt], stat1_l[tt], stat1_a[tt],
  --          stat_c[tt],  stat_l[tt],  stat_a[tt]
  -- end
  -- local tabf1, tabf2 = "%-16s%8s%8s%10s%8s%8s%10s",
  --                      "%-16s%8d%8d%10.2f%8d%8d%10.2f"
  -- local hl = string.rep("-", 68)
  -- print("*** lexer-based optimizations summary ***\n"..hl)
  -- print(fmt(tabf1, "Lexical",
  --           "Input", "Input", "Input",
  --           "Output", "Output", "Output"))
  -- print(fmt(tabf1, "Elements",
  --           "Count", "Bytes", "Average",
  --           "Count", "Bytes", "Average"))
  -- print(hl)
  -- for i = 1, #TTYPES do
  --   local ttype = TTYPES[i]
  --   print(fmt(tabf2, ttype, figures(ttype)))
  --   if ttype == "TK_EOS" then print(hl) end
  -- end
  -- print(hl)
  -- print(fmt(tabf2, "Total Elements", figures("TOTAL_ALL")))
  -- print(hl)
  -- print(fmt(tabf2, "Total Tokens", figures("TOTAL_TOK")))
  -- print(hl)
  --------------------------------------------------------------------
  -- report warning flags from optimizing process
  --------------------------------------------------------------------
  if optlex.warn.lstring then
    print("* WARNING: "..optlex.warn.lstring)
  elseif optlex.warn.mixedeol then
    print("* WARNING: ".."output still contains some CRLF or LFCR line endings")
  end
  print()
  return dat
end

--[[--------------------------------------------------------------------
-- main functions
----------------------------------------------------------------------]]

local arg = {...}  -- program arguments
local fspec = {}
set_options(DEFAULT_CONFIG)     -- set to default options at beginning

------------------------------------------------------------------------
-- per-file handling, ship off to tasks
------------------------------------------------------------------------

local function do_files(fspec)
  for _, srcfl in ipairs(fspec) do
    local destfl
    ------------------------------------------------------------------
    -- find and replace extension for filenames
    ------------------------------------------------------------------
    local extb, exte = string.find(srcfl, "%.[^%.%\\%/]*$")
    local basename, extension = srcfl, ""
    if extb and extb > 1 then
      basename = sub(srcfl, 1, extb - 1)
      extension = sub(srcfl, extb, exte)
    end
    destfl = basename..suffix..extension
    if #fspec == 1 and option.OUTPUT_FILE then
      destfl = option.OUTPUT_FILE
    end
    if srcfl == destfl then
      die("output filename identical to input filename")
    end
    ------------------------------------------------------------------
    -- perform requested operations
    ------------------------------------------------------------------
    if option.DUMP_LEXER then
      dump_tokens(srcfl)
    elseif option.DUMP_PARSER then
      dump_parser(srcfl)
    elseif option.READ_ONLY then
      read_only(srcfl)
    else
      process_file(srcfl, destfl)
    end
  end--for
end

------------------------------------------------------------------------
-- main function (entry point is after this definition)
------------------------------------------------------------------------

local function main()
  local argn, i = #arg, 1
  if argn == 0 then
    option.HELP = true
  end
  --------------------------------------------------------------------
  -- handle arguments
  --------------------------------------------------------------------
  while i <= argn do
    local o, p = arg[i], arg[i + 1]
    local dash = string.match(o, "^%-%-?")
    if dash == "-" then                 -- single-dash options
      if o == "-h" then
        option.HELP = true; break
      elseif o == "-v" then
        option.VERSION = true; break
      elseif o == "-s" then
        if not p then die("-s option needs suffix specification") end
        suffix = p
        i = i + 1
      elseif o == "-o" then
        if not p then die("-o option needs a file name") end
        option.OUTPUT_FILE = p
        i = i + 1
      elseif o == "-" then
        break -- ignore rest of args
      else
        die("unrecognized option "..o)
      end
    elseif dash == "--" then            -- double-dash options
      if o == "--help" then
        option.HELP = true; break
      elseif o == "--version" then
        option.VERSION = true; break
      elseif o == "--keep" then
        if not p then die("--keep option needs a string to match for") end
        option.KEEP = p
        i = i + 1
      elseif o == "--plugin" then
        if not p then die("--plugin option needs a module name") end
        if option.PLUGIN then die("only one plugin can be specified") end
        option.PLUGIN = p
        plugin = require(PLUGIN_SUFFIX..p)
        i = i + 1
      elseif o == "--quiet" then
        option.QUIET = true
      elseif o == "--read-only" then
        option.READ_ONLY = true
      elseif o == "--basic" then
        set_options(BASIC_CONFIG)
      elseif o == "--maximum" then
        set_options(MAXIMUM_CONFIG)
      elseif o == "--none" then
        set_options(NONE_CONFIG)
      elseif o == "--dump-lexer" then
        option.DUMP_LEXER = true
      elseif o == "--dump-parser" then
        option.DUMP_PARSER = true
      elseif o == "--details" then
        option.DETAILS = true
      elseif OPTION[o] then  -- lookup optimization options
        set_options(o)
      else
        die("unrecognized option "..o)
      end
    else
      fspec[#fspec + 1] = o             -- potential filename
    end
    i = i + 1
  end--while
  if option.HELP then
    print(MSG_TITLE..MSG_USAGE); return true
  elseif option.VERSION then
    print(MSG_TITLE); return true
  end
  if #fspec > 0 then
    if #fspec > 1 and option.OUTPUT_FILE then
      die("with -o, only one source file can be specified")
    end
    do_files(fspec)
    return true
  else
    die("nothing to do!")
  end
end

-- entry point -> main() -> do_files()
-- if not main() then
--   die("Please run with option -h or --help for usage information")
-- end

-- end of script

return process_code
