INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621006948502272600');
INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621006207136934630');
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 4329) AND (`Item` IN (4234, 4235, 4304, 8165, 8169));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4329, 4234, 0, 34, 0, 1, 0, 1, 2, 'Firemane Scout - Heavy Leather'),
(4329, 4235, 0, 5, 0, 1, 0, 1, 1, 'Firemane Scout - Heavy Hide'),
(4329, 4304, 0, 51, 0, 1, 0, 1, 2, 'Firemane Scout - Thick Leather'),
(4329, 8165, 0, 5, 0, 1, 0, 1, 2, 'Firemane Scout - Worn Dragonscale'),
(4329, 8169, 0, 5, 0, 1, 0, 1, 1, 'Firemane Scout - Thick Hide');

DELETE FROM `skinning_loot_template` WHERE (`Entry` = 4331) AND (`Item` IN (4234, 4304, 8169));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4331, 4234, 0, 35, 0, 1, 0, 1, 2, 'Firemane Ash Tail - Heavy Leather'),
(4331, 4304, 0, 49, 0, 1, 0, 1, 2, 'Firemane Ash Tail - Thick Leather'),
(4331, 8169, 0, 6, 0, 1, 0, 1, 1, 'Firemane Ash Tail - Thick Hide');

DELETE FROM `skinning_loot_template` WHERE (`Entry` = 4328) AND (`Item` IN (4234, 4235, 4304, 8165, 8169));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4328, 4234, 0, 35, 0, 1, 0, 1, 2, 'Firemane Scalebane - Heavy Leather'),
(4328, 4235, 0, 5, 0, 1, 0, 1, 1, 'Firemane Scalebane - Heavy Hide'),
(4328, 4304, 0, 50, 0, 1, 0, 1, 2, 'Firemane Scalebane - Thick Leather'),
(4328, 8165, 0, 5, 0, 1, 0, 1, 2, 'Firemane Scalebane - Worn Dragonscale'),
(4328, 8169, 0, 5, 0, 1, 0, 1, 1, 'Firemane Scalebane - Thick Hide');

DELETE FROM `skinning_loot_template` WHERE (`Entry` = 4334) AND (`Item` IN (4234, 4235, 4304, 8165, 8169));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4334, 4234, 0, 35, 0, 1, 0, 1, 2, 'Firemane Flamecaller - Heavy Leather'),
(4334, 4235, 0, 5, 0, 1, 0, 1, 1, 'Firemane Flamecaller - Heavy Hide'),
(4334, 4304, 0, 50, 0, 1, 0, 1, 2, 'Firemane Flamecaller - Thick Leather'),
(4334, 8165, 0, 4, 0, 1, 0, 1, 2, 'Firemane Flamecaller - Worn Dragonscale'),
(4334, 8169, 0, 5, 0, 1, 0, 1, 1, 'Firemane Flamecaller - Thick Hide');
