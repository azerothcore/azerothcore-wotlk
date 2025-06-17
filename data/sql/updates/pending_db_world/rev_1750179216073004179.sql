--
-- Creates the reference loot (40110) for Haunted Memento (40110)
DELETE FROM `reference_loot_template` WHERE `Entry` = 40110 AND `Item` = 40110;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(40110, 40110, 0, 100, 0, 1, 1, 1, 1, 'Scourge Invasion Event - Item: Haunted Memento');

-- Adds the reference loot (40110) above for the Haunted Memento (40110) to Ghoul Berserker (16141), Skeletal Shocktrooper (16298) and Spectral Soldier (16299)
DELETE FROM `creature_loot_template` WHERE `Entry` IN (16141, 16298, 16299) AND `Item` = 40110 AND `Reference` = 40110;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16141, 40110, 40110, 2, 0, 1, 1, 1, 1, 'Reference Loot: Scourge Invasion Event - Item: Haunted Memento'),
(16298, 40110, 40110, 2, 0, 1, 1, 1, 1, 'Reference Loot: Scourge Invasion Event - Item: Haunted Memento'),
(16299, 40110, 40110, 2, 0, 1, 1, 1, 1, 'Reference Loot: Scourge Invasion Event - Item: Haunted Memento');

-- Reference loot (40110) is only active during the Scourge Invasion Event (17)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` = 40110 AND `SourceEntry` = 40110 AND `SourceId` = 0 AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 12 AND `ConditionTarget` = 0 AND `ConditionValue1` = 17 AND `ConditionValue2` = 0 AND `ConditionValue3` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(10, 40110, 40110, 0, 0, 12, 0, 17, 0, 0, 0, 0, 0, '', 'Reference Loot: Item: Haunted Memento only drops during the Scourge Invasion Event (17)');
