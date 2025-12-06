--
-- Cooldown Methods by Foereaper
--
-- player:SetLuaCooldown(seconds[, opt_id]) -- Sets the cooldown timer to X seconds, optionally a specific cooldown ID can be set. Default ID: 1
-- player:GetLuaCooldown([opt_id])          -- Returns cooldown or 0 if none, default cooldown checked is ID 1, unless other is specified.
--

local cooldowns = {};

function Player:SetLuaCooldown(seconds, opt_id)
    assert(type(self) == "userdata");
    seconds = assert(tonumber(seconds));
    opt_id = opt_id or 1;
    local guid = self:GetGUIDLow();

    if (not cooldowns[guid]) then
        cooldowns[guid] = {};
    end

    cooldowns[guid][opt_id] = os.time() + seconds;
end

function Player:GetLuaCooldown(opt_id)
    assert(type(self) == "userdata");
    local guid = self:GetGUIDLow();
    opt_id = opt_id or 1;

    if (not cooldowns[guid]) then
        cooldowns[guid] = {};
    end

    local cd = cooldowns[guid][opt_id];
    if (not cd or cd < os.time()) then
        cooldowns[guid][opt_id] = 0
        return 0;
    else
        return cooldowns[guid][opt_id] - os.time();
    end
end

--
-- GossipSetText Methods by Rochet2
--
-- player:GossipMenuAddItem(0, "Text", 0, 0)
-- player:GossipMenuAddItem(0, "Text", 0, 0)
-- player:GossipSetText("Text")
-- player:GossipSendMenu(0x7FFFFFFF, creature)
--

local SMSG_NPC_TEXT_UPDATE = 384
local MAX_GOSSIP_TEXT_OPTIONS = 8

function Player:GossipSetText(text)
    data = CreatePacket(SMSG_NPC_TEXT_UPDATE, 100);
    data:WriteULong(0x7FFFFFFF)
    for i = 1, MAX_GOSSIP_TEXT_OPTIONS do
        data:WriteFloat(0)     -- Probability
        data:WriteString(text) -- Text
        data:WriteString(text) -- Text
        data:WriteULong(0)     -- language
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
    end
    self:SendPacket(data)
end

--
-- WorldState methods by Foereaper
--
-- player:InitializeWorldState(Map, Zone, StateID, Value)
-- player:UpdateWorldState(StateID, Value)
--

local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3

function Player:InitializeWorldState(Map, Zone, StateID, Value)
    local data = CreatePacket(SMSG_INIT_WORLD_STATES, 18);
    data:WriteULong(Map);
    data:WriteULong(Zone);
    data:WriteULong(0);
    data:WriteUShort(1);
    data:WriteULong(StateID);
    data:WriteULong(Value);
    self:SendPacket(data)
end

function Player:UpdateWorldState(StateID, Value)
    local data = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8);
    data:WriteULong(StateID);
    data:WriteULong(Value);
    self:SendPacket(data)
end

function ChatMsg(type)
    if (type == 0x00) then
        return("System")
    elseif (type == 0x01) then
        return("Says")
    elseif (type == 0x02) then
        return("Party")
    elseif (type == 0x03) then
        return("Raid")
    elseif (type == 0x04) then
        return("Guild["..pg.."]")
    elseif (type == 0x05) then
        return("Guild Officer["..pg.."]")
    elseif (type == 0x06) then
        return("Yells")
    elseif (type == 0x07) then
        return("Whisper")
    elseif (type == 0x11) then
        return("(General/Trade/Local Defense/LFG/Custom)")
    elseif (type == 0x2C) then
        return("Battleground")
    elseif (type == 0x2D) then
        return("Battleground Leader")
    else
        return(type)
    end
end

function CreateQueue()
    local Queue = {Queue = {}}

    function Queue:Set(index)
        if (self:Has(index)) then
            return false
        end
        self.Queue[index] = true
        return true
    end

    function Queue:Remove(index)
        if (not self:Has(index)) then
            return false
        end
        self.Queue[index] = nil
        return true
    end

    function Queue:Has(index)
        return self.Queue[index] ~= nil
    end

    function Queue:Get()
        return self.Queue
    end

    local pairs = pairs
    function Queue:Count()
        local count = 0
        for k,v in pairs(self.Queue) do
            count = count + 1
        end
        return count
    end

    return Queue
end