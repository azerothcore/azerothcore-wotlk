--
DELETE FROM `spell_script_names` WHERE `spell_id`=43983 AND `ScriptName`='spell_gen_allow_proc_from_spells_with_cost';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(43983, 'spell_gen_allow_proc_from_spells_with_cost');
-- PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_POS | PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_NEG
UPDATE `spell_proc_event` SET `procFlags`=`procFlags`|(1024|4096) WHERE `entry` = 43983;