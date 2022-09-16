-- DB update 2020_04_08_01 -> 2020_04_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_04_08_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_04_08_01 2020_04_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1586420115016794500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586420115016794500');

ALTER TABLE `creature`
	CHANGE COLUMN `spawndist` `wander_distance` FLOAT NOT NULL DEFAULT '0' AFTER `spawntimesecs`;
	
DELETE FROM `command` WHERE `name` IN ('npc set spawndist', 'npc set wanderdistance');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('npc set wanderdistance', 3, 'Syntax: .npc set wanderdistance #dist\r\n\r\nAdjust wander distance of selected creature to dist.');

-- Loc3 = German Google Translate
UPDATE `acore_string` SET `content_default`='Wander distance changed to: %f', `content_loc3` = 'Wanderentfernung wurde auf %f abgeändert' WHERE `entry`=297;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
