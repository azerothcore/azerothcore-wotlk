-- DB update 2020_08_04_00 -> 2020_08_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_04_00 2020_08_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1592668961234777800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1592668961234777800');
/*
 * Dungeon: Durnholde
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 969, `maxdmg` = 1431, `DamageModifier` = 1.03 WHERE `entry` = 17819;
UPDATE `creature_template` SET `mindmg` = 1141, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 20527;
UPDATE `creature_template` SET `mindmg` = 815, `maxdmg` = 1321, `minrangedmg` = 768, `maxrangedmg` = 1204, `DamageModifier` = 1.03 WHERE `entry` = 17820;
UPDATE `creature_template` SET `mindmg` = 972, `maxdmg` = 1257, `minrangedmg` = 985, `maxrangedmg` = 1450, `DamageModifier` = 1.03 WHERE `entry` = 20526;
UPDATE `creature_template` SET `mindmg` = 940, `maxdmg` = 1321, `DamageModifier` = 1.03 WHERE `entry` = 17833;
UPDATE `creature_template` SET `mindmg` = 1105, `maxdmg` = 1423, `DamageModifier` = 1.03 WHERE `entry` = 20530;
UPDATE `creature_template` SET `mindmg` = 554, `maxdmg` = 775, `DamageModifier` = 1.03 WHERE `entry` = 17840;
UPDATE `creature_template` SET `mindmg` = 998, `maxdmg` = 1382, `DamageModifier` = 1.03 WHERE `entry` = 20528;
UPDATE `creature_template` SET `mindmg` = 923, `maxdmg` = 1292, `DamageModifier` = 1.03 WHERE `entry` = 18598;
UPDATE `creature_template` SET `mindmg` = 1178, `maxdmg` = 1409, `DamageModifier` = 1.03 WHERE `entry` = 20541;
UPDATE `creature_template` SET `mindmg` = 816, `maxdmg` = 1124, `DamageModifier` = 1.03 WHERE `entry` = 17846;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1213, `DamageModifier` = 1.03 WHERE `entry` = 20543;
UPDATE `creature_template` SET `mindmg` = 1117, `maxdmg` = 1431, `DamageModifier` = 1.03 WHERE `entry` = 17860;
UPDATE `creature_template` SET `mindmg` = 1283, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 20529;
UPDATE `creature_template` SET `mindmg` = 923, `maxdmg` = 1292, `minrangedmg` = 725, `maxrangedmg` = 1076, `DamageModifier` = 1.03 WHERE `entry` = 17815;
UPDATE `creature_template` SET `mindmg` = 1178, `maxdmg` = 1409, `minrangedmg` = 1211, `maxrangedmg` = 1798, `DamageModifier` = 1.03 WHERE `entry` = 20537;
UPDATE `creature_template` SET `mindmg` = 1015, `maxdmg` = 1314, `DamageModifier` = 1.03 WHERE `entry` = 17814;
UPDATE `creature_template` SET `mindmg` = 1178, `maxdmg` = 1409, `DamageModifier` = 1.03 WHERE `entry` = 20538;
UPDATE `creature_template` SET `mindmg` = 1217, `maxdmg` = 1429, `DamageModifier` = 1.03 WHERE `entry` = 18092;
UPDATE `creature_template` SET `mindmg` = 1383, `maxdmg` = 1567, `DamageModifier` = 1.03 WHERE `entry` = 20545;
UPDATE `creature_template` SET `mindmg` = 1115, `maxdmg` = 1398, `DamageModifier` = 1.03 WHERE `entry` = 18093;
UPDATE `creature_template` SET `mindmg` = 1321, `maxdmg` = 1612, `DamageModifier` = 1.03 WHERE `entry` = 20547;
UPDATE `creature_template` SET `mindmg` = 973, `maxdmg` = 1192, `minrangedmg` = 843, `maxrangedmg` = 1278, `DamageModifier` = 1.03 WHERE `entry` = 18094;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1315, `minrangedmg` = 1068, `maxrangedmg` = 1479, `DamageModifier` = 1.03 WHERE `entry` = 20546;
UPDATE `creature_template` SET `mindmg` = 1412, `maxdmg` = 1898, `DamageModifier` = 1.03 WHERE `entry` = 18170;
UPDATE `creature_template` SET `mindmg` = 1658, `maxdmg` = 2445, `DamageModifier` = 1.03 WHERE `entry` = 20534;
UPDATE `creature_template` SET `mindmg` = 1389, `maxdmg` = 1762, `DamageModifier` = 1.03 WHERE `entry` = 18171;
UPDATE `creature_template` SET `mindmg` = 1592, `maxdmg` = 2259, `DamageModifier` = 1.03 WHERE `entry` = 20532;
UPDATE `creature_template` SET `mindmg` = 1521, `maxdmg` = 1982, `DamageModifier` = 1.03 WHERE `entry` = 18172;
UPDATE `creature_template` SET `mindmg` = 1786, `maxdmg` = 2654, `DamageModifier` = 1.03 WHERE `entry` = 20533;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1117, `maxdmg` = 1432, `DamageModifier` = 1.01, `ArmorModifier` = 3, `RegenHealth` = 2 WHERE `entry` = 17876;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1283, `maxdmg` = 1534, `DamageModifier` = 1.01, `ArmorModifier` = 3, `RegenHealth` = 2  WHERE `entry` = 20548;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 2168, `maxdmg` = 3057, `DamageModifier` = 1.01 WHERE `entry` = 17848;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 2481, `maxdmg` = 3518, `DamageModifier` = 1.01 WHERE `entry` = 20535;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1605, `maxdmg` = 1259, `DamageModifier` = 1.01 WHERE `entry` = 17862;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 2301, `maxdmg` = 3259, `DamageModifier` = 1.01 WHERE `entry` = 20521;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1734, `maxdmg` = 2445, `DamageModifier` = 1.01 WHERE `entry` = 18096;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 2481, `maxdmg` = 3518, `DamageModifier` = 1.01 WHERE `entry` = 20531;
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
