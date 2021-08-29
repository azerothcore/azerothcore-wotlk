-- DB update 2020_06_06_01 -> 2020_06_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_06_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_06_01 2020_06_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588338017197326500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588338017197326500');

/*
 * Dungeon: Maraudon
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 182, `maxdmg` = 242, `DamageModifier` = 1.03 WHERE `entry` IN (12219, 13533);
UPDATE `creature_template` SET `mindmg` = 178, `maxdmg` = 244, `DamageModifier` = 1.03 WHERE `entry` = 12220;
UPDATE `creature_template` SET `mindmg` = 169, `maxdmg` = 224, `DamageModifier` = 1.03 WHERE `entry` IN (11793, 12221, 11792);
UPDATE `creature_template` SET `mindmg` = 165, `maxdmg` = 223, `DamageModifier` = 1.03 WHERE `entry` = 12222;
UPDATE `creature_template` SET `mindmg` = 122, `maxdmg` = 180, `DamageModifier` = 1.03 WHERE `entry` IN (12218, 11791, 11790);
UPDATE `creature_template` SET `mindmg` = 182, `maxdmg` = 262, `DamageModifier` = 1.03 WHERE `entry` IN (12224, 12207, 12206);
UPDATE `creature_template` SET `mindmg` = 192, `maxdmg` = 272, `DamageModifier` = 1.03 WHERE `entry` = 12223;
UPDATE `creature_template` SET `mindmg` = 169, `maxdmg` = 218, `DamageModifier` = 1.03 WHERE `entry` = 12217;
UPDATE `creature_template` SET `mindmg` = 165, `maxdmg` = 214, `DamageModifier` = 1.03 WHERE `entry` = 12216;
UPDATE `creature_template` SET `mindmg` = 165, `maxdmg` = 221, `DamageModifier` = 1.03 WHERE `entry` = 13141;
UPDATE `creature_template` SET `mindmg` = 189, `maxdmg` = 214, `DamageModifier` = 1.03 WHERE `entry` = 13142;
UPDATE `creature_template` SET `mindmg` = 159, `maxdmg` = 218, `DamageModifier` = 1.03 WHERE `entry` = 13743;
UPDATE `creature_template` SET `mindmg` = 175, `maxdmg` = 241, `DamageModifier` = 1.03 WHERE `entry` = 13599;
UPDATE `creature_template` SET `mindmg` = 182, `maxdmg` = 253, `DamageModifier` = 1.03 WHERE `entry` = 13323;
UPDATE `creature_template` SET `mindmg` = 167, `maxdmg` = 235, `DamageModifier` = 1.03 WHERE `entry` = 11784;
UPDATE `creature_template` SET `mindmg` = 172, `maxdmg` = 205, `DamageModifier` = 1.03 WHERE `entry` = 11783;
UPDATE `creature_template` SET `mindmg` = 142, `maxdmg` = 197, `DamageModifier` = 1.03 WHERE `entry` = 11789;
UPDATE `creature_template` SET `mindmg` = 82, `maxdmg` = 98, `DamageModifier` = 1.03 WHERE `entry` = 13456;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 276, `maxdmg` = 357, `DamageModifier` = 1.02 WHERE `entry` = 12237;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 187, `maxdmg` = 248, `DamageModifier` = 1.01 WHERE `entry` = 13282;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 292, `maxdmg` = 377, `DamageModifier` = 1.01 WHERE `entry` IN (13596, 12203);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 292, `maxdmg` = 377, `minrangedmg` = 134, `maxrangedmg` = 198, `DamageModifier` = 1.01 WHERE `entry` = 13601;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 276, `maxdmg` = 356, `DamageModifier` = 1.01 WHERE `entry` = 12258;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 269, `maxdmg` = 346, `minrangedmg` = 122, `maxrangedmg` = 180, `DamageModifier` = 1.01 WHERE `entry` = 12236;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 284, `maxdmg` = 366, `DamageModifier` = 1.01 WHERE `entry` = 12225;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 344, `maxdmg` = 444, `DamageModifier` = 1.01 WHERE `entry` = 12201;

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11789;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11789);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11789, 0, 0, 0, 0, 0, 100, 0, 2500, 5700, 8700, 12300, 11, 3391, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deep Borer - In Combat - Cast \'3391\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
