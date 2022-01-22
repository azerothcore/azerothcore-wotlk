-- DB update 2019_10_18_00 -> 2019_10_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_10_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_10_18_00 2019_10_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1570401436494865858'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1570401436494865858');

DELETE FROM `instance_template` WHERE `map` = 169;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES
(169, 0, '', 0);

DELETE FROM `game_tele` WHERE `id` IN  (1425, 1426, 1427, 1428);
INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES 
(1425, -366.091, 3097.86, 92.317, 0.0487625, 169, 'EmeraldDream'),
(1426, 2781.566406, 3006.763184, 23.221882, 0.5, 169, 'EmeraldStatue'),
(1427, -2128.12, -1005.89, 132.213, 0.5, 169, 'VerdantFields'),
(1428, 2732.93, -3319.63, 101.284, 0.5, 169, 'EmeraldForest');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
