-- DB update 2020_12_06_00 -> 2020_12_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_06_00 2020_12_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601827483251961900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827483251961900');
/*
 * Raid: Vault of Archavon
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 3162, `maxdmg` = 4399, `DamageModifier` = 1.03 WHERE `entry` = 32353;
UPDATE `creature_template` SET `mindmg` = 6324, `maxdmg` = 8798, `DamageModifier` = 1.03 WHERE `entry` = 32368;
UPDATE `creature_template` SET `mindmg` = 3112, `maxdmg` = 4170, `DamageModifier` = 1.03 WHERE `entry` = 35143;
UPDATE `creature_template` SET `mindmg` = 6224, `maxdmg` = 8340, `DamageModifier` = 1.03 WHERE `entry` = 35359;
UPDATE `creature_template` SET `mindmg` = 3337, `maxdmg` = 4676, `DamageModifier` = 1.03 WHERE `entry` = 34015;
UPDATE `creature_template` SET `mindmg` = 6674, `maxdmg` = 9352, `DamageModifier` = 1.03 WHERE `entry` = 34016;
UPDATE `creature_template` SET `mindmg` = 3438, `maxdmg` = 4724, `DamageModifier` = 1.03 WHERE `entry` = 33998;
UPDATE `creature_template` SET `mindmg` = 6876, `maxdmg` = 9448, `DamageModifier` = 1.03 WHERE `entry` = 34200;
UPDATE `creature_template` SET `mindmg` = 3433, `maxdmg` = 4738, `DamageModifier` = 1.03 WHERE `entry` = 38482;
UPDATE `creature_template` SET `mindmg` = 6866, `maxdmg` = 9476, `DamageModifier` = 1.03 WHERE `entry` = 38483;

/* BOSS */ 
/* 1st: Available at opening - Good values atm. */
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 31125; 
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 31722;
/* 2nd: Second one to appear, towards Tier 8 - During Ulduar. */
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 33993;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69400, `DamageModifier` = 1.01 WHERE `entry` = 33994;
 /* 3rd: Towards Tier 8.5 / 9 - During Trial of Crusader. */ 
UPDATE `creature_template` SET `mindmg` = 27250, `maxdmg` = 37750, `DamageModifier` = 1.01 WHERE `entry` = 35013;
UPDATE `creature_template` SET `mindmg` = 54500, `maxdmg` = 75500, `DamageModifier` = 1.01 WHERE `entry` = 35360;
 /* 4th: Towards Tier 10 and last PvP Season - During Icecrown Citadel (Need testing) */
UPDATE `creature_template` SET `mindmg` = 30380, `maxdmg` = 41445, `DamageModifier` = 1.01 WHERE `entry` = 38433;
UPDATE `creature_template` SET `mindmg` = 60760, `maxdmg` = 82890, `DamageModifier` = 1.01 WHERE `entry` = 38462;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
