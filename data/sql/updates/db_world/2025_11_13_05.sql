-- DB update 2025_11_13_04 -> 2025_11_13_05
-- Makes sure the Shaman player gets the required ritual toch item and that requires the quest to drop
UPDATE `item_loot_template` SET `Chance` = 0, `QuestRequired` = 1, `GroupId` = 1 WHERE `Entry` = 24336 AND `Item` = 23682;
UPDATE `item_loot_template` SET `Chance` = 0, `GroupId` = 2 WHERE `Entry` = 24336 AND `Item` = 24335;
