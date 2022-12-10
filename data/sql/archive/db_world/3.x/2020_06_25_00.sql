-- DB update 2020_06_24_00 -> 2020_06_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_24_00 2020_06_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589122109505979000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589122109505979000');
/*
 * Dungeon: Mana Tombs
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 875, `maxdmg` = 1222, `DamageModifier` = 1.03 WHERE `entry` = 18309;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 20258;
UPDATE `creature_template` SET `mindmg` = 875, `maxdmg` = 1222, `DamageModifier` = 1.03 WHERE `entry` = 18311;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 20255;
UPDATE `creature_template` SET `mindmg` = 815, `maxdmg` = 1138, `DamageModifier` = 1.03 WHERE `entry` = 18429;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 20252;
UPDATE `creature_template` SET `mindmg` = 617, `maxdmg` = 1020, `DamageModifier` = 1.03 WHERE `entry` = 18313;
UPDATE `creature_template` SET `mindmg` = 1198, `maxdmg` = 1739, `DamageModifier` = 1.03 WHERE `entry` = 20259;
UPDATE `creature_template` SET `mindmg` = 604, `maxdmg` = 918, `DamageModifier` = 1.03 WHERE `entry` = 18317;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1565, `DamageModifier` = 1.03 WHERE `entry` = 20257;
UPDATE `creature_template` SET `mindmg` = 815, `maxdmg` = 1138, `DamageModifier` = 1.03 WHERE `entry` = 19306;
UPDATE `creature_template` SET `mindmg` = 1383, `maxdmg` = 1953, `DamageModifier` = 1.03 WHERE `entry` = 20263;
UPDATE `creature_template` SET `mindmg` = 707, `maxdmg` = 1020, `DamageModifier` = 1.03 WHERE `entry` = 18331;
UPDATE `creature_template` SET `mindmg` = 1198, `maxdmg` = 1739, `DamageModifier` = 1.03 WHERE `entry` = 20256;
UPDATE `creature_template` SET `mindmg` = 875, `maxdmg` = 1222, `DamageModifier` = 1.03 WHERE `entry` = 19307;
UPDATE `creature_template` SET `mindmg` = 1488, `maxdmg` = 2103, `DamageModifier` = 1.03 WHERE `entry` = 20265;
UPDATE `creature_template` SET `mindmg` = 646, `maxdmg` = 953, `DamageModifier` = 1.03 WHERE `entry` = 18314;
UPDATE `creature_template` SET `mindmg` = 1126, `maxdmg` = 1597, `DamageModifier` = 1.03 WHERE `entry` = 20264;
UPDATE `creature_template` SET `mindmg` = 596, `maxdmg` = 861, `DamageModifier` = 1.03 WHERE `entry` = 18315;
UPDATE `creature_template` SET `mindmg` = 997, `maxdmg` = 1448, `DamageModifier` = 1.03 WHERE `entry` = 20261;
UPDATE `creature_template` SET `mindmg` = 530, `maxdmg` = 807, `DamageModifier` = 1.03 WHERE `entry` = 18312;
UPDATE `creature_template` SET `mindmg` = 934, `maxdmg` = 1357, `DamageModifier` = 1.03 WHERE `entry` = 20260;
UPDATE `creature_template` SET `mindmg` = 106, `maxdmg` = 141, `DamageModifier` = 1.03 WHERE `entry` = 18394;
UPDATE `creature_template` SET `mindmg` = 114, `maxdmg` = 158, `DamageModifier` = 1.03 WHERE `entry` = 20262;
UPDATE `creature_template` SET `mindmg` = 856, `maxdmg` = 1198, `DamageModifier` = 1.03 WHERE `entry` = 18431;
UPDATE `creature_template` SET `mindmg` = 1383, `maxdmg` = 2032, `DamageModifier` = 1.03 WHERE `entry` = 20254;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 582, `maxdmg` = 817, `DamageModifier` = 1.01 WHERE `entry` = 18341;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 965, `maxdmg` = 1369, `DamageModifier` = 1.01 WHERE `entry` = 20267;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 582, `maxdmg` = 817, `DamageModifier` = 1.01 WHERE `entry` = 18343;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 965, `maxdmg` = 1369, `DamageModifier` = 1.01 WHERE `entry` = 20268;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 897, `maxdmg` = 1258, `DamageModifier` = 1.01 WHERE `entry` = 18344;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 1492, `maxdmg` = 2113, `DamageModifier` = 1.01 WHERE `entry` = 20266;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 2176, `maxdmg` = 3101, `DamageModifier` = 1.01 WHERE `entry` = 22930;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
