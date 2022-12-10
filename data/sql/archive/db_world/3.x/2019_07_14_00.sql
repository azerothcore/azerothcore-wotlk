-- DB update 2019_07_13_00 -> 2019_07_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_13_00 2019_07_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1562110333242304237'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562110333242304237');

-- Random movement for Bile Golem, Crypt Fiend, Devouring Ghoul, Patchwork Construct
UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` IN (28201,27734,28249,27736);

-- Fix Prince Keleseth waypoint movement
DELETE FROM `creature_addon` WHERE `guid` = 126025;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(126025,1260250,0,0,0,0,'');

-- Fix Rocknar SAI link error
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 25514 AND `source_type` = 0 AND `id` = 0;

-- Fix Impaled Valgarde Scout SAI link error (quest "Rescuing the Rescuers")
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 24077 AND `source_type` = 0 AND `id` = 0;

-- Fix Ymirjar Flesh Hunter SAI link error in Normal difficulty; fix using "Aimed Shot" in Heroic difficulty
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 26670 AND `source_type` = 0 AND `id` = 18;
UPDATE `smart_scripts` SET `event_type` = 0 WHERE `entryorguid` = 26670 AND `source_type` = 0 AND `id` = 19;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
