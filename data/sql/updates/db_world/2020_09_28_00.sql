-- DB update 2020_09_25_00 -> 2020_09_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_25_00 2020_09_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598878078501049600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598878078501049600');
/*
 * Dungeon: Dire Maul (East)
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 437, `maxdmg` = 591, `DamageModifier` = 1.03 WHERE `entry` = 11464;
UPDATE `creature_template` SET `mindmg` = 461, `maxdmg` = 624, `DamageModifier` = 1.03 WHERE `entry` = 11462;
UPDATE `creature_template` SET `mindmg` = 452, `maxdmg` = 617, `DamageModifier` = 1.03 WHERE `entry` = 13196;
UPDATE `creature_template` SET `mindmg` = 516, `maxdmg` = 696, `DamageModifier` = 1.03 WHERE `entry` = 13021;
UPDATE `creature_template` SET `mindmg` = 312, `maxdmg` = 461, `DamageModifier` = 1.03 WHERE `entry` = 13022;
UPDATE `creature_template` SET `mindmg` = 333, `maxdmg` = 471, `DamageModifier` = 1.03 WHERE `entry` = 11455;
UPDATE `creature_template` SET `mindmg` = 470, `maxdmg` = 637, `DamageModifier` = 1.03 WHERE `entry` = 11451;
UPDATE `creature_template` SET `mindmg` = 461, `maxdmg` = 628, `DamageModifier` = 1.03 WHERE `entry` = 11454;
UPDATE `creature_template` SET `mindmg` = 446, `maxdmg` = 595, `DamageModifier` = 1.03 WHERE `entry` = 13197;
UPDATE `creature_template` SET `mindmg` = 478, `maxdmg` = 624, `DamageModifier` = 1.03 WHERE `entry` = 14349;
UPDATE `creature_template` SET `mindmg` = 452, `maxdmg` = 601, `DamageModifier` = 1.03 WHERE `entry` = 11456;
UPDATE `creature_template` SET `mindmg` = 446, `maxdmg` = 604, `DamageModifier` = 1.03 WHERE `entry` = 11453;
UPDATE `creature_template` SET `mindmg` = 449, `maxdmg` = 607, `DamageModifier` = 1.03 WHERE `entry` = 11452;
UPDATE `creature_template` SET `mindmg` = 347, `maxdmg` = 437, `DamageModifier` = 1.03 WHERE `entry` = 13276;
UPDATE `creature_template` SET `mindmg` = 446, `maxdmg` = 604, `DamageModifier` = 1.03 WHERE `entry` = 11457;
UPDATE `creature_template` SET `mindmg` = 489, `maxdmg` = 660, `DamageModifier` = 1.03 WHERE `entry` = 13285;
UPDATE `creature_template` SET `mindmg` = 456, `maxdmg` = 615, `DamageModifier` = 1.03 WHERE `entry` = 11461;
UPDATE `creature_template` SET `mindmg` = 452, `maxdmg` = 609, `DamageModifier` = 1.03 WHERE `entry` = 11465;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 601, `maxdmg` = 702, `DamageModifier` = 1.01 WHERE `entry` = 14354;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 602, `maxdmg` = 704, `DamageModifier` = 1.01 WHERE `entry` = 14327;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 608, `maxdmg` = 714, `DamageModifier` = 1.01 WHERE `entry` = 13280;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 619, `maxdmg` = 728, `DamageModifier` = 1.01 WHERE `entry` = 11490;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 615, `maxdmg` = 712, `DamageModifier` = 1.01 WHERE `entry` = 11492;

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 13276;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 13276);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(13276, 0, 0, 0, 9, 0, 100, 2, 0, 20, 6100, 15700, 11, 13340, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wildspawn Imp - Within 0-20 Range - Cast \'13340\' (Normal Dungeon)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
