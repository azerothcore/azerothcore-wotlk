-- DB update 2022_01_17_00 -> 2022_01_17_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_17_00 2022_01_17_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642438429439298217'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642438429439298217');

-- add mapID 44 as valid instance
DELETE FROM `instance_template` WHERE `map`=44;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (44, 0, '', 0);

-- add teleport location OldScarletMonastery
DELETE FROM `game_tele` WHERE `id`=1491;
INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES (1491, 79, -1, 18.6778, 0, 44, 'OldScarletMonastery');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_17_01' WHERE sql_rev = '1642438429439298217';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
