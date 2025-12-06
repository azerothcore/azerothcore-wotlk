------------------------------------------------------------------------------------------------
-- SKIP DEATHKNIGHT STARTER AREA MOD
------------------------------------------------------------------------------------------------

local EnableModule = true
local AnnounceModule = false   -- Announce module on player login ?

local AutoSkip = true       -- true: autoskip on first login , false: lich king has option to skip
local GM_Only = false         -- true: only allow game masters to skip
local AnnounceZone = false     -- true: when player choose to skip, announce to other deathknights
                              --       who are in the dk starting zone

------------------------------------------------------------------------------------------------
-- END CONFIG
------------------------------------------------------------------------------------------------

if (not EnableModule) then return end

local FILE_NAME = string.match(debug.getinfo(1,'S').source, "[^/\\]*.lua$")

local NPC_LK = 25462

local QUEST_STATUS_NONE           = 0
local QUEST_STATUS_COMPLETE       = 1
local QUEST_STATUS_INCOMPLETE     = 3
local QUEST_STATUS_FAILED         = 5
local QUEST_STATUS_REWARDED       = 6

local RACE_HUMAN              = 1 
local RACE_ORC                = 2
local RACE_DWARF              = 3 
local RACE_NIGHTELF           = 4 
local RACE_UNDEAD_PLAYER      = 5
local RACE_TAUREN             = 6
local RACE_GNOME              = 7
local RACE_TROLL              = 8
local RACE_BLOODELF           = 10
local RACE_DRAENEI            = 11

local HORDE_ICON = "|TInterface\\TargetingFrame\\UI-PVP-HORDE:18:19:0:-2:64:64:0:38:0:36|t"
local ALLIANCE_ICON = "|TInterface\\TargetingFrame\\UI-PVP-ALLIANCE:19:19:2:-2:64:64:0:38:0:38|t"

local function doQuest(player, id)
    local reward = false
    if (player:GetQuestStatus(id) == QUEST_STATUS_FAILED) then
        --player:SendBroadcastMessage("REMOVE FAILED QUEST: "..id)
        player:RemoveQuest(id)
    end
    if (player:GetQuestStatus(id) == QUEST_STATUS_NONE) then
        --player:SendBroadcastMessage("ADD QUEST: "..id)
        player:AddQuest(id)
    end
    if (player:GetQuestStatus(id) == QUEST_STATUS_INCOMPLETE) then
        --player:SendBroadcastMessage("COMPLETE QUEST: "..id)
        player:CompleteQuest(id)
    end
    if (player:GetQuestStatus(id) == QUEST_STATUS_COMPLETE) then
        --player:SendBroadcastMessage("REWARD QUEST: "..id)
        player:RewardQuest(id)
        reward = true
    end
    local status = player:GetQuestStatus(id)
    --player:SendBroadcastMessage("QUEST STATUS: "..id.." "..((status==QUEST_STATUS_NONE and "QUEST_STATUS_NONE") or (status==QUEST_STATUS_COMPLETE and "QUEST_STATUS_COMPLETE") or (status==QUEST_STATUS_INCOMPLETE and "QUEST_STATUS_INCOMPLETE") or (status==QUEST_STATUS_FAILED and "QUEST_STATUS_FAILED") or (status==QUEST_STATUS_REWARDED and "QUEST_STATUS_REWARDED") or status))
    return (reward and status==QUEST_STATUS_REWARDED)
end

local function forceEquip(player, slot, itemId)
    local del = player:GetEquippedItemBySlot(slot)
    if (del) then
        local entry = del:GetEntry()
        if (entry == itemId) then -- item is already equipped
            return
        end
        player:RemoveItem(del,1)
        local add = player:AddItem(entry,1)
        if (not add) then
            PrintError("["..FILE_NAME.."] ERROR: Could not unequip worn item "..entry.." on player \""..player:GetName().."\" while skipping the DK questline and the item was destroyed. This should NOT happen.")
        end
    end
    local item = player:GetItemByEntry(itemId)
    local equip
    if (item) then
        equip = player:EquipItem(item, slot)
    else
        equip = player:EquipItem(itemId, slot)
    end
    if (not equip) then
        PrintError("["..FILE_NAME.."] ERROR: Could not equip quest reward item "..itemId.." on player \""..player:GetName().."\" while skipping the DK questline. This should NOT happen.")
    end
end

local function getFreeBagSlots(player)
    local free = 0
    for i = 23, 38 do -- backpack
        if (not player:GetItemByPos(255,i)) then 
            free = free+1
        end
    end
    for i = 19, 22 do -- equipped bags
        local bag = player:GetItemByPos(255,i)
        if (bag) then
            for x = 0, bag:GetBagSize()-1 do
                if (not player:GetItemByPos(i,x)) then 
                    free = free+1
                end
            end
        end
    end
    return free
end

local function announceZone(player)
    local icon = ((player:GetTeam() == 0) and ALLIANCE_ICON) or HORDE_ICON
    local name = player:GetName()
    local players = GetMapById(609,0):GetPlayers()
    for _,p in pairs(players) do
        p:SendBroadcastMessage("[|cff4CFF00Skip Deathknight Starter|r] "..icon.." |Hplayer:"..name.."|h[|cffc41f3b"..name.."|r]|h chose to skip the starter questline and was teleported away.")
    end
end

local function skipDKStarter(player)
    if (player:GetClass() ~= 6) then return end -- how did you get here lol?
    
    local freeSlots = getFreeBagSlots(player)
    if(freeSlots < 21) then
        player:SendBroadcastMessage("[|cff4CFF00Skip Deathknight Starter|r] |cffff2020You need at least 21 available bag space to skip the starter questline|r")
        player:SendBroadcastMessage("[|cff4CFF00Skip Deathknight Starter|r] You currently have "..freeSlots.." free slots, need "..(21-freeSlots).." more")
        player:SendNotification("You need "..(21-freeSlots).." more available bag space to continue")
        return
    end

    local coinage = player:GetCoinage()

    -- first chain (runeforging)
    doQuest(player, 12593) -- In Service Of The Lich King
    doQuest(player, 12619) -- The Emblazoned Runeblade
    doQuest(player, 12842) -- Runeforging: Preparation For Battle
    doQuest(player, 12848) -- The Endless Hunger
    doQuest(player, 12636) -- The Eye Of Acherus
    doQuest(player, 12641) -- Death Comes From On High
    if (doQuest(player, 12657)) then -- The Might Of The Scourge
        forceEquip(player, 1, 38662)
    end 
    doQuest(player, 12850) -- Report To Scourge Commander Thalanor
    doQuest(player, 12670) -- The Scarlet Harvest
    if (doQuest(player, 12678)) then -- If Chaos Drives, Let Suffering Hold The Reins
        forceEquip(player, 10, 38671)
    end
    
    -- second chain (acherus deathcharger)
    doQuest(player, 12680) -- Grand Theft Palomino
    if (doQuest(player, 12687)) then -- Into the Realm of Shadows
        forceEquip(player, 17, 39208)
    end
    
    -- more quests
    if (doQuest(player, 12679)) then -- Tonight We Dine In Havenshire
        forceEquip(player, 14, 39320)
        if (not player:GetItemByEntry(39322)) then
            player:AddItem(39322)
        end
        if (not player:GetItemByEntry(38664)) then
            player:AddItem(38664)
        end
    end
    doQuest(player, 12733) -- Death's Challenge
    
    -- third chain
    doQuest(player, 12697) -- Gothik the Harvester
    if (doQuest(player, 12698)) then -- The Gift That Keeps On Giving
        forceEquip(player, 12, 38674)
    end
    doQuest(player, 12700) -- An Attack Of Opportunity
    if (doQuest(player, 12701)) then -- Massacre At Light's Point
        forceEquip(player, 8, 38666)
    end
    if (doQuest(player, 12706)) then -- Victory At Death's Breach
        forceEquip(player, 6, 38669)
    end
    doQuest(player, 12714) -- The Will Of The Lich King
    doQuest(player, 12715) -- The Crypt of Remembrance
    doQuest(player, 12719) -- Nowhere To Run And Nowhere To Hide
    if (doQuest(player, 12720)) then -- How To Win Friends And Influence Enemies
        forceEquip(player, 11, 38672)
    end
    
    -- next quests
    if (doQuest(player, 12722)) then -- Lambs To The Slaughter
        forceEquip(player, 7, 38670)
    end
    if (doQuest(player, 12716)) then -- The Plaguebringer's Request
        forceEquip(player, 5, 38668)
    end
    doQuest(player, 12717) -- Noth's Special Brew
    doQuest(player, 12723) -- Behind Scarlet Lines (req)
    if (doQuest(player, 12724)) then -- The Path Of The Righteous Crusader
        forceEquip(player, 9, 38667)
    end

    -- fourth chain
    doQuest(player, 12725) -- Brothers In Death
    if (doQuest(player, 12727)) then -- Bloody Breakout
        forceEquip(player, 4, 38665)
    end
    doQuest(player, 12728) -- A Cry For Vengeance (req)
    
    -- race specific 2-part chain
    local race = player:GetRace()
    if (race == RACE_HUMAN) then
        doQuest(player, 12742) -- A Special Surprise
    elseif (race == RACE_ORC) then
        doQuest(player, 12748) -- A Special Surprise
    elseif (race == RACE_DWARF) then
        doQuest(player, 12744) -- A Special Surprise
    elseif (race == RACE_NIGHTELF) then
        doQuest(player, 12743) -- A Special Surprise
    elseif (race == RACE_UNDEAD_PLAYER) then
        doQuest(player, 12750) -- A Special Surprise
    elseif (race == RACE_TAUREN) then
        doQuest(player, 12739) -- A Special Surprise
    elseif (race == RACE_GNOME) then
        doQuest(player, 12745) -- A Special Surprise
    elseif (race == RACE_TROLL) then
        doQuest(player, 12749) -- A Special Surprise
    elseif (race == RACE_BLOODELF) then
        doQuest(player, 12747) -- A Special Surprise
    elseif (race == RACE_DRAENEI) then
        doQuest(player, 12746) -- A Special Surprise
    end
    if (doQuest(player, 12751)) then -- A Sort Of Homecoming
        forceEquip(player, 13, 38675)
    end
    
    -- fifth chain
    doQuest(player, 12754) -- Ambush At The Overlook
    doQuest(player, 12755) -- A Meeting With Fate
    doQuest(player, 12756) -- The Scarlet Onslaught Emerges
    if(doQuest(player, 12757)) then -- Scarlet Armies Approach...
        forceEquip(player, 2, 38663)
    end
    
    -- sixth chain
    doQuest(player, 12778) -- The Scarlet Apocalypse
    if (doQuest(player, 12779)) then -- An End To All Things...
        forceEquip(player, 0, 38661)
    end
    doQuest(player, 12800) -- The Lich King's Command
    
    -- final chain
    if doQuest(player, 12801) then -- The Light of Dawn
    forceEquip(player, 15, 38632)
    if not player:GetItemByEntry(38633) then
        player:AddItem(38633)
    end
end

doQuest(player, 13165) -- Taking Back Acherus
doQuest(player, 13166) -- The Battle For The Ebon Hold

-- Corrigi o erro de indentação e adicionei a vírgula que estava faltando
    if player:GetTeam() == 0 then
    doQuest(player, 13188) -- Where Kings Walk
    -- Spawn em Dalaran Mall (referência do release)
    player:Teleport(571, 5805.6196, 641.6034, 609.886, 4.1022134) -- Spawn
else
    doQuest(player, 13189) -- Saurfang's Blessing
    -- Spawn em Dalaran Mall (referência do release)
    player:Teleport(571, 5805.6196, 641.6034, 609.886, 4.1022134) -- Spawn
end


    player:AddItem(6948) -- Hearthstone
    if (player:GetLevel() < 58) then
        player:SetLevel(58)
    end
    player:SetCoinage(coinage)
    player:SaveToDB()
    
    if (AnnounceZone) then
        announceZone(player)
    end
end

local function onGossipHello(event, player, creature)
    player:GossipAddQuests(creature)
    if (not GM_Only or player:GetGMRank() >= 1) then
        player:GossipMenuAddItem(0, "I wish to skip the Death Knight starter questline", 1, 1, false, "Are you sure you want to skip?")
    end
    player:TalkedToCreature(creature:GetEntry(), creature)
    player:GossipSendMenu(1, creature)
    return true
end

local function onGossipSelect(event, player, creature, sender, intid, code)
    player:GossipComplete()
    if (intid == 1) then
        if (not GM_Only or player:GetGMRank() >= 1) then
            skipDKStarter(player)
        end
    end
    return true
end

local function onLKSpawn(event, creature)
    creature:SetNPCFlags(3)
end

local function onFirstLogin(event, player)
    if (not GM_Only or player:GetGMRank() >= 1) then
        skipDKStarter(player)
    end
end

local function onSendCinematic(event, packet, player)
    if (packet:ReadULong() == 165) then 
        if (not GM_Only or player:GetGMRank() >= 1) then
            return false
        end
    end
end

RegisterCreatureEvent(NPC_LK, 5, onLKSpawn)
RegisterCreatureGossipEvent(NPC_LK, 1, onGossipHello)
RegisterCreatureGossipEvent(NPC_LK, 2, onGossipSelect)

if (AutoSkip) then
    RegisterPlayerEvent(30, onFirstLogin)
    RegisterPacketEvent(250, 7, onSendCinematic) -- PACKET_EVENT_ON_PACKET_SEND (SMSG_TRIGGER_CINEMATIC)
end

if (AnnounceModule and not GM_Only) then
    RegisterPlayerEvent(3, function(event,player) 
        player:SendBroadcastMessage("This server is running the |cff4CFF00Skip Deathknight Starter|r module.")
    end)  -- PLAYER_EVENT_ON_LOGIN
end

PrintInfo("["..FILE_NAME.."] Skip Deathknight Starter module loaded. Config: Announce="..(Announce and "true" or "false").." AutoSkip="..(AutoSkip and "true" or "false").." GM_Only="..(GM_Only and "true" or "false"))
