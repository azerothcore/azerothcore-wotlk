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

--[[ Example:
	player:InitializeWorldState(Map, Zone, StateID, Value)
	player:UpdateWorldState(StateID, Value)
]]