-- DB update 2018_12_29_00 -> 2018_12_31_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_12_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_12_29_00 2018_12_31_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1545767614007203800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1545767614007203800');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 19210;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(19210, 0, 0, 1, 8, 0, 100, 0, 33532, 0, 0, 0, 33, 19210, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'On spell \'Fel Cannon: Fear\' (33532) hit  - Party invoker: Give kill credit \'Fel Cannon: Fear\' (19210)'),
(19210, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 19211, 100, 0, 0, 0, 0, 0, 'Linked - Self: Look at closest alive creature \'Fel Cannon: Fear Target\' (19211) in 100 yards'),
(19210, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Linked - Self: Set event phase to 2'),
(19210, 0, 3, 0, 1, 2, 100, 0, 3000, 3000, 10000, 10000, 11, 33535, 0, 0, 0, 0, 0, 19, 19211, 100, 0, 0, 0, 0, 0, 'When out of combat and timer at the begining between 3000 and 3000 ms (and later repeats every 10000 and 10000 ms) - Self: Cast spell \'Fel Energy Beam\' (33535) on closest alive creature \'Fel Cannon: Fear Target\' (19211) in 100 yards'),
(19210, 0, 4, 5, 1, 2, 100, 0, 8000, 8000, 10000, 10000, 92, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'When out of combat and timer at the begining between 8000 and 8000 ms (and later repeats every 10000 and 10000 ms) - Self: Interrupt cast spell'),
(19210, 0, 5, 6, 61, 2, 100, 0, 0, 0, 0, 0, 86, 42346, 0, 19, 19211, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Cross Cast \'Cosmetic - Flame Patch 2.0\' (42346) on closest alive creature \'Fel Cannon: Fear Target\' (19211) in 100 yards'),
(19210, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Linked - Self: Set event phase to 1'),
(19210, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.09956, 'Linked - Self: Reset to original orientation 1.09956');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 19067;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(19067, 0, 0, 1, 8, 0, 100, 0, 33531, 0, 0, 0, 33, 19067, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'On spell \'Fel Cannon: Hate\' (33531) hit  - Party invoker: Give kill credit \'Fel Cannon: Hate\' (19067)'),
(19067, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 19212, 100, 0, 0, 0, 0, 0, 'Linked - Self: Look at closest alive creature \'Fel Cannon: Hate Target\' (19212) in 100 yards'),
(19067, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Linked - Self: Set event phase to 2'),
(19067, 0, 3, 0, 1, 2, 100, 0, 3000, 3000, 10000, 10000, 11, 33535, 0, 0, 0, 0, 0, 19, 19212, 100, 0, 0, 0, 0, 0, 'When out of combat and timer at the begining between 3000 and 3000 ms (and later repeats every 10000 and 10000 ms) - Self: Cast spell \'Fel Energy Beam\' (33535) on closest alive creature \'Fel Cannon: Hate Target\' (19212) in 100 yards'),
(19067, 0, 4, 5, 1, 2, 100, 0, 8000, 8000, 10000, 10000, 92, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'When out of combat and timer at the begining between 8000 and 8000 ms (and later repeats every 10000 and 10000 ms) - Self: Interrupt cast spell'),
(19067, 0, 5, 6, 61, 2, 100, 0, 0, 0, 0, 0, 86, 42346, 0, 19, 19212, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Cross Cast \'Cosmetic - Flame Patch 2.0\' (42346) on closest alive creature \'Fel Cannon: Hate Target\' (19212) in 100 yards'),
(19067, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Linked - Self: Set event phase to 1'),
(19067, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.610865, 'Linked - Self: Reset to original orientation 0.610865');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
