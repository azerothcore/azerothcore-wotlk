INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558797300881954502');

UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` = 10596;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 10596 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(10596,0,0,0,0,0,100,2,10000,10000,5000,12500,0,11,16468,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mother Smolderweb - In Combat - Cast ''Mother''s Milk'''),
(10596,0,1,0,0,0,100,2,20000,20000,15000,15000,0,11,16104,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Mother Smolderweb - In Combat - Cast ''Crystallize'''),
(10596,0,2,0,6,0,100,2,0,0,0,0,0,11,16103,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mother Smolderweb - On Death - Cast ''Summon Spire Spiderling''');
