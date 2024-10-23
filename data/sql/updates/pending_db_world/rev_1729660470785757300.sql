--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_illidan_shadow_prison_aura' AND `spell_id` = 40647;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(40647, 'spell_illidan_shadow_prison_aura');
