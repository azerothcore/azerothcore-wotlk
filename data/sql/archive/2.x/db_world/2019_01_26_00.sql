-- DB update 2019_01_25_00 -> 2019_01_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_25_00 2019_01_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1548144375618827200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1548144375618827200');

-- Adding train option in gossip menu for Sagorne Creststrider <Shaman Trainer>
UPDATE `gossip_menu_option` SET `OptionText`='Teach me the ways of the spirits.' WHERE `MenuID`=5123 AND `OptionID`=0;

-- [Quest] Mage Summoner
UPDATE `creature_template` SET `faction`=91 WHERE `entry`=3950;
UPDATE `creature_template` SET `flags_extra`=2 WHERE `entry`=3986;

-- Creature Sarilus Foulborne 3986 SAI
SET @ENTRY := 3986;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 4000, 4000, 5000, 8000, 11, 20806, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "When in combat and timer at the begining between 4000 and 4000 ms (and later repeats every 5000 and 8000 ms) - Self: Cast spell Frostbolt (20806) on Random hostile"),
(@ENTRY, 0, 1, 0, 0, 0, 100, 1, 0, 1000, 0, 0, 11, 6490, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When in combat and timer at the begining between 0 and 1000 ms (and later repeats every 0 and 0 ms) - Self: Cast spell Sarilus's Elementals (6490) on Self"),
(@ENTRY, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 9, 3950, 0, 40, 0, 0, 0, 0, "On evade - Creature Minor Water Guardian (3950) in 0 - 40 yards: Despawn in 1000 ms");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
