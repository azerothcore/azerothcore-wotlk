-- DB update 2022_04_23_01 -> 2022_04_23_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_23_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_23_01 2022_04_23_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642750721076432402'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642750721076432402');

-- set "execute event while charmed" flag on all events except:
-- -) movement actions
-- -) nontriggered cast actions
-- -) talk/emote/sound actions
-- -) ally summon actions
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND
    (`action_type` not in (1,4,5,10,11,12,17,25,27,38,39,40,49,62,69,84,85,86,89,92,97,103,107,114) OR
     (`action_type` in (11,86) AND (`action_param2`&2)=2));


-- assorted quest fixes (no claim to completeness)
-- Seeds of Chaos (13172)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=31157;
UPDATE `smart_scripts` SET `event_type`=29, `comment`="Skeletal Assault Gryphon - On Charmed - Start Waypoint" WHERE `source_type`=0 AND `entryorguid`=31157 AND `id`=0;
-- Generosity Abounds (13146)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=30894;
-- Battling the Elements (12967)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=30124;
-- Krolmir, Hammer of Storms (13010)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=30331;
UPDATE `smart_scripts` SET `event_type`=29 WHERE `source_type`=0 AND `entryorguid`=30331 AND `id`=0;
UPDATE `smart_scripts` SET `target_type`=23 WHERE `source_type`=0 AND `entryorguid`=30331 AND `id`=1;
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=9 AND `entryorguid`=3033100;
-- Spy Hunter (12994)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=30219;
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=9 AND `entryorguid` IN (3021900,3021901,3021902);

-- Always for SMART_EVENT_JUST_SUMMONED (Creature can be summoned already charmed by player ie TempSummons)
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|0x200 WHERE `source_type` = 0 AND `event_type`=54;

-- Event linked actions (Many levels of linked calls, do 8 times)
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;

-- Vehicles
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|0x200 WHERE `source_type` = 0 AND `entryorguid` IN (SELECT `entry` FROM `creature_template` WHERE `AIName` = "SmartAI" AND `VehicleId` != 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_23_02' WHERE sql_rev = '1642750721076432402';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
