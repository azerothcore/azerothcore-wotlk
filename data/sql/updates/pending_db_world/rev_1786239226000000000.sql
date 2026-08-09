-- Quest 619 "Enticing Negolash" has no QuestDescription, so its quest log entry
-- shows only the required items. The lifeboat itself does show text, from
-- quest_request_items.CompletionText, so the string already exists in the DB and is
-- the quest's own wording: it is simply never shown in the log.
--
-- Reusing that exact text rather than writing new flavour, so nothing here is
-- invented. The original data leaves QuestDescription empty (checked on Wowhead
-- WotLK and Classic, Warcraft Wiki, TrinityCore and VMaNGOS), so this is a
-- readability change, not a restoration.
UPDATE `quest_template` SET
    `QuestDescription` = 'This is an abandoned lifeboat.  Printed along its side in scratched, faded paint are the words:$B$B"Smotts\' Revenge"',
    `LogDescription`   = 'Bring 10 Barbecued Buzzard Wings and 5 Junglevine Wine to the Ruined Lifeboat.'
WHERE `ID` = 619;

-- Negolash is summoned onto the beach right next to the player instead of rising out
-- of the sea, so he never makes the walk towards the boat where the food was laid out
-- (issue #27049). The SmartAI on the Ruined Lifeboat spawns him at z = 1.72, which is
-- above the waterline.
--
-- VMaNGOS, whose data for this vanilla quest is researched down to respawning each
-- buzzard wing, summons him at -14598.6 76.0563 -11.249, well below the surface:
-- sql/migrations/20211001113141_world.sql, "Ruined Lifeboat - Summon Creature Negolash".
UPDATE `smart_scripts` SET `target_x` = -14598.6, `target_y` = 76.0563, `target_z` = -11.249, `target_o` = 0.925025
WHERE `entryorguid` = 2289 AND `source_type` = 1 AND `id` = 0 AND `event_type` = 20 AND `action_type` = 12;

-- The yell and the walk in. Negolash's line sits on SMART_EVENT_UPDATE_OOC (1), a
-- pulse that keeps firing while he is out of combat, so it repeats instead of playing
-- once. He also never moves: he is meant to surface offshore, say his line, wade in
-- towards the food and speak again on arrival.
--
-- Path and timings from VMaNGOS (sql/migrations/20211001113141_world.sql): six points
-- climbing from z -11.249 out at sea up to 0.734 on the sand, with his two lines fired
-- at the first and the fifth. Both texts already exist in broadcast_text, 731 and 763,
-- so nothing here is written from scratch.
--
-- He also has to stay passive until he is ashore: he is hostile and aggroes the moment
-- he surfaces, and combat movement then overrides the path, leaving him standing in the
-- water unable to reach anyone. React state goes back to aggressive on the last point.
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
(1494, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 149400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Just Summoned - Start Waypoint Path (walk)'),
(1494, 0, 4, 5, 40, 0, 100, 0, 5, 149400, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Waypoint 5 Reached - Say Line 1'),
(1494, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Waypoint 5 Reached - Allow Combat Movement'),
(1494, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Waypoint 5 Reached - Set React State Aggressive');
