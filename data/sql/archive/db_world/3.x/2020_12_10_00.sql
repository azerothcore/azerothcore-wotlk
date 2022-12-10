-- DB update 2020_12_09_01 -> 2020_12_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_09_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_09_01 2020_12_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601827068773284000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827068773284000');
/*
 * Dungeon: Utgarde Keep
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 2176, `maxdmg` = 3101, `DamageModifier` = 1.03 WHERE `entry` = 23961;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7905, `DamageModifier` = 1.03 WHERE `entry` = 30747;
UPDATE `creature_template` SET `mindmg` = 2175, `maxdmg` = 3103, `DamageModifier` = 1.03 WHERE `entry` = 24080;
UPDATE `creature_template` SET `mindmg` = 5481, `maxdmg` = 7903, `DamageModifier` = 1.03 WHERE `entry` = 31667;
UPDATE `creature_template` SET `mindmg` = 2174, `maxdmg` = 3101, `DamageModifier` = 1.03 WHERE `entry` = 24078;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7904, `DamageModifier` = 1.03 WHERE `entry` = 31661;
UPDATE `creature_template` SET `mindmg` = 2176, `maxdmg` = 3103, `DamageModifier` = 1.03 WHERE `entry` = 24079;
UPDATE `creature_template` SET `mindmg` = 5481, `maxdmg` = 7904, `DamageModifier` = 1.03 WHERE `entry` = 31659;
UPDATE `creature_template` SET `mindmg` = 2155, `maxdmg` = 3079, `DamageModifier` = 1.03 WHERE `entry` = 24082;
UPDATE `creature_template` SET `mindmg` = 5417, `maxdmg` = 7839, `DamageModifier` = 1.03 WHERE `entry` = 31675;
UPDATE `creature_template` SET `mindmg` = 2182, `maxdmg` = 3107, `DamageModifier` = 1.03 WHERE `entry` = 24083;
UPDATE `creature_template` SET `mindmg` = 5482, `maxdmg` = 7905, `DamageModifier` = 1.03 WHERE `entry` = 31669;
UPDATE `creature_template` SET `mindmg` = 2176, `maxdmg` = 3101, `DamageModifier` = 1.03 WHERE `entry` = 23956;
UPDATE `creature_template` SET `mindmg` = 5481, `maxdmg` = 7902, `DamageModifier` = 1.03 WHERE `entry` = 31666;
UPDATE `creature_template` SET `mindmg` = 2155, `maxdmg` = 3079, `DamageModifier` = 1.03 WHERE `entry` = 23960;
UPDATE `creature_template` SET `mindmg` = 5412, `maxdmg` = 7832, `DamageModifier` = 1.03 WHERE `entry` = 31663;
UPDATE `creature_template` SET `mindmg` = 518, `maxdmg` = 725, `DamageModifier` = 1.03 WHERE `entry` = 23970;
UPDATE `creature_template` SET `mindmg` = 812, `maxdmg` = 989, `DamageModifier` = 1.03 WHERE `entry` = 31635;
UPDATE `creature_template` SET `mindmg` = 542, `maxdmg` = 675, `DamageModifier` = 1.03 WHERE `entry` = 28419;
UPDATE `creature_template` SET `mindmg` = 759, `maxdmg` = 892, `DamageModifier` = 1.03 WHERE `entry` = 31671;
UPDATE `creature_template` SET `mindmg` = 533, `maxdmg` = 692, `DamageModifier` = 1.03 WHERE `entry` = 24084;
UPDATE `creature_template` SET `mindmg` = 747, `maxdmg` = 886, `DamageModifier` = 1.03 WHERE `entry` = 31681;
UPDATE `creature_template` SET `mindmg` = 2176, `maxdmg` = 3101, `DamageModifier` = 1.03 WHERE `entry` = 24085;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7905, `DamageModifier` = 1.03 WHERE `entry` = 31662;
UPDATE `creature_template` SET `mindmg` = 512, `maxdmg` = 723, `DamageModifier` = 1.03 WHERE `entry` = 29735;
UPDATE `creature_template` SET `mindmg` = 798, `maxdmg` = 962, `DamageModifier` = 1.03 WHERE `entry` = 31678;
UPDATE `creature_template` SET `mindmg` = 2176, `maxdmg` = 3101, `DamageModifier` = 1.03 WHERE `entry` = 24071;
UPDATE `creature_template` SET `mindmg` = 4216, `maxdmg` = 6081, `DamageModifier` = 1.03 WHERE `entry` = 31660;
UPDATE `creature_template` SET `mindmg` = 2182, `maxdmg` = 3105, `DamageModifier` = 1.03 WHERE `entry` = 24069;
UPDATE `creature_template` SET `mindmg` = 5482, `maxdmg` = 7904, `DamageModifier` = 1.03 WHERE `entry` = 31658;
UPDATE `creature_template` SET `mindmg` = 1862, `maxdmg` = 2798, `DamageModifier` = 1.03 WHERE `entry` = 28410;
UPDATE `creature_template` SET `mindmg` = 4989, `maxdmg` = 6710, `DamageModifier` = 1.03 WHERE `entry` = 31665;
UPDATE `creature_template` SET `mindmg` = 2176, `maxdmg` = 3106, `DamageModifier` = 1.03 WHERE `entry` = 24849;
UPDATE `creature_template` SET `mindmg` = 5482, `maxdmg` = 7907, `DamageModifier` = 1.03 WHERE `entry` = 31676;

/* BOSS */
UPDATE `creature_template` SET `mindmg` = 2884, `maxdmg` = 3767, `DamageModifier` = 1.01 WHERE `entry` = 23953;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30748;
UPDATE `creature_template` SET `mindmg` = 2508, `maxdmg` = 3693, `DamageModifier` = 1.01 WHERE `entry` = 24200;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 31679;
UPDATE `creature_template` SET `mindmg` = 2585, `maxdmg` = 3498, `DamageModifier` = 1.01 WHERE `entry` = 24201;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 31656;
UPDATE `creature_template` SET `mindmg` = 2489, `maxdmg` = 3593, `DamageModifier` = 1.01 WHERE `entry` = 23954;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 31673;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
