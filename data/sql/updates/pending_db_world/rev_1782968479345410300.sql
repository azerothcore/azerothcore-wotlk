-- Fix Infected Kodo Beast (entry 25596, quest 11690 "Bring 'Em Back Alive")
-- forcibly dismounting the rider near Warsong Hold / Warsong Slaughterhouse.
-- The creature's vehicle conditions (SmartAI::CheckConditions, checked every
-- ~1s) only allow AreaId 3537, 4141 or 4144 before ejecting the passenger via
-- ExitVehicle(). Area 4143 (Warsong Slaughterhouse), confirmed via .gps at
-- the exact spot the dismount was reported, is missing from that list, so
-- riders passing through it get bounced immediately and repeatedly.
-- https://github.com/azerothcore/azerothcore-wotlk/issues/26412
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 16 AND `SourceEntry` = 25596;
INSERT INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
     `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`,
     `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
    (16, 0, 25596, 0, 0, 23, 0, 3537, 0, 0, 0, 0, 0, '', 'Dismount player when not in intended zone'),
    (16, 0, 25596, 0, 1, 23, 0, 4141, 0, 0, 0, 0, 0, '', 'Dismount player when not in intended zone'),
    (16, 0, 25596, 0, 2, 23, 0, 4144, 0, 0, 0, 0, 0, '', 'Dismount player when not in intended zone'),
    (16, 0, 25596, 0, 3, 23, 0, 4143, 0, 0, 0, 0, 0, '', 'Dismount player when not in intended zone');
