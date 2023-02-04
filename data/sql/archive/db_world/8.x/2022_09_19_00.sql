-- DB update 2022_09_17_01 -> 2022_09_19_00
--
UPDATE `creature_template` SET `unit_flags2`=0, `AiName`='', `ScriptName`='npc_obsidian_nullifier' WHERE `entry`=15312;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15312 AND `source_type`=0;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (25671,26552);
INSERT INTO `spell_script_names` VALUES
(25671,'spell_drain_mana'),
(26552,'spell_nullify');

UPDATE `creature_formations` SET `groupAI`=`groupAI`|0x008 WHERE `memberguid` BETWEEN 88022 AND 88029;
