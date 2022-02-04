-- DB update 2022_02_04_04 -> 2022_02_04_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_04_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_04_04 2022_02_04_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643137247566116938'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643137247566116938');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=11361 AND `ConditionValue1` IN (7003, 7721);

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15, 11361, 0, 0, 1, 8, 0, 7003, 0, 0, 0, 0, 0, '', 'Show gossip option if Quests Zapped Giants and  Fuel for the Zapping are rewarded'),
(15, 11361, 0, 0, 1, 8, 0, 7721, 0, 0, 0, 0, 0, '', 'Show gossip option if Quests Zapped Giants and  Fuel for the Zapping are rewarded');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_04_05' WHERE sql_rev = '1643137247566116938';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
