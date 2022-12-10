-- DB update 2021_10_10_08 -> 2021_10_10_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_08 2021_10_10_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633275809062975000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633275809062975000');

-- baron adds 
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 1 WHERE (`creature_id` = 11197);

-- scholo projections 
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 1 WHERE (`creature_id` = 11263);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_09' WHERE sql_rev = '1633275809062975000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
