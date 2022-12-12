--
-- 3329 Spiked Wooden Plank too high rate on AC
UPDATE `creature_loot_template` SET `Chance`=1.25 WHERE `Entry`=1753 AND `Item`=3329 AND `Reference`=0 AND `GroupId`=0;
-- 3335 Farmer's Broom cleanup drop rate on AC
UPDATE `creature_loot_template` SET `Chance`=7 WHERE `Entry`=1935 AND `Item`=3335 AND `Reference`=0 AND `GroupId`=0;
