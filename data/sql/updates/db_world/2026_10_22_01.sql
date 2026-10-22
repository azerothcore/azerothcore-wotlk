-- DB update 2026_10_22_00 -> 2026_10_22_01
--
UPDATE `spell_proc` SET `SpellTypeMask` = 0x0, `SpellPhaseMask` = 0x4, `AttributesMask` = 0x2 WHERE `SpellId` = 64999;
DELETE FROM `spell_script_names` WHERE `spell_id` = 64999 AND `ScriptName` = 'spell_item_meteoric_inspiration';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (64999, 'spell_item_meteoric_inspiration');
