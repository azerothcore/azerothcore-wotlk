-- DB update 2021_11_25_00 -> 2021_11_25_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_25_00 2021_11_25_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634130715021024000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634130715021024000');

UPDATE `creature_template` SET `unit_flags` = 768, `flags_extra` = `flags_extra`|512 WHERE `entry` IN (36908,36909);
DELETE FROM `creature_template_addon` WHERE `entry` IN (36908,36909);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(36908,0,0,0,1,0,0,'69641'),
(36909,0,0,0,1,0,0,'69641');

DELETE FROM `spell_script_names` WHERE `spell_id` = 69641 AND `ScriptName` = 'spell_gen_gryphon_wyvern_mount_check';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(69641,'spell_gen_gryphon_wyvern_mount_check');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_25_01' WHERE sql_rev = '1634130715021024000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
