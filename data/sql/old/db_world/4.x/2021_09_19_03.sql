-- DB update 2021_09_19_02 -> 2021_09_19_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_19_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_19_02 2021_09_19_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631634961417748000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631634961417748000');

-- sets for all, generic 20/100 and maxrep
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 20, `MaxStanding1` = 5, `MaxStanding2` = 7, `RewOnKillRepValue2` = -100 WHERE (`RewOnKillRepFaction1` = 92 AND `RewOnKillRepFaction2` = 93);
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 20, `MaxStanding1` = 5, `MaxStanding2` = 7, `RewOnKillRepValue2` = -100 WHERE (`RewOnKillRepFaction1` = 93 AND `RewOnKillRepFaction2` = 92);

-- Warug bodyguard
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 5, `RewOnKillRepValue2` = -25 WHERE (`creature_id` = 6068);

-- khan shaka doesn't exist in current DB
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 5602);
DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` = 5602);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(5602, 93, 92, 5, 0, 25, 7, 0, -125, 0);

-- khan jehn
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 25, `RewOnKillRepValue2` = -125 WHERE (`creature_id` = 5601);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_19_03' WHERE sql_rev = '1631634961417748000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
