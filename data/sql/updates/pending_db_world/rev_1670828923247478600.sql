--
-- 3325 Vile Fin Battle Axe satisfactory drop rate on AC
-- 3327 Vile Fin Oracle Staff satisfactory drop rate on AC
-- 4263 Standard Issue Shield satisfactory drop rate on AC
-- 3329 Spiked Wooden Plank too high rate on AC
UPDATE `creature_loot_template` SET `Chance`=1.25 WHERE `Entry`=1753 AND `Item`=3329 AND `Reference`=0 AND `GroupId`=0;
-- 3328 Spider Web Robe satisfactory drop rate on AC
-- 3319 Short Sabre satisfactory drop rate on AC
-- 3332 Perrine's Boots agree with drop rate on AC
-- 3331 Melrache's Cape agree with drop rate on AC
-- 3321 Gray Fur Booties agree with drop rate on AC
-- 3330 Dargol's Hauberk agree with drop rate on AC
-- 3335 Farmer's Broom cleanup drop rate on AC
UPDATE `creature_loot_template` SET `Chance`=7 WHERE `Entry`=1935 AND `Item`=3335 AND `Reference`=0 AND `GroupId`=0;
