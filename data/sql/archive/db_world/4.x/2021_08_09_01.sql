-- DB update 2021_08_09_00 -> 2021_08_09_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_09_00 2021_08_09_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628079878307473993'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628079878307473993');

-- Delete lvl 75 plans from Galak Windchaser
DELETE FROM `creature_loot_template` WHERE `Entry` = 4096 AND `Item` IN (30302, 30322);
-- Deletes drop condition skill requirement
DELETE FROM `conditions` WHERE `SourceGroup` = 4096 AND `SourceEntry` IN (30302, 30322);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_09_01' WHERE sql_rev = '1628079878307473993';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
