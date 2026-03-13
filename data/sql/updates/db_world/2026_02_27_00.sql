-- DB update 2026_02_26_06 -> 2026_02_27_00
-- Replace generic no-offhand-proc with Focused Attacks-specific script
-- that only blocks Fan of Knives offhand from proccing, allowing Mutilate
-- offhand and other offhand attacks to proc normally
DELETE FROM `spell_script_names` WHERE `spell_id` = -51634 AND `ScriptName` = 'spell_gen_no_offhand_proc';
DELETE FROM `spell_script_names` WHERE `spell_id` = -51634 AND `ScriptName` = 'spell_rog_focused_attacks';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-51634, 'spell_rog_focused_attacks');
