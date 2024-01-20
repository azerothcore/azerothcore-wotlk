-- DB update 2021_10_01_02 -> 2021_10_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_01_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_01_02 2021_10_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632394526847584580'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632394526847584580');

-- Set 300 rep until end of exalted for Moam, General Rajaxx, Kurinnaxx, Ayamiss the Hunter, Buru The Gorger
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue2` = 300 WHERE `creature_id` IN (15340, 15341, 15348, 15369, 15370);

-- Set 600 rep until end of exalted for Ossirian the Unscarred
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue2` = 600 WHERE `creature_id` = 15339;

-- Set 10 rep until end of exalted for Vekniss (Soldier, Warrior, Stinger, Wasp, Hive Crawler), Qiraji Lasher, Obsidian Eradicator, Anubisath (Sentinel, Defender).
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue2` = 10 WHERE `creature_id` IN (15229, 15230, 15235, 15236, 15240, 15249, 15262, 15264, 15277);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_02_00' WHERE sql_rev = '1632394526847584580';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
