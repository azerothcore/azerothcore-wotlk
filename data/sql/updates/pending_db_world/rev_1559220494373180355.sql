INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559220494373180355');

-- Extend existing script
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18069 AND `source_type` = 0 AND `id` IN (15,16,17);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18069,0,15,0,63,0,100,0,0,0,0,0,0,42,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Just Created - Set Invincibility HP Level To 1'),
(18069,0,16,0,11,0,100,0,0,0,0,0,0,42,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Respawn - Set Invincibility HP Level To 1'),
(18069,0,17,0,2,0,100,0,0,0,0,0,0,80,1806901,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Health Percentage 0 - Run Script');

-- Overwrite existing non-functional script
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1806901 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1806901,9,0,0,0,0,100,0,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set ''UNIT_STAND_STATE_DEAD'''),
(1806901,9,1,0,0,0,100,0,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Stop Combat'),
(1806901,9,2,0,0,0,100,0,0,0,0,0,0,28,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Remove All Auras'),
(1806901,9,3,0,0,0,100,0,0,0,0,0,0,18,33686272,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Unit Flags'),
(1806901,9,4,0,0,0,100,0,0,0,0,0,0,42,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Invincibility HP Level To 0'),
(1806901,9,5,0,0,0,100,0,10000,10000,0,0,0,11,32343,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Cast Spell ''Revive Self'''),
(1806901,9,6,0,0,0,100,0,2500,2500,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Say Line 5'),
(1806901,9,7,0,0,0,100,0,0,0,0,0,0,19,33686272,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Remove Unit Flags'),
(1806901,9,8,0,0,0,100,0,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Remove ''UNIT_STAND_STATE_DEAD'''),
(1806901,9,9,0,0,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Mogor - On Script - Attack Nearest Player Within 50 Yards');
