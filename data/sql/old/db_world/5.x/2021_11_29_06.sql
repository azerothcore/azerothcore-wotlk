-- DB update 2021_11_29_05 -> 2021_11_29_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_29_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_29_05 2021_11_29_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637860809744969300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637860809744969300');

-- Set proper modelid
UPDATE `creature_template` SET `modelid1`=31248, `modelid2`=31007 WHERE `entry`=38545; -- Invincible
UPDATE `creature_template` SET `modelid1`=31957, `modelid2`=31958 WHERE `entry`=40625; -- Celestial Steed
-- Invincible wrong otherGender displayID
UPDATE `creature_model_info` SET `DisplayID_Other_Gender`=0 WHERE `DisplayID` IN (31007,31248);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_29_06' WHERE sql_rev = '1637860809744969300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
