-- Update gameobject 'Transpolyporter' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (143230, 142175))
AND (`guid` IN (11010, 32372));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(11010, 143230, 0, 0, 0, 1, 1, -14468.337890625, 457.59954833984375, 15.16606616973876953, 0.139624491333961486, 0, 0, 0.06975555419921875, 0.997564136981964111, 120, 255, 1, "", 45572, NULL),
(32372, 142175, 0, 0, 0, 1, 1, -5096.5966796875, 750.10186767578125, 260.55023193359375, 2.687806606292724609, 0, 0, 0.974370002746582031, 0.224951311945915222, 120, 255, 1, "", 46779, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (142172))
AND (`guid` IN (28));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(28, 142172, 0, 0, 0, 1, 1, -14468.0830078125, 457.62255859375, 15.16595935821533203, 2.146752834320068359, 0, 0, 0.878816604614257812, 0.477159708738327026, 120, 255, 1, "", 45572, NULL);

-- add missing condition
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 11409) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 2) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 9173) AND (`ConditionValue2` = 1) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 11409, 0, 0, 2, 1, 9173, 1, 0, 0, 0, 0, '', 'Requires Target to have item');
