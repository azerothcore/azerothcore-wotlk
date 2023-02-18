-- DB update 2022_10_29_04 -> 2022_10_30_00
--
UPDATE `creature_loot_template` SET `Chance`=100 WHERE `Entry` IN (20798, 19298) AND `Item` IN (29590, 29588);
