--
DELETE FROM `spell_proc` WHERE `SpellId` = 44544;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(44544, 0, 3, 685904631, 1151040, 32, 65536, 0, 3, 0, 2, 0, 0, 0, 0, 0);

DELETE FROM `spell_script_names` WHERE `spell_id` = 44544 AND `ScriptName` = 'spell_mage_fingers_of_frost_aurastate';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(44544, 'spell_mage_fingers_of_frost_aurastate');
