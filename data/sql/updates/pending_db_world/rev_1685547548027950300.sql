--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-49220, 34246, 60779) AND `ScriptName` IN ('spell_dru_idol_lifebloom', 'spell_dk_impurity');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-49220, 'spell_dk_impurity'),
(34246, 'spell_dru_idol_lifebloom'),
(60779, 'spell_dru_idol_lifebloom');
