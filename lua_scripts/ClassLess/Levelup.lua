--  ___ ___ _ __      _____   ___  ___    ___ ___ ___  _   ___ _  __
-- | __| __| |\ \    / / _ \ / _ \|   \  | _ \ __| _ \/_\ / __| |/ /
-- | _|| _|| |_\ \/\/ / (_) | (_) | |) | |   / _||  _/ _ \ (__| ' < 
-- |_| |___|____\_/\_/ \___/ \___/|___/  |_|_\___|_|/_/ \_\___|_|\_\


local function OnLevel(event, player)
local level=player:GetLevel()
if level>=10 then if not player:HasSkill(414) then player:SetSkill(414, 0, 1, 1) end end
if level>=20 then if not player:HasSkill(413) then player:SetSkill(413, 0, 1, 1) end end
if level>=40 then if not player:HasSkill(293) then player:SetSkill(293, 0, 1, 1) end end
end

RegisterPlayerEvent(13, OnLevel)

local plrs = GetPlayersInWorld()
if plrs then
    for i, player in ipairs(plrs) do
        OnLevel(i, player)
    end
end