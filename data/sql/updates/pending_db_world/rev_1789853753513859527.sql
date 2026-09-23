-- Zul'Farrak grave summons: use the Loot Normalization (#24398) world loot pools.
-- Gultask's WotLK Classic research (builds 49822, 52237 and 54261):
-- https://github.com/azerothcore/azerothcore-wotlk/pull/27381#issuecomment-5798468763
-- Keep Troll Sweat, cloth, food, ZF junk and quest drops unchanged.
-- Remove direct world drops supplied by the normalized references to avoid duplicate rolls.
DELETE FROM `creature_loot_template` WHERE `Entry` IN (7276, 7286) AND `Reference` = 0 AND `Item` IN
    (1685,3395,3831,3832,3864,3868,3873,3874,3914,3928,4300,4353,4416,4417,4419,4421,4422,4424,
    4637,4638,5974,6149,7084,7085,7086,7453,7909,7910,7975,7989,7990,7992,7993,8029,8386,8387,
    8389,8390,9293,9295,9298,10300,10301,10302,10312,10315,10320,10603,10604,10606,11167,11202,
    11204,11208,11225,12684,13068);
DELETE FROM `creature_loot_template` WHERE `Entry` IN (7276, 7286) AND `Reference` <> 0;
INSERT INTO `creature_loot_template`
(`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
    (7276, 1, 1000145, 0, 0, 1, 5, 1, 1, 'Zul''Farrak Dead Hero - World Loot Level 45'),
    (7276, 2, 1000146, 0, 0, 1, 5, 1, 1, 'Zul''Farrak Dead Hero - World Loot Level 46'),
    (7286, 1, 1000343, 0, 0, 1, 5, 1, 1, 'Zul''Farrak Zombie - World Loot Level 43'),
    (7286, 2, 1000344, 0, 0, 1, 5, 1, 1, 'Zul''Farrak Zombie - World Loot Level 44'),
    (7286, 209, 1209000, 0.5, 0, 1, 0, 1, 1, 'Zul''Farrak Zombie - Zul''Farrak BoEs');

-- Money research from the same sniffs:
-- https://github.com/azerothcore/azerothcore-wotlk/pull/27381#issuecomment-5798878487
-- Zombie bounds are inferred from comparable level 44 ZF elites; keep Dead Hero money unchanged.
UPDATE `creature_template` SET `mingold` = 186, `maxgold` = 1438 WHERE `entry` = 7286;
-- Observed grave money range, in copper. This addon table has no VerifiedBuild column.
UPDATE `gameobject_template_addon` SET `mingold` = 18, `maxgold` = 131 WHERE `entry` IN (128308, 128403);
