-- DB update 2021_09_01_32 -> 2021_09_01_33
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_32';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_32 2021_09_01_33 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630244571729817781'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630244571729817781');

--  Anubisath Defender, Anubisath Sentinel, Obsidian Eradicator, Qiraji Lasher, Vekniss Hive Crawler, Vekniss Soldier, Vekniss Stinger, Vekniss Warrior, Vekniss Wasp kill rep to 100
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 100 WHERE `creature_id` IN (15277, 15264, 15262, 15249, 15240, 15229, 15235, 15230, 15236);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_33' WHERE sql_rev = '1630244571729817781';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
