-- DB update 2026_08_20_06 -> 2026_08_20_07
--
-- Sartharion (Obsidian Sanctum 25-man) base gear loot pool structure
-- Splits the single 10-item ilvl 213 gear pool of reference 34166 into the two pools
-- evidenced by recorded retail kills (21 kills), so each kill yields exactly one item
-- from each pool instead of two draws from one pool.
-- Issue: azerothcore/azerothcore-wotlk#26276

-- Sartharion 25-man (2 pools: 5+5)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
    WHERE `Entry`=31311 AND `Item`=1 AND `Reference`=34166;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34166 AND `Item`=40431; -- Fury of the Five Flights
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34166 AND `Item`=40437; -- Concealment Shoulderpads
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34166 AND `Item`=40446; -- Dragon Brood Legguards
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34166 AND `Item`=40451; -- Hyaline Helm of the Sniper
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34166 AND `Item`=40453; -- Chestplate of the Great Aspects

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34166 AND `Item`=40432; -- Illustration of the Dragon Soul
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34166 AND `Item`=40433; -- Wyrmrest Band
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34166 AND `Item`=40438; -- Council Chamber Epaulets
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34166 AND `Item`=40439; -- Mantle of the Eternal Sentinel
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34166 AND `Item`=40455; -- Staff of Restraint
