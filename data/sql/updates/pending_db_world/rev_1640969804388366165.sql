INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640969804388366165');

-- removes loot id 7549 link from Tree Frog
UPDATE `creature_template` SET `lootid`=0 WHERE  `entry`=7549;

-- Removes Loot from creature Tree Frog NPC ID 7549
DELETE FROM `creature_loot_template` WHERE  `Entry`=7549 AND `Item`=18255 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE  `Entry`=7549 AND `Item`=18297 AND `Reference`=0 AND `GroupId`=0;
