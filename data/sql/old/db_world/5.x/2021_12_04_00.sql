-- DB update 2021_12_03_06 -> 2021_12_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_03_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_03_06 2021_12_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635830311358655196'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635830311358655196');

DELETE FROM `command` WHERE `name` IN ('teleport name npc id','teleport name npc guid','teleport name npc name');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('teleport name npc id',2,'Syntax: .teleport name id #playername #creatureId
Teleport the given character to first found creature with id #creatureId. Character can be offline.'),
('teleport name npc guid',2,'Syntax: .teleport name id #playername #creatureSpawnId
Teleport the given character to creature with spawn id #creatureSpawnId. Character can be offline.'),
('teleport name npc name',2,'Syntax: .teleport name id #playername #creatureName
Teleport the given character to first found creature with name (must match exactly) #creatureName. Character can be offline.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_04_00' WHERE sql_rev = '1635830311358655196';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
