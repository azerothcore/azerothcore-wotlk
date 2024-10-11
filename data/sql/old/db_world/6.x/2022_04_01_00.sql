-- DB update 2022_03_30_00 -> 2022_04_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_30_00 2022_04_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646287552186744609'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646287552186744609');

DELETE FROM `command` WHERE `name`='debug objectcount';
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('debug objectcount',3,'Syntax: .debug objectcount <optional map id> Shows the number of Creatures and GameObjects for the specified map id or for all maps if none is specified');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_01_00' WHERE sql_rev = '1646287552186744609';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
