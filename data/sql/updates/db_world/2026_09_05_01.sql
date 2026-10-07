-- DB update 2026_09_05_00 -> 2026_09_05_01
-- Fuel for the Fire: Flatulate only affects Drakkari Skullcrushers, excluding the abomination and players.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 52497;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
    `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
    `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 52497, 0, 0, 31, 0, 3, 28844, 0, 0, 0, 0, '', 'Flatulate - Target Drakkari Skullcrusher');
