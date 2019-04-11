INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555024514010587300');

SET @ENTRY := 21291;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 54, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When player opened dialog - Give Pause path for 20000 ms"),
(@ENTRY, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 53, 0, 21291, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On respawn  - Start path, walk, repeat, Passive"),
(@ENTRY, 0, 2, 0, 1, 0, 100, 0, 10000, 30000, 240000, 240000, 80, 2129100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When out of combat and timer at the begining - Start timed action list id #2129100");
