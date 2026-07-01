-- Fix: Hemet Nesingwary faction reset during first talbuk hunt on server startup.
--
-- Potential Root cause:
--   Gankly Rottenfist's action list 1829701 sends SetData(1,3) to HEMET as well
--   as Fitz. On first server startup Gankly's patrol cycle aligns with Hemet's
--   30-minute Point 1 pause, so 1829701 fires during the active talbuk hunt.
--   1829701 step 8 triggers Hemet's id=0 handler, running action list 1820000.
--   1820000 step 2 was resetting Hemet's faction to 35 (neutral). At faction 35:
--     - Hemet could no longer damage talbuks (auto-attack faction check fails).
--     - Hemet evaded after his leash timer expired.
--     - Hemet's EVADE handler (id=17-18) fired, resetting FITZ's faction to 35.
--     - With Fitz at faction 35, he could not attack the talbuks either.
--   On subsequent runs Gankly's cycle is out of phase, so the problem never
--   recurs in the same server session.
--
-- Fix: Change 1820000 step 2 from faction 35 to faction 495. After the Gankly
-- RP "shoot" animation, Hemet ends in combat faction (495) instead of neutral,
-- so he never evades prematurely and never cascades a faction reset onto Fitz.
-- Cleanup back to 35 is handled by Hemet's existing EVADE and Point 4 handlers
-- at the natural end of each hunt cycle. Fitz already has matching cleanup via
-- his EVADE handler added in rev_1880291000000000002.
--
-- Note: Fitz no longer uses 1820000 (redirected to 1820005 in rev_...002), so
-- this change is Hemet-only.
--
-- A belt-and-suspenders measure is also added: while Hemet is in combat he
-- actively re-applies faction 495 to Fitz every 3 s (id=28). This makes the
-- fix robust against any remaining unknown reset source -- whatever resets
-- Fitz's faction will be overwritten within 3 s of Hemet firing at a talbuk.

-- ============================================================
-- Hemet (18180): in-combat periodic to maintain Fitz's combat faction
-- ============================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18180 AND `source_type` = 0 AND `id` = 28;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`,
     `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`,
     `comment`)
VALUES
(18180, 0, 28, 0,
 0, 0, 100, 0,
 2000, 2000, 3000, 3000, 0, 0,
 2, 495, 0, 0, 0, 0, 0,
 19, 18200, 100, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - In Combat - Maintain Fitz Combat Faction 495');

-- ============================================================
-- Action list 1820000 (Hemet's Gankly RP "shoot" sequence)
-- ============================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1820000 AND `source_type` = 9;
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
(1820000, 9, 0, 0,
 0, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 2, 250, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - On Script - Set Faction 250'),
-- step 1 (0 ms): fire the Gankly RP shot
(1820000, 9, 1, 0,
 0, 0, 100, 0,
 0, 0, 0, 0, 0, 0,
 11, 32190, 0, 0, 0, 0, 0,
 19, 18297, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - On Script - Cast Shoot at Gankly Rottenfist'),
-- step 2 (3000 ms): restore faction 495 (combat) not 35 (neutral), so the
-- Gankly RP cannot override the hostile state set by Hemet's Point 2 scripts.
-- Hemet evading at faction 35 would cascade a faction reset onto Fitz via id=18.
(1820000, 9, 2, 0,
 0, 0, 100, 0,
 3000, 3000, 0, 0, 0, 0,
 2, 495, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 0, 0, 0,
 'Hemet Nesingwary - On Script - Set Faction 495');
