-- DB update 2021_10_17_02 -> 2021_10_17_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_17_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_17_02 2021_10_17_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634149757183552200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634149757183552200');

DELETE FROM `item_loot_template` WHERE `entry`=9265 AND `item` IN (9361,9360);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(9265, 9360, 0, 86, 0, 1, 0, 1, 1, 'Cuergo\'s Hidden Treasure - Cuergo\'s Gold'),
(9265, 9361, 0, 8, 0, 1, 0, 1, 1, 'Cuergo\'s Hidden Treasure - Cuergo\'s Gold with worm');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_17_03' WHERE sql_rev = '1634149757183552200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
