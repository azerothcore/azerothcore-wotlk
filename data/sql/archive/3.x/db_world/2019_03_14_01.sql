-- DB update 2019_03_14_00 -> 2019_03_14_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_14_00 2019_03_14_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1550579754213080400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1550579754213080400');
UPDATE `creature_template` SET `speed_walk` = 1.20000004768372, `speed_run` = 1 WHERE `entry` IN (27755, 27756, 27692);
UPDATE `creature_template` SET `ScriptName` = 'npc_centrifuge_construct' WHERE `entry` = 27641;

-- Spells of the dragons
DELETE FROM `spell_script_names` WHERE spell_id IN (50241, 50325, 49460, 49464, 49346, 53797);
INSERT INTO `spell_script_names` VALUES
(50241, 'spell_oculus_evasive_charges'),
(50325, 'spell_oculus_soar'),
(49460, 'spell_oculus_rider_aura'),
(49464, 'spell_oculus_rider_aura'),
(49346, 'spell_oculus_rider_aura'),
(53797, 'spell_oculus_drake_flag');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
