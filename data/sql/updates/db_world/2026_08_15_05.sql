-- DB update 2026_08_15_04 -> 2026_08_15_05
--
DELETE FROM `reference_loot_template` WHERE (`Entry` = 10016) AND (`Item` IN (48679, 48681, 49667));

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 10) AND (`SourceGroup` = 10016) AND (`SourceEntry` IN (48679, 48681, 49667));

DELETE FROM `item_loot_template` WHERE (`Entry` = 46007) AND (`Item` IN (48679, 48681, 49667));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(46007, 49667, 0, 2, 0, 1, 0, 1, 1, 'Bag of Fishing Treasures - Waterlogged Recipe, Starts Non-repeatable Quest 24431'),
(46007, 48679, 0, 2, 0, 1, 0, 1, 1, 'Bag of Fishing Treasures - Waterlogged Recipe, Starts Repeatable Quest 14203');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 5) AND (`SourceGroup` = 46007) AND (`SourceEntry` IN (48679, 48681, 49667));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(5, 46007, 49667, 0, 0, 7, 0, 185, 300, 0, 0, 0, 0, '', 'Only drop "Waterlogged Recipe" (49667) from "Bag of Fishing Treasures" (46007) if the player has at least 300 cooking skill'),
(5, 46007, 48679, 0, 0, 7, 0, 185, 300, 0, 0, 0, 0, '', 'Only drop "Waterlogged Recipe" (48679) from "Bag of Fishing Treasures" (46007) if the player has at least 300 cooking skill'),
(5, 46007, 48679, 0, 0, 47, 0, 24431, 64, 0, 0, 0, 0, '', 'Only drop "Waterlogged Recipe" (48679) if the player has been rewarded the non-repeatable quest "Waterlogged Recipe" (24431)');
