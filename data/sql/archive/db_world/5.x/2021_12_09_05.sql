-- DB update 2021_12_09_04 -> 2021_12_09_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_09_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_09_04 2021_12_09_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638644587511744300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638644587511744300');

/* Apply 'Permanent Feign Death' aura to Citizen of New Avalon
*/

DELETE FROM `creature_addon` WHERE (`guid` IN (129727, 129769));

INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(129727, 0, 0, 0, 0, 0, 0, '29266'),
(129769, 0, 0, 0, 0, 0, 0, '29266');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_09_05' WHERE sql_rev = '1638644587511744300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
