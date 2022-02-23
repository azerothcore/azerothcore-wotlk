-- DB update 2022_01_12_00 -> 2022_01_12_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_12_00 2022_01_12_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641866061298667986'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641866061298667986');

-- Maraudon CTM
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN 
(12223, 12207, 13323, 12216, 12217, 11790, 11791, 11792, 13141, 12236, 13142, 11345, 11685, 11785, 12222, 12221, 13282, 11794, 11784, 13743, 12206);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(12223, 1, 1, 0, 0, 0, 0, NULL),
(12207, 1, 1, 0, 0, 0, 0, NULL),
(13323, 1, 1, 0, 0, 0, 0, NULL),
(12216, 1, 1, 0, 0, 0, 0, NULL),
(12217, 1, 1, 0, 0, 0, 0, NULL),
(11790, 1, 1, 0, 0, 0, 0, NULL),
(11791, 1, 1, 0, 0, 0, 0, NULL),
(11792, 1, 1, 0, 0, 0, 0, NULL),
(13141, 1, 1, 0, 0, 0, 0, NULL),
(12236, 1, 1, 0, 0, 0, 0, NULL),
(13142, 1, 1, 0, 0, 0, 0, NULL),
(11345, 1, 1, 0, 0, 0, 0, NULL),
(11685, 1, 1, 0, 0, 0, 0, NULL),
(11785, 1, 1, 0, 0, 0, 0, NULL),
(12222, 1, 1, 0, 0, 0, 0, NULL),
(13282, 1, 1, 0, 0, 0, 0, NULL),
(11794, 1, 1, 0, 0, 0, 0, NULL),
(13743, 1, 1, 0, 0, 0, 0, NULL),
(11784, 1, 1, 0, 0, 0, 0, NULL),
(12206, 1, 1, 0, 0, 0, 0, NULL),
(12221, 1, 1, 0, 0, 0, 0, NULL);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_12_01' WHERE sql_rev = '1641866061298667986';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
