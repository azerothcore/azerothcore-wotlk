-- Where Time Went Wrong (13048): Lorehammer reaction lines
DELETE FROM `spell_script_names` WHERE `spell_id` IN (56796, 56797);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56796, 'spell_q13048_time_period'),
(56797, 'spell_q13048_time_period');
