-- DB update 2026_04_27_00 -> 2026_04_28_00
--
DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 26860);
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26860, 44651, 0, 100, 1, 1, 1, 1, 1, 'Heart of Magic - Heart of Magic - 25m'),
(26860, 44650, 0, 100, 1, 1, 2, 1, 1, 'Heart of Magic - Heart of Magic - 10m');

DELETE FROM `gameobject_questitem` WHERE (`GameObjectEntry` = 194159) AND (`Idx` IN (1));
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(194159, 1, 44650, 0);
