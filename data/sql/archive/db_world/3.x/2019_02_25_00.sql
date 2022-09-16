-- DB update 2019_02_24_00 -> 2019_02_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_24_00 2019_02_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1550874957572075786'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1550874957572075786');

UPDATE `creature_text`
SET `BroadcastTextID` = 37093, `Sound` = 16747, `Text` = 'Intruders have entered the master''s domain. Signal the alarms!', `comment` = 'tyrannus SAY_TYRANNUS_INTRO_1'
WHERE `CreatureID` = 36794 AND `groupid` = 1;

UPDATE `creature_text`
SET `BroadcastTextID` = 37392, `Sound` = 17045, `Text` = 'Soldiers of the Horde, attack!', `comment` = 'sylvanas SAY_SYLVANAS_INTRO_1'
WHERE `CreatureID` = 36990 AND `groupid` = 3;

UPDATE `creature_text`
SET `BroadcastTextID` = 37087, `Sound` = 16626, `Text` = 'Heroes of the Alliance, attack!', `comment` = 'jaina SAY_JAINA_INTRO_1'
WHERE `CreatureID` = 36993 AND `groupid` = 2;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
