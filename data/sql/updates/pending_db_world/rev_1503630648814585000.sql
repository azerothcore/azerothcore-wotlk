INSERT INTO version_db_world (`sql_rev`) VALUES ('1503630648814585000');

-- fix arrows and spawn script, must be started after talk
UPDATE `smart_scripts` SET  `id` = '6' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '4' AND `link` = '0';
UPDATE `smart_scripts` SET  `id` = '4' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '3' AND `link` = '0'; 
UPDATE `smart_scripts` SET  `id` = '5',`source_type` = '9',`entryorguid` = '1746100' WHERE `entryorguid` = '17461' AND `source_type` = '0' AND `id` = '2' AND `link` = '0'; 
UPDATE `smart_scripts` SET  `id` = '3',`source_type` = '9',`entryorguid` = '1746100' WHERE `entryorguid` = '17461' AND `source_type` = '0' AND `id` = '1' AND `link` = '0'; 


-- fix infinite spawn bug
UPDATE `smart_scripts` SET `event_param3` = '0' , `event_param4` = '0' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '5' AND `link` = '0';

-- fix timings
UPDATE `smart_scripts` SET `event_param1` = '4000' , `event_param2` = '4000' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '2' AND `link` = '0'; 
UPDATE `smart_scripts` SET `event_param1` = '0' , `event_param2` = '0' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '3' AND `link` = '0';

-- added voice to blood guard 
UPDATE `creature_text` SET `sound` = '10156' WHERE `entry` = '17461' AND `groupid` = '0' AND `id` = '0'; 
UPDATE `creature_text` SET `sound` = '10157' WHERE `entry` = '17461' AND `groupid` = '1' AND `id` = '0'; 
UPDATE `creature_text` SET `sound` = '10158' WHERE `entry` = '17461' AND `groupid` = '2' AND `id` = '0'; 
UPDATE `creature_text` SET `sound` = '10159' WHERE `entry` = '17461' AND `groupid` = '3' AND `id` = '0'; 
