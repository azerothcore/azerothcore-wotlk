-- DB update 2025_10_17_00 -> 2025_10_18_00
--
UPDATE `spell_proc_event` SET `SpellFamilyMask2` = 0x00000040 WHERE `entry` = -33191;

DELETE FROM `spell_script_names` WHERE `spell_id` = -33191;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-33191, 'spell_gen_proc_on_victim');
