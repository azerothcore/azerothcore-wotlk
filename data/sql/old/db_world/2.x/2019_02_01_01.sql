-- DB update 2019_02_01_00 -> 2019_02_01_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_01_00 2019_02_01_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1548717283055325995'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548717283055325995');

SET
@RIFT_SPAWN := 6492,
@CANTATION  := 9095;

DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = @CANTATION;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`)
VALUES 
(0, @CANTATION, 64, '', '', 'Ignore LoS for Cantation of Manifestation');

UPDATE `smart_scripts` SET `link` = 12 WHERE `entryorguid` = @RIFT_SPAWN AND `id` = 4;
UPDATE `smart_scripts` SET `action_param1` = 1 WHERE `entryorguid` = @RIFT_SPAWN AND `id` = 8;

DELETE FROM `smart_scripts` WHERE `entryorguid` = @RIFT_SPAWN AND `id` in (12,13);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(@RIFT_SPAWN, 0, 12, 13, 61, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Rift Spawn - Linked - Say line 0"),
(@RIFT_SPAWN, 0, 13, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Rift Spawn - Linked - Attack ActionInvoker");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
