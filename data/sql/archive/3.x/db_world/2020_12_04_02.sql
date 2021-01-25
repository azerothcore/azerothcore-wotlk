-- DB update 2020_12_04_01 -> 2020_12_04_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_04_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_04_01 2020_12_04_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606710338440572300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606710338440572300');

-- Reduce cooldown
UPDATE `smart_scripts` SET `event_param3`=10000, `event_param4`=15000, `comment`='Stitched Giant - In combat - Cast target Knockback' WHERE `entryorguid`=16025 AND `source_type`=0 AND `id`=0 AND `link`=0;
-- Fix enrage
DELETE FROM `smart_scripts` WHERE `entryorguid`=16025 AND `id`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(16025, 0, 1, 0, 2, 0, 100, 1, 0, 29, 0, 0, 0, 11, 54356, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stitched Giant - On 30% HP - Cast self Unstoppable Enrage');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
