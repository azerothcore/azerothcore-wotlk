-- Alystros the Verdant Keeper - Lapsing Dream
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_alystros_lapsing_dream_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51922, 'spell_alystros_lapsing_dream_aura');

UPDATE `smart_scripts` SET `target_type` = 5, `target_param2` = 1 WHERE `entryorguid` = 27249 AND `source_type` = 0 AND `id` = 2;
