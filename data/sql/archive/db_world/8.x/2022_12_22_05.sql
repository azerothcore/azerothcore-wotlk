-- DB update 2022_12_22_04 -> 2022_12_22_05
--
UPDATE `creature_loot_template` SET `Chance`=30 WHERE `Entry`=16951 AND `Item`=23269 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`=30 WHERE `Entry` IN (19442, 16871, 16873, 16907, 19422, 19424, 19457) AND `Item`=30425 AND `Reference`=0 AND `GroupId`=0;
