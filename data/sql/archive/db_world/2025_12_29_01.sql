-- DB update 2025_12_29_00 -> 2025_12_29_01
-- Fix A Sister's Pledge (12411) spawning multiple Sasha when turned in by multiple players
-- Add condition to prevent Sasha spawn if she already exists nearby
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 27646 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 27646, 0, 0, 29, 1, 26935, 50, 0, 1, 0, 0, '', 'Anya - Quest reward chain only if Sasha is not already nearby');
