-- DB update 2023_01_06_00 -> 2023_01_06_01
--
-- Worn Stone Tokens are 100%
UPDATE `creature_loot_template` SET `Chance`=100 WHERE `Item`=3714 AND `entry` IN (2271, 2272, 2358, 2415, 2628);

-- Encrusted Tail Fins should be 100% and only off Saltscale Murlocs
UPDATE `creature_loot_template` SET `Chance`=100 WHERE `Item`=5796 AND `entry` IN (871, 873, 875, 877, 879);
DELETE FROM `creature_loot_template` WHERE  `Entry` IN (4457, 4458, 4459, 4460, 4461) AND `Item`=5796 AND `Reference`=0 AND `GroupId`=0;
