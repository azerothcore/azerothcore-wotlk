-- DB update 2023_10_18_01 -> 2023_10_18_02
-- Strange Engine Part
DELETE FROM `gameobject_loot_template` WHERE `Entry` = 19605 AND `Item` = 34469;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19605, 34469, 0, 0.5, 0, 1, 1, 1, 1, 'Strange Engine Part');

-- Make it repeatable + correct gold reward
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`|1 WHERE (`ID` = 11531);
UPDATE `quest_template` SET `RewardBonusMoney` = 75900 WHERE (`ID` = 11531);
