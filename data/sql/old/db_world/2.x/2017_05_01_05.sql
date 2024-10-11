-- DB update 2017_05_01_04 -> 2017_05_01_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_05_01_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_05_01_04 2017_05_01_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1490985497792697600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1490985497792697600');

-- Crusader Lamoof SAI
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 28142);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28142, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 11, 50681, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Just Summoned - Cast \'Bleeding Out\''),
(28142, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Waypoint 5 Reached - Store Targetlist (No Repeat)'),
(28142, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Waypoint 5 Reached - Start Follow Invoker (No Repeat)'),
(28142, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Waypoint 5 Reached - Set Event Phase 1 (No Repeat)'),
(28142, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Waypoint 5 Reached - Remove Flag Standstate Sit Down (No Repeat)'),
(28142, 0, 5, 0, 23, 1, 100, 1, 50681, 0, 0, 0, 80, 2814200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Has Aura \'Bleeding Out\' - Run Script (No Repeat)'),
(28142, 0, 6, 7, 40, 0, 100, 1, 5, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Waypoint 5 Reached - Set Flag Standstate Sit Down (No Repeat)'),
(28142, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Resuscitate\' - Despawn In 20000 ms'),
(28142, 0, 8, 9, 8, 1, 100, 0, 50669, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Set Event Phase 2 (Phase 1)'),
(28142, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 11, 50683, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Cast \'Kill Credit Lamoof 01\' (Phase 1)'),
(28142, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 11, 50723, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Cast \'Strip Aura Lamoof 01\' (Phase 1)'),
(28142, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 86, 50684, 0, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Resuscitate\' - Cross Cast \'Lamoof Kill Credit\''),
(28142, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 86, 50722, 0, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Resuscitate\' - Cross Cast \'Strip Aura Lamoof\''),
(28142, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Resuscitate\' - Stop Follow '),
(28142, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Resuscitate\' - Say Line 0'),
(28142, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 53, 0, 28142, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Resuscitate\' - Start Waypoint'),
(28142, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Resuscitate\' - Remove Npc Flag Gossip');

-- Crusader Josephine SAI
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 28148);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28148, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 11, 50695, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Cast \'Bleeding Out\''),
(28148, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Resuscitate\' - Store Targetlist'),
(28148, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Waypoint 4 Reached - Start Follow Invoker (No Repeat)'),
(28148, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Waypoint 4 Reached - Set Event Phase 1 (No Repeat)'),
(28148, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Waypoint 4 Reached - Remove Flag Standstate Sit Down (No Repeat)'),
(28148, 0, 5, 0, 23, 1, 100, 1, 50695, 0, 0, 0, 80, 2814800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Has Aura \'Bleeding Out\' - Run Script (No Repeat)'),
(28148, 0, 6, 7, 40, 0, 100, 1, 4, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Waypoint 4 Reached - Set Flag Standstate Sit Down (No Repeat)'),
(28148, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Despawn In 20000 ms (Phase 1)'),
(28148, 0, 8, 9, 8, 1, 100, 0, 50669, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Set Event Phase 2 (Phase 1)'),
(28148, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 11, 50698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Cast \'Kill Credit Jospehine 01\''),
(28148, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 11, 50711, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Cast \'Strip Aura Josephine 01\''),
(28148, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 86, 50699, 0, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Cross Cast \'Josephine Kill Credit\''),
(28148, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 86, 50712, 0, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Cross Cast \'Strip Aura Josephine\''),
(28148, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Stop Follow '),
(28148, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Say Line 0'),
(28148, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 53, 0, 28148, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Start Waypoint'),
(28148, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Remove Npc Flag Gossip');

-- Crusader Jonathan SAI
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 28136);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28136, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 11, 50665, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Just Summoned - Cast \'Bleeding Out\''),
(28136, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Store Targetlist (No Repeat)'),
(28136, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Start Follow Invoker (No Repeat)'),
(28136, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Set Event Phase 1 (No Repeat)'),
(28136, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Remove Flag Standstate Sit Down (No Repeat)'),
(28136, 0, 5, 0, 23, 1, 100, 1, 50665, 0, 0, 0, 80, 2813600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Has Aura \'Bleeding Out\' - Run Script (No Repeat)'),
(28136, 0, 6, 7, 40, 0, 100, 1, 5, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Set Flag Standstate Sit Down (No Repeat)'),
(28136, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Despawn In 20000 ms (No Repeat)'),
(28136, 0, 8, 9, 8, 1, 100, 0, 50669, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Set Event Phase 2 (Phase 1)'),
(28136, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 11, 50671, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Resuscitate\' - Cast \'Kill Credit Jonathan 01\''),
(28136, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 11, 50709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Resuscitate\' - Cast \'Strip Aura Jonathan 01\''),
(28136, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 86, 50680, 0, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Resuscitate\' - Cross Cast \'Jonathan Kill Credit\''),
(28136, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 86, 50710, 0, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Resuscitate\' - Cross Cast \'Strip Aura Jonanthan\''),
(28136, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Stop Follow  (No Repeat)'),
(28136, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Say Line 0 (No Repeat)'),
(28136, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 53, 0, 28136, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Start Waypoint (No Repeat)'),
(28136, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Waypoint 5 Reached - Remove Npc Flag Gossip (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
