-- DB update 2022_01_11_05 -> 2022_01_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_11_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_11_05 2022_01_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641925718732444493'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641925718732444493');

-- Wailing Caverns CTM
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (5053, 5761, 5055, 3640, 5756, 5763);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(5053, 1, 1, 0, 0, 0, 0, NULL),
(5756, 1, 1, 0, 0, 0, 0, NULL),
(5763, 1, 1, 0, 0, 0, 0, NULL),
(5761, 1, 1, 0, 0, 0, 0, NULL),
(5055, 1, 1, 0, 0, 0, 0, NULL),
(3640, 1, 1, 0, 0, 0, 0, NULL);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_12_00' WHERE sql_rev = '1641925718732444493';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
