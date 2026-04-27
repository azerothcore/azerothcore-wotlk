-- Bind low-level heroic DK direct-hit tuning script
-- Applies to all ranks in Icy Touch and Plague Strike chains.

DELETE FROM `spell_script_names`
WHERE `spell_id` IN (-45477, -45462)
  AND `ScriptName` = 'spell_dk_low_heroic_damage_tuning';

INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-45477, 'spell_dk_low_heroic_damage_tuning'),
(-45462, 'spell_dk_low_heroic_damage_tuning');
