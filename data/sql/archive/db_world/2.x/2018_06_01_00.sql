-- DB update 2018_05_26_00 -> 2018_06_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_05_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_05_26_00 2018_06_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1527682153565076000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1527682153565076000');

UPDATE `smart_scripts` SET
`event_type` = 70,
`event_param1` = 2,
`action_type` = 9,
`action_param1` = 0,
`target_type` = 14,
`target_param1` = 43178,
`target_param2` = 175610
WHERE `entryorguid` = 177385 AND `id` = 0;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
