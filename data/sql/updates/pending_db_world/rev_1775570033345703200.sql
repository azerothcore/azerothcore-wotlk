-- is no longer used
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30331) AND (`source_type` = 0) AND (`id` IN (5));

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q13010_jokkum_summon';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_riding_jokkum';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56541, 'spell_q13010_jokkum_summon'),
(56606, 'spell_riding_jokkum');
