-- DB update 2025_03_16_04 -> 2025_03_17_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (29707, 30324, 47449, 47450) AND `ScriptName` = 'spell_warr_heroic_strike';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(29707, 'spell_warr_heroic_strike'),
(30324, 'spell_warr_heroic_strike'),
(47449, 'spell_warr_heroic_strike'),
(47450, 'spell_warr_heroic_strike');
