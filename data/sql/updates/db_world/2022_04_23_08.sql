-- DB update 2022_04_23_07 -> 2022_04_23_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_23_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_23_07 2022_04_23_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1650378083515345987'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650378083515345987');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 6910) AND (`Item` IN (7741));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6910, 7741, 0, 100, 0, 1, 0, 1, 1, 'Revelosh - The Shaft of Tsol');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_23_08' WHERE sql_rev = '1650378083515345987';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
