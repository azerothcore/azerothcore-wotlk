--[[--------------------------------------------------------------------

  optparser.lua: does parser-based optimizations
  This file is part of LuaSrcDiet.

  Copyright (c) 2008 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- NOTES:
-- * For more parser-based optimization ideas, see the TODO items or
--   look at technotes.txt.
-- * The processing load is quite significant, but since this is an
--   off-line text processor, I believe we can wait a few seconds.
-- * TODO: might process "local a,a,a" wrongly... need tests!
-- * TODO: remove position handling if overlapped locals (rem < 0)
--   needs more study, to check behaviour
-- * TODO: there are probably better ways to do allocation, e.g. by
--   choosing better methods to sort and pick locals...
-- * TODO: we don't need 53*63 two-letter identifiers; we can make
--   do with significantly less depending on how many that are really
--   needed and improve entropy; e.g. 13 needed -> choose 4*4 instead
----------------------------------------------------------------------]]

local base = {}
-- local base = _G
-- local string = require "string"
-- local table = require "table"
-- module "optparser"

----------------------------------------------------------------------
-- Letter frequencies for reducing symbol entropy (fixed version)
-- * Might help a wee bit when the output file is compressed
-- * See Wikipedia: http://en.wikipedia.org/wiki/Letter_frequencies
-- * We use letter frequencies according to a Linotype keyboard, plus
--   the underscore, and both lower case and upper case letters.
-- * The arrangement below (LC, underscore, %d, UC) is arbitrary.
-- * This is certainly not optimal, but is quick-and-dirty and the
--   process has no significant overhead
----------------------------------------------------------------------

local LETTERS = "etaoinshrdlucmfwypvbgkqjxz_ETAOINSHRDLUCMFWYPVBGKQJXZ"
local ALPHANUM = "etaoinshrdlucmfwypvbgkqjxz_0123456789ETAOINSHRDLUCMFWYPVBGKQJXZ"

-- names or identifiers that must be skipped
-- * the first two lines are for keywords
local SKIP_NAME = {}
for v in string.gmatch([[
and break do else elseif end false for function if in
local nil not or repeat return then true until while
self]], "%S+") do
  SKIP_NAME[v] = true
end

------------------------------------------------------------------------
-- variables and data structures
------------------------------------------------------------------------

local toklist, seminfolist,             -- token lists
      globalinfo, localinfo,            -- variable information tables
      globaluniq, localuniq,            -- unique name tables
      var_new,                          -- index of new variable names
      varlist                           -- list of output variables

----------------------------------------------------------------------
-- preprocess information table to get lists of unique names
----------------------------------------------------------------------

local function preprocess(infotable)
  local uniqtable = {}
  for i = 1, #infotable do              -- enumerate info table
    local obj = infotable[i]
    local name = obj.name
    --------------------------------------------------------------------
    if not uniqtable[name] then         -- not found, start an entry
      uniqtable[name] = {
        decl = 0, token = 0, size = 0,
      }
    end
    --------------------------------------------------------------------
    local uniq = uniqtable[name]        -- count declarations, tokens, size
    uniq.decl = uniq.decl + 1
    local xref = obj.xref
    local xcount = #xref
    uniq.token = uniq.token + xcount
    uniq.size = uniq.size + xcount * #name
    --------------------------------------------------------------------
    if obj.decl then            -- if local table, create first,last pairs
      obj.id = i
      obj.xcount = xcount
      if xcount > 1 then        -- if ==1, means local never accessed
        obj.first = xref[2]
        obj.last = xref[xcount]
      end
    --------------------------------------------------------------------
    else                        -- if global table, add a back ref
      uniq.id = i
    end
    --------------------------------------------------------------------
  end--for
  return uniqtable
end

----------------------------------------------------------------------
-- calculate actual symbol frequencies, in order to reduce entropy
-- * this may help further reduce the size of compressed sources
-- * note that since parsing optimizations is put before lexing
--   optimizations, the frequency table is not exact!
-- * yes, this will miss --keep block comments too...
----------------------------------------------------------------------

local function recalc_for_entropy(option)
  local byte = string.byte
  local char = string.char
  -- table of token classes to accept in calculating symbol frequency
  local ACCEPT = {
    TK_KEYWORD = true, TK_NAME = true, TK_NUMBER = true,
    TK_STRING = true, TK_LSTRING = true,
  }
  if not option["opt-comments"] then
    ACCEPT.TK_COMMENT = true
    ACCEPT.TK_LCOMMENT = true
  end
  --------------------------------------------------------------------
  -- create a new table and remove any original locals by filtering
  --------------------------------------------------------------------
  local filtered = {}
  for i = 1, #toklist do
    filtered[i] = seminfolist[i]
  end
  for i = 1, #localinfo do              -- enumerate local info table
    local obj = localinfo[i]
    local xref = obj.xref
    for j = 1, obj.xcount do
      local p = xref[j]
      filtered[p] = ""                  -- remove locals
    end
  end
  --------------------------------------------------------------------
  local freq = {}                       -- reset symbol frequency table
  for i = 0, 255 do freq[i] = 0 end
  for i = 1, #toklist do                -- gather symbol frequency
    local tok, info = toklist[i], filtered[i]
    if ACCEPT[tok] then
      for j = 1, #info do
        local c = byte(info, j)
        freq[c] = freq[c] + 1
      end
    end--if
  end--for
  --------------------------------------------------------------------
  -- function to re-sort symbols according to actual frequencies
  --------------------------------------------------------------------
  local function resort(symbols)
    local symlist = {}
    for i = 1, #symbols do              -- prepare table to sort
      local c = byte(symbols, i)
      symlist[i] = { c = c, freq = freq[c], }
    end
    table.sort(symlist,                 -- sort selected symbols
      function(v1, v2)
        return v1.freq > v2.freq
      end
    )
    local charlist = {}                 -- reconstitute the string
    for i = 1, #symlist do
      charlist[i] = char(symlist[i].c)
    end
    return table.concat(charlist)
  end
  --------------------------------------------------------------------
  LETTERS = resort(LETTERS)             -- change letter arrangement
  ALPHANUM = resort(ALPHANUM)
end

----------------------------------------------------------------------
-- returns a string containing a new local variable name to use, and
-- a flag indicating whether it collides with a global variable
-- * trapping keywords and other names like 'self' is done elsewhere
----------------------------------------------------------------------

local function new_var_name()
  local var
  local cletters, calphanum = #LETTERS, #ALPHANUM
  local v = var_new
  if v < cletters then                  -- single char
    v = v + 1
    var = string.sub(LETTERS, v, v)
  else                                  -- longer names
    local range, sz = cletters, 1       -- calculate # chars fit
    repeat
      v = v - range
      range = range * calphanum
      sz = sz + 1
    until range > v
    local n = v % cletters              -- left side cycles faster
    v = (v - n) / cletters              -- do first char first
    n = n + 1
    var = string.sub(LETTERS, n, n)
    while sz > 1 do
      local m = v % calphanum
      v = (v - m) / calphanum
      m = m + 1
      var = var..string.sub(ALPHANUM, m, m)
      sz = sz - 1
    end
  end
  var_new = var_new + 1
  return var, globaluniq[var] ~= nil
end

----------------------------------------------------------------------
-- calculate and print some statistics
-- * probably better in main source, put here for now
----------------------------------------------------------------------

local function stats_summary(globaluniq, localuniq, afteruniq, option)
  local fmt = string.format
  local opt_details = option.DETAILS
  local uniq_g , uniq_li, uniq_lo, uniq_ti, uniq_to,  -- stats needed
        decl_g, decl_li, decl_lo, decl_ti, decl_to,
        token_g, token_li, token_lo, token_ti, token_to,
        size_g, size_li, size_lo, size_ti, size_to
    = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  local function avg(c, l)              -- safe average function
    if c == 0 then return 0 end
    return l / c
  end
  --------------------------------------------------------------------
  -- collect statistics (note: globals do not have declarations!)
  --------------------------------------------------------------------
  for name, uniq in pairs(globaluniq) do
    uniq_g = uniq_g + 1
    token_g = token_g + uniq.token
    size_g = size_g + uniq.size
  end
  for name, uniq in pairs(localuniq) do
    uniq_li = uniq_li + 1
    decl_li = decl_li + uniq.decl
    token_li = token_li + uniq.token
    size_li = size_li + uniq.size
  end
  for name, uniq in pairs(afteruniq) do
    uniq_lo = uniq_lo + 1
    decl_lo = decl_lo + uniq.decl
    token_lo = token_lo + uniq.token
    size_lo = size_lo + uniq.size
  end
  uniq_ti = uniq_g + uniq_li
  decl_ti = decl_g + decl_li
  token_ti = token_g + token_li
  size_ti = size_g + size_li
  uniq_to = uniq_g + uniq_lo
  decl_to = decl_g + decl_lo
  token_to = token_g + token_lo
  size_to = size_g + size_lo
  --------------------------------------------------------------------
  -- detailed stats: global list
  --------------------------------------------------------------------
  if opt_details then
    local sorted = {} -- sort table of unique global names by size
    for name, uniq in pairs(globaluniq) do
      uniq.name = name
      sorted[#sorted + 1] = uniq
    end
    table.sort(sorted,
      function(v1, v2)
        return v1.size > v2.size
      end
    )
    local tabf1, tabf2 = "%8s%8s%10s  %s", "%8d%8d%10.2f  %s"
    local hl = string.rep("-", 44)
    print("*** global variable list (sorted by size) ***\n"..hl)
    print(fmt(tabf1, "Token",  "Input", "Input", "Global"))
    print(fmt(tabf1, "Count", "Bytes", "Average", "Name"))
    print(hl)
    for i = 1, #sorted do
      local uniq = sorted[i]
      print(fmt(tabf2, uniq.token, uniq.size, avg(uniq.token, uniq.size), uniq.name))
    end
    print(hl)
    print(fmt(tabf2, token_g, size_g, avg(token_g, size_g), "TOTAL"))
    print(hl.."\n")
  --------------------------------------------------------------------
  -- detailed stats: local list
  --------------------------------------------------------------------
    local tabf1, tabf2 = "%8s%8s%8s%10s%8s%10s  %s", "%8d%8d%8d%10.2f%8d%10.2f  %s"
    local hl = string.rep("-", 70)
    print("*** local variable list (sorted by allocation order) ***\n"..hl)
    print(fmt(tabf1, "Decl.", "Token",  "Input", "Input", "Output", "Output", "Global"))
    print(fmt(tabf1, "Count", "Count", "Bytes", "Average", "Bytes", "Average", "Name"))
    print(hl)
    for i = 1, #varlist do  -- iterate according to order assigned
      local name = varlist[i]
      local uniq = afteruniq[name]
      local old_t, old_s = 0, 0
      for j = 1, #localinfo do  -- find corresponding old names and calculate
        local obj = localinfo[j]
        if obj.name == name then
          old_t = old_t + obj.xcount
          old_s = old_s + obj.xcount * #obj.oldname
        end
      end
      print(fmt(tabf2, uniq.decl, uniq.token, old_s, avg(old_t, old_s),
                uniq.size, avg(uniq.token, uniq.size), name))
    end
    print(hl)
    print(fmt(tabf2, decl_lo, token_lo, size_li, avg(token_li, size_li),
              size_lo, avg(token_lo, size_lo), "TOTAL"))
    print(hl.."\n")
  end--if opt_details
  --------------------------------------------------------------------
  -- display output
  --------------------------------------------------------------------
  -- local tabf1, tabf2 = "%-16s%8s%8s%8s%8s%10s", "%-16s%8d%8d%8d%8d%10.2f"
  -- local hl = string.rep("-", 58)
  -- print("*** local variable optimization summary ***\n"..hl)
  -- print(fmt(tabf1, "Variable",  "Unique", "Decl.", "Token", "Size", "Average"))
  -- print(fmt(tabf1, "Types", "Names", "Count", "Count", "Bytes", "Bytes"))
  -- print(hl)
  -- print(fmt(tabf2, "Global", uniq_g, decl_g, token_g, size_g, avg(token_g, size_g)))
  -- print(hl)
  -- print(fmt(tabf2, "Local (in)", uniq_li, decl_li, token_li, size_li, avg(token_li, size_li)))
  -- print(fmt(tabf2, "TOTAL (in)", uniq_ti, decl_ti, token_ti, size_ti, avg(token_ti, size_ti)))
  -- print(hl)
  -- print(fmt(tabf2, "Local (out)", uniq_lo, decl_lo, token_lo, size_lo, avg(token_lo, size_lo)))
  -- print(fmt(tabf2, "TOTAL (out)", uniq_to, decl_to, token_to, size_to, avg(token_to, size_to)))
  -- print(hl.."\n")
end

----------------------------------------------------------------------
-- main entry point
-- * does only local variable optimization for now
----------------------------------------------------------------------

function base.optimize(option, _toklist, _seminfolist, _globalinfo, _localinfo)
  -- set tables
  toklist, seminfolist, globalinfo, localinfo
    = _toklist, _seminfolist, _globalinfo, _localinfo
  var_new = 0                           -- reset variable name allocator
  varlist = {}
  ------------------------------------------------------------------
  -- preprocess global/local tables, handle entropy reduction
  ------------------------------------------------------------------
  globaluniq = preprocess(globalinfo)
  localuniq = preprocess(localinfo)
  if option["opt-entropy"] then         -- for entropy improvement
    recalc_for_entropy(option)
  end
  ------------------------------------------------------------------
  -- build initial declared object table, then sort according to
  -- token count, this might help assign more tokens to more common
  -- variable names such as 'e' thus possibly reducing entropy
  -- * an object knows its localinfo index via its 'id' field
  -- * special handling for "self" special local (parameter) here
  ------------------------------------------------------------------
  local object = {}
  for i = 1, #localinfo do
    object[i] = localinfo[i]
  end
  table.sort(object,                    -- sort largest first
    function(v1, v2)
      return v1.xcount > v2.xcount
    end
  )
  ------------------------------------------------------------------
  -- the special "self" function parameters must be preserved
  -- * the allocator below will never use "self", so it is safe to
  --   keep those implicit declarations as-is
  ------------------------------------------------------------------
  local temp, j, gotself = {}, 1, false
  for i = 1, #object do
    local obj = object[i]
    if not obj.isself then
      temp[j] = obj
      j = j + 1
    else
      gotself = true
    end
  end
  object = temp
  ------------------------------------------------------------------
  -- a simple first-come first-served heuristic name allocator,
  -- note that this is in no way optimal...
  -- * each object is a local variable declaration plus existence
  -- * the aim is to assign short names to as many tokens as possible,
  --   so the following tries to maximize name reuse
  -- * note that we preserve sort order
  ------------------------------------------------------------------
  local nobject = #object
  while nobject > 0 do
    local varname, gcollide
    repeat
      varname, gcollide = new_var_name()  -- collect a variable name
    until not SKIP_NAME[varname]          -- skip all special names
    varlist[#varlist + 1] = varname       -- keep a list
    local oleft = nobject
    ------------------------------------------------------------------
    -- if variable name collides with an existing global, the name
    -- cannot be used by a local when the name is accessed as a global
    -- during which the local is alive (between 'act' to 'rem'), so
    -- we drop objects that collides with the corresponding global
    ------------------------------------------------------------------
    if gcollide then
      -- find the xref table of the global
      local gref = globalinfo[globaluniq[varname].id].xref
      local ngref = #gref
      -- enumerate for all current objects; all are valid at this point
      for i = 1, nobject do
        local obj = object[i]
        local act, rem = obj.act, obj.rem  -- 'live' range of local
        -- if rem < 0, it is a -id to a local that had the same name
        -- so follow rem to extend it; does this make sense?
        while rem < 0 do
          rem = localinfo[-rem].rem
        end
        local drop
        for j = 1, ngref do
          local p = gref[j]
          if p >= act and p <= rem then drop = true end  -- in range?
        end
        if drop then
          obj.skip = true
          oleft = oleft - 1
        end
      end--for
    end--if gcollide
    ------------------------------------------------------------------
    -- now the first unassigned local (since it's sorted) will be the
    -- one with the most tokens to rename, so we set this one and then
    -- eliminate all others that collides, then any locals that left
    -- can then reuse the same variable name; this is repeated until
    -- all local declaration that can use this name is assigned
    -- * the criteria for local-local reuse/collision is:
    --   A is the local with a name already assigned
    --   B is the unassigned local under consideration
    --   => anytime A is accessed, it cannot be when B is 'live'
    --   => to speed up things, we have first/last accesses noted
    ------------------------------------------------------------------
    while oleft > 0 do
      local i = 1
      while object[i].skip do  -- scan for first object
        i = i + 1
      end
      ------------------------------------------------------------------
      -- first object is free for assignment of the variable name
      -- [first,last] gives the access range for collision checking
      ------------------------------------------------------------------
      oleft = oleft - 1
      local obja = object[i]
      i = i + 1
      obja.newname = varname
      obja.skip = true
      obja.done = true
      local first, last = obja.first, obja.last
      local xref = obja.xref
      ------------------------------------------------------------------
      -- then, scan all the rest and drop those colliding
      -- if A was never accessed then it'll never collide with anything
      -- otherwise trivial skip if:
      -- * B was activated after A's last access (last < act)
      -- * B was removed before A's first access (first > rem)
      -- if not, see detailed skip below...
      ------------------------------------------------------------------
      if first and oleft > 0 then  -- must have at least 1 access
        local scanleft = oleft
        while scanleft > 0 do
          while object[i].skip do  -- next valid object
            i = i + 1
          end
          scanleft = scanleft - 1
          local objb = object[i]
          i = i + 1
          local act, rem = objb.act, objb.rem  -- live range of B
          -- if rem < 0, extend range of rem thru' following local
          while rem < 0 do
            rem = localinfo[-rem].rem
          end
          --------------------------------------------------------
          if not(last < act or first > rem) then  -- possible collision
            --------------------------------------------------------
            -- B is activated later than A or at the same statement,
            -- this means for no collision, A cannot be accessed when B
            -- is alive, since B overrides A (or is a peer)
            --------------------------------------------------------
            if act >= obja.act then
              for j = 1, obja.xcount do  -- ... then check every access
                local p = xref[j]
                if p >= act and p <= rem then  -- A accessed when B live!
                  oleft = oleft - 1
                  objb.skip = true
                  break
                end
              end--for
            --------------------------------------------------------
            -- A is activated later than B, this means for no collision,
            -- A's access is okay since it overrides B, but B's last
            -- access need to be earlier than A's activation time
            --------------------------------------------------------
            else
              if objb.last and objb.last >= obja.act then
                oleft = oleft - 1
                objb.skip = true
              end
            end
          end
          --------------------------------------------------------
          if oleft == 0 then break end
        end
      end--if first
      ------------------------------------------------------------------
    end--while
    ------------------------------------------------------------------
    -- after assigning all possible locals to one variable name, the
    -- unassigned locals/objects have the skip field reset and the table
    -- is compacted, to hopefully reduce iteration time
    ------------------------------------------------------------------
    local temp, j = {}, 1
    for i = 1, nobject do
      local obj = object[i]
      if not obj.done then
        obj.skip = false
        temp[j] = obj
        j = j + 1
      end
    end
    object = temp  -- new compacted object table
    nobject = #object  -- objects left to process
    ------------------------------------------------------------------
  end--while
  ------------------------------------------------------------------
  -- after assigning all locals with new variable names, we can
  -- patch in the new names, and reprocess to get 'after' stats
  ------------------------------------------------------------------
  for i = 1, #localinfo do  -- enumerate all locals
    local obj = localinfo[i]
    local xref = obj.xref
    if obj.newname then                 -- if got new name, patch it in
      for j = 1, obj.xcount do
        local p = xref[j]               -- xrefs indexes the token list
        seminfolist[p] = obj.newname
      end
      obj.name, obj.oldname             -- adjust names
        = obj.newname, obj.name
    else
      obj.oldname = obj.name            -- for cases like 'self'
    end
  end
  ------------------------------------------------------------------
  -- deal with statistics output
  ------------------------------------------------------------------
  if gotself then  -- add 'self' to end of list
    varlist[#varlist + 1] = "self"
  end
  local afteruniq = preprocess(localinfo)
  stats_summary(globaluniq, localuniq, afteruniq, option)
  ------------------------------------------------------------------
end

return base
