-- DB update 2022_12_06_07 -> 2022_12_06_08
-- Normal Mode regular creatures award 5 rep. Heroic awards 15
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 5, `RewOnKillRepValue2` = 5 WHERE `creature_id` IN (
17370, -- Laughing Skull Enforcer
17626, -- Laughing Skull Legionnaire
17624, -- Laughing Skull Warden
17397, -- Shadowmoon Adept
17491, -- Laughing Skull Rogue
17371, -- Shadowmoon Warlock
17395, -- Shadowmoon Summoner
17414, -- Shadowmoon Technician
17398, -- Nascent Fel Orc
17429, -- Fel Orc Neophyte
18894, -- Fel Guard Brute
17653  -- Shadowmoon Channeler
);
-- One of these heroic creatures awarded 1 instead of 3 and I forgot to check which
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 3, `RewOnKillRepValue2` = 3 WHERE `creature_id` IN (
18606, -- Hellfire Imp
21646  -- Hellfire Familiar
);
