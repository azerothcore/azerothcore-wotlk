-- DB update 2021_08_16_00 -> 2021_08_16_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_16_00 2021_08_16_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628777209086733059'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628777209086733059');

-- Make Aku'mai Servant cast Frostbolt Volley on victims and not itself
UPDATE `smart_scripts` SET `target_type` = 2 WHERE `source_type` = 0 AND `id` = 0 AND `entryorguid` = 4978;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_16_01' WHERE sql_rev = '1628777209086733059';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
