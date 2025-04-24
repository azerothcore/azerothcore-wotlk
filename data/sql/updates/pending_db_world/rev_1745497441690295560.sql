-- blue dragon 25% haste aura
DELETE FROM `spell_script_names` WHERE `spell_id` = 45856;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45856, 'spell_blue_dragon_breath_haste');
