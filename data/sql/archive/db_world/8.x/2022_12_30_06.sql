-- DB update 2022_12_30_05 -> 2022_12_30_06
--
UPDATE `creature_loot_template` SET `GroupId`=1, `MinCount`=1, `MaxCount`=2 WHERE `entry`=35360 AND `Item`=1;
DELETE FROM `creature_loot_template` WHERE `entry`=35360 AND `item` IN (3,4);
INSERT INTO `creature_loot_template` VALUES
(35360,3,34205,100,0,1,2,1,2,'Koralon the Flame Watcher (1) - (ReferenceTable)'),
(35360,4,34205,100,0,1,3,1,2,'Koralon the Flame Watcher (1) - (ReferenceTable)');

UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `entry`=34205 AND `item` IN (48658,48625,47770,47772,48623,48593,47803,47805,48591,48556,48064,48066,
48554,48499,48094,48096,48497,48464,48150,48152,48462,48394,48180,48182,48193,48195,48392,48364,48362,48334,48239,48241,48332,48303,48271,48273,48301,48660);

UPDATE `creature_loot_template` SET `GroupId`=1, `MinCount`=1, `MaxCount`=1 WHERE `entry`=35013 AND `Item`=1;
DELETE FROM `creature_loot_template` WHERE `entry`=35013 AND `item` IN (2,3);
INSERT INTO `creature_loot_template` VALUES
(35013,2,34204,100,0,1,2,1,1,'Koralon the Flame Watcher - (ReferenceTable)'),
(35013,3,34204,100,0,1,3,1,1,'Koralon the Flame Watcher - (ReferenceTable)');

UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `entry`=34204 AND `item` IN (48653,48630,47773,47775,48628,48598,47800,47802,48596,48561,48067,48069,
48559,48504,48097,48099,48502,48459,48153,48155,48457,48389,48183,48185,48190,48192,48387,48369,48367,48339,48244,48246,48337,48298,48276,48278,48296,48655);
