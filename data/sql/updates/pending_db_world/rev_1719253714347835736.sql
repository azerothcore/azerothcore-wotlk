--
DELETE FROM `spell_script_names` WHERE `spell_id` = 32865;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(32865, 'spell_warl_seed_of_corruption');
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-27243, 32863, 38252, 44141, 70388);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-27243, 'spell_warl_seed_of_corruption_aura'),
(32863,  'spell_warl_seed_of_corruption_aura'),
(38252,  'spell_warl_seed_of_corruption_aura'),
(44141,  'spell_warl_seed_of_corruption_aura'),
(70388,  'spell_warl_seed_of_corruption_aura');
UPDATE `spell_script_names` SET `ScriptName`='spell_warl_seed_of_corruption_aura' WHERE `spell_id` IN (36123, 39367) AND `ScriptName` = 'spell_zereketh_seed_of_corruption';
