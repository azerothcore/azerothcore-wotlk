INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647748556942480300');

/* Old Blanchy
*/

UPDATE `creature_template` SET `type` = 0 WHERE (`entry` = 582);

/* Furlbrow Family Text Update
*/

DELETE FROM `creature_text` WHERE `CreatureID`=237 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (237, 0, 0, 'Can\'t believe the forsaken wagon broke down.  Ain\'t no luck to be had in this land...', 12, 7, 100, 0, 0, 0, 56, 0, 'Farmer Furlbrow');
DELETE FROM `creature_text` WHERE `CreatureID`=237 AND `GroupID`=0 AND `ID`=1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (237, 0, 1, 'We\'ll be out of here just as soon as I get this wagon fixed...', 12, 7, 100, 0, 0, 0, 57, 0, 'Farmer Furlbrow');
DELETE FROM `creature_text` WHERE `CreatureID`=238 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (238, 0, 0, 'Don\'t worry, Old Blanchy, we\'ll get you something to eat soon...', 12, 7, 100, 0, 0, 0, 54, 0, 'Verna Furlbrow');
DELETE FROM `creature_text` WHERE `CreatureID`=238 AND `GroupID`=0 AND `ID`=1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (238, 0, 1, 'I never thought the day would come that I\'d leave my homeland of Westfall...', 12, 7, 100, 0, 0, 0, 55, 0, 'Verna Furlbrow');

UPDATE `broadcast_text` SET `FemaleText`='Don\'t worry, Old Blanchy, we\'ll get you something to eat soon...' WHERE `ID` =54;
UPDATE `broadcast_text` SET `FemaleText`='I never thought the day would come that I\'d leave my homeland of Westfall...' WHERE `ID` =55;
UPDATE `broadcast_text` SET `MaleText`='Can\'t believe the forsaken wagon broke down.  Ain\'t no luck to be had in this land...' WHERE `ID` =56;
UPDATE `broadcast_text` SET `MaleText`='We\'ll be out of here just as soon as I get this wagon fixed...' WHERE `ID` =57;

/* SAI for text lines
*/

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 237;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 237) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(237, 0, 0, 0, 1, 0, 100, 0, 10000, 10000, 180000, 180000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Farmer Furlbrow - Out of Combat - Say Line 0');


UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 238;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 238) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(238, 0, 0, 0, 1, 0, 100, 0, 6000, 8000, 240000, 240000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Verna Furlbrow - Out of Combat - Say Line 0');
