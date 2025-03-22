-- DB update 2025_02_24_00 -> 2025_02_25_00
-- update Mr. Bigglesworth script name
UPDATE `creature_template` SET `ScriptName` = 'npc_mr_bigglesworth' WHERE (`entry` = 16998);

-- update Living Poison script name
UPDATE `creature_template` SET `ScriptName` = 'npc_living_poison' WHERE (`entry` = 16027);

-- update Naxxramas Trigger script name
UPDATE `creature_template` SET `ScriptName` = 'npc_naxxramas_trigger' WHERE (`entry` = 16082);
