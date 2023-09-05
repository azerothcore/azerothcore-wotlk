--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (22486, 22487);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (22091, 21964, 21965, 21966) AND `source_type` = 0;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_spitfire_totem' WHERE `entry` = 22091;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_greater_earthbind_totem' WHERE `entry` = 22486;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_greater_poison_cleansing_totem' WHERE `entry` = 22487;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_fathomguard_caribdis' WHERE `entry` = 21964;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_fathomguard_tidalvess' WHERE `entry` = 21965;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_fathomguard_sharkkis' WHERE `entry` = 21966;
