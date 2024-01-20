-- DB update 2023_09_17_02 -> 2023_09_17_03
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 30629 AND `ScriptName` = 'spell_magtheridon_debris_target_selector';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30629, 'spell_magtheridon_debris_target_selector');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|33554432, `AIName` = '', `ScriptName` = 'npc_target_trigger' WHERE `entry` = 17516;

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 17516);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(17516, 0, 0, 0, 1, 0, 0, 0);
