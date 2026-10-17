-- --------------------------------------------------------------------------------------------
-- Meteorite Crystal (Item 46051)
-- Meteoric Inspiration (Spell 64999)
-- Let Beacon of Light heals add stacks
-- -------------------------------------------
UPDATE `spell_proc` SET `AttributesMask` = `AttributesMask`&~4 WHERE (`SpellId` = 64999);

DELETE FROM `spell_script_names` WHERE `spell_id` = 64999 AND `ScriptName` = 'spell_item_meteoric_inspiration';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(64999, 'spell_item_meteoric_inspiration');
