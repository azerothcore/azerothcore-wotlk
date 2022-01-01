INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641060833240410684');

-- Delete and rebuild based on UDB, play thru retail, and feedback from prior udb team about it
DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 11103) AND (`Item` IN (11751, 11752, 11753));

-- These items are Quest Required
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
-- item 4483 burning essense is a quest item for quest 4483 which is a retrieval quest not a % loot quest
(11103, 11751, 0, 100, 1, 1, 0, 1, 1, 'Dark Coffer - Burning Essence'),

-- item 11752 Black Blood of the Tormentede is a quest item for quest 4463 which is a retrieval quest not a % loot quest
(11103, 11752, 0, 100, 1, 1, 0, 1, 1, 'Dark Coffer - Black Blood of the Tormented'),

-- item 11753 Eye of Kajal is a quest item for quest 4482 which is a retrieval quest not a % loot quest
(11103, 11753, 0, 100, 1, 1, 0, 1, 1, 'Dark Coffer - Eye of Kajal');

-- Adds items to the questitem objective with gameobject
-- Added deletes for re-runability, but they are not in the table
DELETE FROM `gameobject_questitem` WHERE `GameObjectEntry`=11103 AND `Idx`=0;
DELETE FROM `gameobject_questitem` WHERE `GameObjectEntry`=11103 AND `Idx`=0;
DELETE FROM `gameobject_questitem` WHERE `GameObjectEntry`=11103 AND `Idx`=0;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES 
(11103, 0, 11751, 0),
(11103, 0, 11752, 0),
(11103, 0, 11753, 0);
