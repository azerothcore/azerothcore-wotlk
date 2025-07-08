--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_dk_disease' AND `spell_id` IN(55078,55095);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (55078,"spell_dk_disease"), (55095,"spell_dk_disease");
