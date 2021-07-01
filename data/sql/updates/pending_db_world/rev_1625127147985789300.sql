INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625127147985789300');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3376) AND (`Item` IN (5017, 5018, 5019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3376, 5017, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Soldier - Nitroglycerin'),
(3376, 5018, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Soldier - Wood Pulp'),
(3376, 5019, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Soldier - Sodium Nitrate');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3377) AND (`Item` IN (5017, 5018, 5019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3377, 5017, 0, 29, 1, 1, 0, 1, 1, 'Bael\'dun Rifleman - Nitroglycerin'),
(3377, 5018, 0, 29, 1, 1, 0, 1, 1, 'Bael\'dun Rifleman - Wood Pulp'),
(3377, 5019, 0, 29, 1, 1, 0, 1, 1, 'Bael\'dun Rifleman - Sodium Nitrate');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3378) AND (`Item` IN (5017, 5018, 5019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3378, 5017, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Officer - Nitroglycerin'),
(3378, 5018, 0, 28, 1, 1, 0, 1, 1, 'Bael\'dun Officer - Wood Pulp'),
(3378, 5019, 0, 27, 1, 1, 0, 1, 1, 'Bael\'dun Officer - Sodium Nitrate');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 6668) AND (`Item` IN (5017, 5018, 5019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6668, 5017, 0, 7, 1, 1, 0, 1, 1, 'Lord Cyrik Blackforge - Nitroglycerin'),
(6668, 5018, 0, 7, 1, 1, 0, 1, 1, 'Lord Cyrik Blackforge - Wood Pulp'),
(6668, 5019, 0, 7, 1, 1, 0, 1, 1, 'Lord Cyrik Blackforge - Sodium Nitrate');