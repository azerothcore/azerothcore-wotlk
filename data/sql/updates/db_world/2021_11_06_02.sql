-- DB update 2021_11_06_01 -> 2021_11_06_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_06_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_06_01 2021_11_06_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635700076222913000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635700076222913000');

-- Remove sneak from iron guard
DELETE FROM `creature_addon` WHERE `guid` = 137990;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(137990, 1379900, 0, 0, 1, 0, 0, '');

-- Remove "remove sneak" from assassin, this way they drop the sneak on attacking
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10318;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 10318 AND `source_type` = 0 AND `id` = 1;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_06_02' WHERE sql_rev = '1635700076222913000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
