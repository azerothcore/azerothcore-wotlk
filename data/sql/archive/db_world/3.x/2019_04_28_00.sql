-- DB update 2019_04_27_00 -> 2019_04_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_27_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_27_00 2019_04_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1555887226948080900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555887226948080900');

-- Fix wrong prevQuestId assignment on BE starting zone.
UPDATE `quest_template_addon` SET `PrevQuestId`=8328 WHERE `Id`=10068;
UPDATE `quest_template_addon` SET `PrevQuestId`=9676 WHERE `Id`=10069;
UPDATE `quest_template_addon` SET `PrevQuestId`=9393 WHERE `Id`=10070;
UPDATE `quest_template_addon` SET `PrevQuestId`=8564 WHERE `Id`=10072;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
