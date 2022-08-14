--
UPDATE `creature_template` SET `ScriptName`='npc_obsidian_eradicator', `AiName`='' WHERE `entry`=15262;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15262 AND `source_type`=0;

DELETE FROM `spell_script_names` WHERE `spell_id`=25671;
INSERT INTO `spell_script_names` VALUES
(25671,'spell_drain_mana');
