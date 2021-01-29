-- DB update 2020_05_21_01 -> 2020_05_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_21_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_21_01 2020_05_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1587562111390803800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587562111390803800');

DELETE FROM `acore_string` WHERE entry IN (30083,30084);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(30083, 'You cannot share quests while in a Battleground.'),
(30084, 'You cannot start a Ready Check while in a Battlground.');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
