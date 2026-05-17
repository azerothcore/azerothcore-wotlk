-- DB update 2026_05_17_05 -> 2026_05_17_06
--
UPDATE `item_loot_template` SET `Chance` = 0 WHERE `Entry` = 41888 AND `GroupId` = 1;
