-- DB update 2023_05_12_02 -> 2023_05_12_03
--
UPDATE `creature_template` SET `AiName`='', `ScriptName`='npc_underbat' WHERE `entry`=17724;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17724 AND `source_type`=0;

DELETE FROM `spelldifficulty_dbc` WHERE `ID`=34171;
INSERT INTO `spelldifficulty_dbc` VALUES
(34171,34171,37956,0,0);
