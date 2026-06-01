-- Fix: Shado 'Fitz' Farstrider first-run combat failure on server startup.
--
-- Background: Gankly Rottenfist's action list 1829701 sends SetData(1,3) to both
-- Fitz AND Hemet during the first talbuk hunt after server startup (Kristen
-- Dipswitch's ~30-min patrol cycle aligns with Hemet's 1800-second Point 1 pause).
-- The full root cause and primary fix are in rev_1880291000000000003. This file
-- provides the defensive layer on Fitz's side.
--
-- What this file does:
--   1. Gives Fitz his own Gankly-RP action list (1820005) that is identical to
--      the shared 1820000 except step 2 restores faction 495 instead of 35.
--      This prevents the Gankly event from directly resetting Fitz's faction.
--   2. Adds EVADE handler on Fitz (id=8): reset faction to 35 after every fight
--      as explicit cleanup, matching Hemet's own evade cleanup (id=17-18).
--
-- The primary fix (Hemet's in-combat periodic id=28 and 1820000 step 2 correction)
-- is in rev_1880291000000000003. Both files are required.

-- ============================================================
-- Fitz (18200): route Data 1-3 trigger to Fitz-specific list
-- ============================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18200 AND `source_type` = 0 AND `id` IN (0, 8);
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`,
     `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`,
     `comment`)
VALUES
-- id=0: same trigger as before but runs 1820005 (Fitz-specific, ends at 495)
(18200, 0, 0, 0,
 38, 0, 100, 512,
 1, 3, 0, 0, 0, 0,
 80, 1820005, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Shado Fitz Farstrider - On Data 1-3 Set - Run Script'),
-- id=8: on evade, reset to neutral faction 35 as defensive cleanup
(18200, 0, 8, 0,
 7, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 2, 35, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Shado Fitz Farstrider - On Evade - Set Faction 35');

-- ============================================================
-- Action list 1820005: Fitz-specific variant of 1820000
-- Identical except step 2 restores faction 495, not 35.
-- ============================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1820005 AND `source_type` = 9;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`,
     `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`,
     `comment`)
VALUES
-- step 0 (0 ms): briefly set faction 250 so spell 32190 can target Gankly (faction 14)
(1820005, 9, 0, 0,
 0, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 2, 250, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Shado Fitz Farstrider - On Script - Set Faction 250'),
-- step 1 (0 ms): fire the Gankly RP shot (identical to 1820000 step 1)
(1820005, 9, 1, 0,
 0, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 11, 32190, 0, 0, 0, 0, 0,
 19, 18297, 0, 0, 0,
 0, 0, 0, 0,
 'Shado Fitz Farstrider - On Script - Cast Shoot at Gankly Rottenfist'),
-- step 2 (3000 ms): restore faction 495 (combat) not 35 (neutral), so the
-- Gankly RP cannot override the hostile state set by Hemet's Point 2 scripts.
-- Cleanup back to 35 is handled by Hemet's evade/Point 4 handlers and Fitz id=8.
(1820005, 9, 2, 0,
 0, 0, 100, 0,
 3000, 3000, 0, 0, 0, 0,
 2, 495, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Shado Fitz Farstrider - On Script - Set Faction 495');
