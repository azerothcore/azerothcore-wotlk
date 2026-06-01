-- Fix: Hemet Nesingwary (18180) talbuk attack event in Nagrand.
--
-- Root cause: Talbuk Stags (17130) summoned by Hemet's patrol event were missing their
-- JUST_SUMMONED handler. They spawned 50-65 yards away and stood idle. Hemet's combat
-- script (1818000) searched for talbuks within 50 yards but found none, leaving him set
-- to hostile faction 495 indefinitely without ever entering real combat.
--
-- Fixes:
--   1. Restore Talbuk Stag JUST_SUMMONED -> run script 1713000, which sets hostile faction,
--      starts random movement, then after 10 s charges the summoner (Hemet).
--   2. Add EVADE handler on Hemet to reset his own faction and Fitz's faction to 35,
--      so the event cleans up correctly after combat ends or if something goes wrong.
--   3. Move Harold Lane's closing line (line 4) from a timed entry in action list 1818000
--      to a new action list 1818001 triggered by Hemet's EVADE, so it fires only after
--      all talbuks are dead and combat has ended.

-- Talbuk Stag (17130): restore JUST_SUMMONED handler and its action list
DELETE FROM `smart_scripts` WHERE `entryorguid` = 17130 AND `source_type` = 0 AND `id` = 1;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1713000 AND `source_type` = 9;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`,
     `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`,
     `comment`)
VALUES
-- On JUST_SUMMONED: run timed action list 1713000 to activate the stag
(17130, 0, 1, 0,
 54, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 80, 1713000, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Talbuk Stag - Just Summoned - Run Script'),
-- Action list 1713000: set hostile faction, wander briefly, then charge summoner
(1713000, 9, 0, 0,
 0, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 2, 14, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Talbuk Stag - On Script - Set Faction 14'),
(1713000, 9, 1, 0,
 0, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 89, 5, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Talbuk Stag - On Script - Start Random Movement'),
(1713000, 9, 2, 0,
 0, 0, 100, 0,
 10000, 10000, 0, 0, 0, 0,
 49, 0, 0, 0, 0, 0, 0,
 23, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Talbuk Stag - On Script - Start Attacking Summoner');

-- Hemet Nesingwary (18180): add EVADE handler to reset factions as cleanup
-- and trigger Harold Lane's closing line via RUN_SCRIPT on action list 1818001
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18180 AND `source_type` = 0 AND `id` IN (17, 18, 22);
-- Remove timed Harold closing line from hunt script (fires on EVADE instead)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1818000 AND `source_type` = 9 AND `id` = 7;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1818001 AND `source_type` = 9;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`,
     `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`,
     `comment`)
VALUES
-- On EVADE: reset Hemet's own faction to 35 (linked to next)
(18180, 0, 17, 18,
 7, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 2, 35, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - On Evade - Set Faction 35'),
-- Linked: also reset Fitz's faction to 35
(18180, 0, 18, 0,
 61, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 2, 35, 0, 0, 0, 0, 0,
 19, 18200, 100, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - On Evade - Set Faction 35 (Shado Fitz Farstrider)'),
-- On EVADE: run action list 1818001 to trigger Harold's closing line
(18180, 0, 22, 0,
 7, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 80, 1818001, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - On Evade - Run Script (Harold Closing Line)'),
-- Action list 1818001: 3 s pause then Harold says line 4
(1818001, 9, 0, 0,
 0, 0, 100, 0,
 3000, 3000, 0, 0, 0, 0,
 1, 4, 0, 0, 0, 0, 0,
 19, 18218, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - On Script - Say Line 4 (Harold Lane - Closing Line)');

