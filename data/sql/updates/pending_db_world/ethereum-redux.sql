UPDATE `creature_loot_template` SET `Chance` = 50, `GroupId` = 2 WHERE `Entry` = 20783 AND `Reference` IN (14501, 24013);
UPDATE `creature_loot_template` SET `Chance` = 50, `GroupId` = 1 WHERE `Entry` IN (20785, 20786, 20788, 20789, 20790) AND `Reference` IN (14501, 24013);
UPDATE `creature_loot_template` SET `Chance` = 50, `GroupId` = 1 WHERE `Entry` = 20784 AND `Reference` = 14501;

DELETE FROM `creature_loot_template` WHERE `Entry` = 20784 AND `Reference` = 24013;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20784, 24013, 24013, 50, 0, 1, 1, 1, 1, 'Armbreaker Huffaz - (ReferenceTable)');
