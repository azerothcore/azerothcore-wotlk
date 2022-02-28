--[[

LUA MODULE

  digest.crc32 - CRC-32 checksum implemented entirely in Lua.

SYNOPSIS

  local CRC = require 'digest.crc32lua'
  print(CRC.crc32 'test') --> 0xD87F7E0C or -662733300
  
  assert(CRC.crc32('st', CRC.crc32('te')) == CRC.crc32 'test')
  
DESCRIPTION

  This can be used to compute CRC-32 checksums on strings.
  This is similar to [1-2].

API

  Note: in the functions below, checksums are 32-bit integers stored in
  numbers.  The number format currently depends on the bit
  implementation--see DESIGN NOTES below.

  CRC.crc32_byte(byte [, crc]) --> rcrc
  
    Returns CRC-32 checksum `rcrc` of byte `byte` (number 0..255) appended to
    a string with CRC-32 checksum `crc`.  `crc` defaults to 0 (empty string)
    if omitted.

  CRC.crc32_string(s, crc) --> bcrc

    Returns CRC-32 checksum `rcrc` of string `s` appended to
    a string with CRC-32 checksum `crc`.  `crc` defaults to 0 (empty string)
    if omitted.
  
  CRC.crc32(o, crc) --> bcrc

    This invokes `crc32_byte` if `o` is a byte or `crc32_string` if `o`
    is a string.
  
  CRC.bit

    This contains the underlying bit library used by the module.  It
    should be considered a read-only copy.

DESIGN NOTES

  Currently, this module exposes the underlying bit array implementation in CRC
  checksums returned.  In BitOp, bit arrays are 32-bit signed integer numbers
  (may be negative).  In Lua 5.2 'bit32' and 'bit.numberlua', bit arrays are
  32-bit unsigned integer numbers (non-negative).  This is subject to change
  in the future but is currently done due to (unconfirmed) performance
  implications.
  
  On platforms with 64-bit numbers, one way to normalize CRC
  checksums to be unsigned is to do `crcvalue % 2^32`,
  
  The name of this module is inspired by Perl `Digest::CRC*`.

DEPENDENCIES
 
  Requires one of the following bit libraries:

    BitOp "bit" -- bitop.luajit.org -- This is included in LuaJIT and also available
      for Lua 5.1/5.2.  This provides the fastest performance in LuaJIT.
    Lua 5.2 "bit32" -- www.lua.org/manual/5.2 -- This is provided in Lua 5.2
      and is preferred in 5.2 (unless "bit" also happens to be installed).
    "bit.numberlua" (>=000.003) -- https://github.com/davidm/lua-bit-numberlua
      This is slowest and used as a last resort.
      It is only a few times slower than "bit32" though.

DOWNLOAD/INSTALLATION

  If using LuaRocks:
    luarocks install lua-digest-crc32lua

  Otherwise, download <https://github.com/davidm/lua-digest-crc32lua/zipball/master>.
  Alternately, if using git:
    git clone git://github.com/davidm/lua-digest-crc32lua.git
    cd lua-digest-crc32lua
  Optionally unpack:
    ./util.mk
  or unpack and install in LuaRocks:
    ./util.mk install 
  
REFERENCES

  [1] http://www.axlradius.com/freestuff/CRC32.java
  [2] http://www.gamedev.net/reference/articles/article1941.asp
  [3] http://java.sun.com/j2se/1.5.0/docs/api/java/util/zip/CRC32.html
  [4] http://www.dsource.org/projects/tango/docs/current/tango.io.digest.Crc32.html
  [5] http://pydoc.org/1.5.2/zlib.html#-crc32
  [6] http://www.python.org/doc/2.5.2/lib/module-binascii.html
 
LICENSE

  (c) 2008-2011 David Manura.  Licensed under the same terms as Lua (MIT).

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  (end license)
 
--]]


local M = {_TYPE='module', _NAME='digest.crc32', _VERSION='0.3.20111128'}

local type = type
local require = require
local setmetatable = setmetatable

--[[
 Requires the first module listed that exists, else raises like `require`.
 If a non-string is encountered, it is returned.
 Second return value is module name loaded (or '').
 --]]
local function requireany(...)
  local errs = {}
  for _,name in ipairs{...} do
    if type(name) ~= 'string' then return name, '' end
    local ok, mod = pcall(require, name)
    if ok then return mod, name end
    errs[#errs+1] = mod
  end
  error(table.concat(errs, '\n'), 2)
end

local bit, name_ = requireany('bit', 'bit32', 'bit.numberlua', 'bit53')
local bxor = bit.bxor
local bnot = bit.bnot
local band = bit.band
local rshift = bit.rshift

-- CRC-32-IEEE 802.3 (V.42)
local POLY = 0xEDB88320

-- Memoize function pattern (like http://lua-users.org/wiki/FuncTables ).
local function memoize(f)
  local mt = {}
  local t = setmetatable({}, mt)
  function mt:__index(k)
    local v = f(k); t[k] = v
    return v
  end
  return t
end

-- CRC table.
local crc_table = memoize(function(i)
  local crc = i
  for _=1,8 do
    local b = band(crc, 1)
    crc = rshift(crc, 1)
    if b == 1 then crc = bxor(crc, POLY) end
  end
  return crc
end)


function M.crc32_byte(byte, crc)
  crc = bnot(crc or 0)
  local v1 = rshift(crc, 8)
  local v2 = crc_table[bxor(crc % 256, byte)]
  return bnot(bxor(v1, v2))
end
local M_crc32_byte = M.crc32_byte


function M.crc32_string(s, crc)
  crc = crc or 0
  for i=1,#s do
    crc = M_crc32_byte(s:byte(i), crc)
  end
  return crc
end
local M_crc32_string = M.crc32_string


function M.crc32(s, crc)
  if type(s) == 'string' then
    return M_crc32_string(s, crc)
  else
    return M_crc32_byte(s, crc)
  end
end


M.bit = bit  -- bit library used


return M
