-- DB update 2017_03_04_09 -> 2017_03_04_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_03_04_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_03_04_09 2017_03_04_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1487515634336392300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1487515634336392300');
DELETE FROM `spell_area` WHERE `spell`=60197 AND `area`=3752;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(60197, 3752, 10528, 0, 0, 0, 2, 1, 64, 0);

DELETE FROM `spell_area` WHERE `spell`=60194 AND `area`=3752;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(60194, 3752, 0, 10528, 0, 0, 2, 1, 0, 11);--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
