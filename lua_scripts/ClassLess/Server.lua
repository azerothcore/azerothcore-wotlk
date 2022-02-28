--  ___ ___ _ __      _____   ___  ___    ___ ___ ___  _   ___ _  __
-- | __| __| |\ \    / / _ \ / _ \|   \  | _ \ __| _ \/_\ / __| |/ /
-- | _|| _|| |_\ \/\/ / (_) | (_) | |) | |   / _||  _/ _ \ (__| ' < 
-- |_| |___|____\_/\_/ \___/ \___/|___/  |_|_\___|_|/_/ \_\___|_|\_\


-- SERVER SECRET
local serverSecret = randomString(128)
local handlerName = "yQ4CiWjHET"

local prices = {10000, 50000, 100000, 150000, 200000, 350000}

--Functions
local function tContains(table, item)
    local index = 1
    while table[index] do
        if (item == table[index]) then
            return true
        end
        index = index + 1
    end
    return nil
end

local function toTable(string)
    local t = {}
    if string ~= "" then
        for i in string.gmatch(string, "([^,]+)") do
            table.insert(t, tonumber(i))
        end
    end
    return t
end

local function toString(tbl)
    local string = ""
    if #tbl > 1 then
        string = table.concat(tbl, ",")
    elseif #tbl == 1 then
        string = tbl[1]
    end
    return string
end

--Init
local AIO = AIO or require("AIO")
local MyHandlers = AIO.AddHandlers(handlerName, {})
local spells, tpells, talents, stats, resets = {}, {}, {}, {}, {}
local AttributesAuraIds = {7464, 7471, 7477, 7468, 7474} -- Strength, Agility, Stamina, Intellect, Spirit

local function SendVars(msg, player, resend)
    local guid = player:GetGUIDLow()
    local sendspells = spells[guid] or ""
    local sendtpells = tpells[guid] or ""
    local sendtalents = talents[guid] or ""
    local sendstats = stats[guid] or "0,0,0,0,0"
    local sendreset = resets[guid] or 0
    AIO.Handle(player, handlerName, "LoadVars", sendspells, sendtpells, sendtalents, sendstats, sendreset, prices, serverSecret, resend)
end

AIO.AddOnInit(SendVars)

--Database Functions
--create DB for GUID
local function DBCreate(guid)
    CharDBQuery("INSERT INTO character_classless VALUES (" .. guid .. ", '', '', '', '0,0,0,0,0', 0)")
end

--Read DB for GUID
local function DBRead(querry)
    local spells, tpells, talents, stats, reset = "", "", "", "0,0,0,0,0", 0
    if querry ~= nil then
        spells = querry:GetString(1)
        tpells = querry:GetString(2)
        talents = querry:GetString(3)
        stats = "0,0,0,0,0"
        reset = querry:GetUInt32(5)
    end
    return spells, tpells, talents, stats, reset
end

--Write DB for GUID
local function DBWrite(guid, entry, value)
    local querry = "UPDATE character_classless SET " .. entry .. "='" .. value .. "' WHERE guid = " .. guid
    CharDBQuery(querry)
    return true
end

--Delete DB for GUID
local function OnDelete(event, guid)
    CharDBQuery("DELETE FROM character_classless WHERE guid = " .. guid)
end

--Utility Functions
local function OnLogin(event, player)
    local guid = player:GetGUIDLow()
    local sp, tsp, tal, sta, reset = "", "", "", "0,0,0,0,0", 0
    local querry = CharDBQuery("SELECT * FROM character_classless WHERE guid = " .. guid)
    if querry == nil then
        DBCreate(guid)
    else
        sp, tsp, tal, sta, reset = DBRead(querry)
    end
    spells[guid] = toTable(sp)
    tpells[guid] = toTable(tsp)
    talents[guid] = toTable(tal)
    stats[guid] = toTable(sta)
    resets[guid] = reset
end

local function OnLogout(event, player)
    local guid = player:GetGUIDLow()
    DBWrite(guid, "spells", toString(spells[guid]))
    DBWrite(guid, "tpells", toString(tpells[guid]))
    DBWrite(guid, "talents", toString(talents[guid]))
    DBWrite(guid, "stats", "0,0,0,0,0")
    DBWrite(guid, "resets", resets[guid])
    spells[guid] = nil
    tpells[guid] = nil
    talents[guid] = nil
    stats[guid] = nil
    resets[guid] = nil
end

RegisterPlayerEvent(2, OnDelete)
RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(4, OnLogout)


local plrs = GetPlayersInWorld()
if plrs then
    for i, player in ipairs(plrs) do
        OnLogin(i, player)
    end
end

function MyHandlers.LearnSpell(player, spr, tpr, clientSecret)
	local isValid = checkSecret(player, clientSecret, serverSecret)
	if not (isValid) then return end
    local guid = player:GetGUIDLow()
    for i = 1, #spr do
        local spell = spr[i]
        if not player:HasSpell(spell) then

            player:LearnSpell(spell)
        end
    end
	for i = 1, #spells[guid] do
  local spell = spells[guid][i]
  if not tContains(spr, spell) then
    player:RemoveSpell(spell)
  end
end
for i = 1, #tpells[guid] do
  local spell = tpells[guid][i]
  if not tContains(spr, spell) then
    player:RemoveSpell(spell)
  end
end
    spells[guid] = spr
    tpells[guid] = tpr
    DBWrite(guid, "spells", toString(spr))
    DBWrite(guid, "tpells", toString(tpr))
    player:SaveToDB()
end

function MyHandlers.LearnTalent(player, tar, clientSecret)
	local isValid = checkSecret(player, clientSecret, serverSecret)
	if not (isValid) then return end
    local guid = player:GetGUIDLow()
    for i = 1, #tar do
        local spell = tar[i]
        if not player:HasSpell(spell) then
            player:LearnSpell(spell)
        end
    end
	for i = 1, #talents[guid] do
  local talent = talents[guid][i]
  if not tContains(tar, talent) then
    player:RemoveSpell(talent)
  end
end
    talents[guid] = tar
    DBWrite(guid, "talents", toString(tar))
    player:SaveToDB()
end



function MyHandlers.WipeAll(player, clientSecret)
	local isValid = checkSecret(player, clientSecret, serverSecret)
    if not (isValid) then return end

    local guid = player:GetGUIDLow()

    rst = resets[guid] + 1
    if (rst > #prices) then
        rst = #prices
    end

    price = prices[rst]
    if (player:GetCoinage() < price) then
        player:SendNotification("Not enough money to reset.")
        return 
    end

    player:ModifyMoney(-price)

    table.sort(spells[guid], function(a, b) return a > b end)
    table.sort(tpells[guid], function(a, b) return a > b end)
    table.sort(talents[guid], function(a, b) return a > b end)
    for i=1,#spells[guid] do
        local spell=spells[guid][i]
        if player:HasSpell(spell) then
            player:RemoveSpell(spell)
        end
    end

    for i=1,#tpells[guid] do
        local spell=tpells[guid][i]
        if player:HasSpell(spell) then
            player:RemoveSpell(spell)
            player:RemoveSpell(spell)
        end
    end

    for i=1,#talents[guid] do
        local spell=talents[guid][i]
        if player:HasSpell(spell) then
            player:RemoveSpell(spell)
        end
    end

    spells[guid]={}
    tpells[guid]={}
    talents[guid]={}
    stats[guid]={0,0,0,0,0}

    resets[guid] = resets[guid] + 1

    DBWrite(guid,"spells","")
    DBWrite(guid,"tpells","")
    DBWrite(guid,"talents","")
    DBWrite(guid,"stats","0,0,0,0,0")
    DBWrite(guid,"resets",resets[guid])
    player:SaveToDB()
    SendVars(AIO.Msg(), player, true)
end


local function PLAYER_EVENT_ON_SAVE(event, player)
    player:SendBroadcastMessage("You're saved! :)")
end

-- RegisterPlayerEvent( 25, PLAYER_EVENT_ON_SAVE )