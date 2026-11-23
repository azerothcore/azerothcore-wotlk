-- Prince Malchezaar: Summon Axes
DELETE FROM `spell_script_names` WHERE `spell_id` = 30891;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30891, 'spell_malchezaar_summon_axes');
