-- DB update 2020_07_23_00 -> 2020_07_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_23_00 2020_07_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590935747620234800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590935747620234800');
/*
 * Dungeon: The Arcatraz
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 984, `maxdmg` = 1453, `DamageModifier` = 1.03 WHERE `entry` = 20859;
UPDATE `creature_template` SET `mindmg` = 1383, `maxdmg` = 1864, `DamageModifier` = 1.03 WHERE `entry` = 21587;
UPDATE `creature_template` SET `mindmg` = 1064, `maxdmg` = 1570, `DamageModifier` = 1.03 WHERE `entry` = 20857;
UPDATE `creature_template` SET `mindmg` = 1364, `maxdmg` = 2013, `DamageModifier` = 1.03 WHERE `entry` = 21585;
UPDATE `creature_template` SET `mindmg` = 1064, `maxdmg` = 1521, `DamageModifier` = 1.03 WHERE `entry` = 20865;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 21607;
UPDATE `creature_template` SET `mindmg` = 1206, `maxdmg` = 1708, `DamageModifier` = 1.03 WHERE `entry` = 20864;
UPDATE `creature_template` SET `mindmg` = 1574, `maxdmg` = 2191, `DamageModifier` = 1.03 WHERE `entry` = 21608;
UPDATE `creature_template` SET `mindmg` = 126, `maxdmg` = 178, `DamageModifier` = 1.03 WHERE `entry` = 21395;
UPDATE `creature_template` SET `mindmg` = 148, `maxdmg` = 196, `DamageModifier` = 1.03 WHERE `entry` = 21609;
UPDATE `creature_template` SET `mindmg` = 1210, `maxdmg` = 1670, `DamageModifier` = 1.03 WHERE `entry` = 20866;
UPDATE `creature_template` SET `mindmg` = 1481, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 21614;
UPDATE `creature_template` SET `mindmg` = 1170, `maxdmg` = 1580, `DamageModifier` = 1.03 WHERE `entry` = 20867;
UPDATE `creature_template` SET `mindmg` = 1375, `maxdmg` = 1985, `DamageModifier` = 1.03 WHERE `entry` = 21591;
UPDATE `creature_template` SET `mindmg` = 1418, `maxdmg` = 2005, `DamageModifier` = 1.03 WHERE `entry` = 22890;
UPDATE `creature_template` SET `mindmg` = 1891, `maxdmg` = 2673, `DamageModifier` = 1.03 WHERE `entry` = 22892;
UPDATE `creature_template` SET `mindmg` = 1067, `maxdmg` = 1509, `DamageModifier` = 1.03 WHERE `entry` = 20869;
UPDATE `creature_template` SET `mindmg` = 1171, `maxdmg` = 1632, `DamageModifier` = 1.03 WHERE `entry` = 21586;
UPDATE `creature_template` SET `mindmg` = 1276, `maxdmg` = 1804, `DamageModifier` = 1.03 WHERE `entry` = 20873;
UPDATE `creature_template` SET `mindmg` = 1636, `maxdmg` = 2313, `DamageModifier` = 1.03 WHERE `entry` = 21605;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 20875;
UPDATE `creature_template` SET `mindmg` = 1383, `maxdmg` = 1953, `DamageModifier` = 1.03 WHERE `entry` = 21604;
UPDATE `creature_template` SET `mindmg` = 2186, `maxdmg` = 3088, `DamageModifier` = 1.03 WHERE `entry` = 20880;
UPDATE `creature_template` SET `mindmg` = 2636, `maxdmg` = 3724, `DamageModifier` = 1.03 WHERE `entry` = 21594;
UPDATE `creature_template` SET `mindmg` = 992, `maxdmg` = 1401, `DamageModifier` = 1.03 WHERE `entry` = 20879;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 21595;
UPDATE `creature_template` SET `mindmg` = 1068, `maxdmg` = 1478, `DamageModifier` = 1.03 WHERE `entry` = 20883;
UPDATE `creature_template` SET `mindmg` = 1383, `maxdmg` = 1953, `DamageModifier` = 1.03 WHERE `entry` = 21615;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 20882;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 21613;
UPDATE `creature_template` SET `mindmg` = 1215, `maxdmg` = 1650, `DamageModifier` = 1.03 WHERE `entry` = 20881;
UPDATE `creature_template` SET `mindmg` = 1545, `maxdmg` = 2078, `DamageModifier` = 1.03 WHERE `entry` = 21619;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 20897;
UPDATE `creature_template` SET `mindmg` = 1383, `maxdmg` = 1953, `DamageModifier` = 1.03 WHERE `entry` = 21597;
UPDATE `creature_template` SET `mindmg` = 1056, `maxdmg` = 1478, `DamageModifier` = 1.03 WHERE `entry` = 21702;
UPDATE `creature_template` SET `mindmg` = 1215, `maxdmg` = 1650, `DamageModifier` = 1.03 WHERE `entry` = 22346;
UPDATE `creature_template` SET `mindmg` = 1180, `maxdmg` = 1580, `DamageModifier` = 1.03 WHERE `entry` = 20896;
UPDATE `creature_template` SET `mindmg` = 1486, `maxdmg` = 1987, `DamageModifier` = 1.03 WHERE `entry` = 21596;
UPDATE `creature_template` SET `mindmg` = 1096, `maxdmg` = 1498, `DamageModifier` = 1.03 WHERE `entry` = 20902;
UPDATE `creature_template` SET `mindmg` = 1312, `maxdmg` = 1865, `DamageModifier` = 1.03 WHERE `entry` = 21611;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 20901;
UPDATE `creature_template` SET `mindmg` = 1415, `maxdmg` = 1853, `DamageModifier` = 1.03 WHERE `entry` = 21610;
UPDATE `creature_template` SET `mindmg` = 1215, `maxdmg` = 1718, `DamageModifier` = 1.03 WHERE `entry` = 20898;
UPDATE `creature_template` SET `mindmg` = 1547, `maxdmg` = 2191, `DamageModifier` = 1.03 WHERE `entry` = 21598;
UPDATE `creature_template` SET `mindmg` = 1206, `maxdmg` = 1714, `DamageModifier` = 1.03 WHERE `entry` = 20900;
UPDATE `creature_template` SET `mindmg` = 1614, `maxdmg` = 2185, `DamageModifier` = 1.03 WHERE `entry` = 21621;
UPDATE `creature_template` SET `mindmg` = 1254, `maxdmg` = 1778, `DamageModifier` = 1.03 WHERE `entry` = 20904;
UPDATE `creature_template` SET `mindmg` = 1609, `maxdmg` = 2281, `DamageModifier` = 1.03 WHERE `entry` = 21622;
UPDATE `creature_template` SET `mindmg` = 1230, `maxdmg` = 1738, `DamageModifier` = 1.03 WHERE `entry` = 20905;
UPDATE `creature_template` SET `mindmg` = 2123, `maxdmg` = 3013, `DamageModifier` = 1.03 WHERE `entry` = 21589;
UPDATE `creature_template` SET `mindmg` = 1896, `maxdmg` = 2686, `DamageModifier` = 1.03 WHERE `entry` = 20908;
UPDATE `creature_template` SET `mindmg` = 3287, `maxdmg` = 4655, `DamageModifier` = 1.03 WHERE `entry` = 21617;
UPDATE `creature_template` SET `mindmg` = 2045, `maxdmg` = 2900, `DamageModifier` = 1.03 WHERE `entry` = 20911;
UPDATE `creature_template` SET `mindmg` = 3545, `maxdmg` = 5026, `DamageModifier` = 1.03 WHERE `entry` = 21588;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1163, `maxdmg` = 1647, `DamageModifier` = 1.01 WHERE `entry` = 20870;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1492, `maxdmg` = 2113, `DamageModifier` = 1.01 WHERE `entry` = 21626;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1003, `maxdmg` = 1423, `DamageModifier` = 1.01 WHERE `entry` = 20885;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1287, `maxdmg` = 1825, `DamageModifier` = 1.01 WHERE `entry` = 21590;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1254, `maxdmg` = 1778, `DamageModifier` = 1.01 WHERE `entry` = 20886;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1609, `maxdmg` = 2281, `DamageModifier` = 1.01 WHERE `entry` = 21624;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1896, `maxdmg` = 2686, `DamageModifier` = 1.01 WHERE `entry` = 20912;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 3287, `maxdmg` = 4655, `DamageModifier` = 1.01 WHERE `entry` = 21601;

/* ILLUSIONS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1896, `maxdmg` = 2686, `DamageModifier` = 1.01 WHERE `entry` = 21466;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 3287, `maxdmg` = 4655, `DamageModifier` = 1.01 WHERE `entry` = 21600;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1896, `maxdmg` = 2686, `DamageModifier` = 1.01 WHERE `entry` = 21467;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 3287, `maxdmg` = 4655, `DamageModifier` = 1.01 WHERE `entry` = 21599;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
