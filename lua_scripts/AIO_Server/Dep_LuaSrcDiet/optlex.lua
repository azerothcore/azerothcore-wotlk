--[[--------------------------------------------------------------------

  optlex.lua: does lexer-based optimizations
  This file is part of LuaSrcDiet.

  Copyright (c) 2008 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- NOTES:
-- * For more lexer-based optimization ideas, see the TODO items or
--   look at technotes.txt.
-- * TODO: general string delimiter conversion optimizer
-- * TODO: (numbers) warn if overly significant digit
----------------------------------------------------------------------]]

local base = {}
-- local base = _G
-- local string = require "string"
-- module "optlex"
local match = string.match
local sub = string.sub
local find = string.find
local rep = string.rep
local print = print
local tostring = tostring
local tonumber = tonumber

------------------------------------------------------------------------
-- variables and data structures
------------------------------------------------------------------------

-- error function, can override by setting own function into module
local error = error

base.warn = {}                       -- table for warning flags

local stoks, sinfos, stoklns    -- source lists

local is_realtoken = {          -- significant (grammar) tokens
  TK_KEYWORD = true,
  TK_NAME = true,
  TK_NUMBER = true,
  TK_STRING = true,
  TK_LSTRING = true,
  TK_OP = true,
  TK_EOS = true,
}
local is_faketoken = {          -- whitespace (non-grammar) tokens
  TK_COMMENT = true,
  TK_LCOMMENT = true,
  TK_EOL = true,
  TK_SPACE = true,
}

local opt_details               -- for extra information

------------------------------------------------------------------------
-- true if current token is at the start of a line
-- * skips over deleted tokens via recursion
------------------------------------------------------------------------

local function atlinestart(i)
  local tok = stoks[i - 1]
  if i <= 1 or tok == "TK_EOL" then
    return true
  elseif tok == "" then
    return atlinestart(i - 1)
  end
  return false
end

------------------------------------------------------------------------
-- true if current token is at the end of a line
-- * skips over deleted tokens via recursion
------------------------------------------------------------------------

local function atlineend(i)
  local tok = stoks[i + 1]
  if i >= #stoks or tok == "TK_EOL" or tok == "TK_EOS" then
    return true
  elseif tok == "" then
    return atlineend(i + 1)
  end
  return false
end

------------------------------------------------------------------------
-- counts comment EOLs inside a long comment
-- * in order to keep line numbering, EOLs need to be reinserted
------------------------------------------------------------------------

local function commenteols(lcomment)
  local sep = #match(lcomment, "^%-%-%[=*%[")
  local z = sub(lcomment, sep + 1, -(sep - 1))  -- remove delims
  local i, c = 1, 0
  while true do
    local p, q, r, s = find(z, "([\r\n])([\r\n]?)", i)
    if not p then break end     -- if no matches, done
    i = p + 1
    c = c + 1
    if #s > 0 and r ~= s then   -- skip CRLF or LFCR
      i = i + 1
    end
  end
  return c
end

------------------------------------------------------------------------
-- compares two tokens (i, j) and returns the whitespace required
-- * important! see technotes.txt for more information
-- * only two grammar/real tokens are being considered
-- * if "", no separation is needed
-- * if " ", then at least one whitespace (or EOL) is required
------------------------------------------------------------------------

local function checkpair(i, j)
  local match = match
  local t1, t2 = stoks[i], stoks[j]
  --------------------------------------------------------------------
  if t1 == "TK_STRING" or t1 == "TK_LSTRING" or
     t2 == "TK_STRING" or t2 == "TK_LSTRING" then
    return ""
  --------------------------------------------------------------------
  elseif t1 == "TK_OP" or t2 == "TK_OP" then
    if (t1 == "TK_OP" and (t2 == "TK_KEYWORD" or t2 == "TK_NAME")) or
       (t2 == "TK_OP" and (t1 == "TK_KEYWORD" or t1 == "TK_NAME")) then
      return ""
    end
    if t1 == "TK_OP" and t2 == "TK_OP" then
      -- for TK_OP/TK_OP pairs, see notes in technotes.txt
      local op, op2 = sinfos[i], sinfos[j]
      if (match(op, "^%.%.?$") and match(op2, "^%.")) or
         (match(op, "^[~=<>]$") and op2 == "=") or
         (op == "[" and (op2 == "[" or op2 == "=")) then
        return " "
      end
      return ""
    end
    -- "TK_OP" + "TK_NUMBER" case
    local op = sinfos[i]
    if t2 == "TK_OP" then op = sinfos[j] end
    if match(op, "^%.%.?%.?$") then
      return " "
    end
    return ""
  --------------------------------------------------------------------
  else-- "TK_KEYWORD" | "TK_NAME" | "TK_NUMBER" then
    return " "
  --------------------------------------------------------------------
  end
end

------------------------------------------------------------------------
-- repack tokens, removing deletions caused by optimization process
------------------------------------------------------------------------

local function repack_tokens()
  local dtoks, dinfos, dtoklns = {}, {}, {}
  local j = 1
  for i = 1, #stoks do
    local tok = stoks[i]
    if tok ~= "" then
      dtoks[j], dinfos[j], dtoklns[j] = tok, sinfos[i], stoklns[i]
      j = j + 1
    end
  end
  stoks, sinfos, stoklns = dtoks, dinfos, dtoklns
end

------------------------------------------------------------------------
-- number optimization
-- * optimization using string formatting functions is one way of doing
--   this, but here, we consider all cases and handle them separately
--   (possibly an idiotic approach...)
-- * scientific notation being generated is not in canonical form, this
--   may or may not be a bad thing, feedback welcome
-- * note: intermediate portions need to fit into a normal number range
-- * optimizations can be divided based on number patterns:
-- * hexadecimal:
--   (1) no need to remove leading zeros, just skip to (2)
--   (2) convert to integer if size equal or smaller
--       * change if equal size -> lose the 'x' to reduce entropy
--   (3) number is then processed as an integer
--   (4) note: does not make 0[xX] consistent
-- * integer:
--   (1) note: includes anything with trailing ".", ".0", ...
--   (2) remove useless fractional part, if present, e.g. 123.000
--   (3) remove leading zeros, e.g. 000123
--   (4) switch to scientific if shorter, e.g. 123000 -> 123e3
-- * with fraction:
--   (1) split into digits dot digits
--   (2) if no integer portion, take as zero (can omit later)
--   (3) handle degenerate .000 case, after which the fractional part
--       must be non-zero (if zero, it's matched as an integer)
--   (4) remove trailing zeros for fractional portion
--   (5) p.q where p > 0 and q > 0 cannot be shortened any more
--   (6) otherwise p == 0 and the form is .q, e.g. .000123
--   (7) if scientific shorter, convert, e.g. .000123 -> 123e-6
-- * scientific:
--   (1) split into (digits dot digits) [eE] ([+-] digits)
--   (2) if significand has ".", shift it out so it becomes an integer
--   (3) if significand is zero, just use zero
--   (4) remove leading zeros for significand
--   (5) shift out trailing zeros for significand
--   (6) examine exponent and determine which format is best:
--       integer, with fraction, scientific
------------------------------------------------------------------------

local function do_number(i)
  local before = sinfos[i]      -- 'before'
  local z = before              -- working representation
  local y                       -- 'after', if better
  --------------------------------------------------------------------
  if match(z, "^0[xX]") then            -- hexadecimal number
    local v = tostring(tonumber(z))
    if #v <= #z then
      z = v  -- change to integer, AND continue
    else
      return  -- no change; stick to hex
    end
  end
  --------------------------------------------------------------------
  if match(z, "^%d+%.?0*$") then        -- integer or has useless frac
    z = match(z, "^(%d+)%.?0*$")  -- int portion only
    if z + 0 > 0 then
      z = match(z, "^0*([1-9]%d*)$")  -- remove leading zeros
      local v = #match(z, "0*$")
      local nv = tostring(v)
      if v > #nv + 1 then  -- scientific is shorter
        z = sub(z, 1, #z - v).."e"..nv
      end
      y = z
    else
      y = "0"  -- basic zero
    end
  --------------------------------------------------------------------
  elseif not match(z, "[eE]") then      -- number with fraction part
    local p, q = match(z, "^(%d*)%.(%d+)$")  -- split
    if p == "" then p = 0 end  -- int part zero
    if q + 0 == 0 and p == 0 then
      y = "0"  -- degenerate .000 case
    else
      -- now, q > 0 holds and p is a number
      local v = #match(q, "0*$")  -- remove trailing zeros
      if v > 0 then
        q = sub(q, 1, #q - v)
      end
      -- if p > 0, nothing else we can do to simplify p.q case
      if p + 0 > 0 then
        y = p.."."..q
      else
        y = "."..q  -- tentative, e.g. .000123
        local v = #match(q, "^0*")  -- # leading spaces
        local w = #q - v            -- # significant digits
        local nv = tostring(#q)
        -- e.g. compare 123e-6 versus .000123
        if w + 2 + #nv < 1 + #q then
          y = sub(q, -w).."e-"..nv
        end
      end
    end
  --------------------------------------------------------------------
  else                                  -- scientific number
    local sig, ex = match(z, "^([^eE]+)[eE]([%+%-]?%d+)$")
    ex = tonumber(ex)
    -- if got ".", shift out fractional portion of significand
    local p, q = match(sig, "^(%d*)%.(%d*)$")
    if p then
      ex = ex - #q
      sig = p..q
    end
    if sig + 0 == 0 then
      y = "0"  -- basic zero
    else
      local v = #match(sig, "^0*")  -- remove leading zeros
      sig = sub(sig, v + 1)
      v = #match(sig, "0*$") -- shift out trailing zeros
      if v > 0 then
        sig = sub(sig, 1, #sig - v)
        ex = ex + v
      end
      -- examine exponent and determine which format is best
      local nex = tostring(ex)
      if ex == 0 then  -- it's just an integer
        y = sig
      elseif ex > 0 and (ex <= 1 + #nex) then  -- a number
        y = sig..rep("0", ex)
      elseif ex < 0 and (ex >= -#sig) then  -- fraction, e.g. .123
        v = #sig + ex
        y = sub(sig, 1, v).."."..sub(sig, v + 1)
      elseif ex < 0 and (#nex >= -ex - #sig) then
        -- e.g. compare 1234e-5 versus .01234
        -- gives: #sig + 1 + #nex >= 1 + (-ex - #sig) + #sig
        --     -> #nex >= -ex - #sig
        v = -ex - #sig
        y = "."..rep("0", v)..sig
      else  -- non-canonical scientific representation
        y = sig.."e"..ex
      end
    end--if sig
  end
  --------------------------------------------------------------------
  if y and y ~= sinfos[i] then
    if opt_details then
      print("<number> (line "..stoklns[i]..") "..sinfos[i].." -> "..y)
      opt_details = opt_details + 1
    end
    sinfos[i] = y
  end
end

------------------------------------------------------------------------
-- string optimization
-- * note: works on well-formed strings only!
-- * optimizations on characters can be summarized as follows:
--   \a\b\f\n\r\t\v -- no change
--   \\ -- no change
--   \"\' -- depends on delim, other can remove \
--   \[\] -- remove \
--   \<char> -- general escape, remove \
--   \<eol> -- normalize the EOL only
--   \ddd -- if \a\b\f\n\r\t\v, change to latter
--           if other < ascii 32, keep ddd but zap leading zeros
--           if >= ascii 32, translate it into the literal, then also
--                           do escapes for \\,\",\' cases
--   <other> -- no change
-- * switch delimiters if string becomes shorter
------------------------------------------------------------------------

local function do_string(I)
  local info = sinfos[I]
  local delim = sub(info, 1, 1)                 -- delimiter used
  local ndelim = (delim == "'") and '"' or "'"  -- opposite " <-> '
  local z = sub(info, 2, -2)                    -- actual string
  local i = 1
  local c_delim, c_ndelim = 0, 0                -- "/' counts
  --------------------------------------------------------------------
  while i <= #z do
    local c = sub(z, i, i)
    ----------------------------------------------------------------
    if c == "\\" then                   -- escaped stuff
      local j = i + 1
      local d = sub(z, j, j)
      local p = find("abfnrtv\\\n\r\"\'0123456789", d, 1, true)
      ------------------------------------------------------------
      if not p then                     -- \<char> -- remove \
        z = sub(z, 1, i - 1)..sub(z, j)
        i = i + 1
      ------------------------------------------------------------
      elseif p <= 8 then                -- \a\b\f\n\r\t\v\\
        i = i + 2                       -- no change
      ------------------------------------------------------------
      elseif p <= 10 then               -- \<eol> -- normalize EOL
        local eol = sub(z, j, j + 1)
        if eol == "\r\n" or eol == "\n\r" then
          z = sub(z, 1, i).."\n"..sub(z, j + 2)
        elseif p == 10 then  -- \r case
          z = sub(z, 1, i).."\n"..sub(z, j + 1)
        end
        i = i + 2
      ------------------------------------------------------------
      elseif p <= 12 then               -- \"\' -- remove \ for ndelim
        if d == delim then
          c_delim = c_delim + 1
          i = i + 2
        else
          c_ndelim = c_ndelim + 1
          z = sub(z, 1, i - 1)..sub(z, j)
          i = i + 1
        end
      ------------------------------------------------------------
      else                              -- \ddd -- various steps
        local s = match(z, "^(%d%d?%d?)", j)
        j = i + 1 + #s                  -- skip to location
        local cv = s + 0
        local cc = string.char(cv)
        local p = find("\a\b\f\n\r\t\v", cc, 1, true)
        if p then                       -- special escapes
          s = "\\"..sub("abfnrtv", p, p)
        elseif cv < 32 then             -- normalized \ddd
          s = "\\"..cv
        elseif cc == delim then         -- \<delim>
          s = "\\"..cc
          c_delim = c_delim + 1
        elseif cc == "\\" then          -- \\
          s = "\\\\"
        else                            -- literal character
          s = cc
          if cc == ndelim then
            c_ndelim = c_ndelim + 1
          end
        end
        z = sub(z, 1, i - 1)..s..sub(z, j)
        i = i + #s
      ------------------------------------------------------------
      end--if p
    ----------------------------------------------------------------
    else-- c ~= "\\"                    -- <other> -- no change
      i = i + 1
      if c == ndelim then  -- count ndelim, for switching delimiters
        c_ndelim = c_ndelim + 1
      end
    ----------------------------------------------------------------
    end--if c
  end--while
  --------------------------------------------------------------------
  -- switching delimiters, a long-winded derivation:
  -- (1) delim takes 2+2*c_delim bytes, ndelim takes c_ndelim bytes
  -- (2) delim becomes c_delim bytes, ndelim becomes 2+2*c_ndelim bytes
  -- simplifying the condition (1)>(2) --> c_delim > c_ndelim
  if c_delim > c_ndelim then
    i = 1
    while i <= #z do
      local p, q, r = find(z, "([\'\"])", i)
      if not p then break end
      if r == delim then                -- \<delim> -> <delim>
        z = sub(z, 1, p - 2)..sub(z, p)
        i = p
      else-- r == ndelim                -- <ndelim> -> \<ndelim>
        z = sub(z, 1, p - 1).."\\"..sub(z, p)
        i = p + 2
      end
    end--while
    delim = ndelim  -- actually change delimiters
  end
  --------------------------------------------------------------------
  z = delim..z..delim
  if z ~= sinfos[I] then
    if opt_details then
      print("<string> (line "..stoklns[I]..") "..sinfos[I].." -> "..z)
      opt_details = opt_details + 1
    end
    sinfos[I] = z
  end
end

------------------------------------------------------------------------
-- long string optimization
-- * note: warning flagged if trailing whitespace found, not trimmed
-- * remove first optional newline
-- * normalize embedded newlines
-- * reduce '=' separators in delimiters if possible
------------------------------------------------------------------------

local function do_lstring(I)
  local info = sinfos[I]
  local delim1 = match(info, "^%[=*%[")  -- cut out delimiters
  local sep = #delim1
  local delim2 = sub(info, -sep, -1)
  local z = sub(info, sep + 1, -(sep + 1))  -- lstring without delims
  local y = ""
  local i = 1
  --------------------------------------------------------------------
  while true do
    local p, q, r, s = find(z, "([\r\n])([\r\n]?)", i)
    -- deal with a single line
    local ln
    if not p then
      ln = sub(z, i)
    elseif p >= i then
      ln = sub(z, i, p - 1)
    end
    if ln ~= "" then
      -- flag a warning if there are trailing spaces, won't base.optimize!
      if match(ln, "%s+$") then
        warn.lstring = "trailing whitespace in long string near line "..stoklns[I]
      end
      y = y..ln
    end
    if not p then  -- done if no more EOLs
      break
    end
    -- deal with line endings, normalize them
    i = p + 1
    if p then
      if #s > 0 and r ~= s then  -- skip CRLF or LFCR
        i = i + 1
      end
      -- skip first newline, which can be safely deleted
      if not(i == 1 and i == p) then
        y = y.."\n"
      end
    end
  end--while
  --------------------------------------------------------------------
  -- handle possible deletion of one or more '=' separators
  if sep >= 3 then
    local chk, okay = sep - 1
    -- loop to test ending delimiter with less of '=' down to zero
    while chk >= 2 do
      local delim = "%]"..rep("=", chk - 2).."%]"
      if not match(y, delim) then okay = chk end
      chk = chk - 1
    end
    if okay then  -- change delimiters
      sep = rep("=", okay - 2)
      delim1, delim2 = "["..sep.."[", "]"..sep.."]"
    end
  end
  --------------------------------------------------------------------
  sinfos[I] = delim1..y..delim2
end

------------------------------------------------------------------------
-- long comment optimization
-- * note: does not remove first optional newline
-- * trim trailing whitespace
-- * normalize embedded newlines
-- * reduce '=' separators in delimiters if possible
------------------------------------------------------------------------

local function do_lcomment(I)
  local info = sinfos[I]
  local delim1 = match(info, "^%-%-%[=*%[")  -- cut out delimiters
  local sep = #delim1
  local delim2 = sub(info, -sep, -1)
  local z = sub(info, sep + 1, -(sep - 1))  -- comment without delims
  local y = ""
  local i = 1
  --------------------------------------------------------------------
  while true do
    local p, q, r, s = find(z, "([\r\n])([\r\n]?)", i)
    -- deal with a single line, extract and check trailing whitespace
    local ln
    if not p then
      ln = sub(z, i)
    elseif p >= i then
      ln = sub(z, i, p - 1)
    end
    if ln ~= "" then
      -- trim trailing whitespace if non-empty line
      local ws = match(ln, "%s*$")
      if #ws > 0 then ln = sub(ln, 1, -(ws + 1)) end
      y = y..ln
    end
    if not p then  -- done if no more EOLs
      break
    end
    -- deal with line endings, normalize them
    i = p + 1
    if p then
      if #s > 0 and r ~= s then  -- skip CRLF or LFCR
        i = i + 1
      end
      y = y.."\n"
    end
  end--while
  --------------------------------------------------------------------
  -- handle possible deletion of one or more '=' separators
  sep = sep - 2
  if sep >= 3 then
    local chk, okay = sep - 1
    -- loop to test ending delimiter with less of '=' down to zero
    while chk >= 2 do
      local delim = "%]"..rep("=", chk - 2).."%]"
      if not match(y, delim) then okay = chk end
      chk = chk - 1
    end
    if okay then  -- change delimiters
      sep = rep("=", okay - 2)
      delim1, delim2 = "--["..sep.."[", "]"..sep.."]"
    end
  end
  --------------------------------------------------------------------
  sinfos[I] = delim1..y..delim2
end

------------------------------------------------------------------------
-- short comment optimization
-- * trim trailing whitespace
------------------------------------------------------------------------

local function do_comment(i)
  local info = sinfos[i]
  local ws = match(info, "%s*$")        -- just look from end of string
  if #ws > 0 then
    info = sub(info, 1, -(ws + 1))      -- trim trailing whitespace
  end
  sinfos[i] = info
end

------------------------------------------------------------------------
-- returns true if string found in long comment
-- * this is a feature to keep copyright or license texts
------------------------------------------------------------------------

local function keep_lcomment(opt_keep, info)
  if not opt_keep then return false end  -- option not set
  local delim1 = match(info, "^%-%-%[=*%[")  -- cut out delimiters
  local sep = #delim1
  local delim2 = sub(info, -sep, -1)
  local z = sub(info, sep + 1, -(sep - 1))  -- comment without delims
  if find(z, opt_keep, 1, true) then  -- try to match
    return true
  end
end

------------------------------------------------------------------------
-- main entry point
-- * currently, lexer processing has 2 passes
-- * processing is done on a line-oriented basis, which is easier to
--   grok due to the next point...
-- * since there are various options that can be enabled or disabled,
--   processing is a little messy or convoluted
------------------------------------------------------------------------

function base.optimize(option, toklist, semlist, toklnlist)
  --------------------------------------------------------------------
  -- set option flags
  --------------------------------------------------------------------
  local opt_comments = option["opt-comments"]
  local opt_whitespace = option["opt-whitespace"]
  local opt_emptylines = option["opt-emptylines"]
  local opt_eols = option["opt-eols"]
  local opt_strings = option["opt-strings"]
  local opt_numbers = option["opt-numbers"]
  local opt_keep = option.KEEP
  opt_details = option.DETAILS and 0  -- upvalues for details display
  print = print or base.print
  if opt_eols then  -- forced settings, otherwise won't work properly
    opt_comments = true
    opt_whitespace = true
    opt_emptylines = true
  end
  --------------------------------------------------------------------
  -- variable initialization
  --------------------------------------------------------------------
  stoks, sinfos, stoklns                -- set source lists
    = toklist, semlist, toklnlist
  local i = 1                           -- token position
  local tok, info                       -- current token
  local prev    -- position of last grammar token
                -- on same line (for TK_SPACE stuff)
  --------------------------------------------------------------------
  -- changes a token, info pair
  --------------------------------------------------------------------
  local function settoken(tok, info, I)
    I = I or i
    stoks[I] = tok or ""
    sinfos[I] = info or ""
  end
  --------------------------------------------------------------------
  -- processing loop (PASS 1)
  --------------------------------------------------------------------
  while true do
    tok, info = stoks[i], sinfos[i]
    ----------------------------------------------------------------
    local atstart = atlinestart(i)      -- set line begin flag
    if atstart then prev = nil end
    ----------------------------------------------------------------
    if tok == "TK_EOS" then             -- end of stream/pass
      break
    ----------------------------------------------------------------
    elseif tok == "TK_KEYWORD" or       -- keywords, identifiers,
           tok == "TK_NAME" or          -- operators
           tok == "TK_OP" then
      -- TK_KEYWORD and TK_OP can't be optimized without a big
      -- optimization framework; it would be more of an optimizing
      -- compiler, not a source code compressor
      -- TK_NAME that are locals needs parser to analyze/base.optimize
      prev = i
    ----------------------------------------------------------------
    elseif tok == "TK_NUMBER" then      -- numbers
      if opt_numbers then
        do_number(i)  -- base.optimize
      end
      prev = i
    ----------------------------------------------------------------
    elseif tok == "TK_STRING" or        -- strings, long strings
           tok == "TK_LSTRING" then
      if opt_strings then
        if tok == "TK_STRING" then
          do_string(i)  -- base.optimize
        else
          do_lstring(i)  -- base.optimize
        end
      end
      prev = i
    ----------------------------------------------------------------
    elseif tok == "TK_COMMENT" then     -- short comments
      if opt_comments then
        if i == 1 and sub(info, 1, 1) == "#" then
          -- keep shbang comment, trim whitespace
          do_comment(i)
        else
          -- safe to delete, as a TK_EOL (or TK_EOS) always follows
          settoken()  -- remove entirely
        end
      elseif opt_whitespace then        -- trim whitespace only
        do_comment(i)
      end
    ----------------------------------------------------------------
    elseif tok == "TK_LCOMMENT" then    -- long comments
      if keep_lcomment(opt_keep, info) then
        ------------------------------------------------------------
        -- if --keep, we keep a long comment if <msg> is found;
        -- this is a feature to keep copyright or license texts
        if opt_whitespace then          -- trim whitespace only
          do_lcomment(i)
        end
        prev = i
      elseif opt_comments then
        local eols = commenteols(info)
        ------------------------------------------------------------
        -- prepare opt_emptylines case first, if a disposable token
        -- follows, current one is safe to dump, else keep a space;
        -- it is implied that the operation is safe for '-', because
        -- current is a TK_LCOMMENT, and must be separate from a '-'
        if is_faketoken[stoks[i + 1]] then
          settoken()  -- remove entirely
          tok = ""
        else
          settoken("TK_SPACE", " ")
        end
        ------------------------------------------------------------
        -- if there are embedded EOLs to keep and opt_emptylines is
        -- disabled, then switch the token into one or more EOLs
        if not opt_emptylines and eols > 0 then
          settoken("TK_EOL", rep("\n", eols))
        end
        ------------------------------------------------------------
        -- if optimizing whitespaces, force reinterpretation of the
        -- token to give a chance for the space to be optimized away
        if opt_whitespace and tok ~= "" then
          i = i - 1  -- to reinterpret
        end
        ------------------------------------------------------------
      else                              -- disabled case
        if opt_whitespace then          -- trim whitespace only
          do_lcomment(i)
        end
        prev = i
      end
    ----------------------------------------------------------------
    elseif tok == "TK_EOL" then         -- line endings
      if atstart and opt_emptylines then
        settoken()  -- remove entirely
      elseif info == "\r\n" or info == "\n\r" then
        -- normalize the rest of the EOLs for CRLF/LFCR only
        -- (note that TK_LCOMMENT can change into several EOLs)
        settoken("TK_EOL", "\n")
      end
    ----------------------------------------------------------------
    elseif tok == "TK_SPACE" then       -- whitespace
      if opt_whitespace then
        if atstart or atlineend(i) then
          -- delete leading and trailing whitespace
          settoken()  -- remove entirely
        else
          ------------------------------------------------------------
          -- at this point, since leading whitespace have been removed,
          -- there should be a either a real token or a TK_LCOMMENT
          -- prior to hitting this whitespace; the TK_LCOMMENT case
          -- only happens if opt_comments is disabled; so prev ~= nil
          local ptok = stoks[prev]
          if ptok == "TK_LCOMMENT" then
            -- previous TK_LCOMMENT can abut with anything
            settoken()  -- remove entirely
          else
            -- prev must be a grammar token; consecutive TK_SPACE
            -- tokens is impossible when optimizing whitespace
            local ntok = stoks[i + 1]
            if is_faketoken[ntok] then
              -- handle special case where a '-' cannot abut with
              -- either a short comment or a long comment
              if (ntok == "TK_COMMENT" or ntok == "TK_LCOMMENT") and
                 ptok == "TK_OP" and sinfos[prev] == "-" then
                -- keep token
              else
                settoken()  -- remove entirely
              end
            else--is_realtoken
              -- check a pair of grammar tokens, if can abut, then
              -- delete space token entirely, otherwise keep one space
              local s = checkpair(prev, i + 1)
              if s == "" then
                settoken()  -- remove entirely
              else
                settoken("TK_SPACE", " ")
              end
            end
          end
          ------------------------------------------------------------
        end
      end
    ----------------------------------------------------------------
    else
      error("unidentified token encountered")
    end
    ----------------------------------------------------------------
    i = i + 1
  end--while
  repack_tokens()
  --------------------------------------------------------------------
  -- processing loop (PASS 2)
  --------------------------------------------------------------------
  if opt_eols then
    i = 1
    -- aggressive EOL removal only works with most non-grammar tokens
    -- optimized away because it is a rather simple scheme -- basically
    -- it just checks 'real' token pairs around EOLs
    if stoks[1] == "TK_COMMENT" then
      -- first comment still existing must be shbang, skip whole line
      i = 3
    end
    while true do
      tok, info = stoks[i], sinfos[i]
      --------------------------------------------------------------
      if tok == "TK_EOS" then           -- end of stream/pass
        break
      --------------------------------------------------------------
      elseif tok == "TK_EOL" then       -- consider each TK_EOL
        local t1, t2 = stoks[i - 1], stoks[i + 1]
        if is_realtoken[t1] and is_realtoken[t2] then  -- sanity check
          local s = checkpair(i - 1, i + 1)
          if s == "" then
            settoken()  -- remove entirely
          end
        end
      end--if tok
      --------------------------------------------------------------
      i = i + 1
    end--while
    repack_tokens()
  end
  --------------------------------------------------------------------
  if opt_details and opt_details > 0 then print() end -- spacing
  return stoks, sinfos, stoklns
end

return base
