-- DB update 2024_09_22_00 -> 2024_09_22_01
-- Unyielding Footman

-- Runecloth chance 50 (chance was 20)
UPDATE `creature_loot_template`
SET `Chance` = 50, `GroupId` = 1
WHERE `Entry` = 16904 AND `Item` = 14047;

-- Netherweave Cloth chance 25 (chance was 60)
UPDATE `creature_loot_template`
SET `Chance` = 25, `GroupId` = 1
WHERE `Entry` = 16904 AND `Item` = 21877;



-- Unyielding Sorcerer

-- Runecloth chance 50 (chance was 20)
UPDATE `creature_loot_template`
SET `Chance` = 50, `GroupId` = 1
WHERE `Entry` = 16905 AND `Item` = 14047;

-- Netherweave Cloth chance 25 (chance was 60)
UPDATE `creature_loot_template`
SET `Chance` = 25, `GroupId` = 1
WHERE `Entry` = 16905 AND `Item` = 21877;



-- Unyielding Knight

-- Runecloth chance 50 (chance was 20)
UPDATE `creature_loot_template`
SET `Chance` = 50, `GroupId` = 1
WHERE `Entry` = 16906 AND `Item` = 14047;

-- Netherweave Cloth chance 25 (chance was 60)
UPDATE `creature_loot_template`
SET `Chance` = 25, `GroupId` = 1
WHERE `Entry` = 16906 AND `Item` = 21877;

