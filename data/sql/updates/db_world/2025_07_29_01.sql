-- DB update 2025_07_29_00 -> 2025_07_29_01
-- Moonglade Raiment 2 set
DELETE FROM `spell_script_names` WHERE `spell_id`=-774 AND `ScriptName`='spell_dru_rejuvenation_moonglade_2_set';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-774, 'spell_dru_rejuvenation_moonglade_2_set');
