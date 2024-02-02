--
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (20060, 20062, 20063, 20064);

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_lord_sanguinar' WHERE `entry` = 20060;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_capernian' WHERE `entry` = 20062;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_telonicus' WHERE `entry` = 20063;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_thaladred' WHERE `entry` = 20064;
