-- DB update 2023_05_24_02 -> 2023_05_24_03
--
UPDATE `creature_loot_template` SET `GroupId` = 1 WHERE (`Entry` = 17370) AND (`Item` IN (1, 2, 3, 4, 5, 6));
UPDATE `creature_loot_template` SET `Chance` = 5 WHERE (`Entry` = 17370) AND (`Item` IN (1, 2));
UPDATE `creature_loot_template` SET `Chance` = 1 WHERE (`Entry` = 17370) AND (`Item` IN (3, 4, 5, 6));

UPDATE `creature_loot_template` SET `GroupId` = 1 WHERE (`Entry` = 18620) AND (`Item` IN (1, 2, 3, 4, 5, 6, 7));
UPDATE `creature_loot_template` SET `Chance` = 5 WHERE (`Entry` = 18620) AND (`Item` IN (1, 2));
UPDATE `creature_loot_template` SET `Chance` = 1 WHERE (`Entry` = 18620) AND (`Item` IN (3, 4, 5, 6, 7));
