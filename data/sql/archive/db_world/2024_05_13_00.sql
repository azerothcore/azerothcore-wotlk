-- DB update 2024_05_12_03 -> 2024_05_13_00
-- Rimblat Earthshatter smart ai
SET @ENTRY := 16134;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` IN (@ENTRY * 100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 1, 0, 100, 512, 1000, 15000, 150000, 180000, 80, 1613400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter: Start timed action list id #Rimblat Earthshatter #0 (1613400) (update out of combat) // -inline'),
(@ENTRY * 100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - Talk 0 to invoker'),
(@ENTRY * 100, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - Play emote ONESHOT_KNEEL (16)'),
(@ENTRY * 100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 50, 181104, 0, 1, 8, 0, 0, 8, 0, 0, 0, 2276.9, -5326.88, 88.6976, 1.67551, 'Rimblat Earthshatter - Summon gameobject - Small Dirt Mound (181104) at (2276.9, -5326.88, 88.6976, 1.67551) and despawn in 0 ms'),
(@ENTRY * 100, 9, 3, 0, 0, 0, 100, 0, 4400, 4400, 0, 0, 11, 27824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rimblat Earthshatter - Cast spell Rimblat Grows Flower DND (27824) on Self'),
(@ENTRY * 100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 50, 181103, 0, 1, 8, 0, 0, 8, 0, 0, 0, 2277, -5326.86, 88.7085, 5.74214, 'Rimblat Earthshatter - Summon gameobject - Flower (181103) at (2277, -5326.86, 88.7085, 5.74214) and despawn in 0 ms'),
(@ENTRY * 100, 9, 5, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 41, 0, 0, 0, 0, 0, 0, 20, 181104, 10, 0, 0, 0, 0, 0, 'Closest gameobject Small Dirt Mound (181104) in 10 yards: Despawn instantly'),
(@ENTRY * 100, 9, 6, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 5, 21, 0, 0, 0, 0, 0, 10, 54186, 16135, 0, 0, 0, 0, 0, 'Creature Rayne (16135) with guid 54186 (fetching): Play emote ONESHOT_APPLAUD (21)'),
(@ENTRY * 100, 9, 7, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 54186, 16135, 0, 0, 0, 0, 0, 'Creature Rayne (16135) with guid 54186 (fetching): Talk 0 to invoker'),
(@ENTRY * 100, 9, 8, 0, 0, 0, 100, 0, 58600, 58600, 0, 0, 41, 0, 0, 0, 0, 0, 0, 20, 181103, 10, 0, 0, 0, 0, 0, 'Closest gameobject Flower (181103) in 10 yards: Despawn instantly');

-- DEL Flower
DELETE FROM `gameobject` WHERE `id` = 181103 AND `guid` = 45964;

-- DEL Small Dirt Mound
DELETE FROM `gameobject` WHERE `id` = 181104 AND `guid` = 45965;
