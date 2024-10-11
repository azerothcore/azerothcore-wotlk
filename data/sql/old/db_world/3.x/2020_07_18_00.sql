-- DB update 2020_07_17_00 -> 2020_07_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_17_00 2020_07_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590769251197902700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590769251197902700');

-- Change maraudon portal faction to 0 (usable by both factions)
UPDATE `gameobject_template_addon` SET `faction` = 0 WHERE `entry` = 178404;
DELETE FROM `gameobject` WHERE `guid` = 265127 AND `id` = 178404;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
