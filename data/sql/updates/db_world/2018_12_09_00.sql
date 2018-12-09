-- DB update 2018_11_25_00 -> 2018_12_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_11_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_11_25_00 2018_12_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1544356865614961000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1544356865614961000');
UPDATE `gameobject` SET `position_x`='342.79', `position_y`='1249.17', `position_z`='81.0146' WHERE `guid`=33326;
UPDATE `gameobject` SET `position_x`='-3597', `position_y`='-2714.84', `position_z`='19.94' WHERE `guid`=13764;
UPDATE `gameobject` SET `position_x`='-4970.3', `position_y`='-1712.6', `position_z`='-62.5' WHERE `guid`=16889;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
