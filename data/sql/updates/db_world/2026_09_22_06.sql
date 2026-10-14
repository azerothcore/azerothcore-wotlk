-- DB update 2026_09_22_05 -> 2026_09_22_06
-- Champion's Purse: reduce the Champion's Seal drop chance to 10% (AC #27664).
UPDATE `item_loot_template` SET `Chance` = 10 WHERE `Entry` = 45724 AND `Item` = 44990 AND `Reference` = 0;
