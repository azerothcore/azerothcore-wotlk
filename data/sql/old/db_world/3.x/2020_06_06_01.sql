-- DB update 2020_06_06_00 -> 2020_06_06_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_06_00 2020_06_06_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588337806789523700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588337806789523700');

/*
 * Dungeon: Uldaman
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 115, `maxdmg` = 152, `DamageModifier` = 1.03 WHERE `entry` = 4852;
UPDATE `creature_template` SET `mindmg` = 131, `maxdmg` = 177, `DamageModifier` = 1.03 WHERE `entry` = 7175;
UPDATE `creature_template` SET `mindmg` = 169, `maxdmg` = 234, `DamageModifier` = 1.03 WHERE `entry` = 4851;
UPDATE `creature_template` SET `mindmg` = 139, `maxdmg` = 193, `DamageModifier` = 1.03 WHERE `entry` = 4850;
UPDATE `creature_template` SET `mindmg` = 139, `maxdmg` = 193, `DamageModifier` = 1.03 WHERE `entry` = 4861;
UPDATE `creature_template` SET `mindmg` = 135, `maxdmg` = 182, `DamageModifier` = 1.03 WHERE `entry` = 7078;
UPDATE `creature_template` SET `mindmg` = 139, `maxdmg` = 193, `DamageModifier` = 1.03 WHERE `entry` = 4863;
UPDATE `creature_template` SET `mindmg` = 139, `maxdmg` = 193, `DamageModifier` = 1.03 WHERE `entry` = 7022;
UPDATE `creature_template` SET `mindmg` = 145, `maxdmg` = 187, `DamageModifier` = 1.03 WHERE `entry` = 7011;
UPDATE `creature_template` SET `mindmg` = 90, `maxdmg` = 129, `DamageModifier` = 1.03 WHERE `entry` = 7012;
UPDATE `creature_template` SET `mindmg` = 148, `maxdmg` = 199, `DamageModifier` = 1.03 WHERE `entry` = 4860;
UPDATE `creature_template` SET `mindmg` = 143, `maxdmg` = 199, `DamageModifier` = 1.03 WHERE `entry` = 4855;
UPDATE `creature_template` SET `mindmg` = 118, `maxdmg` = 161, `DamageModifier` = 1.03 WHERE `entry` = 4853;
UPDATE `creature_template` SET `mindmg` = 143, `maxdmg` = 199, `minrangedmg` = 72, `maxrangedmg` = 109, `DamageModifier` = 1.03 WHERE `entry` = 7290;
UPDATE `creature_template` SET `mindmg` = 143, `maxdmg` = 199, `DamageModifier` = 1.03 WHERE `entry` = 7320;
UPDATE `creature_template` SET `mindmg` = 118, `maxdmg` = 161, `DamageModifier` = 1.03 WHERE `entry` = 7030;
UPDATE `creature_template` SET `mindmg` = 143, `maxdmg` = 199, `DamageModifier` = 1.03 WHERE `entry` = 4849;
UPDATE `creature_template` SET `mindmg` = 118, `maxdmg` = 161, `DamageModifier` = 1.03 WHERE `entry` = 4848;
UPDATE `creature_template` SET `mindmg` = 118, `maxdmg` = 161, `DamageModifier` = 1.03 WHERE `entry` = 4847;
UPDATE `creature_template` SET `mindmg` = 90, `maxdmg` = 129, `DamageModifier` = 1.03 WHERE `entry` = 7321;
UPDATE `creature_template` SET `mindmg` = 142, `maxdmg` = 184, `DamageModifier` = 1.03 WHERE `entry` = 7396;
UPDATE `creature_template` SET `mindmg` = 92, `maxdmg` = 129, `DamageModifier` = 1.03 WHERE `entry` = 7397;
UPDATE `creature_template` SET `mindmg` = 212, `maxdmg` = 286, `DamageModifier` = 1.03 WHERE `entry` = 4857;
UPDATE `creature_template` SET `mindmg` = 134, `maxdmg` = 189, `DamageModifier` = 1.03 WHERE `entry` = 7076;
UPDATE `creature_template` SET `mindmg` = 143, `maxdmg` = 193, `DamageModifier` = 1.03 WHERE `entry` = 7309;
UPDATE `creature_template` SET `mindmg` = 90, `maxdmg` = 125, `DamageModifier` = 1.03 WHERE `entry` = 7077;
UPDATE `creature_template` SET `mindmg` = 184, `maxdmg` = 248, `DamageModifier` = 1.03 WHERE `entry` = 10120;

UPDATE `creature_template` SET `rank` = 2, `mindmg` = 199, `maxdmg` = 256, `DamageModifier` = 1.02 WHERE `entry` = 7057;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 199, `maxdmg` = 256, `DamageModifier` = 1.01 WHERE `entry` = 6910;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 269, `maxdmg` = 346, `DamageModifier` = 1.01 WHERE `entry` = 6906;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 193, `maxdmg` = 249, `DamageModifier` = 1.01 WHERE `entry` = 6907;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 215, `maxdmg` = 276, `DamageModifier` = 1.01 WHERE `entry` = 6908;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 269, `maxdmg` = 346, `DamageModifier` = 1.01 WHERE `entry` = 7206;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 204, `maxdmg` = 295, `DamageModifier` = 1.01 WHERE `entry` = 7291;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 251, `maxdmg` = 325, `DamageModifier` = 1.01 WHERE `entry` = 4854;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 269, `maxdmg` = 346, `DamageModifier` = 1.01 WHERE `entry` = 7023;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 263, `maxdmg` = 361, `DamageModifier` = 1.01 WHERE `entry` = 7228;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 329, `maxdmg` = 364, `DamageModifier` = 1.01 WHERE `entry` = 2748;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
