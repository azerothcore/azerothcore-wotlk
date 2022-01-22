-- DB update 2017_08_25_00 -> 2017_09_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_25_00 2017_09_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1504433338685092700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1504433338685092700');
-- Scarlet Commander Mograine SAI
SET @ENTRY := 3976;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_commander_mograine' WHERE `entry`='3976';
-- High Inquisitor Whitemane SAI
SET @ENTRY := 3977;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
SET @ENTRY := 397700;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='boss_high_inquisitor_whitemane' WHERE `entry`='3977';
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
