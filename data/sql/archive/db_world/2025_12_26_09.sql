-- DB update 2025_12_26_08 -> 2025_12_26_09
-- Winterskorn Vrykul Dismembering Bunny should only be giblet
DELETE FROM `creature_template_model` WHERE `CreatureID` = 24095;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(24095, 0, 1126, 1, 0, 51831),
(24095, 1, 25628, 1, 1, 51831);

-- Conditions
DELETE FROM `conditions` WHERE `SourceEntry` = 43036 AND `SourceTypeOrReferenceId` = 17;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 43036, 0, 0, 1, 1, 43059, 0, 0, 1, 0, 0, '', 'Spell 43036 (Dismembering Corpse) - Target must not already be transformed'),
(17, 0, 43036, 0, 0, 36, 1, 0, 0, 0, 1, 0, 0, '', 'Spell 43036 (Dismembering Corpse) - Explicit target must be dead');
