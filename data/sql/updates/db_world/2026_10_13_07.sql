-- DB update 2026_10_13_06 -> 2026_10_13_07
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 40834;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (40834, 'spell_illidan_agonizing_flames');
