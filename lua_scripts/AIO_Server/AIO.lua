--[[
    Copyright (C) 2014-  Rochet2 <https://github.com/Rochet2>

    This program is free software you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]

--[=[
-- #API
-- For example scripts see the Examples folder. The example files are named according to their final execution location. To run the examples place all of their files to `server_root/lua_scripts/`.

-- AIO is required this way due to server and client differences with require function
local AIO = AIO or require("AIO")

-- Returns true if we are on server side, false if we are on client side
isServer = AIO.IsServer()

-- Returns AIO version - note the type is not guaranteed to be a number
version = AIO.GetVersion()

-- Adds the file at given path to files to send to players if called on server side.
-- The addon code is trimmed according to settings in AIO.lua.
-- The addon is cached on client side and will be updated only when needed.
-- Returns false on client side and true on server side. By default the
-- path is the current file's path and name is the file's name
-- 'path' is relative to worldserver.exe but an absolute path can also be given.
-- You should call this function only on startup to ensure everyone gets the same
-- addons and no addon is duplicate.
added = AIO.AddAddon([path, name])
-- The way this is designed to be used is at the top of an addon file so that the
-- file is added and not run if we are on server, and just run if we are on client:
if AIO.AddAddon() then
    return
end

-- Similar to AddAddon - Adds 'code' to the addons sent to players. The code is trimmed
-- according to settings in AIO.lua. The addon is cached on client side and will
-- be updated only when needed. 'name' is an unique name for the addon, usually
-- you can use the file name or addon name there. Do note that short names are
-- better since they are sent back and forth to indentify files.
-- The function only exists on server side.
-- You should call this function only on startup to ensure everyone gets the same
-- addons and no addon is duplicate.
AIO.AddAddonCode(name, code)

-- Triggers the handler function that has the name 'handlername' from the handlertable
-- added with AIO.AddHandlers(name, handlertable) for the 'name'.
-- Can also trigger a function registered with AIO.RegisterEvent(name, func)
-- All triggered handlers have parameters handler(player, ...) where varargs are
-- the varargs in AIO.Handle or msg.Add
-- This function is a shorthand for AIO.Msg():Add(name, handlername, ...):Send()
-- For efficiency favour creating messages once and sending them rather than creating
-- them over and over with AIO.Handle().
-- The server side version.
AIO.Handle(player, name, handlername[, ...])
-- The client side version.
AIO.Handle(name, handlername[, ...])

-- Adds a table of handler functions for the specified 'name'. When a message like:
-- AIO.Handle(name, "HandlerName", ...) is received, the handlertable["HandlerName"]
-- will be called with player and varargs as parameters.
-- Returns the passed 'handlertable'.
-- AIO.AddHandlers uses AIO.RegisterEvent internally, so same name can not be used on both.
handlertable = AIO.AddHandlers(name, handlertable)

-- Adds a new callback function that is called if a message with the given
-- name is recieved. All parameters the sender sends in the message will
-- be passed to func when called.
-- Example message: AIO.Msg():Add(name, ...):Send()
-- AIO.AddHandlers uses AIO.RegisterEvent internally, so same name can not be used on both.
AIO.RegisterEvent(name, func)

-- Adds a new function that is called when the initial message is sent to the player.
-- The function is called before sending and the initial message is passed to it
-- along with the player if available: func(msg[, player])
-- In the function you can modify the passed msg and/or return a new one to be
-- used as initial message. Only on server side.
-- This can be used to send for example initial values (like player stats) for the addons.
-- If dynamic loading is preferred, you can use the messaging API to request the values
-- on demand also.
AIO.AddOnInit(func)

-- Key is a key for a variable in the global table _G.
-- The variable is stored when the player logs out and will be restored
-- when he logs back in before the addon codes are run.
-- These variables are account bound.
-- Only exists on client side and you should call it only once per key.
-- All saved data is saved to client side.
AIO.AddSavedVar(key)

-- Key is a key for a variable in the global table _G.
-- The variable is stored when the player logs out and will be restored
-- when he logs back in before the addon codes are run.
-- These variables are character bound.
-- Only exists on client side and you should call it only once per key.
-- All saved data is saved to client side.
AIO.AddSavedVarChar(key)

-- Makes the addon frame save it's position and restore it on login.
-- If char is true, the position saving is character bound, otherwise account bound.
-- Only exists on client side and you should call it only once per frame.
-- All saved data is saved to client side.
AIO.SavePosition(frame[, char])

-- AIO message class:
-- Creates and returns a new AIO message that you can append stuff to and send to
-- client or server. Example: AIO.Msg():Add("MyHandlerName", param1, param2):Send(player)
-- These messages handle all client-server communication.
msg = AIO.Msg()

-- The name is used to identify the handler function on receiving end.
-- A handler function registered with AIO.RegisterEvent(name, func)
-- will be called on receiving end with the varargs.
function msgmt:Add(name, ...)

-- Appends messages to eachother, returns self
msg = msg:Append(msg2)

-- Sends the message, returns self
-- Server side version - sends to all players passed
msg = msg:Send(player, ...)
-- Client side version - sends to server
msg = msg:Send()

-- Returns true if the message has something in it
hasmsg = msg:HasMsg()

-- Returns the message as a string
msgstr = msg:ToString()

-- Erases the so far built message and returns self
msg = msg:Clear()

-- Assembles the message string from added and appended data. Mainly for internal use.
-- Returns self
msg = msg:Assemble()
]=]

-- Try to avoid multiple versions of AIO
assert(not AIO, "AIO is already loaded. Possibly different versions!")

----------------------------------
-- Server-Client messaging config:
----------------------------------

-- When developing an addon it is advised to set AIO_ENABLE_PCALL false and AIO_CODE_OBFUSCATE to false
-- Or alternatively set AIO_ENABLE_PCALL true, AIO_ENABLE_TRACEBACK to true and AIO_CODE_OBFUSCATE to false
-- The defaults are recommended for normal use

-- Enables some additional prints for debugging
local AIO_ENABLE_DEBUG_MSGS = false -- default false

-- Enables pcall to silence errors and continue running normally when an error occurs
-- If AIO_ENABLE_PCALL is true, errors are printed and running is continued
-- If AIO_ENABLE_PCALL is false, pcall is not used and errors occur normally
-- Erroring out can be useful for debugging scripts
local AIO_ENABLE_PCALL = true -- default true

-- Enables using debug.traceback as the error handler to help locating errors
-- on server side. Make sure you have default Eluna extensions in place.
-- On client side uses _ERRORMESSAGE function to output errors with trace.
-- Requires AIO_ENABLE_PCALL to be true
local AIO_ENABLE_TRACEBACK = false -- default false

-- prints all messages
local AIO_ENABLE_MSGPRINT = false -- default false

-- Max VM instructions to do before timeout
-- Attempts to avoid server freeze on bad code and or user
-- Use 0 to disable timeout
-- Server side only
local AIO_TIMEOUT_INSTRUCTIONCOUNT = 1e8 -- default 1e8

-- Amount of data to store per character at maximum
-- Attempts to avoid consuming ram
-- Server side only
local AIO_MSG_CACHE_SPACE = 5e5 -- bytes -- default 5e5

-- Time to wait for a message to arrive
-- Attempts to avoid consuming ram and storing incomplete messages
local AIO_MSG_CACHE_TIME = 15*1000 -- ms -- default 15*1000

-- Delay between checking for outdated messages
local AIO_MSG_CACHE_DELAY = 5*1000 -- ms -- default 5*1000

-- Delay between possible sending of full addon code
-- User can potentially request the full addon list repeatedly
-- this limits the ability to do that (avoid lagging from bad user)
-- Server side only
local AIO_UI_INIT_DELAY = 5*1000 -- ms -- default 5*1000

-- Setting to enable and disable LZW compressing for addons
-- Server side only
local AIO_MSG_COMPRESS = true -- default true

-- Setting to enable and disable obfuscation for code to reduce size
-- Note that error messages will not have correct line numbers since obfuscation rearranage the code
-- for debugging purposes it is recommended to disable this option
-- Server side only
local AIO_CODE_OBFUSCATE = true -- default true

-- Setting to send client errors to server
-- Client must have AIO_ENABLE_PCALL enabled
-- Client side only
local AIO_ERROR_LOG = false -- default false

----------------------------------

----------------------------------

local assert = assert
local type = type
local tostring = tostring
local pairs = pairs
local ipairs = ipairs
local ssub = string.sub
local match = string.match
local ceil = ceil or math.ceil
local floor = floor or math.floor
local sbyte = strbyte or string.byte
local schar = string.char
local tconcat = table.concat
local select = select
local pcall = pcall
local xpcall = xpcall
-- Some lua compatibility between 5.1 and 5.2
loadstring = loadstring or load -- loadstring name varies with lua 5.1 and 5.2
unpack = unpack or table.unpack -- unpack place varies with lua 5.1 and 5.2
-- server client compatibility
local AIO_GetTime = os and os.time or function() return GetTime()*1000 end
local AIO_GetTimeDiff = os and os.difftime or function(_now, _then) return _now-_then end

-- boolean value to define whether we are on server or client side
local AIO_SERVER = type(GetLuaEngine) == "function"
-- Client must have same version (basically same AIO file)
local AIO_VERSION = 1.74
-- ID characters for client-server messaging
local AIO_ShortMsg          = schar(1)..schar(1)
local AIO_Compressed        = 'C'
local AIO_Uncompressed      = 'U'
local AIO_Prefix            = "AIO"
AIO_Prefix = ssub((AIO_Prefix), 1, 16) -- shorten to max allowed
local AIO_ServerPrefix = ssub(("S"..AIO_Prefix), 1, 16)
local AIO_ClientPrefix = ssub(("C"..AIO_Prefix), 1, 16)
assert(#AIO_ServerPrefix == #AIO_ClientPrefix)
-- Client can send only 255 max size messages, but server can send more
-- on different patches the limit varies, on 3.3.5 it is exactly 3004 and on cataclysm 2^23
-- thus we use 2560 that is about 10 times more data and below both max values. Too high value can crash client.
-- Change if you need to :)
local AIO_MsgLen = (AIO_SERVER and 2560 or 255) -1 -#AIO_ServerPrefix -#AIO_ShortMsg -- remove \t, prefix, msg ID
local MSG_MIN = 1
local MSG_MAX = 2^16-767

-- AIO main table
AIO =
{
    -- AIO flavour functions
    unpack = unpack,
}

local AIO = AIO
-- Client side table containing frames that need to have their position saved
local AIO_SAVEDFRAMES = {}
-- Client side tables that contain keys to _G table for saved variables
-- you should add your variables here with AIO.AddSavedVar(key) or AIO.AddSavedVarChar(key)
local AIO_SAVEDVARS = {}
local AIO_SAVEDVARSCHAR = {}
-- Client side flag for noting if the client has been inited or not
local AIO_INITED = false
-- Server and Client side functions to execute on AIO messages
local AIO_HANDLERS = {}
-- Server side functions to execute when an init msg is received
local AIO_INITHOOKS = {}
-- Server and Client side custom coded handlers for incoming data
local AIO_BLOCKHANDLES = {}
-- A server side table for correct order of addons to send
-- you should add all addon code here with AIO.AddAddon
local AIO_ADDONSORDER = {}

-- Dependencies
local LibWindow
local LuaSrcDiet
local NewQueue = NewQueue or require("queue")
local Smallfolk = Smallfolk or require("smallfolk")
local lualzw = lualzw or require("lualzw")
if AIO_SERVER then
    LuaSrcDiet = require("LuaSrcDiet")
else
    LibWindow = LibStub("LibWindow-1.1")
end

-- Returns true if we are on server
function AIO.IsServer()
    return AIO_SERVER
end

-- Returns AIO version - note the type is not guaranteed to be a number
function AIO.GetVersion()
    return AIO_VERSION
end

-- Converts an uint16 number to string (2 chars)
-- Note that this escapes using \0 character so the full uint16 range is not usable
local function AIO_16tostring(uint16)
    -- split 16bit to 2 8bit parts but without \0
    assert(uint16 <= 2^16-767, "Too high value")
    assert(uint16 >= 0, "Negative value")
    local high = floor(uint16 / 254)
    local l = high +1
    local r = uint16 - high * 254 +1
    return schar(l)..schar(r)
end

-- Converts a string (2 chars) to uint16 number
-- Note that the chars can not be \0 character so the full uint16 range is not usable
local function AIO_stringto16(str)
    local l = sbyte(ssub(str, 1,1)) -1
    local r = sbyte(ssub(str, 2,2)) -1
    local val = l*254 + r
    assert(val <= 2^16-767, "Too high value")
    assert(val >= 0, "Negative value")
    return val
end

-- Resets AIO saved variables on client side
local AIO_RESET
if not AIO_SERVER then
    function AIO_RESET()
        AIO_SAVEDVARS = nil
        AIO_SAVEDVARSCHAR = nil
        AIO_sv_Addons = nil
        AIO_SAVEDFRAMES = {}
    end
end

-- Used to print debug messages if AIO_ENABLE_DEBUG_MSGS is true
function AIO_debug(...)
    if AIO_ENABLE_DEBUG_MSGS then
        print("AIO:", ...)
    end
end

-- returns the amount of varargs from passed varargs
local function AIO_extractN(...)
    return select("#", ...), ...
end

-- Calls function f with parameters ... with pcall
-- Shows errors with print or AIO_debug
local function AIO_pcall(f, ...)
    assert(type(f) == 'function')
    if not AIO_ENABLE_PCALL then
        return f(...)
    end
    local data
    if AIO_SERVER and AIO_ENABLE_TRACEBACK and debug.traceback then
        data = {AIO_extractN(xpcall(f, debug.traceback, ...))}
    else
        data = {AIO_extractN(pcall(f, ...))}
    end
    if not data[2] then
        if AIO_SERVER then
            AIO_debug(data[3])
        else
            if AIO_ERROR_LOG then
                AIO.Handle("AIO", "Error", data[3])
            end
            if AIO_ENABLE_TRACEBACK then
                _ERRORMESSAGE(data[3])
            else
                print(data[3])
            end
        end
        return
    end
    return unpack(data, 3, data[1]+1)
end

-- Reads a file at given absolute or relative to server root path
-- and returns the full file contents as a string
local function AIO_ReadFile(path)
    AIO_debug("Reading a file")
    assert(type(path) == 'string', "#1 string expected")
    local f = assert(io.open(path, "rb"))
    local str = f:read("*all")
    f:close()
    return str
end

-- player data handler
local plrdata = {}
local removeque = NewQueue()
local function RemoveData(guid, msgid)
    local pdata = plrdata[guid]
    if pdata then
        if msgid then
            local data = pdata[msgid]
            if data then
                pdata[msgid] = nil
                pdata.ramque:gettable()[data.ramquepos] = nil
                removeque:gettable()[data.remquepos] = nil
            end
        else
            local que = pdata.ramque:gettable()
            local l, r = pdata.ramque:getrange()
            for i = l, r do
                if que[i] then
                    removeque:gettable()[que[i].remquepos] = nil
                end
            end
            plrdata[guid] = nil
        end
    end
end
local function ProcessRemoveQue()
    if removeque:empty() then
        return
    end
    local now = AIO_GetTime()
    local l, r = removeque:getrange()
    for i = l, r do
        local v = removeque:popleft()
        if v then
            if AIO_GetTimeDiff(now, v.stamp) < AIO_MSG_CACHE_TIME then
                AIO_debug("removing outdated incomplete message")
                removeque:pushleft(v)
                break
            end
            RemoveData(v.guid, v.id)
        end
    end
end
if AIO_SERVER then
    CreateLuaEvent(ProcessRemoveQue, AIO_MSG_CACHE_DELAY, 0)
else
    local frame = CreateFrame("Frame")
    local timer = AIO_MSG_CACHE_DELAY
    local function ONUPDATE(self, diff)
        if timer > diff then
            timer = timer - diff
        else
            ProcessRemoveQue()
            timer = AIO_MSG_CACHE_DELAY
        end
    end
    frame:SetScript("OnUpdate", ONUPDATE)
end
-- Erase data on logout
if AIO_SERVER then
    local function Erase(event, player)
        RemoveData(player:GetGUIDLow())
    end
    RegisterPlayerEvent(4, Erase)
end

-- Selects a method to send the string to the player depending on whether
-- running on client or server side. From client to server no player needed
local function AIO_SendAddonMessage(msg, player)
    if AIO_SERVER then
        -- server -> client
        player:SendAddonMessage(AIO_ServerPrefix, msg, 7, player)
    else
        -- client -> server
        SendAddonMessage(AIO_ClientPrefix, msg, "WHISPER", UnitName("player"))
    end
end

-- Sends a string to given players (vararg).
-- Can have one or more receiver players (no receivers when sending from client -> server)
-- Splits too long messages into smaller pieces
local function AIO_Send(msg, player, ...)
    assert(type(msg) == "string", "#1 string expected")
    assert(not AIO_SERVER or type(player) == 'userdata', "#2 player expected")

    AIO_debug("Sending message length:", #msg)
    if AIO_ENABLE_MSGPRINT then
        print("sent:", msg)
    end

    -- split message to 255 character packets if needed (send long message)
    if #msg <= AIO_MsgLen then
        -- Send short <= AIO_MsgLen msg
        AIO_SendAddonMessage(AIO_ShortMsg..msg, player)
    else
        -- Send long > AIO_MsgLen msg

        local guid = AIO_SERVER and player:GetGUIDLow() or 1
        if not plrdata[guid] then
            plrdata[guid] = {
                stored = 0,
                ramque = NewQueue(),
                MSG_GUID = MSG_MIN,
            }
        end
        local pdata = plrdata[guid]

        -- the chars can not contain \0
        -- 16bit -> Message ID -- 0 reserved for identifying short msg
        -- 16bit -> Number of parts (should be > 1)
        -- 16bit -> Part ID
        -- Rest -> Message String

        -- msglen - 4 bits for header data, messageid is already substracted
        local msglen = (AIO_MsgLen-4)
        -- Calculate amount of messages to send
        local parts = ceil(#msg / msglen)
        -- assemble header
        local header = AIO_16tostring(pdata.MSG_GUID)..AIO_16tostring(parts)

        -- update guid
        if pdata.MSG_GUID >= MSG_MAX then
            pdata.MSG_GUID = MSG_MIN
        else
            pdata.MSG_GUID = pdata.MSG_GUID+1
        end

        -- send messages
        for i = 1, parts do
            AIO_SendAddonMessage(header..AIO_16tostring(i)..ssub(msg, ((i-1)*msglen)+1, (i*msglen)), player)
        end
    end

    -- More than one receiver, mass send message
    if ... then
        for i = 1, select('#',...) do
            AIO_Send(msg, select(i, ...))
        end
    end
end

-- Message class metatable
local msgmt = {}
function msgmt.__index(tbl, key)
    return msgmt[key]
end

-- Add a new block to message and returns self
-- A block is a chunk of data identified by a string name
-- blocks are sent between server and client and handled on the receiving end
-- by block handlers. Blockhandlers are functions you can assign to
-- a specific name as a handler with AIO.RegisterEvent(name, func)
-- The All values in the block after it's name will be passed to the handler
-- function in same order.
function msgmt:Add(Name, ...)
    assert(Name, "#1 Block must have name")
    self.params[#self.params+1] = {select('#', ...), Name, ...}
    self.assemble = true
    return self
end

-- Function to append messages together, returns self
-- Example AIO.Msg():Append(msg):Append(msg2):Send(...)
function msgmt:Append(msg2)
    assert(type(msg2) == 'table', "#1 table expected")
    for i = 1, #msg2.params do
        assert(type(msg2.params[i]) == 'table', "#1["..i.."] table expected")
        self.params[#self.params+1] = msg2.params[i]
    end
    self.assemble = true
    return self
end

-- Assembles the message string from stored data
function msgmt:Assemble()
    if not self.assemble then
        return self
    end
    self.MSG = Smallfolk.dumps(self.params)
    self.assemble = false
    return self
end

-- Function to send the message to given players
function msgmt:Send(player, ...)
    assert(not AIO_SERVER or player, "#1 player is nil")
    AIO_Send(self:ToString(), player, ...)
    return self
end

-- Erases the so far built message and returns self
function msgmt:Clear()
    for i = 1, #self.params do
        self.params[i] = nil
    end
    self.MSG = nil
    self.assemble = false
    return self
end

-- Returns the message string or an empty string
function msgmt:ToString()
    return self:Assemble().MSG
end

-- Returns true if the message has something in it
function msgmt:HasMsg()
    return #self.params > 0
end

-- Creates and returns a new message that you can append stuff to and send to client or server
-- Example: AIO.Msg():Add("MyHandlerName", param1, param2):Send(player)
function AIO.Msg()
    local msg = {params = {}, MSG = nil, assemble = false}
    setmetatable(msg, msgmt)
    return msg
end

-- Calls the handler for block, see AIO.RegisterEvent
-- for adding handlers for blocks
local preinitblocks = {}
local function AIO_HandleBlock(player, data, skipstored)
    local HandleName = data[2]
    assert(HandleName, "Invalid handle, no handle name")

    if not AIO_SERVER and not AIO_INITED and (HandleName ~= 'AIO' or data[3] ~= 'Init') then
        -- store blocks received before initialization
        preinitblocks[#preinitblocks+1] = data
        AIO_debug("Received block before Init:", HandleName, data[1], data[3])
        return
    end

    local handledata = AIO_BLOCKHANDLES[HandleName]
    if not handledata then
        error("Unknown AIO block handle: '"..tostring(HandleName).."'")
    end

    -- found the block handler and arguments match the format.
    -- call the block handler
    if AIO_SERVER and data[1] > 15 then
        error("Received AIO block with over 15 arguments. Try using tables instead")
        return
    end
    handledata(player, unpack(data, 3, data[1]+2))

    if not skipstored and not AIO_SERVER and AIO_INITED and HandleName == 'AIO' and data[3] == 'Init' then
        -- handle stored blocks after initialization, if they are not init messages
        for i = 1, #preinitblocks do
            AIO_HandleBlock(player, preinitblocks[i], true)
            preinitblocks[i] = nil
        end
    end
end

-- Extracts blocks from assembled addon messages
local curmsg = ''
local function AIO_Timeout()
    error(string.format("AIO Timeout. Your code ran over %s instructions with message:\n%s", ''..AIO_TIMEOUT_INSTRUCTIONCOUNT, (curmsg or 'nil')))
end
local function _AIO_ParseBlocks(msg, player)
    if AIO_SERVER and AIO_TIMEOUT_INSTRUCTIONCOUNT > 0 then
        curmsg = msg
        debug.sethook(AIO_Timeout, "", AIO_TIMEOUT_INSTRUCTIONCOUNT)
    end

    AIO_debug("Received messagelength:", #msg)
    if AIO_ENABLE_MSGPRINT then
        print("received:", msg)
    end

    -- deserialize the message
    local data = AIO_pcall(Smallfolk.loads, msg, #msg)
    if not data or type(data) ~= 'table' then
        AIO_debug("Received invalid message - data not a table")
        return
    end

    -- Handle parsing of all blocks
    for i = 1, #data do
        -- Using pcall here so errors wont stop handling other blocks in the msg
        AIO_pcall(AIO_HandleBlock, player, data[i])
    end

    if AIO_SERVER and AIO_TIMEOUT_INSTRUCTIONCOUNT > 0 then
        debug.sethook()
    end
end
local function AIO_ParseBlocks(msg, player)
    AIO_pcall(_AIO_ParseBlocks, msg, player)
end

-- Handles cleaning and assembling the messages received
-- Messages can be 255 characters long, so big messages will be split
local function _AIO_HandleIncomingMsg(msg, player)
    -- Received a long message part (msg split into 255 character parts)
    local msgid = ssub(msg, 1,2)

    if msgid == AIO_ShortMsg then
        -- Received <= 255 char msg, direct parse, take out the msg tag first
        AIO_ParseBlocks(ssub(msg, 3), player)
        return
    end

    -- the chars can not contain \0
    -- 16bit -> Message ID -- 0 reserved for identifying short msg
    -- 16bit -> Number of parts (should be > 1)
    -- 16bit -> Part ID
    -- Rest -> Message String

    if #msg < 3*2 then
        return
    end

    local messageId = AIO_stringto16(msgid)
    local parts = AIO_stringto16(ssub(msg, 3,4))
    local partId = AIO_stringto16(ssub(msg, 5,6))
    if partId <= 0 or partId > parts then
        error("received long message with invalid amount of parts. id, parts: "..partId.." "..parts)
        return
    end

    msg = ssub(msg, 7)

    -- guid is used to store information about long messages for specific player
    local guid = AIO_SERVER and player:GetGUIDLow() or 1

    if not plrdata[guid] then
        plrdata[guid] = {
            stored = 0,
            ramque = NewQueue(),
            MSG_GUID = MSG_MIN,
        }
    end
    local pdata = plrdata[guid]
    pdata[messageId] = pdata[messageId] or {}
    local data = pdata[messageId]

    -- Different message with same ID, scrap previous message (probably reloaded UI)
    -- Or new message so parts is nil
    if not data.parts or data.parts.n ~= parts then
        if data.parts then
            for i = 0, data.parts.n do
                data.parts[i] = nil
            end
        end
        data.guid = guid
        data.parts = {n=parts}
        data.id = messageId
        data.stamp = AIO_GetTime()
        data.remquepos = removeque:pushright(data)
        data.ramquepos = pdata.ramque:pushright(data)
    end

    data.parts[partId] = msg

    pdata.stored = pdata.stored + #msg
    if AIO_SERVER and pdata.stored > AIO_MSG_CACHE_SPACE then
        local l, r = pdata.ramque:getrange()
        for i = l, r-1 do -- -1 for leaving at least one message
            -- remove message from stores leaving it for GC
            local msgdata = pdata.ramque:popleft()
            if msgdata then
                removeque:gettable()[msgdata.remquepos] = nil
                pdata[msgdata.id] = nil
                -- count the data it holds and substract from stored data
                for j = 1, msgdata.parts.n do
                    if msgdata.parts[j] then
                        pdata.stored = pdata.stored - #msgdata.parts[j]
                    end
                end
                -- check if enough freed to hold latest message in the cache
                if pdata.stored <= AIO_MSG_CACHE_SPACE then
                    break
                end
            end
        end
        -- if still error even though tried freeing all memory possible to free
        -- throw error and clear cache
        if pdata.stored > AIO_MSG_CACHE_SPACE then
            RemoveData(guid)
            error("AIO_MSG_CACHE_SPACE is too small for received message")
            return
        end
    end

    -- Has all parts, process
    if #data.parts == data.parts.n then
        local cat = tconcat(data.parts)
        RemoveData(guid, messageId)
        AIO_ParseBlocks(cat, player)
    end
end
local function AIO_HandleIncomingMsg(msg, player)
    AIO_pcall(_AIO_HandleIncomingMsg, msg, player)
end

-- Adds a new callback function for AIO that is called if
-- a block with the same name is recieved.
-- All parameters the client sends will be passed to func when called
-- Only one function can be a handler for one name (subject for change)
function AIO.RegisterEvent(name, func)
    assert(name ~= nil, "name of the registered event expected not nil")
    assert(type(func) == "function", "callback function must be a function")
    assert(not AIO_BLOCKHANDLES[name], "an event is already registered for the name: "..name)
    AIO_BLOCKHANDLES[name] = func
end

-- Adds a table of handler functions for the specified name.
-- You can fill a table with functions and use this to add them for a name.
-- Then when a message like AIO.Msg():Add("MyName", "HandlerName"):Send()
-- is received, the handlertable["HandlerName"] will be executed with player and additional params passed to the block.
-- Returns the passed table
function AIO.AddHandlers(name, handlertable)
    assert(name ~= nil, "#1 expected not nil")
    assert(type(handlertable) == 'table', "#2 a table expected")

    for k,v in pairs(handlertable) do
        assert(type(v) == 'function', "#2 a table of functions expected, found a "..type(v).." value")
    end

    local function handler(player, key, ...)
        if key and handlertable[key] then
            handlertable[key](player, ...)
        end
    end
    AIO.RegisterEvent(name, handler)
    return handlertable
end

-- Adds the current file as an AIO sent addon.
-- Can be used from server and client, but on client does nothing.
-- You can provide path and/or name of the lua file to add, but if
-- omitted the file the function is executed in will be used as path
-- and the path's or given path's file name will be used.
-- Returns true if addon was added
function AIO.AddAddon(path, name)
    if AIO_SERVER then
        path = path or debug.getinfo(2, 'S').source:sub(2)
        name = name or match(path, "([^/]*)$")
        local code = AIO_ReadFile(path)
        AIO.AddAddonCode(name, code)
        AIO_debug("Added addon path&name:", path, name)
        return true
    end
end

if AIO_SERVER then
    -- A shorthand for sending a message for a handler.
    function AIO.Handle(player, name, handlername, ...)
        assert(type(player) == 'userdata', "#1 player expected")
        assert(name ~= nil, "#2 expected not nil")
        return AIO.Msg():Add(name, handlername, ...):Send(player)
    end

    -- Adds the addon code to the sent addons on login.
    -- The addon code is trimmed according to settings at top of this file.
    -- The addon is cached on client side and will be updated if needed.
    -- name is an unique ID for the addon, usually you can use the file name or addon name there
    -- Do note that short names are better since they are sent back and forth to indentify files
    local crc32 = require("crc32lua").crc32
    function AIO.AddAddonCode(name, code)
        assert(type(name) == 'string', "#1 string expected")
        assert(type(code) == 'string', "#2 string expected")
        if AIO_CODE_OBFUSCATE then
            code = LuaSrcDiet(code, 3)
        end
        if AIO_MSG_COMPRESS then
            code = AIO_Compressed..assert(lualzw.compress(code))
        else
            code = AIO_Uncompressed..code
        end
        AIO_ADDONSORDER[#AIO_ADDONSORDER+1] = {name=name, crc=crc32(code), code=code}
    end

    -- Adds a new function that is called when an init message
    -- is about to be sent by server. The function is called before sending and
    -- the message is passed to it along with the player if available:
    -- func(msg[, player])
    -- you can modify the passed message and or return a new one
    function AIO.AddOnInit(func)
        assert(type(func) == 'function', "#1 function expected")
        table.insert(AIO_INITHOOKS, func)
    end

    -- This restricts player's ability to request the initial UI to some set time delay
    local timers = {}
    local function RemoveInitTimer(eventid, playerguid)
        if type(playerguid) == "number" then
            timers[playerguid] = nil
        end
    end
    -- This handles sending initial UI to player.
    -- The Client sends a request to the server for the addons along with it's cached addon data.
    -- Then the server checks what files it has to send back and what it has to remove from the client's cache.
    -- Then after server sends the required data to client, the client will one by one execute the addons
    -- in the same order as they are sent from the server.
    local versionmsg = AIO.Msg():Add("AIO", "Init", AIO_VERSION)
    function AIO_HANDLERS.Init(player, version, clientdata)
        -- check that the player is not on cooldown for init calling
        local guid = player:GetGUIDLow()
        if timers[guid] then
            return
        end

        -- make a new cooldown for init calling
        timers[guid] = CreateLuaEvent(function(e) RemoveInitTimer(e, guid) end, AIO_UI_INIT_DELAY, 1) -- the timer here (AIO_UI_INIT_DELAY) is the min time in ms between inits the player can do

        -- Check for bad version and send version back for error directly
        if version ~= AIO_VERSION then
            versionmsg:Send(player)
            return
        end

        local istable = type(clientdata) == 'table'

        local addons = {}
        local cached = {}
        for i = 1, #AIO_ADDONSORDER do
            local data = AIO_ADDONSORDER[i]
            local clientcrc = istable and clientdata[data.name] or nil
            if clientcrc and clientcrc == data.crc then
                -- valid - send name only
                cached[i] = data.name
            else
                -- not cached or outdated - send new
                addons[i] = data
            end
        end

        local initmsg = AIO.Msg():Add("AIO", "Init", AIO_VERSION, #AIO_ADDONSORDER, addons, cached)

        for k,v in ipairs(AIO_INITHOOKS) do
            initmsg = v(initmsg, player) or initmsg
        end

        initmsg:Send(player)
    end

    -- Handler that catches client errors
    -- can be used to log client errors to server
    function AIO_HANDLERS.Error(player, errmsg)
        if not AIO_ERROR_LOG or type(errmsg) ~= 'string' then
            return
        end
        PrintInfo(errmsg)
    end

    -- An addon message event handler for the lua engine
    -- If the message data is correct, move the message forward to the AIO message handler.
    local function ONADDONMSG(event, sender, Type, prefix, msg, target)
        if prefix == AIO_ClientPrefix and tostring(sender) == tostring(target) and #msg < 510 then
            AIO_HandleIncomingMsg(msg, sender)
        end
    end
    RegisterServerEvent(30, ONADDONMSG)

    for k,v in ipairs(GetPlayersInWorld()) do
        AIO.Handle(v, "AIO", "ForceReload")
    end

else

    -- A shorthand for sending a message for a handler.
    function AIO.Handle(name, handlername, ...)
        assert(name ~= nil, "#1 expected not nil")
        return AIO.Msg():Add(name, handlername, ...):Send()
    end

    -- Key is a key for a variable in the global table _G
    -- The variable is stored when the player logs out and will be restored
    -- when he logs back in before the addon codes are run
    -- these variables are account bound
    function AIO.AddSavedVar(key)
        assert(key ~= nil, "#1 table key expected")
        AIO_SAVEDVARS[key] = true
    end

    -- Key is a key for a variable in the global table _G
    -- The variable is stored when the player logs out and will be restored
    -- when he logs back in before the addon codes are run
    -- these variables are character bound
    function AIO.AddSavedVarChar(key)
        assert(key ~= nil, "#1 table key expected")
        AIO_SAVEDVARSCHAR[key] = true
    end

    AIO_FRAMEPOSITIONS = AIO_FRAMEPOSITIONS or {}
    AIO.AddSavedVar("AIO_FRAMEPOSITIONS")
    AIO_FRAMEPOSITIONSCHAR = AIO_FRAMEPOSITIONSCHAR or {}
    AIO.AddSavedVarChar("AIO_FRAMEPOSITIONSCHAR")
    -- Makes the frame save it's position over relog
    -- If char is true, the position saving is character bound, otherwise account bound
    function AIO.SavePosition(frame, char)
        assert(frame:GetName(), "Called AIO.SavePosition on a nameless frame")
        local store = char and AIO_FRAMEPOSITIONSCHAR or AIO_FRAMEPOSITIONS
        if not store[frame:GetName()] then
            store[frame:GetName()] = {}
        end
        LibWindow.RegisterConfig(frame, store[frame:GetName()])
        LibWindow.RestorePosition(frame)
        LibWindow.SavePosition(frame)
        table.insert(AIO_SAVEDFRAMES, frame)
    end

    -- A client side event handler
    -- Passes the incoming message to AIO message handler if it is valid
    local function ONADDONMSG(self, event, prefix, msg, Type, sender)
        if prefix == AIO_ServerPrefix then
            if event == "CHAT_MSG_ADDON" and sender == UnitName("player") then
                -- Normal AIO message handling from addon messages
                AIO_HandleIncomingMsg(msg, sender)
            end
        end
    end
    local MsgReceiver = CreateFrame("Frame")
    MsgReceiver:RegisterEvent("CHAT_MSG_ADDON")
    MsgReceiver:SetScript("OnEvent", ONADDONMSG)

    -- A block handler for Init name, checks the version number and errors out if needed
    -- On wrong version prevents handling any more messages
    -- Stores new and changed addons to cache and runs the addons from cache
    -- Also removes removed and outdated addons
    local function RunAddon(name)
        -- Check if code is compressed and uncompress if needed
        local code = AIO_sv_Addons[name] and AIO_sv_Addons[name].code
        assert(code, "Addon doesnt exist")
        local compression, compressedcode = ssub(code, 1, 1), ssub(code, 2)
        if compression == AIO_Compressed then
            compressedcode = assert(lualzw.decompress(compressedcode))
        end
        assert(loadstring(compressedcode, name))()
    end
    function AIO_HANDLERS.Init(player, version, N, addons, cached)
        if(AIO_VERSION ~= version) then
            AIO_INITED = true
            -- stop handling any incoming messages
            AIO_HandleBlock = function() end
            print("You have AIO version "..AIO_VERSION.." and the server uses "..(version or "nil")..". Get the same version")
            return
        end

        assert(type(N) == 'number')
        assert(type(addons) == 'table')
        assert(type(cached) == 'table')

        local validAddons = {}
        for i = 1, N do
            local name
            if addons[i] then
                name = addons[i].name
                AIO_sv_Addons[name] = addons[i]
                validAddons[name] = true
            elseif cached[i] then
                name = cached[i]
                validAddons[name] = true
            else
                error("Unexpected behavior, try /aio reset")
            end

            AIO_pcall(RunAddon, name)
        end

        local invalidAddons = {}
        for name, data in pairs(AIO_sv_Addons) do
            if not validAddons[name] then
                invalidAddons[#invalidAddons+1] = name
            end
        end

        for i = 1, #invalidAddons do
            AIO_sv_Addons[invalidAddons[i]] = nil
        end

        AIO_INITED = true
        print("Initialized AIO version "..AIO_VERSION..". Type '/aio help' for commands")
    end

    -- Forces reload of UI for user on next action
    function AIO_HANDLERS.ForceReload(player)
        local frame = CreateFrame("BUTTON")
        frame:SetToplevel(true)
        frame:SetFrameStrata("TOOLTIP")
        frame:SetFrameLevel(100)
        frame:SetAllPoints(WorldFrame)
        -- frame.texture = frame:CreateTexture()
        -- frame.texture:SetAllPoints(frame)
        -- frame.texture:SetTexture(0.1, 0.1, 0.1, 0.5)
        frame:SetScript("OnClick", ReloadUI)
        print("AIO: Force reloading UI")
        message("AIO: Force reloading UI")
    end

    -- Forces reset of UI for user on next action
    function AIO_HANDLERS.ForceReset(player)
        AIO_RESET()
        AIO_HANDLERS.ForceReload(player)
    end

    local frame = CreateFrame("FRAME") -- Need a frame to respond to events
    frame:RegisterEvent("ADDON_LOADED") -- Fired when saved variables are loaded
    frame:RegisterEvent("PLAYER_LOGOUT") -- Fired when about to log out

    -- message to request initialization of UI
    function frame:OnEvent(event, addon)
        if event == "ADDON_LOADED" and addon == "AIO_Client" then
            -- Register addon channel on cata+
            local _,_,_, tocversion = GetBuildInfo()
            if tocversion and tocversion >= 40100 and RegisterAddonMessagePrefix then
                RegisterAddonMessagePrefix("C"..AIO_Prefix)
            end

            -- Our saved variables are ready at this point. If there is no save, they will be nil
            -- Must be before any other addon action like sending init request
            if type(AIO_sv) ~= 'table' then
                AIO_sv = {} -- This is the first time this addon is loaded; initialize the var
            end
            if type(AIO_sv_char) ~= 'table' then
                AIO_sv_char = {} -- This is the first time this addon is loaded; initialize the var
            end
            if type(AIO_sv_Addons) ~= 'table' then
                AIO_sv_Addons = {} -- This is the first time this addon is loaded; initialize the var
            end

            -- Restore addon saved variables to global namespace
            -- Must be before sending init request
            for k,v in pairs(AIO_sv) do
                if _G[k] then
                    AIO_debug("Overwriting global var _G["..k.."] with a saved var")
                end
                _G[k] = v
            end
            for k,v in pairs(AIO_sv_char) do
                if _G[k] then
                    AIO_debug("Overwriting global var _G["..k.."] with a saved character var")
                end
                _G[k] = v
            end

            -- Request initialization of UI if not done yet
            -- works by timer for every second. Timer shut down after inited.
            -- initmsg consists of the version and all known crc codes for cached addons.
            local rem = {}
            local addons = {}
            for name, data in pairs(AIO_sv_Addons) do
                if type(name) ~= 'string' or type(data) ~= 'table' or type(data.crc) ~= 'number' or type(data.code) ~= 'string' then
                    table.insert(rem, name)
                else
                    addons[name] = data.crc
                end
            end
            for _,name in ipairs(rem) do
                AIO_sv_Addons[name] = nil -- remove invalid addons
            end

            local initmsg = AIO.Msg():Add("AIO", "Init", AIO_VERSION, addons)

            local reset = 1
            local timer = reset
            local function ONUPDATE(self, diff)
                if AIO_INITED then
                    self:SetScript("OnUpdate", nil)
                    initmsg = nil
                    reset = nil
                    timer = nil
                    return
                end
                if timer < diff then
                    initmsg:Send()
                    timer = reset
                    reset = reset * 1.5
                else
                    timer = timer - diff
                end
            end
            frame:SetScript("OnUpdate", ONUPDATE)
            -- initmsg:Send()
        elseif event == "PLAYER_LOGOUT" then
            -- On logout we must store all global namespace to saved vars
            AIO_sv = {} -- discard vars that no longer exist
            for key,_ in pairs(AIO_SAVEDVARS or {}) do
                AIO_sv[key] = _G[key]
            end
            AIO_sv_char = {} -- discard vars that no longer exist
            for key,_ in pairs(AIO_SAVEDVARSCHAR or {}) do
                AIO_sv_char[key] = _G[key]
            end

            for k,v in ipairs(AIO_SAVEDFRAMES or {}) do
                LibWindow.SavePosition(v)
            end
        end
    end
    frame:SetScript("OnEvent", frame.OnEvent)
end

-- Adds all handlers from AIO_HANDLERS for the "AIO" msg handler
AIO.AddHandlers("AIO", AIO_HANDLERS)

-- Tables holding the command functions and the help messages
-- both are indexed by the command name. See below for how to add a command and help
local cmds = {}
local helps = {}

-- A print selector
local function pprint(player, ...)
    if player then
        player:SendBroadcastMessage(tconcat({...}, " "))
    else
        print(...)
    end
end

if AIO_SERVER then
    local function OnCommand(event, player, msg)
        msg = msg:lower()
        if ssub(msg, 1, 3) ~= 'aio' then
            return
        end
        msg = ssub(msg, 5)
        if msg and msg ~= "" then
            for k,v in pairs(cmds) do
                if k:find(msg, 1, true) == 1 then
                    v(player)
                    return false
                end
            end
        end
        pprint(player, "Unknown command .aio "..tostring(msg))
        cmds.help(player)
        return false
    end
    RegisterPlayerEvent(42, OnCommand)
else
    SLASH_AIO1 = "/aio"
    function SlashCmdList.AIO(msg)
        local msg = msg:lower()
        if msg and msg ~= "" then
            for k,v in pairs(cmds) do
                if k:find(msg, 1, true) == 1 then
                    v()
                    return
                end
            end
        end
        print("Unknown command /aio "..tostring(msg))
        cmds.help()
    end
end

-- Define slash commands and helps for them
-- triggered with /aio <command name>
helps.help = "prints this list"
function cmds.help(player)
    pprint(player, "Available commands:")
    for k,v in pairs(cmds) do
        pprint(player, (AIO_SERVER and '.' or '/').."aio "..k.." - "..(helps[k] or "no info"))
    end
end
if not AIO_SERVER then
    helps.reset = "resets local AIO cache - clears saved addons and their saved variables and reloads the UI"
    function cmds.reset()
        AIO_RESET()
        ReloadUI()
    end
end
helps.trace = "toggles using debug.traceback or _ERRORMESSAGE"
function cmds.trace(player)
    AIO_ENABLE_TRACEBACK = not AIO_ENABLE_TRACEBACK
    pprint(player, "using trace is now", AIO_ENABLE_TRACEBACK and "on" or "off")
end
helps.debug = "toggles showing of debug messages"
function cmds.debug(player)
    AIO_ENABLE_DEBUG_MSGS = not AIO_ENABLE_DEBUG_MSGS
    pprint(player, "showing debug messages is now", AIO_ENABLE_DEBUG_MSGS and "on" or "off")
end
helps.pcall = "toggles using pcall"
function cmds.pcall(player)
    AIO_ENABLE_PCALL = not AIO_ENABLE_PCALL
    pprint(player, "using pcall is now", AIO_ENABLE_PCALL and "on" or "off")
end
helps.printio = "toggles printing all sent and received messages"
function cmds.printio(player)
    AIO_ENABLE_MSGPRINT = not AIO_ENABLE_MSGPRINT
    pprint(player, "printing IO is now", AIO_ENABLE_MSGPRINT and "on" or "off")
end

return AIO
