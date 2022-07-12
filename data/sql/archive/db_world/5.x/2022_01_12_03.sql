-- DB update 2022_01_12_02 -> 2022_01_12_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_12_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_12_02 2022_01_12_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641844288862423527'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641844288862423527');

-- Redridge Mulocs Not swimming fix
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (422, 548, 544, 578, 545, 1083);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(422, 1, 1, 0, 0, 0, 0, NULL),
(548, 1, 1, 0, 0, 0, 0, NULL),
(544, 1, 1, 0, 0, 0, 0, NULL),
(578, 1, 1, 0, 0, 0, 0, NULL),
(1083, 1, 1, 0, 0, 0, 0, NULL),
(545, 1, 1, 0, 0, 0, 0, NULL);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_12_03' WHERE sql_rev = '1641844288862423527';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
