-- DB update 2021_08_13_00 -> 2021_08_13_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_13_00 2021_08_13_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628606203210970248'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628606203210970248');

-- Add motion to Dunemaul Ogres
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 5471 AND `guid` IN (23126, 23127, 23131);

-- Add motion to Dunemaul Enforcers
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 5472 AND `guid` IN (23136, 23137, 23138, 23144, 23145, 23151, 23153);

-- Add motion to Dunemaul Ogre Mage
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 5473 AND `guid` = 23162;

-- Add motion to Dunemaul Brutes
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 5474 AND `guid` IN (23173, 23177, 23178, 23180, 23181, 23182, 23183, 23184);

-- Add motion to Dunemaul Warlocks
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 5475 AND `guid` IN (23197, 23209, 23213);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_13_01' WHERE sql_rev = '1628606203210970248';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
