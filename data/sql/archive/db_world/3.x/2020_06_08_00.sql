-- DB update 2020_06_07_01 -> 2020_06_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_07_01 2020_06_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588338380679685500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588338380679685500');

/*
 * Dungeon: Sunken Temple
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 191, `maxdmg` = 259, `DamageModifier` = 1.03 WHERE `entry` IN (5226, 8384, 5228, 5267);
UPDATE `creature_template` SET `mindmg` = 182, `maxdmg` = 248, `DamageModifier` = 1.03 WHERE `entry` = 8311;
UPDATE `creature_template` SET `mindmg` = 177, `maxdmg` = 239, `DamageModifier` = 1.03 WHERE `entry` IN (5259, 5259);
UPDATE `creature_template` SET `mindmg` = 187, `maxdmg` = 253, `DamageModifier` = 1.03 WHERE `entry` IN (8318, 5263);
UPDATE `creature_template` SET `mindmg` = 57, `maxdmg` = 76, `DamageModifier` = 1.03 WHERE `entry` IN (8656, 8657);
UPDATE `creature_template` SET `mindmg` = 44, `maxdmg` = 61, `DamageModifier` = 1.03 WHERE `entry` = 8658;
UPDATE `creature_template` SET `mindmg` = 63, `maxdmg` = 85, `DamageModifier` = 1.03 WHERE `entry` = 8324;
UPDATE `creature_template` SET `mindmg` = 195, `maxdmg` = 259, `DamageModifier` = 1.03 WHERE `entry` IN (5228, 5256, 5228);
UPDATE `creature_template` SET `mindmg` = 195, `maxdmg` = 264, `DamageModifier` = 1.03 WHERE `entry` = 5283;
UPDATE `creature_template` SET `mindmg` = 199, `maxdmg` = 264, `DamageModifier` = 1.03 WHERE `entry` = 5277;
UPDATE `creature_template` SET `mindmg` = 180, `maxdmg` = 244, `DamageModifier` = 1.03 WHERE `entry` IN (5280, 5271, 5273, 5291);
UPDATE `creature_template` SET `mindmg` = 383, `maxdmg` = 520, `DamageModifier` = 1.03 WHERE `entry` = 8317;
UPDATE `creature_template` SET `mindmg` = 172, `maxdmg` = 234, `DamageModifier` = 1.03 WHERE `entry` = 5269;
UPDATE `creature_template` SET `mindmg` = 116, `maxdmg` = 154, `DamageModifier` = 1.03 WHERE `entry` = 8497;
UPDATE `creature_template` SET `mindmg` = 59, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 8437;
UPDATE `creature_template` SET `mindmg` = 363, `maxdmg` = 480, `DamageModifier` = 1.03 WHERE `entry` = 8438;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 199, `maxdmg` = 264, `DamageModifier` = 1.02 WHERE `entry` = 5708;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 410, `maxdmg` = 500, `DamageModifier` = 1.01 WHERE `entry` = 8580;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 500, `maxdmg` = 788, `DamageModifier` = 1.01 WHERE `entry` = 8443;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 716, `maxdmg` = 908, `DamageModifier` = 1.01 WHERE `entry` = 5709;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 328, `maxdmg` = 421, `DamageModifier` = 1.01 WHERE `entry` = 5710;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 344, `maxdmg` = 444, `DamageModifier` = 1.01 WHERE `entry` IN (5711, 5717, 5712, 5713, 5714, 5715, 5716);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 310, `maxdmg` = 400, `DamageModifier` = 1.01 WHERE `entry` IN (5719, 5721);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 300, `maxdmg` = 388, `DamageModifier` = 1.01 WHERE `entry` IN (5720, 5722);

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8319;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8319);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8319, 0, 0, 0, 0, 0, 100, 0, 2400, 4900, 11800, 17200, 11, 15653, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Whelp - In Combat - Cast \'15653\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
