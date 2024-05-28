--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18104 AND `source_type` = 0;
UPDATE `creature_template` SET `speed_run` = 3, `AIName` = '', `ScriptName` = 'npc_doomfire_spirit' WHERE `entry` = 18104;
