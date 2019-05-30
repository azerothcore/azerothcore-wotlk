INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559220494373180355');

-- Overwrite existing script
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18069 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18069,0,0,0,0,0,100,0,1000,1000,3500,3500,0,11,16033,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Mogor - In Combat - Cast ''Chain Lightning'''),
(18069,0,1,0,0,0,100,0,4000,4000,11000,13000,0,11,39529,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Mogor - In Combat - Cast ''Flame Shock'''),
(18069,0,2,0,2,0,100,1,0,60,0,0,0,11,15982,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - Between 0-60% Health - Cast ''Healing Wave'' (No Repeat)'),
(18069,0,3,0,0,0,100,0,20000,20000,20000,20000,0,11,18975,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - In Combat - Cast ''Summon Ice Totem'''),
(18069,0,4,0,2,0,100,1,0,30,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Mogor - Between 0-30% Health - Say Line 0 (No Repeat)'),
(18069,0,5,0,6,0,100,1,0,0,0,0,0,26,9977,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Mogor - On Just Died - Run Script (No Repeat)'),
(18069,0,6,0,38,0,100,0,12,12,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Data Set 12 12 - Say Line 1 (No Repeat)'),
(18069,0,7,0,38,0,100,0,13,13,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Data Set 13 13 - Say Line 2 (No Repeat)'),
(18069,0,8,0,38,0,100,0,14,14,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Data Set 14 14 - Say Line 6 (No Repeat)'),
(18069,0,9,10,38,0,100,0,1,1,0,0,0,53,0,18069,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Data Set 1 1 - Start Waypoint'),
(18069,0,10,0,61,0,100,0,0,0,0,0,0,1,3,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Mogor - On Data Set 1 1 - Say Line 3'),
(18069,0,11,12,40,0,100,0,4,18069,0,0,0,54,100000,0,2,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Waypoint 4 Reached - Pause Waypoint'),
(18069,0,12,0,61,0,100,0,0,0,0,0,0,80,1806900,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Waypoint 4 Reached - Run Script'),
(18069,0,13,0,21,0,100,0,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Reached Home - Set Faction 35'),
(18069,0,14,0,6,0,100,1,0,0,0,0,0,26,9977,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Mogor - On Just Died - Quest Credit ''The Ring of Blood: The Final Challenge'''),
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
(1806901,9,9,0,0,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Mogor - On Script - Attack Nearest Player Within 50 Yards'),
(1806901,9,10,0,0,0,100,0,0,0,0,0,0,11,28747,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Cast ''Frenzy''');
