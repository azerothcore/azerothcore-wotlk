-- DB update 2022_03_06_01 -> 2022_03_06_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_01 2022_03_06_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643992773701266100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643992773701266100');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14, 15) AND `SourceGroup`=9262;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 9262, 12577, 0, 0, 8, 0, 11946, 0, 0, 1, 0, 0, "", "Show gossip text if quest 'Keristrasza' is not rewarded"),
(14, 9262, 12576, 0, 0, 8, 0, 11946, 0, 0, 0, 0, 0, "", "Show gossip text if quest 'Keristrasza' is rewarded"),
(15, 9262, 0, 0, 0, 47, 0, 11957, 10, 0, 0, 0, 0, "", "Show gossip option if player has quest 'Saragosa's End' in progress or completed"),
(15, 9262, 1, 0, 0, 47, 0, 11967, 10, 0, 0, 0, 0, "", "Show gossip option if player has quest 'Mustering the Reds' in progress or completed");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_02' WHERE sql_rev = '1643992773701266100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
