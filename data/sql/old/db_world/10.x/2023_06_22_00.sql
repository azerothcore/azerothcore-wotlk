-- DB update 2023_06_21_00 -> 2023_06_22_00
--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_murmur_touch', 'spell_shockwave_knockback');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(33686, 'spell_shockwave_knockback');
