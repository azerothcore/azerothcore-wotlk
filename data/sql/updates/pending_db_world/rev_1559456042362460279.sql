INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559456042362460279');

-- use "SMART_ACTION_MUSIC" instead of "SMART_ACTION_SOUND" to play "Lament of the Highborne" as music for all players within 50 yards distance
-- changed the comments of the other SAI entries slightly
DELETE FROM `smart_scripts` WHERE `entryorguid` = 39048 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(39048,0,0,0,60,0,100,1,200,200,0,0,0,11,37090,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sylvanas Lamenter - On Update - Cast Spell ''Lament of the Highborne: Highborne Aura'''),
(39048,0,1,0,1,0,100,0,0,0,5000,5000,0,216,15095,1,0,0,0,0,18,50,0,0,0,0,0,0,0,'Sylvanas Lamenter - OOC - Play music for players within 50 yards (Repeat every 5 seconds)'),
(39048,0,2,3,60,0,100,1,1000,1000,0,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sylvanas Lamenter - On Update - Set Fly (No Repeat)'),
(39048,0,3,0,61,0,100,0,0,0,0,0,0,69,1,0,0,0,0,0,1,0,0,0,0,0,0,6,0,'Sylvanas Lamenter - Linked - Move Pos To Self offset Z');

-- use "onlySelf" 1 for Thrall event as the music needs to be played only for the players directly
UPDATE `smart_scripts` SET `action_param2` = 1 WHERE `entryorguid` = 19556 AND `source_type` = 0 AND `action_type` = 216;
