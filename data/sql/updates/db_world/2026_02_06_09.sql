-- DB update 2026_02_06_08 -> 2026_02_06_09
--
-- 35475 Drums of War
-- 35476 Drums of Battle
-- 35478 Drums of Restoration
-- 'Cannot affect targets level 80 or higher.'
DELETE FROM `spell_script_names` WHERE `spell_id` IN (35475, 35476, 35478);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(35475, 'spell_gen_filter_party_level_80'),
(35476, 'spell_gen_filter_party_level_80'),
(35478, 'spell_gen_filter_party_level_80');
