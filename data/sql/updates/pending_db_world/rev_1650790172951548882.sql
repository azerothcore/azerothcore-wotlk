INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650790172951548882');

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 13574) AND (`Item` IN (12812));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13574, 12812, 0, 100, 0, 1, 0, 1, 1, 'Unfired Plate Gauntlets - Unfired Plate Gauntlets');
