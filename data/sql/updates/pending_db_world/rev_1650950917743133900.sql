--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_vem_knockback', 'spell_vem_vengeance');
DELETE FROM `spell_script_names` WHERE `spell_id` = 18670; -- Delete the current script to prevent stacking.
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(18670, 'spell_vem_knockback'),
(25790, 'spell_vem_vengeance');
