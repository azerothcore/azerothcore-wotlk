-- DB update 2024_07_17_00 -> 2024_07_16_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 30282 AND `ScriptName` = 'spell_nightbane_fireball_barrage';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(30282, 'spell_nightbane_fireball_barrage');
