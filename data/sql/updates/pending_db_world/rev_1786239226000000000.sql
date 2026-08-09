-- 619 shows only its required items in the log because QuestDescription is empty.
-- Reuses the lifeboat's own wording, already in quest_request_items.
UPDATE `quest_template` SET
    `QuestDescription` = 'This is an abandoned lifeboat.  Printed along its side in scratched, faded paint are the words:$B$B"Smotts\' Revenge"',
    `LogDescription`   = 'Bring 10 Barbecued Buzzard Wings and 5 Junglevine Wine to the Ruined Lifeboat.'
WHERE `ID` = 619;

-- Negolash is summoned onto the sand beside the player instead of offshore (#27049).
-- Position from VMaNGOS, sql/migrations/20211001113141_world.sql.
UPDATE `smart_scripts` SET `target_x` = -14598.6, `target_y` = 76.0563, `target_z` = -11.249, `target_o` = 0.925025
WHERE `entryorguid` = 2289 AND `source_type` = 1 AND `id` = 0 AND `event_type` = 20 AND `action_type` = 12;

-- His line is on UPDATE_OOC so it repeats, and he never wades in. Path and both texts
-- from the same VMaNGOS file; he stays passive until ashore or chase overrides the path.
DELETE FROM `creature_text` WHERE `CreatureID` = 1494 AND `GroupID` = 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `BroadcastTextId`, `comment`) VALUES
(1494, 1, 0, 'AH, A FEAST!  WHO LEFT THIS HERE...?', 14, 0, 100, 763, 'Negolash - On reaching the lifeboat');

DELETE FROM `waypoint_data` WHERE `id` = 149400;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`) VALUES
(149400, 1, -14598.599609, 76.056297, -11.249000, 0, 0),
(149400, 2, -14603.400391, 87.177902, -10.240300, 0, 0),
(149400, 3, -14612.900391, 104.960999, -8.736550, 0, 0),
(149400, 4, -14625.200195, 125.224998, -5.169360, 0, 0),
(149400, 5, -14647.200195, 142.490005, 0.734623, 1000, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1494 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1494, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Just Summoned - Say Line 0'),
(1494, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Just Summoned - Set React State Passive'),
(1494, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Just Summoned - Stop Combat Movement'),
(1494, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 149400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Just Summoned - Start Waypoint Path'),
(1494, 0, 4, 5, 108, 0, 100, 1, 5, 149400, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Waypoint 5 Reached - Say Line 1'),
(1494, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Waypoint 5 Reached - Allow Combat Movement'),
(1494, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Waypoint 5 Reached - Set React State Aggressive');
