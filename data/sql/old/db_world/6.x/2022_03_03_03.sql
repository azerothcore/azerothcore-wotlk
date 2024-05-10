-- DB update 2022_03_03_02 -> 2022_03_03_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_03_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_03_02 2022_03_03_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645899379343826300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645899379343826300');

UPDATE `quest_request_items` SET `CompletionText` = "Possessing a Cenarion Beacon allows one to see a corrupted soul shard on those tainted beasts that are put down for the greater good. I grind shards into a usable reagent that goes into making Cenarion plant salve. We will use that salve to turn corrupted plants into healthy ones again.$b$bIn exchange for these shards, I will give you some Cenarion plant salves I have already prepared." WHERE `id` IN (4103, 4108, 5882, 5887);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_03_03' WHERE sql_rev = '1645899379343826300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
