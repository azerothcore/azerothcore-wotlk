-- DB update 2017_03_04_06 -> 2017_03_04_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_03_04_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_03_04_06 2017_03_04_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1486299918082046500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1486299918082046500');
-- DB/Creature: Add flag guard Deathguard Elite
-- creature is a guard (Will ignore feign death and vanish)
UPDATE `creature_template` SET `flags_extra`=32768 WHERE `entry`=7980;--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
