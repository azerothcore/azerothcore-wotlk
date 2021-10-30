-- DB update 2021_05_21_00 -> 2021_05_21_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_21_00 2021_05_21_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621105426491747047'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621105426491747047');

-- Remove id=1: Silvermane Stalker - On Reset - Cast Faded (6408) at 100% chance (No Repeat)
DELETE FROM `smart_scripts` WHERE `entryorguid`=2926 AND `id`=1;

-- The `creature_template` table does already have the updated (black) modelid (9562),
-- but the `creature` table (spawns) does not. Change modelid: 11418 --> 9562
UPDATE `creature` SET `modelid`=9562 WHERE `id`=2926;

-- Show nameplate (thanks, @Branel): Change bytes1: 131072 -> 0
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry`=2926;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
