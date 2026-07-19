-- Rocket Strike must only hit VX-001's mounted rocket visuals, otherwise the
-- area-entry target degrades to any nearby unit and VX-001 fires itself
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (64402, 65034)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 34050) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 64402, 0, 0, 31, 0, 3, 34050, 0, 0, 0, 0, '', 'Rocket Strike EFFECT_0 can only hit NPC_ROCKET_VISUAL'),
(13, 1, 65034, 0, 0, 31, 0, 3, 34050, 0, 0, 0, 0, '', 'Rocket Strike EFFECT_0 can only hit NPC_ROCKET_VISUAL');
