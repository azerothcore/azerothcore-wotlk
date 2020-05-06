-- DB update 2018_12_11_01 -> 2018_12_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_12_11_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_12_11_01 2018_12_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1544615446472927600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1544615446472927600');
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `action_type`, `action_param1`, `action_param2`, `target_type`, `comment`) VALUES ('20132', '5', '6', '11', '35762', '2', '16', 'Socrethar - On Death - Quest Credit');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
