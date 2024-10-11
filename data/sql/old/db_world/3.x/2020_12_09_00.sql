-- DB update 2020_12_07_01 -> 2020_12_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_07_01 2020_12_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601827164368024300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827164368024300');
/*
 * Dungeon: Utgarde Pinnacle
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 487, `maxdmg` = 641, `DamageModifier` = 1.03 WHERE `entry` = 26536;
UPDATE `creature_template` SET `mindmg` = 578, `maxdmg` = 816, `DamageModifier` = 1.03 WHERE `entry` = 30791;
UPDATE `creature_template` SET `mindmg` = 2787, `maxdmg` = 3925, `DamageModifier` = 1.03 WHERE `entry` = 26550;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7905, `DamageModifier` = 1.03 WHERE `entry` = 30764;
UPDATE `creature_template` SET `mindmg` = 3125, `maxdmg` = 4362, `DamageModifier` = 1.03 WHERE `entry` = 26554;
UPDATE `creature_template` SET `mindmg` = 5417, `maxdmg` = 7839, `DamageModifier` = 1.03 WHERE `entry` = 30766;
UPDATE `creature_template` SET `mindmg` = 3162, `maxdmg` = 4399, `DamageModifier` = 1.03 WHERE `entry` = 26553;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7904, `DamageModifier` = 1.03 WHERE `entry` = 30765;
UPDATE `creature_template` SET `mindmg` = 3165, `maxdmg` = 4401, `DamageModifier` = 1.03 WHERE `entry` = 26555;
UPDATE `creature_template` SET `mindmg` = 5708, `maxdmg` = 7909, `DamageModifier` = 1.03 WHERE `entry` = 30806;
UPDATE `creature_template` SET `mindmg` = 3027, `maxdmg` = 4229, `DamageModifier` = 1.03 WHERE `entry` = 26670;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7901, `DamageModifier` = 1.03 WHERE `entry` = 30818;
UPDATE `creature_template` SET `mindmg` = 3015, `maxdmg` = 4215, `DamageModifier` = 1.03 WHERE `entry` = 26672;
UPDATE `creature_template` SET `mindmg` = 5382, `maxdmg` = 7905, `DamageModifier` = 1.03 WHERE `entry` = 30762;
UPDATE `creature_template` SET `mindmg` = 3021, `maxdmg` = 4217, `DamageModifier` = 1.03 WHERE `entry` = 26669;
UPDATE `creature_template` SET `mindmg` = 5417, `maxdmg` = 7902, `DamageModifier` = 1.03 WHERE `entry` = 30821;
UPDATE `creature_template` SET `mindmg` = 3162, `maxdmg` = 4399, `DamageModifier` = 1.03 WHERE `entry` = 26683;
UPDATE `creature_template` SET `mindmg` = 5951, `maxdmg` = 8197, `DamageModifier` = 1.03 WHERE `entry` = 30772;
UPDATE `creature_template` SET `mindmg` = 3158, `maxdmg` = 4385, `DamageModifier` = 1.03 WHERE `entry` = 26685;
UPDATE `creature_template` SET `mindmg` = 5948, `maxdmg` = 8186, `DamageModifier` = 1.03 WHERE `entry` = 30790;
UPDATE `creature_template` SET `mindmg` = 512, `maxdmg` = 686, `DamageModifier` = 1.03 WHERE `entry` = 27228;
UPDATE `creature_template` SET `mindmg` = 648, `maxdmg` = 872, `DamageModifier` = 1.03 WHERE `entry` = 30779;
UPDATE `creature_template` SET `mindmg` = 3125, `maxdmg` = 4362, `DamageModifier` = 1.03 WHERE `entry` = 26684;
UPDATE `creature_template` SET `mindmg` = 5853, `maxdmg` = 8116, `DamageModifier` = 1.03 WHERE `entry` = 30803;
UPDATE `creature_template` SET `mindmg` = 3162, `maxdmg` = 4352, `DamageModifier` = 1.03 WHERE `entry` = 26686;
UPDATE `creature_template` SET `mindmg` = 5951, `maxdmg` = 8127, `DamageModifier` = 1.03 WHERE `entry` = 30770;
UPDATE `creature_template` SET `mindmg` = 2826, `maxdmg` = 3947, `DamageModifier` = 1.03 WHERE `entry` = 26690;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7902, `DamageModifier` = 1.03 WHERE `entry` = 30822;
UPDATE `creature_template` SET `mindmg` = 2794, `maxdmg` = 3915, `DamageModifier` = 1.03 WHERE `entry` = 26691;
UPDATE `creature_template` SET `mindmg` = 5417, `maxdmg` = 7839, `DamageModifier` = 1.03 WHERE `entry` = 30823;
UPDATE `creature_template` SET `mindmg` = 2826, `maxdmg` = 3947, `DamageModifier` = 1.03 WHERE `entry` = 26692;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7902, `DamageModifier` = 1.03 WHERE `entry` = 30819;
UPDATE `creature_template` SET `mindmg` = 3162, `maxdmg` = 4399, `DamageModifier` = 1.03 WHERE `entry` = 26696;
UPDATE `creature_template` SET `mindmg` = 5475, `maxdmg` = 7901, `DamageModifier` = 1.03 WHERE `entry` = 30816;
UPDATE `creature_template` SET `mindmg` = 2502, `maxdmg` = 3614, `DamageModifier` = 1.03 WHERE `entry` = 28368;
UPDATE `creature_template` SET `mindmg` = 4499, `maxdmg` = 6710, `DamageModifier` = 1.03 WHERE `entry` = 30820;
UPDATE `creature_template` SET `mindmg` = 2514, `maxdmg` = 3638, `DamageModifier` = 1.03 WHERE `entry` = 26694;
UPDATE `creature_template` SET `mindmg` = 4572, `maxdmg` = 6857, `DamageModifier` = 1.03 WHERE `entry` = 30817;

/* BOSS */
UPDATE `creature_template` SET `mindmg` = 3648, `maxdmg` = 4992, `DamageModifier` = 1.01 WHERE `entry` = 26668;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30810;
UPDATE `creature_template` SET `mindmg` = 3662, `maxdmg` = 4942, `DamageModifier` = 1.01 WHERE `entry` = 26687;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30774;
UPDATE `creature_template` SET `mindmg` = 3768, `maxdmg` = 4942, `DamageModifier` = 1.01 WHERE `entry` = 26693;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30807;
UPDATE `creature_template` SET `mindmg` = 3889, `maxdmg` = 4961, `DamageModifier` = 1.01 WHERE `entry` = 26861;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30788;

/* SMARTSCRIPTS */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26555;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 26555);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26555, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 15000, 17000, 11, 48697, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Hulk - In Combat - Cast \'48697\''),
(26555, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 59228, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Scourge Hulk - In Combat - Cast \'59228\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
