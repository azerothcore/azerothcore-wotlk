-- DB update 2020_12_09_00 -> 2020_12_09_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_09_00 2020_12_09_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601826958284839000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601826958284839000');
/*
 * Dungeon: The Oculus
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 615, `maxdmg` = 750, `DamageModifier` = 1.03 WHERE `entry` = 26736;
UPDATE `creature_template` SET `mindmg` = 812, `maxdmg` = 1015, `DamageModifier` = 1.03 WHERE `entry` = 30902;
UPDATE `creature_template` SET `mindmg` = 3027, `maxdmg` = 4229, `DamageModifier` = 1.03 WHERE `entry` = 26633;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7905, `DamageModifier` = 1.03 WHERE `entry` = 30901;
UPDATE `creature_template` SET `mindmg` = 2993, `maxdmg` = 4195, `DamageModifier` = 1.03 WHERE `entry` = 26716;
UPDATE `creature_template` SET `mindmg` = 5417, `maxdmg` = 7839, `DamageModifier` = 1.03 WHERE `entry` = 30904;
UPDATE `creature_template` SET `mindmg` = 2992, `maxdmg` = 4194, `DamageModifier` = 1.03 WHERE `entry` = 27638;
UPDATE `creature_template` SET `mindmg` = 5415, `maxdmg` = 7841, `DamageModifier` = 1.03 WHERE `entry` = 30903;
UPDATE `creature_template` SET `mindmg` = 2987, `maxdmg` = 4192, `DamageModifier` = 1.03 WHERE `entry` = 27639;
UPDATE `creature_template` SET `mindmg` = 5414, `maxdmg` = 7776, `DamageModifier` = 1.03 WHERE `entry` = 30916;
UPDATE `creature_template` SET `mindmg` = 2995, `maxdmg` = 4187, `DamageModifier` = 1.03 WHERE `entry` = 27640;
UPDATE `creature_template` SET `mindmg` = 5419, `maxdmg` = 7841, `DamageModifier` = 1.03 WHERE `entry` = 30915;
UPDATE `creature_template` SET `mindmg` = 3027, `maxdmg` = 4229, `DamageModifier` = 1.03 WHERE `entry` = 27641;
UPDATE `creature_template` SET `mindmg` = 5481, `maxdmg` = 7905, `DamageModifier` = 1.03 WHERE `entry` = 30905;
UPDATE `creature_template` SET `mindmg` = 3027, `maxdmg` = 4227, `DamageModifier` = 1.03 WHERE `entry` = 27651;
UPDATE `creature_template` SET `mindmg` = 5476, `maxdmg` = 7902, `DamageModifier` = 1.03 WHERE `entry` = 30908;
UPDATE `creature_template` SET `mindmg` = 2993, `maxdmg` = 4195, `DamageModifier` = 1.03 WHERE `entry` = 27653;
UPDATE `creature_template` SET `mindmg` = 5641, `maxdmg` = 7839, `DamageModifier` = 1.03 WHERE `entry` = 30913;
UPDATE `creature_template` SET `mindmg` = 3027, `maxdmg` = 4218, `DamageModifier` = 1.03 WHERE `entry` = 27650;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7624, `DamageModifier` = 1.03 WHERE `entry` = 30906;
UPDATE `creature_template` SET `mindmg` = 3025, `maxdmg` = 4225, `DamageModifier` = 1.03 WHERE `entry` = 27649;
UPDATE `creature_template` SET `mindmg` = 5476, `maxdmg` = 7621, `DamageModifier` = 1.03 WHERE `entry` = 30910;
UPDATE `creature_template` SET `mindmg` = 3022, `maxdmg` = 4218, `DamageModifier` = 1.03 WHERE `entry` = 27648;
UPDATE `creature_template` SET `mindmg` = 5481, `maxdmg` = 7623, `DamageModifier` = 1.03 WHERE `entry` = 30911;
UPDATE `creature_template` SET `mindmg` = 2993, `maxdmg` = 4195, `DamageModifier` = 1.03 WHERE `entry` = 27647;
UPDATE `creature_template` SET `mindmg` = 5417, `maxdmg` = 7839, `DamageModifier` = 1.03 WHERE `entry` = 30912;
UPDATE `creature_template` SET `mindmg` = 2992, `maxdmg` = 4192, `DamageModifier` = 1.03 WHERE `entry` = 27645;
UPDATE `creature_template` SET `mindmg` = 5416, `maxdmg` = 7832, `DamageModifier` = 1.03 WHERE `entry` = 30907;
UPDATE `creature_template` SET `mindmg` = 3024, `maxdmg` = 4221, `DamageModifier` = 1.03 WHERE `entry` = 27644;
UPDATE `creature_template` SET `mindmg` = 5481, `maxdmg` = 7903, `DamageModifier` = 1.03 WHERE `entry` = 30914;
UPDATE `creature_template` SET `mindmg` = 3031, `maxdmg` = 4232, `DamageModifier` = 1.03 WHERE `entry` = 27642;
UPDATE `creature_template` SET `mindmg` = 5484, `maxdmg` = 7624, `DamageModifier` = 1.03 WHERE `entry` = 30909;

/* BOSS */
UPDATE `creature_template` SET `mindmg` = 3862, `maxdmg` = 4630, `DamageModifier` = 1.01 WHERE `entry` = 27654;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 31558;
UPDATE `creature_template` SET `mindmg` = 3793, `maxdmg` = 4680, `DamageModifier` = 1.01 WHERE `entry` = 27447;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 31559;
UPDATE `creature_template` SET `mindmg` = 3753, `maxdmg` = 4689, `DamageModifier` = 1.01 WHERE `entry` = 27655;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 31560;
UPDATE `creature_template` SET `mindmg` = 3894, `maxdmg` = 4869, `DamageModifier` = 1.01 WHERE `entry` = 27656;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 31561;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
