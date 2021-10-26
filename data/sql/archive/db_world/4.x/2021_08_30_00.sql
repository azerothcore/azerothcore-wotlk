-- DB update 2021_08_29_01 -> 2021_08_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_29_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_29_01 2021_08_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629787955866471200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629787955866471200');

-- Fix location for spell: 'Halls of Invention Teleport'
UPDATE `spell_target_position`
    SET `PositionX` = 2518.22, `PositionY` = 2569.11, `PositionZ` = 412.69, `Orientation` = 3.10668
    WHERE `ID` = 64025;

-- Fix location for 'Prison of Yogg-Saron Teleport'
UPDATE `spell_target_position`
    SET `PositionX` = 1854.8, `PositionY` = -11.46, `PositionZ` = 334.57, `Orientation` = 4.79266
    WHERE `ID` = 65042;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_30_00' WHERE sql_rev = '1629787955866471200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
