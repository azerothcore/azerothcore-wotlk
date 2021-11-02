INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635882858166720225');

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 11103) AND (`Item` IN (11751, 11752, 11753));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11103, 11751, 0, 46, 0, 1, 0, 2, 1, 'Dark Coffer - Burning Essence'),
(11103, 11752, 0, 43, 0, 1, 0, 2, 1, 'Dark Coffer - Black Blood of the Tormented'),
(11103, 11753, 0, 39, 0, 1, 0, 1, 1, 'Dark Coffer - Eye of Kajal');

