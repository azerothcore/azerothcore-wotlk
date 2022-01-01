INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641060833240410684');

-- Delete and rebuild based on UDB, play thru retail, and feedback from prior udb team about it
DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 11103) AND (`Item` IN (11751, 11752, 11753));

-- These items are Quest Required
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
-- item 11751 burning essense is a quest item for quest 4483 which is a retrieval quest not a % loot quest
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

-- Conditions to ensure it only drops only durning quests
DELETE FROM `conditions` WHERE `SourceGroup`='11103' AND `SourceEntry`='11751' AND `ConditionValue1`='4483' AND `ConditionTypeOrReference`='9';
INSERT INTO `conditions` SET 
	`SourceTypeOrReferenceId`='4', -- gameobject loot template
	`SourceGroup`='11103', -- gameobject
	`SourceEntry`='11751', -- item id
	`SourceId`='0',
	`ElseGroup`='0',
	`ConditionTypeOrReference`='9', -- CONDITION_QUESTTAKEN
	`ConditionTarget`='0', -- player
	`ConditionValue1`='4483', -- quest ID
	`ConditionValue2`='0', -- always 0
	`ConditionValue3`='0', -- always 0
	`NegativeCondition`='0',
	`ErrorTextId`='0',
	`ScriptName`='',
	`Comment`="Loot Dark Coffer - Burning Essence while quest 4483 is active";

DELETE FROM `conditions` WHERE `SourceGroup`='11103' AND `SourceEntry`='11752' AND `ConditionValue1`='4463' AND `ConditionTypeOrReference`='9';
INSERT INTO `conditions` SET 
	`SourceTypeOrReferenceId`='4', -- gameobject loot template
	`SourceGroup`='11103', -- gameobject
	`SourceEntry`='11752', -- item id
	`SourceId`='0',
	`ElseGroup`='0',
	`ConditionTypeOrReference`='9', -- CONDITION_QUESTTAKEN
	`ConditionTarget`='0', -- player
	`ConditionValue1`='4463', -- quest ID
	`ConditionValue2`='0', -- always 0
	`ConditionValue3`='0', -- always 0
	`NegativeCondition`='0',
	`ErrorTextId`='0',
	`ScriptName`='',
	`Comment`="Loot Dark Coffer - Black Blood of the Tormented while quest 4463 is active";

DELETE FROM `conditions` WHERE `SourceGroup`='11103' AND `SourceEntry`='11753' AND `ConditionValue1`='4482' AND `ConditionTypeOrReference`='9';
INSERT INTO `conditions` SET 
	`SourceTypeOrReferenceId`='4', -- gameobject loot template
	`SourceGroup`='11103', -- gameobject
	`SourceEntry`='11753', -- item id
	`SourceId`='0',
	`ElseGroup`='0',
	`ConditionTypeOrReference`='9', -- CONDITION_QUESTTAKEN
	`ConditionTarget`='0', -- player
	`ConditionValue1`='4482', -- quest ID
	`ConditionValue2`='0', -- always 0
	`ConditionValue3`='0', -- always 0
	`NegativeCondition`='0',
	`ErrorTextId`='0',
	`ScriptName`='',
	`Comment`="Loot Dark Coffer - Eye of Kajal while quest 4482 is active";
