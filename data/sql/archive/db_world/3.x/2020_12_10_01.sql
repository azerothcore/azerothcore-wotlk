-- DB update 2020_12_10_00 -> 2020_12_10_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_10_00 2020_12_10_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1602173033401388800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1602173033401388800');
/*
 * Raid: Ulduar 
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* FLAME LEVIATHAN SPAWNS */
UPDATE `creature_template` SET `mindmg` = 3480, `maxdmg` = 4530, `DamageModifier` = 1.01 WHERE `entry` = 33387;
UPDATE `creature_template` SET `mindmg` = 6960, `maxdmg` = 9060, `DamageModifier` = 1.01 WHERE `entry` = 34277;

/* FURNACE MASTER CONSTRUCTS */
UPDATE `creature_template` SET `mindmg` = 9821, `maxdmg` = 13391, `DamageModifier` = 1.01 WHERE `entry` = 32933;
UPDATE `creature_template` SET `mindmg` = 19642, `maxdmg` = 26782, `DamageModifier` = 1.01 WHERE `entry` = 33910;

/* RAZORSCALE RUNE SUMMONS */
UPDATE `creature_template` SET `mindmg` = 6800, `maxdmg` = 9248, `DamageModifier` = 1.01 WHERE `entry` = 33453;
UPDATE `creature_template` SET `mindmg` = 13600, `maxdmg` = 18496, `DamageModifier` = 1.01 WHERE `entry` = 33851;
UPDATE `creature_template` SET `mindmg` = 11310, `maxdmg` = 15420, `DamageModifier` = 1.01 WHERE `entry` = 33846;
UPDATE `creature_template` SET `mindmg` = 22620, `maxdmg` = 30840, `DamageModifier` = 1.01 WHERE `entry` = 33852;
UPDATE `creature_template` SET `mindmg` = 8105, `maxdmg` = 11430, `DamageModifier` = 1.01 WHERE `entry` = 33388;
UPDATE `creature_template` SET `mindmg` = 16210, `maxdmg` = 22860, `DamageModifier` = 1.01 WHERE `entry` = 33850;

/* XT-002 DECONSTRUCTOR HEART PHASE */
UPDATE `creature_template` SET `mindmg` = 11907, `maxdmg` = 16233, `DamageModifier` = 1.01 WHERE `entry` = 33344;
UPDATE `creature_template` SET `mindmg` = 23814, `maxdmg` = 32466, `DamageModifier` = 1.01 WHERE `entry` = 33888;
UPDATE `creature_template` SET `mindmg` = 2930, `maxdmg` = 5870, `DamageModifier` = 1.01 WHERE `entry` = 33343;
UPDATE `creature_template` SET `mindmg` = 5860, `maxdmg` = 11740, `DamageModifier` = 1.01 WHERE `entry` = 33887;
UPDATE `creature_template` SET `mindmg` = 10712, `maxdmg` = 14754, `DamageModifier` = 1.01 WHERE `entry` = 33346;
UPDATE `creature_template` SET `mindmg` = 21424, `maxdmg` = 29508, `DamageModifier` = 1.01 WHERE `entry` = 33886;

/* KOLOGARN ARMS */
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 32933;
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 33910;
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 32934;
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 33911;
UPDATE `creature_template` SET `mindmg` = 3480, `maxdmg` = 4530, `DamageModifier` = 1.01 WHERE `entry` = 33768;
UPDATE `creature_template` SET `mindmg` = 6960, `maxdmg` = 9060, `DamageModifier` = 1.01 WHERE `entry` = 33908;

/* AURIAYA FERAL DEFENDERS */
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 32933;
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 33910;
UPDATE `creature_template` SET `mindmg` = 4450, `maxdmg` = 5980, `DamageModifier` = 1.01 WHERE `entry` = 32934;
UPDATE `creature_template` SET `mindmg` = 8900, `maxdmg` = 11960, `DamageModifier` = 1.01 WHERE `entry` = 33911;

/* FREYA ELEMENTAL ALLIES */
UPDATE `creature_template` SET `mindmg` = 3480, `maxdmg` = 4530, `DamageModifier` = 1.01 WHERE `entry` = 32918;
UPDATE `creature_template` SET `mindmg` = 6960, `maxdmg` = 9060, `DamageModifier` = 1.01 WHERE `entry` = 33399;
UPDATE `creature_template` SET `mindmg` = 8105, `maxdmg` = 11430, `DamageModifier` = 1.01 WHERE `entry` = 33202;
UPDATE `creature_template` SET `mindmg` = 16210, `maxdmg` = 22860, `DamageModifier` = 1.01 WHERE `entry` = 33398;
UPDATE `creature_template` SET `mindmg` = 11310, `maxdmg` = 15420, `DamageModifier` = 1.01 WHERE `entry` = 32919;
UPDATE `creature_template` SET `mindmg` = 22620, `maxdmg` = 30840, `DamageModifier` = 1.01 WHERE `entry` = 33401;
UPDATE `creature_template` SET `mindmg` = 4450, `maxdmg` = 5980, `DamageModifier` = 1.01 WHERE `entry` = 32916;
UPDATE `creature_template` SET `mindmg` = 8900, `maxdmg` = 11960, `DamageModifier` = 1.01 WHERE `entry` = 33400;
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 33203;
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 33376;

/* FREYA ELDERS */
UPDATE `creature_template` SET `mindmg` = 18815, `maxdmg` = 24905, `DamageModifier` = 1.01 WHERE `entry` = 32913;
UPDATE `creature_template` SET `mindmg` = 37630, `maxdmg` = 49810, `DamageModifier` = 1.01 WHERE `entry` = 33392;
UPDATE `creature_template` SET `mindmg` = 18815, `maxdmg` = 24905, `DamageModifier` = 1.01 WHERE `entry` = 32914;
UPDATE `creature_template` SET `mindmg` = 37630, `maxdmg` = 49810, `DamageModifier` = 1.01 WHERE `entry` = 33393;
UPDATE `creature_template` SET `mindmg` = 18815, `maxdmg` = 24905, `DamageModifier` = 1.01 WHERE `entry` = 32915;
UPDATE `creature_template` SET `mindmg` = 37630, `maxdmg` = 49810, `DamageModifier` = 1.01 WHERE `entry` = 33391;

/* THORIM PREPHASE */
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 32882;
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 33154;

/* THORIM TUNNEL PHASE */
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 32873;
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 33148;
UPDATE `creature_template` SET `mindmg` = 3480, `maxdmg` = 4530, `DamageModifier` = 1.01 WHERE `entry` = 33110;
UPDATE `creature_template` SET `mindmg` = 6960, `maxdmg` = 9060, `DamageModifier` = 1.01 WHERE `entry` = 33161;
UPDATE `creature_template` SET `mindmg` = 11310, `maxdmg` = 15420, `DamageModifier` = 1.01 WHERE `entry` = 32876;
UPDATE `creature_template` SET `mindmg` = 22620, `maxdmg` = 30840, `DamageModifier` = 1.01 WHERE `entry` = 33158;
UPDATE `creature_template` SET `mindmg` = 8105, `maxdmg` = 11430, `DamageModifier` = 1.01 WHERE `entry` = 32904;
UPDATE `creature_template` SET `mindmg` = 16210, `maxdmg` = 22860, `DamageModifier` = 1.01 WHERE `entry` = 33157;
UPDATE `creature_template` SET `mindmg` = 4450, `maxdmg` = 5980, `DamageModifier` = 1.01 WHERE `entry` = 32878;
UPDATE `creature_template` SET `mindmg` = 8900, `maxdmg` = 11960, `DamageModifier` = 1.01 WHERE `entry` = 33156;
UPDATE `creature_template` SET `mindmg` = 11310, `maxdmg` = 15420, `DamageModifier` = 1.01 WHERE `entry` = 32877;
UPDATE `creature_template` SET `mindmg` = 22620, `maxdmg` = 30840, `DamageModifier` = 1.01 WHERE `entry` = 33155;
UPDATE `creature_template` SET `mindmg` = 11907, `maxdmg` = 16233, `DamageModifier` = 1.01 WHERE `entry` = 32874;
UPDATE `creature_template` SET `mindmg` = 23814, `maxdmg` = 32466, `DamageModifier` = 1.01 WHERE `entry` = 33162;
UPDATE `creature_template` SET `mindmg` = 12358, `maxdmg` = 17454, `DamageModifier` = 1.01 WHERE `entry` = 33125;
UPDATE `creature_template` SET `mindmg` = 24716, `maxdmg` = 34908, `DamageModifier` = 1.01 WHERE `entry` = 33164;
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 32872;
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 33149;

/* ALGALON DARK MATTER SUMMON */
UPDATE `creature_template` SET `mindmg` = 5400, `maxdmg` = 7200, `DamageModifier` = 1.01 WHERE `entry` = 33089;
UPDATE `creature_template` SET `mindmg` = 10800, `maxdmg` = 14400, `DamageModifier` = 1.01 WHERE `entry` = 34221;

/* BOSS - Some difference in basic melee attacks due Mechanics and or Hard Mode. */ 
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 33113;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69400, `DamageModifier` = 1.01 WHERE `entry` = 34003;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 33118;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69400, `DamageModifier` = 1.01 WHERE `entry` = 33190;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 33186;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 33724;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 33293;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 33885;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 32930;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 33909;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 33515;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 34175;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 32845;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 32846;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 33271;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 33449;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 33288;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 33955;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 32871;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 33070;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 32857;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 33694;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 32927;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 33692;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34700, `DamageModifier` = 1.01 WHERE `entry` = 32867;
UPDATE `creature_template` SET `mindmg` = 50900, `maxdmg` = 69700, `DamageModifier` = 1.01 WHERE `entry` = 33693;

/* Thorim - Hes basic melee is lowered by 50% due staccking increase of damage and attack speed.*/
UPDATE `creature_template` SET `mindmg` = 12725, `maxdmg` = 17350, `DamageModifier` = 1.01 WHERE `entry` = 32865;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34850, `DamageModifier` = 1.01 WHERE `entry` = 33147;

/* FREYA - Due Hard Mode and flat increase of 75% Psy. damage, her basic is lowered by 30%. */
UPDATE `creature_template` SET `mindmg` = 17815, `maxdmg` = 23905, `DamageModifier` = 1.01 WHERE `entry` = 32906;
UPDATE `creature_template` SET `mindmg` = 35630, `maxdmg` = 47810, `DamageModifier` = 1.01 WHERE `entry` = 33360;

/* MIMIRON LEVIATHAN TANK - Basic melee damage is lowered by 20%. */
UPDATE `creature_template` SET `mindmg` = 20360, `maxdmg` = 27760, `DamageModifier` = 1.01 WHERE `entry` = 33432;
UPDATE `creature_template` SET `mindmg` = 40720, `maxdmg` = 55760, `DamageModifier` = 1.01 WHERE `entry` = 34106;

/* MIMIRON ASSAULT CANNON */
UPDATE `creature_template` SET `mindmg` = 12725, `maxdmg` = 17350, `DamageModifier` = 1.01 WHERE `entry` = 33651;
UPDATE `creature_template` SET `mindmg` = 24450, `maxdmg` = 34850, `DamageModifier` = 1.01 WHERE `entry` = 34108;

/* MIMIRON COMMAND UNIT */
UPDATE `creature_template` SET `mindmg` = 12725, `maxdmg` = 17350, `DamageModifier` = 1.01 WHERE `entry` = 33670;
UPDATE `creature_template` SET `mindmg` = 24450, `maxdmg` = 34850, `DamageModifier` = 1.01 WHERE `entry` = 34109;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
