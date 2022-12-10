-- DB update 2021_08_08_02 -> 2021_08_08_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_08_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_08_02 2021_08_08_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628065925391917900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628065925391917900');

-- Changed the spell Chill(28547) to Chilled(15850) for Chillwind Ravager(7449)
UPDATE `smart_scripts` SET `action_param1` = 15850, `comment` = 'Chillwind Ravager - In Combat - Cast \'Chilled\'' WHERE (`entryorguid` = 7449) AND (`source_type` = 0) AND (`id` IN (0));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_08_03' WHERE sql_rev = '1628065925391917900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
