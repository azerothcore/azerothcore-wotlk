-- DB update 2022_03_27_13 -> 2022_03_27_14
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_13';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_13 2022_03_27_14 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647924729405978168'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647924729405978168');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_death_knight_initiate_visual');
INSERT INTO `spell_script_names` VALUES
(51519, 'spell_death_knight_initiate_visual');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_14' WHERE sql_rev = '1647924729405978168';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
