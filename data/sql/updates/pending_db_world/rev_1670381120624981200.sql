--
-- Deathknell Zone Drops
-- Night Web Matriarch should drop Webbed Cloak most of the time (~80%  Wowhead estimate, seems fair based off testing)
UPDATE `creature_loot_template` SET `Chance`=80, `Comment`='Night Web Matriarch - Webbed Cloak' WHERE `Entry`=1688 AND `Item`=3261 AND `Reference`=0 AND `GroupId`=0;
-- Night Web Crawlers should drop Webbed Pants (sniff 5/~410, wowhead estimate 1% based on robust error adjusted wowhead data
UPDATE `creature_loot_template` SET `Chance`=1, `Comment`='Night Web Spider - Webbed Pants' WHERE `Entry`=1505 AND `Item`=3263 AND `Reference`=0 AND `GroupId`=0;
-- Putrid Wooden Hammer 3/369 off Rattlecage Skeleton, but 2% is in line with robust error adjusted wowhead data, leaving unchanged from AC
-- Deadman Cleaver off Daniel Ulfman (~3/300 sniff, wowhead 10/567 1.5% seems fair)
UPDATE `creature_loot_template` SET `Chance`=1.5 WHERE `Entry`=1917 AND `Item`=3293 AND `Reference`=0 AND `GroupId`=0;
-- Deadman Dagger off Stephan Bartec (~7/300 sniff, wowhead 9/518 2% seems fair, leaving unchanged from AC)
-- 1 Deadman Blade off Samuel Flipps (~1/300 sniff, wowhead 48/5208 0.9% seems fair)
UPDATE `creature_loot_template` SET `Chance`=0.9 WHERE `Entry`=1919 AND `Item`=3295 AND `Reference`=0 AND `GroupId`=0;
-- 1 Deadman Club off Karrel Grayves (~1/300 sniff, wowhead 22/664 2% seems fair, leaving unchanged from AC)
-- 3 Tarnished Bastard Sword off 850 Scarlet Converts, 2 Scarlet Initiate Robes off ~250 Scarlet Initiates, 1.25% brings it in line with robust error adjusted wowhead data
UPDATE `creature_loot_template` SET `Chance`=1.25 WHERE `Entry`=1506 AND `Item`=2754 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`=1.25 WHERE `Entry`=1507 AND `Item`=3260 AND `Reference`=0 AND `GroupId`=0;