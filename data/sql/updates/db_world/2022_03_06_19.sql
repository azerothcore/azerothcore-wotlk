-- DB update 2022_03_06_18 -> 2022_03_06_19
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_18';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_18 2022_03_06_19 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646325069714130000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646325069714130000');

DELETE FROM `smart_scripts` WHERE `entryorguid`=18471 AND `source_type`=0 AND `id`=31;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18471, 0, 31, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, "Gurgthock - On Quest \'The Ring of Blood: The Blue Brothers\' Taken - Store Target (Invoker Party)");

UPDATE `smart_scripts` SET `link`=31 WHERE `entryorguid`=18471 AND `source_type`=0 AND `id`=3;

UPDATE `smart_scripts` SET `target_type`=12, `target_param1`=2 WHERE `entryorguid`=18471 AND `source_type`=0 AND `id`=28;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_19' WHERE sql_rev = '1646325069714130000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
