--
UPDATE `creature_loot_template` SET `GroupId`=1, `MinCount`=1, `MaxCount`=2 WHERE `entry`=35360 AND `Item`=1;
DELETE FROM `creature_loot_template` WHERE `entry`=35360 AND `item` IN (3,4);
INSERT INTO `creature_loot_template` VALUES
(35360,3,34205,100,0,1,2,1,2,'Koralon the Flame Watcher (1) - (ReferenceTable)'),
(35360,4,34205,100,0,1,3,1,2,'Koralon the Flame Watcher (1) - (ReferenceTable)');

UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `entry`=34205 AND `item` IN (48658,48625,47770,47772,48623,48593,47803,47805,48591,48556,48064,48066,
48554,48499,48094,48096,48497,48464,48150,48152,48462,48394,48180,48182,48193,48195,48392,48364,48362,48334,48239,48241,48332,48303,48271,48273,48301,48660);
