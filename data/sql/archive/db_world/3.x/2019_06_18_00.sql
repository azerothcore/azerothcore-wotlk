-- DB update 2019_06_17_00 -> 2019_06_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_17_00 2019_06_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1560039329024344786'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1560039329024344786');

UPDATE `smart_scripts` SET `target_param2` = 15 WHERE `entryorguid` IN (28214,28215,28216) AND `action_type` = 11 AND `action_param1` = 51959 AND `target_type` = 19;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 28161 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(28161,0,0,1,25,0,100,0,0,0,0,0,0,11,50734,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Reset - Cast ''Frenzyheart Chicken: Invisibility'''),
(28161,0,1,2,61,0,100,0,0,0,0,0,0,42,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - Linked - Set Invincibility HP Level To 1'),
(28161,0,2,0,61,0,100,0,0,0,0,0,0,11,51846,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - Linked - Cast ''Scared Chicken'''),
(28161,0,3,0,73,0,100,0,0,0,0,0,0,80,2816101,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Spellclick - Run Script'),
(28161,0,4,0,8,0,100,0,51959,0,11000,11000,0,80,2816100,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Spellhit (Chicken Net) - Run Script'),
(28161,0,5,0,1,0,100,0,20500,22500,20500,22500,0,11,51846,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - Out Of Combat - Cast ''Scared Chicken'''),
(28161,0,6,0,1,0,100,0,180000,240000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - Out Of Combat - Despawn'),
(28161,0,7,0,0,0,100,0,20000,20000,20000,20000,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - In Combat - Evade');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2816100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(2816100,9,0,0,0,0,100,0,0,0,0,0,0,18,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Set Unit Flag ''UNIT_FLAG_NON_ATTACKABLE'''),
(2816100,9,1,0,0,0,100,0,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Stop Combat'),
(2816100,9,2,0,0,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Set React State ''Passive'''),
(2816100,9,3,0,0,0,100,0,0,0,0,0,0,28,51846,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Remove Aura Scared Chicken'),
(2816100,9,4,0,0,0,100,0,0,0,0,0,0,11,51959,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Cast ''Chicken Net'''),
(2816100,9,5,0,0,0,100,0,10000,10000,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Set React State ''Aggressive'''),
(2816100,9,6,0,0,0,100,0,0,0,0,0,0,19,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Remove Unit Flag ''UNIT_FLAG_NON_ATTACKABLE''');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2816101 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(2816101,9,0,0,0,0,100,0,0,0,0,0,0,85,51037,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Invoker Cast ''Capture Chicken Escapee'''),
(2816101,9,1,0,0,0,100,0,0,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Reset Home Position'),
(2816101,9,2,0,0,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chicken Escapee - On Script - Despawn');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
