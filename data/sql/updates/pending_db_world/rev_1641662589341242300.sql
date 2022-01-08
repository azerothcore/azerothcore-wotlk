INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641662589341242300');

DELETE FROM `reference_loot_template` WHERE `item` IN (2020,1680,1986,1677,1933);

DELETE FROM `creature_loot_template` WHERE `entry`=539 AND `item`=2020;
INSERT INTO `creature_loot_template` VALUES
(539,2020,0,1.07,0,1,0,1,1,'Pygmy Venom Web Spider - Hollowfang Blade');

DELETE FROM `creature_loot_template` WHERE `entry`=723 AND `item`=1680;
INSERT INTO `creature_loot_template` VALUES
(723,1680,0,32,0,1,0,1,1,'Mosh\'Ogg Butcher - Headchopper');

DELETE FROM `creature_loot_template` WHERE `entry`=709 AND `item`=1986;
INSERT INTO `creature_loot_template` VALUES
(709,1986,0,3.19,0,1,0,1,1,'Mosh\'Ogg Warmonger - Gutrender');

DELETE FROM `creature_loot_template` WHERE `entry`=680 AND `item`=1677;
INSERT INTO `creature_loot_template` VALUES
(680,1677,0,2.72,0,1,0,1,1,'Mosh\'Ogg Lord - Drake-scale Vest');

DELETE FROM `creature_loot_template` WHERE `entry`=619 AND `item`=1933;
INSERT INTO `creature_loot_template` VALUES
(619,1933,0,5.76,0,1,0,1,1,'Defias Conjurer - Staff of Conjuring');
