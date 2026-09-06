-- DB update 2025_12_29_10 -> 2025_12_29_11
UPDATE `reference_loot_template` SET `Chance` = 5 WHERE `Entry` = 6010 AND `Item` = 1 AND `Reference` = 4000;
UPDATE `reference_loot_template` SET `Chance` = 5 WHERE `Entry` = 6010 AND `Item` = 2 AND `Reference` = 4001;
