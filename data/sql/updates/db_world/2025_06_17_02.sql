-- DB update 2025_06_17_01 -> 2025_06_17_02
-- HoL - Static Overload
DELETE FROM `spell_script_names` WHERE `spell_id` IN (52658,59795) AND `ScriptName`='spell_ionar_static_overload';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(52658, 'spell_ionar_static_overload'),
(59795, 'spell_ionar_static_overload');

DELETE FROM `spelldifficulty_dbc` WHERE `ID` = 53337;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(53337, 53337, 59798, 0, 0);
