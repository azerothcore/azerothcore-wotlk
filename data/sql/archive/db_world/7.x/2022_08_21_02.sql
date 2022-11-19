-- DB update 2022_08_21_01 -> 2022_08_21_02
--
UPDATE `creature_template` SET `ScriptName`='npc_obsidian_destroyer', `AiName`='' WHERE `entry`=15338;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15338 AND `source_type`=0;

DELETE FROM `spell_script_names` WHERE `spell_id`=25755;
INSERT INTO `spell_script_names` VALUES
(25755,'spell_drain_mana');
