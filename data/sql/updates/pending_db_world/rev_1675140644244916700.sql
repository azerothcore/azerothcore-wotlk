--

DELETE FROM `reference_loot_template` WHERE `Entry` = 24076 AND `Item` = 1927;

DELETE FROM `creature_loot_template` WHERE `Entry` = 594 AND `Item` = 1927;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(594,1927,0,6,0,1,1,1,1,"Defias Henchman - Deadmines Cleaver");
