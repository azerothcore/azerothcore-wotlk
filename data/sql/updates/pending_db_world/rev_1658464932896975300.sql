--
DELETE FROM `reference_loot_template` WHERE  (`Entry`=35026) AND (`Item` IN (22406, 22404));

DELETE FROM `creature_loot_template` WHERE (`Entry` = 10997) AND (`Item` IN (35026, 35027, 22406, 22404));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10997, 35026, 35026, 100, 0, 1, 1, 1, 1, 'Cannon Master Willey - (ReferenceTable)'),
(10997, 35027, 35026, 100, 0, 1, 2, 1, 1, 'Cannon Master Willey - (ReferenceTable)'),
(10997, 22406, 0, 10, 0, 1, 1, 1, 1, ''),
(10997, 22404, 0, 8, 0, 1, 2, 1, 1, '');
