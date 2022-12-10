-- DB update 2021_12_03_00 -> 2021_12_03_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_03_00 2021_12_03_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637946798791977700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637946798791977700');

DELETE FROM `creature_text` WHERE `CreatureID` = 16080;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16080, 0, 0, 'All of Nature\'s might is at my disposal, puny mortals. Let us see which of my many forms it will be that ends your suffering!', 14, 0, 100, 0, 0, 0, 11966, 0, 'Mor Grayhoof - ON AGGRO'),
(16080, 1, 0, 'Though I move on in peace, you all have my undying gratitude. Thank you for freeing me of the curse of my folly and greed.', 14, 0, 100, 0, 0, 0, 11861, 0, 'Mor Grayhoof - ON DEATH');

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_mor_grayhoof' WHERE `entry` = 16080;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 16080 AND `source_type` = 0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_03_01' WHERE sql_rev = '1637946798791977700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
