-- DB update 2026_03_12_00 -> 2026_03_13_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = -11426 AND `ScriptName` = 'spell_mage_ice_barrier_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-11426, 'spell_mage_ice_barrier_aura');
