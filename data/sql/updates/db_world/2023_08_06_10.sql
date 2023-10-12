-- DB update 2023_08_06_09 -> 2023_08_06_10
 -- Master Woodsman Anderhol smart ai
SET @ENTRY := 27277;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, 20, 0, 100, 0, 12227, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On player rewarded quest Doing Your Duty (12227) - Self: Talk Alright Ben. We\'ve retrieved the amberseeds again. You know ... (0) to invoker'),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 10, 113907, 27071, 0, 0, 0, 0, 0, 'On player rewarded quest Doing Your Duty (12227) - Creature Benjamin Jacobs (27071) with guid 113907 (fetching): Set creature data #0 to 0');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 27277 AND `SourceId` = 0;

DELETE FROM `creature_text` WHERE `CreatureID` = 27277;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27277, 0, 0, 'Alright Ben. We\'ve retrieved the amberseeds again. You know the drill.', 12, 0, 100, 0, 0, 0, 26350, 0, 'Master Woodsman Anderhol // Master Woodsman Anderhol');

DELETE FROM `creature_text` WHERE `CreatureID` = 27071;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27071, 0, 0, 'I know, I know. Back in the bucket....', 12, 0, 100, 0, 0, 0, 26351, 0, 'Benjamin Jacobs // Benjamin Jacobs');

DELETE FROM `waypoints` WHERE (`entry` = 27071) AND (`pointid` IN (1, 2));
DELETE FROM `waypoints` WHERE (`entry` = 2707100) AND (`pointid` BETWEEN 1 AND 13);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(27071, 1, 3405.55, -2792.33, 201.809, NULL, 0, NULL),
(27071, 2, 3414.19, -2795.07, 201.514, NULL, 0, NULL),
(2707100, 1, 3416.03, -2792.59, 201.818, NULL, 0, NULL),
(2707100, 2, 3416.28, -2791.84, 201.818, NULL, 0, NULL),
(2707100, 3, 3420.28, -2786.09, 201.818, NULL, 0, NULL),
(2707100, 4, 3421, -2785.11, 201.657, NULL, 0, NULL),
(2707100, 5, 3421.46, -2784.44, 201.777, NULL, 0, NULL),
(2707100, 6, 3422.37, -2783.12, 202.621, NULL, 0, NULL),
(2707100, 7, 3422.38, -2783.11, 202.614, NULL, 0, NULL),
(2707100, 8, 3423.12, -2782.5, 202.625, NULL, 0, NULL),
(2707100, 9, 3424.93, -2780.98, 202.628, NULL, 0, NULL),
(2707100, 10, 3426.54, -2779.83, 202.889, NULL, 0, NULL),
(2707100, 11, 3427.29, -2779.33, 202.889, NULL, 0, NULL),
(2707100, 12, 3428.04, -2779.33, 202.889, NULL, 0, NULL),
(2707100, 13, 3431.14, -2779.69, 202.65, NULL, 0, NULL);

 -- Benjamin Jacobs smart ai
SET @ENTRY := 27071;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, 38, 0, 100, 0, 0, 0, 0, 0, 53, 0, 27071, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 0 - Self: Start path #27071, walk, do not repeat, Passive'),
(@ENTRY, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 6000, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 0 - Trigger timed event timedEvent[1] in 6000 - 6000 ms // -meta_wait'),
(@ENTRY, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 67, 2, 14000, 14000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 0 - Trigger timed event timedEvent[2] in 14000 - 14000 ms // -meta_wait'),
(@ENTRY, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 3, 24000, 24000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 0 - Trigger timed event timedEvent[3] in 24000 - 24000 ms // -meta_wait'),
(@ENTRY, 0, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On timed event timedEvent[1] triggered - Self: Talk I know, I know. Back in the bucket.... (0) to invoker'),
(@ENTRY, 0, 5, 0, 59, 0, 100, 0, 2, 0, 0, 0, 53, 0, 2707100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On timed event timedEvent[2] triggered - Self: Start path #2707100, walk, do not repeat, Passive'),
(@ENTRY, 0, 6, 7, 59, 0, 100, 0, 3, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On timed event timedEvent[3] triggered - Self: Set stand state to KNEEL'),
(@ENTRY, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 6000, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On timed event timedEvent[3] triggered - Self: Despawn in 6 s respawn in 1 seconds'),
(@ENTRY, 0, 8, 0, 11, 0, 100, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 10, 113907, 27071, 0, 0, 0, 0, 0, 'On respawn - Creature Benjamin Jacobs (27071) with guid 113907 (fetching): Remove stand state KNEEL');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 27071 AND `SourceId` = 0;

