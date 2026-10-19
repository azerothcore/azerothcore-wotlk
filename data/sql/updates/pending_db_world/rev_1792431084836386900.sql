--
-- Acherus teleport pads: only hit units on the pad's own floor
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (54699, 54725, 54744, 54746)) AND (`ConditionTypeOrReference` = 35);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 54699, 0, 0, 35, 0, 1, 3, 4, 0, 0, 0, '', 'Teleport to Heart of Acherus (54699) - Only hit targets within 3 yards of caster'),
(13, 1, 54725, 0, 0, 35, 0, 1, 3, 4, 0, 0, 0, '', 'Teleport to Hall of Command (54725) - Only hit targets within 3 yards of caster'),
(13, 1, 54744, 0, 0, 35, 0, 1, 3, 4, 0, 0, 0, '', 'Teleport to Heart of Acherus (54744) - Only hit targets within 3 yards of caster'),
(13, 1, 54746, 0, 0, 35, 0, 1, 3, 4, 0, 0, 0, '', 'Teleport to Hall of Command (54746) - Only hit targets within 3 yards of caster');
