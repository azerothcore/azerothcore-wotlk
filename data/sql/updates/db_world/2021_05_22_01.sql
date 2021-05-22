-- DB update 2021_05_22_00 -> 2021_05_22_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_22_00 2021_05_22_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620469549972464900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620469549972464900');
UPDATE `creature_text` SET `language`=7, `BroadcastTextid`=13770 WHERE `creatureid`=17312 AND `groupid`=1;
UPDATE `creature_text` SET `emote`=5 WHERE `creatureid`=17312 AND `groupid`=2;
UPDATE `creature_text` SET `emote`=22 WHERE `creatureid`=17312 AND `groupid`=3;
UPDATE `creature_text` SET `emote`=5 WHERE `creatureid`=17312 AND `groupid`=4;

DELETE FROM `creature_text` WHERE `creatureid`=17311;
INSERT INTO `creature_text` (`creatureid`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17311, 0, 0, (SELECT `MaleText` FROM `broadcast_text` WHERE `ID`=13749), 12, 7, 100, 0, 0, 0, 13749, 0, "Cowlen");

UPDATE `script_waypoint` SET `waittime`=3000 WHERE `entry`=17312 AND `pointid`=28;
UPDATE `script_waypoint` SET `waittime`=5000 WHERE `entry`=17312 AND `pointid`=29;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
