--

DELETE FROM `creature_loot_template` WHERE `Reference` = 24076;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(594,24076,24076,5,0,1,1,1,1,"Defias Henchman - (ReferenceTable)");
