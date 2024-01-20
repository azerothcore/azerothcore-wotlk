-- DB update 2023_12_12_15 -> 2023_12_12_16
--
UPDATE `creature_template` SET `scale` = 0.5, `unit_flags` = `unit_flags`|2048|524288, `mechanic_immune_mask` = 1073741823, `AIName` = '', `ScriptName` = 'npc_rancid_mushroom' WHERE `entry` = 22250;

DELETE FROM `spell_script_names` WHERE `spell_id` = 38652 AND `ScriptName` = 'spell_rancid_spore_cloud';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38652, 'spell_rancid_spore_cloud');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 22250 AND `source_type` = 0;
