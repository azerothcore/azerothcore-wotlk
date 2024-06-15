-- DB update 2016_09_24_06 -> 2016_10_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2016_09_24_06 2016_10_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1474792959599938200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world(`sql_rev`) VALUES ('1474792959599938200');


DELETE FROM smart_scripts WHERE entryorguid = 30283;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(30283, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 11, 56709, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plague Walker - Combat - Cast \'Aura of Lost Hope\' (Phase 1) (No Repeat) (Dungeon)'),
(30283, 0, 1, 0, 0, 0, 100, 4, 0, 0, 0, 0, 11, 61459, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plague Walker - On Respawn - Cast \'Aura of Lost Hope\' (Phase 1) (No Repeat) (Dungeon)'),
(30283, 0, 2, 0, 0, 0, 100, 6, 7000, 11000, 120000, 130000, 11, 56707, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plague Walker - In Combat - Cast \'Contagion of Rot\' (Phase 1) (No Repeat) (Dungeon)');
--
-- END UPDATING QUERIES
--
COMMIT;
END;
//
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
