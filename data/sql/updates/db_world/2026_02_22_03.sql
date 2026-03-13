-- DB update 2026_02_22_02 -> 2026_02_22_03
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` IN (1267174, 1266870, 1267579, 1268083) AND `SourceEntry` = 43876 AND `ConditionTypeOrReference` = 7 AND `ConditionValue1` = 197;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(10, 1266870, 43876, 0, 0, 7, 0, 197, 1, 0, 0, 0, 0, '', 'Player must have Tailoring Skill to loot A Guide to Northern Cloth Scavenging'),
(10, 1267174, 43876, 0, 0, 7, 0, 197, 1, 0, 0, 0, 0, '', 'Player must have Tailoring Skill to loot A Guide to Northern Cloth Scavenging'),
(10, 1267579, 43876, 0, 0, 7, 0, 197, 1, 0, 0, 0, 0, '', 'Player must have Tailoring Skill to loot A Guide to Northern Cloth Scavenging'),
(10, 1268083, 43876, 0, 0, 7, 0, 197, 1, 0, 0, 0, 0, '', 'Player must have Tailoring Skill to loot A Guide to Northern Cloth Scavenging');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` IN (1260002) AND `SourceEntry` IN (42172,42173,42175,42176,42177,42178) AND `ConditionTypeOrReference` = 1 AND `ConditionValue1` IN (55993,55994,55996,55998,55997,55999);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(10, 1260002, 42172, 0, 0, 1, 0, 55993, 0, 0, 1, 0, 0, '', 'Player must not know this Tailoring pattern already'),
(10, 1260002, 42173, 0, 0, 1, 0, 55994, 0, 0, 1, 0, 0, '', 'Player must not know this Tailoring pattern already'),
(10, 1260002, 42175, 0, 0, 1, 0, 55996, 0, 0, 1, 0, 0, '', 'Player must not know this Tailoring pattern already'),
(10, 1260002, 42176, 0, 0, 1, 0, 55998, 0, 0, 1, 0, 0, '', 'Player must not know this Tailoring pattern already'),
(10, 1260002, 42177, 0, 0, 1, 0, 55997, 0, 0, 1, 0, 0, '', 'Player must not know this Tailoring pattern already'),
(10, 1260002, 42178, 0, 0, 1, 0, 55999, 0, 0, 1, 0, 0, '', 'Player must not know this Tailoring pattern already');
