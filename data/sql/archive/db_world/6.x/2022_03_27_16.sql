-- DB update 2022_03_27_15 -> 2022_03_27_16
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_15';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_15 2022_03_27_16 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648289846118024900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648289846118024900');

-- Fix selectable doors
UPDATE `gameobject_template_addon` SET `faction` = 114, `flags` = `flags`|32 WHERE `entry` IN (176964, 179117, 179365);
UPDATE `gameobject_template_addon` SET `flags` = `flags`|4 WHERE `entry` = 179115;

-- Fix Blackwing technicians spawn time
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `id1` = 13996;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_16' WHERE sql_rev = '1648289846118024900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
