-- DB update 2026_07_19_04 -> 2026_07_19_05
--
-- XT-002 Deconstructor: restore Searing Light / Gravity Bomb single random non-tank targeting
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_xt002_searing_light_gravity_bomb';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63018, 'spell_xt002_searing_light_gravity_bomb'),
(65121, 'spell_xt002_searing_light_gravity_bomb'),
(63024, 'spell_xt002_searing_light_gravity_bomb'),
(64234, 'spell_xt002_searing_light_gravity_bomb');
