-- DB update 2018_05_07_00 -> 2018_05_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_05_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_05_07_00 2018_05_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1525370516654001760'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1525370516654001760');

UPDATE `smart_scripts` SET `link` = 3, `target_type` = 21, `target_param1` = 30, `action_param2` = 5000 WHERE `entryorguid` = 2044 AND `id` = 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2044 AND `id` IN (3,4);
INSERT INTO `smart_scripts`
(`entryorguid`,`source_type`, `id`, `link`,
`event_type`, `event_phase_mask`,`event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(2044, 0, 3, 4,
52, 0, 100, 0, 0, 2044, 0, 0,
2, 16, 0, 0, 0, 0, 0,
1, 0, 0, 0, 0, 0, 0, 0, 'Forlorn Spirit - On Text Over - Set Faction 16'),
(2044, 0, 4, 0,
61, 0, 100, 0, 0, 0, 0, 0,
49, 0, 0, 0, 0, 0, 0,
21, 30, 0, 0, 0, 0, 0, 0, 'Forlorn Spirit - On Text Over - Start Attacking');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
