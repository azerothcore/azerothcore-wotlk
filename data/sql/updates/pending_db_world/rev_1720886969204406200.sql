--
UPDATE`smart_scripts` SET `action_param1` = 39649 WHERE (`entryorguid` = 22855) AND (`source_type` = 0) AND (`id` = 3);

DELETE FROM `spell_script_names` WHERE `spell_id`=39649 AND `ScriptName`='spell_black_temple_summon_shadowfiends';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (39649, 'spell_black_temple_summon_shadowfiends');
