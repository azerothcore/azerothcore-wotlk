## Remove male Crimson Courier  It has no male text files in the female broadcast_text and only female text without male text ###
DELETE FROM `creature_model_info` WHERE `DisplayID`=10502;
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`) VALUES (10502, 0.208, 1.5, 1, 0);

##  Class TYPE is 12
DELETE FROM `creature_text` WHERE `CreatureID`=12337 AND `GroupID`=1 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(12337, 1, 0, 'Assassins! Guards! Guards!', 12, 0, 100, 0, 0, 0, 7595, 0, 'Crimson Courier');

##  Added text to the Crimson Courier to enter battle
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12337;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12337) AND (`source_type` = 0) AND (`id` IN (8, 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12337, 0, 8, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 3, 0, 10502, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Courier - On Respawn - Modelid'),
(12337, 0, 9, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Courier - On  Aggro - say');

## Set up as a group
DELETE FROM `creature_formations` WHERE `leaderGUID`=92287;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(92287, 92287, 0, 0, 515, 0, 0),
(92287, 92288, 3, 0, 515, 0, 0),
(92287, 92289, 3, 90, 515, 0, 0),
(92287, 92290, 3, 180, 515, 0, 0),
(92287, 92291, 3, 270, 515, 0, 0);