-- DB update 2021_12_03_05 -> 2021_12_03_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_03_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_03_05 2021_12_03_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638401383244389098'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638401383244389098');

DROP TABLE IF EXISTS `playercreateinfo_cast_spell`;
CREATE TABLE IF NOT EXISTS `playercreateinfo_cast_spell` (
  `raceMask` INT UNSIGNED NOT NULL DEFAULT '0',
  `classMask` INT UNSIGNED NOT NULL DEFAULT '0',
  `spell` MEDIUMINT UNSIGNED NOT NULL DEFAULT '0',
  `note` VARCHAR(255) DEFAULT NULL
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4;

DELETE FROM `playercreateinfo_cast_spell` WHERE `spell` IN (48266, 2457);
INSERT INTO `playercreateinfo_cast_spell` (`racemask`, `classmask`, `spell`, `note`) VALUES
(0, 32, 48266, 'Death Knight - Blood Presence'),
(0, 1, 2457, 'Warrior - Battle Stance');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_03_06' WHERE sql_rev = '1638401383244389098';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
