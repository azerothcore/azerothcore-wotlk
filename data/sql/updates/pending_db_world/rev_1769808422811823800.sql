--
DELETE FROM `spell_area` WHERE `spell` = 37280 AND `area` = 3607;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(37280, 3607, 0, 0, 0, 0, 2, 1, 64, 11);

DELETE FROM `spell_script_names` WHERE `spell_id`=37025 AND `ScriptName`='spell_serpentshrine_cavern_coilfang_water';
DELETE FROM `spell_script_names` WHERE `spell_id`=37280 AND `ScriptName`='spell_serpentshrine_cavern_coilfang_water';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37280, 'spell_serpentshrine_cavern_coilfang_water');
