-- Displacement Device (Ulduar): it rendered half-sunk into the floor and never moved, because entry
-- 34203 runs NullCreatureAI. Give it SmartAI so it hovers on spawn and walks after the raid.
-- Hover comes from the script, not a `creature_template_movement` row: `Creature::Create()` would
-- apply that row twice and lift the device by 10 instead of the sniffed `HoverHeight` = 5.
-- Only 34203 is touched: `GetAIName()` and `GetScript()` both read `GetEntry()`, which stays 34203
-- in 25 man, so one block drives both difficulties.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 34203;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 34203 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34203,0,0,1,11,0,100,0,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Displacement Device - On Respawn - Set React State Passive'),
(34203,0,1,2,61,0,100,0,0,0,0,0,0,0,207,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Displacement Device - On Respawn - Set Hover On'),
(34203,0,2,0,61,0,100,0,0,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Displacement Device - On Respawn - Set Walk'),
(34203,0,3,0,60,0,100,0,500,500,1000,1000,0,0,69,0,0,0,0,0,1,21,50,0,0,0,0,0,0,0,'Displacement Device - Every 1s - Move To Closest Player');
