-- DB update 2023_04_19_11 -> 2023_04_19_12
DELETE FROM `creature_loot_template` WHERE (`Entry` = 18708) AND (`Item` IN (24309));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18708, 24309, 0, 10, 0, 1, 0, 1, 1, 'Murmur - Pattern: Spellstrike Pants');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` = 18708) AND (`SourceEntry` = 24309);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 18708, 24309, 0, 0, 7, 0, 197, 1, 0, 0, 0, 0, '', 'Requires Tailoring Skill ID 197, Minimum Skill Value 1');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 16807) AND (`Item` IN (24312));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16807, 24312, 0, 10, 0, 1, 0, 1, 1, 'Grand Warlock Nethekurse - Pattern: Spellstrike Hood');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` = 16807) AND (`SourceEntry` = 24312);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 16807, 24312, 0, 0, 7, 0, 197, 1, 0, 0, 0, 0, '', 'Requires Tailoring Skill ID 197, Minimum Skill Value 1');

UPDATE `creature_loot_template` SET `Chance`=10 WHERE `Item`=24313;

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17978) AND (`Item` IN (24310));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17978, 24310, 0, 10, 0, 1, 0, 1, 1, 'Thorngrin the Tender - Pattern: Battlecast Pants');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` = 17978) AND (`SourceEntry` = 24310);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 17978, 24310, 0, 0, 7, 0, 197, 1, 0, 0, 0, 0, '', 'Requires Tailoring Skill ID 197, Minimum Skill Value 1');
