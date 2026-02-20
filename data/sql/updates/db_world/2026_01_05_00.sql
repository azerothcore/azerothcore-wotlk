-- DB update 2026_01_04_01 -> 2026_01_05_00
-- Everfrost Chip (quest starter) should always drop.
UPDATE `gameobject_loot_template` SET `Chance` = 100 WHERE `Entry` = 26782 AND `Item` = 44725;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 4) AND (`SourceGroup` = 26782) AND (`SourceEntry` = 44725) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 8) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 13420) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 26782, 44725, 0, 0, 8, 0, 13420, 0, 0, 1, 0, 0, '', 'Item: Everfrost Chip [44725] doesn\'t drop if Quest: Everfrost has been rewarded');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 4) AND (`SourceGroup` = 26782) AND (`SourceEntry` = 44725) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 13420) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 26782, 44725, 0, 0, 9, 0, 13420, 0, 0, 1, 0, 0, '', 'Item: Everfrost Chip [44725] doesn\'t drop if Quest: Everfrost is currently on quest log');

-- From "Everfrost Chip requires Sons of Hodir friendly"
UPDATE `conditions` SET `Comment` = 'Item: Everfrost Chip [44725] requires Sons of Hodir friendly or higher to appear' WHERE (`SourceTypeOrReferenceId` = 4) AND (`SourceGroup` = 26782) AND (`SourceEntry` = 44725) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 5) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 1119) AND (`ConditionValue2` = 240) AND (`ConditionValue3` = 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 4) AND (`SourceGroup` = 26782) AND (`SourceEntry` = 44724) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 8) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 13420) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 26782, 44724, 0, 0, 8, 0, 13420, 0, 0, 0, 0, 0, '', 'Item: Everfrost Chip [44724] requires  Quest: Everfrost to be completed to appear on loot');
