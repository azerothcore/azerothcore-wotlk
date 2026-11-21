--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (66017, 68753, 68754, 68755) AND `ScriptName` = 'spell_faction_champion_death_grip';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66017, 'spell_faction_champion_death_grip'),
(68753, 'spell_faction_champion_death_grip'),
(68754, 'spell_faction_champion_death_grip'),
(68755, 'spell_faction_champion_death_grip');
