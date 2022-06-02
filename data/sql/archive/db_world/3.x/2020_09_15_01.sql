-- DB update 2020_09_15_00 -> 2020_09_15_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_15_00 2020_09_15_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598303195521812924'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598303195521812924');
DELETE FROM `smart_scripts` WHERE `entryorguid`= 28202 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28202, 0, 0, 0, 8, 0, 100, 1, 50926, 0, 0, 0, 0, 11, 50927, 3, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Zul\'Drak Rat - On Spellhit \'Gluttonous Lurkers: Create Zul\'Drak Rat Cover\' - Cast `Create Zul\'Drak Rat`'),
(28202, 0, 1, 0, 31, 0, 100, 1, 50927, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zul\'Drak Rat - On Spellhit target \'Create Zul\'Drak Rat\' - Despawn Instant');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
