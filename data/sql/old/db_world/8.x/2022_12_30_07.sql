-- DB update 2022_12_30_06 -> 2022_12_30_07
--
-- Deathknell Zone Drops
UPDATE `creature_loot_template` SET `Chance`=80, `Comment`='Night Web Matriarch - Webbed Cloak' WHERE `Entry`=1688 AND `Item`=3261 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`=1, `Comment`='Night Web Spider - Webbed Pants' WHERE `Entry`=1505 AND `Item`=3263 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`=1.5 WHERE `Entry`=1917 AND `Item`=3293 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`=0.9 WHERE `Entry`=1919 AND `Item`=3295 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`=1.25 WHERE `Entry`=1506 AND `Item`=2754 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`=1.25 WHERE `Entry`=1507 AND `Item`=3260 AND `Reference`=0 AND `GroupId`=0;
