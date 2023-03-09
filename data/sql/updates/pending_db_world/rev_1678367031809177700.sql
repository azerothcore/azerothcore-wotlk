-- Steam Pump Overseer
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 18340;
UPDATE `creature_template` SET `ScriptName` = 'npc_steam_pump_overseer' WHERE `entry` = 18340;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18340 AND `source_type` = 0;
