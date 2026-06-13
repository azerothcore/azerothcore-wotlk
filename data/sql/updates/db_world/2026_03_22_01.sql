-- DB update 2026_03_22_00 -> 2026_03_22_01
--
-- Fix Quest 9927 (Ruthless Cunning): banner spell 32307 conditions only checked for Kil'sorrow Deathsworn (17148)
-- Each ElseGroup should check a different Kil'sorrow creature so banners work on all applicable mobs
-- No double-banner check needed: SpellEffects.cpp already removes corpse after banner placement

-- Remove old conditions for spell 32307 and insert corrected ones: CONDITION_NEAR_CREATURE (29) per mob
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 32307;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 32307, 0, 0, 29, 0, 17148, 5, 1, 0, 12, 0, '', 'Spell Place Kil''sorrow Banner requires nearby Kil''sorrow Deathsworn'),
(17, 0, 32307, 0, 1, 29, 0, 17147, 5, 1, 0, 12, 0, '', 'Spell Place Kil''sorrow Banner requires nearby Kil''sorrow Cultist'),
(17, 0, 32307, 0, 2, 29, 0, 17146, 5, 1, 0, 12, 0, '', 'Spell Place Kil''sorrow Banner requires nearby Kil''sorrow Spellbinder'),
(17, 0, 32307, 0, 3, 29, 0, 18391, 5, 1, 0, 12, 0, '', 'Spell Place Kil''sorrow Banner requires nearby Giselda the Crone');
