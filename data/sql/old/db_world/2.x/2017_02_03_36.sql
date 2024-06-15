-- DB update 2017_02_03_35 -> 2017_02_03_36
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_02_03_35';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_02_03_35 2017_02_03_36 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1485433480867835400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1485433480867835400');
DELETE FROM `spell_area` WHERE `quest_start` IN (13861, 13862, 13863, 13864) AND `area`=4522;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES 
(64576, 4522, 13864, 13864, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13861, 13861, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13862, 13862, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13863, 13863, 0, 0, 2, 1, 74, 11);--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
