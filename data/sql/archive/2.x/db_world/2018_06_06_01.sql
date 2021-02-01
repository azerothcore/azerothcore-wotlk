-- DB update 2018_06_06_00 -> 2018_06_06_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_06_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_06_06_00 2018_06_06_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1526938640533602197'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1526938640533602197');

UPDATE `smart_scripts` SET `event_param1` = 2, `event_param2` = 30, `comment` = 'Scarlet Captain - Within 2-30 Range - Shoot' WHERE `entryorguid` = 28611 AND `id` = 0;

DELETE FROM `smart_scripts` where `entryorguid` = 28611 and `id` = 4;
INSERT INTO `smart_scripts`
(`entryorguid`,`source_type`, `id`, `link`,
`event_type`, `event_phase_mask`,`event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(28611, 0, 4, 0,
4, 0, 100, 0, 0, 0, 0, 0,
1, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Captain - On Aggro - Say Line 0');

-- delete wrong text line "Light bless you, my child."
DELETE FROM `creature_text` WHERE `entry` = 28611 AND `id` = 6;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
