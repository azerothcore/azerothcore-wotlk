-- DB update 2025_05_13_00 -> 2025_05_15_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 46102;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(46102, 'spell_spell_fury_aura');

-- Remove 'Deal periodic damage'
SET @procFlags = (0x4000 | 0x10000);
DELETE FROM `spell_proc_event` WHERE `entry` = 46102;
INSERT INTO `spell_proc_event` (`entry`, `procFlags`) VALUES
(46102, @procFlags);
