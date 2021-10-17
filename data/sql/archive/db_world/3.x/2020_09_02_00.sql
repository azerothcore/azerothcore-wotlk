-- DB update 2020_09_01_03 -> 2020_09_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_01_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_01_03 2020_09_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1597589334229639700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1597589334229639700');
/*
 * Dungeon: Scholomance
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 342, `maxdmg` = 471, `DamageModifier` = 1.03 WHERE `entry` = 10489;
UPDATE `creature_template` SET `mindmg` = 327, `maxdmg` = 486, `DamageModifier` = 1.03 WHERE `entry` = 10486;
UPDATE `creature_template` SET `mindmg` = 242, `maxdmg` = 344, `DamageModifier` = 1.03 WHERE `entry` = 10470;
UPDATE `creature_template` SET `mindmg` = 319, `maxdmg` = 431, `DamageModifier` = 1.03 WHERE `entry` = 10471;
UPDATE `creature_template` SET `mindmg` = 325, `maxdmg` = 449, `DamageModifier` = 1.03 WHERE `entry` = 10499;
UPDATE `creature_template` SET `mindmg` = 346, `maxdmg` = 458, `DamageModifier` = 1.03 WHERE `entry` = 14861;
UPDATE `creature_template` SET `mindmg` = 312, `maxdmg` = 417, `DamageModifier` = 1.03 WHERE `entry` = 10476;
UPDATE `creature_template` SET `mindmg` = 348, `maxdmg` = 471, `DamageModifier` = 1.03 WHERE `entry` = 11258;
UPDATE `creature_template` SET `mindmg` = 325, `maxdmg` = 432, `DamageModifier` = 1.03 WHERE `entry` = 11582;
UPDATE `creature_template` SET `mindmg` = 348, `maxdmg` = 479, `DamageModifier` = 1.03 WHERE `entry` = 11551;
UPDATE `creature_template` SET `mindmg` = 325, `maxdmg` = 449, `DamageModifier` = 1.03 WHERE `entry` = 10487;
UPDATE `creature_template` SET `mindmg` = 313, `maxdmg` = 424, `DamageModifier` = 1.03 WHERE `entry` = 10469;
UPDATE `creature_template` SET `mindmg` = 317, `maxdmg` = 431, `DamageModifier` = 1.03 WHERE `entry` = 10498;
UPDATE `creature_template` SET `mindmg` = 309, `maxdmg` = 412, `DamageModifier` = 1.03 WHERE `entry` = 10477;
UPDATE `creature_template` SET `mindmg` = 244, `maxdmg` = 330, `DamageModifier` = 1.03 WHERE `entry` = 10495;
UPDATE `creature_template` SET `mindmg` = 192, `maxdmg` = 242, `DamageModifier` = 1.03 WHERE `entry` = 10485;
UPDATE `creature_template` SET `mindmg` = 349, `maxdmg` = 471, `DamageModifier` = 1.03 WHERE `entry` = 10481;
UPDATE `creature_template` SET `mindmg` = 332, `maxdmg` = 457, `DamageModifier` = 1.03 WHERE `entry` = 10678;
UPDATE `creature_template` SET `mindmg` = 313, `maxdmg` = 428, `DamageModifier` = 1.03 WHERE `entry` = 11257;
UPDATE `creature_template` SET `mindmg` = 348, `maxdmg` = 489, `DamageModifier` = 1.03 WHERE `entry` = 10488;
UPDATE `creature_template` SET `mindmg` = 209, `maxdmg` = 283, `DamageModifier` = 1.03 WHERE `entry` = 10475;
UPDATE `creature_template` SET `mindmg` = 325, `maxdmg` = 458, `DamageModifier` = 1.03 WHERE `entry` = 10500;
UPDATE `creature_template` SET `mindmg` = 348, `maxdmg` = 471, `DamageModifier` = 1.03 WHERE `entry` = 10480;
UPDATE `creature_template` SET `mindmg` = 325, `maxdmg` = 441, `DamageModifier` = 1.03 WHERE `entry` = 10491;
UPDATE `creature_template` SET `mindmg` = 178, `maxdmg` = 242, `DamageModifier` = 1.03 WHERE `entry` = 10478;
UPDATE `creature_template` SET `mindmg` = 325, `maxdmg` = 438, `DamageModifier` = 1.03 WHERE `entry` = 10472;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 614, `maxdmg` = 813, `DamageModifier` = 1.01 WHERE `entry` = 10506;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 627, `maxdmg` = 828, `DamageModifier` = 1.01 WHERE `entry` = 11622;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 568, `maxdmg` = 728, `DamageModifier` = 1.01 WHERE `entry` = 10433;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 549, `maxdmg` = 726, `DamageModifier` = 1.01 WHERE `entry` = 10432;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 535, `maxdmg` = 765, `DamageModifier` = 1.01 WHERE `entry` = 10508;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 546, `maxdmg` = 758, `DamageModifier` = 1.01 WHERE `entry` = 10503;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 525, `maxdmg` = 738, `DamageModifier` = 1.01 WHERE `entry` = 10901;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 516, `maxdmg` = 726, `DamageModifier` = 1.01 WHERE `entry` = 10502;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 532, `maxdmg` = 724, `DamageModifier` = 1.01 WHERE `entry` = 10504;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 562, `maxdmg` = 779, `DamageModifier` = 1.01 WHERE `entry` = 10507;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 519, `maxdmg` = 754, `DamageModifier` = 1.01 WHERE `entry` = 11261;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 514, `maxdmg` = 732, `DamageModifier` = 1.01 WHERE `entry` = 10505;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 741, `maxdmg` = 981, `DamageModifier` = 1.01 WHERE `entry` = 1853;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
