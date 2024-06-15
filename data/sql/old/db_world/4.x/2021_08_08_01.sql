-- DB update 2021_08_08_00 -> 2021_08_08_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_08_00 2021_08_08_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628001727322964286'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628001727322964286');

-- Caliph Scorpidsting - Gadgetzan kill rep to 15
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 15, `MaxStanding1` = 4 WHERE `creature_id` = 7847;

-- Wastewander Assassin, Bandit, Rogue, Scofflaw, Shadow Mage, Thief - Gadgetzan kill rep to 5
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 5 WHERE `creature_id` IN (5623, 5618, 5615, 7805, 5617, 5616);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_08_01' WHERE sql_rev = '1628001727322964286';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
