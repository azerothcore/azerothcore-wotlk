-- DB update 2020_06_11_00 -> 2020_06_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_11_00 2020_06_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588338975542081700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588338975542081700');

/*
 * Dungeon: Blackfathom Deeps
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 57, `maxdmg` = 77, `DamageModifier` = 1.03 WHERE `entry` = 4815;
UPDATE `creature_template` SET `mindmg` = 57, `maxdmg` = 77, `DamageModifier` = 1.03 WHERE `entry` = 4818;
UPDATE `creature_template` SET `mindmg` = 57, `maxdmg` = 77, `DamageModifier` = 1.03 WHERE `entry` = 4821;
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 4805;
UPDATE `creature_template` SET `mindmg` = 57, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 4824;
UPDATE `creature_template` SET `mindmg` = 57, `maxdmg` = 77, `DamageModifier` = 1.03 WHERE `entry` = 4807;
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 4798;
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 4799;
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 4819;
UPDATE `creature_template` SET `mindmg` = 52, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 4820;
UPDATE `creature_template` SET `mindmg` = 52, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 4811;
UPDATE `creature_template` SET `mindmg` = 27, `maxdmg` = 36, `DamageModifier` = 1.03 WHERE `entry` = 6047;
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 4810;
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 4812;
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 4809;
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 4823;
UPDATE `creature_template` SET `mindmg` = 57, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 4827;
UPDATE `creature_template` SET `mindmg` = 63, `maxdmg` = 84, `DamageModifier` = 1.03 WHERE `entry` = 4830;
UPDATE `creature_template` SET `mindmg` = 40, `maxdmg` = 56, `DamageModifier` = 1.03 WHERE `entry` = 4813;
UPDATE `creature_template` SET `mindmg` = 40, `maxdmg` = 56, `DamageModifier` = 1.03 WHERE `entry` = 4814;
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 4825;
UPDATE `creature_template` SET `mindmg` = 80, `maxdmg` = 92, `DamageModifier` = 1.03 WHERE `entry` = 4978;
UPDATE `creature_template` SET `mindmg` = 35, `maxdmg` = 47, `DamageModifier` = 1.03 WHERE `entry` = 4977;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 129, `maxdmg` = 166, `DamageModifier` = 1.02 WHERE `entry` = 12902;
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 86, `maxdmg` = 110, `DamageModifier` = 1.02 WHERE `entry` = 12876;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 94, `maxdmg` = 108, `DamageModifier` = 1.01 WHERE `entry` = 4887;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 112, `maxdmg` = 144, `minrangedmg` = 28, `maxrangedmg` = 42, `DamageModifier` = 1.01 WHERE `entry` = 4831;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 129, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` = 6243;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 129, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` = 4830;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 129, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` = 4832;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 134, `maxdmg` = 173, `DamageModifier` = 1.01 WHERE `entry` = 4829;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
