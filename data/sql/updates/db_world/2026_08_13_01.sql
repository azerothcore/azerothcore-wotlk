-- DB update 2026_08_13_00 -> 2026_08_13_01
-- Sifreldar Storm Maiden (29323) - Storm Cloud (57408)
-- The spell was bound to SMART_EVENT_AGGRO (fires at 0ms) with NOT_REPEATABLE,
-- so it was cast instantly on pull and never re-applied, even though the aura
-- only lasts 10 seconds. Moved to SMART_EVENT_UPDATE_IC: first cast ~5s after
-- combat starts (as seen in the reference videos), then repeated.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = 29323);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29323, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 15000, 20000, 0, 0, 11, 57408, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sifreldar Storm Maiden - In Combat - Cast \'Storm Cloud\'');
