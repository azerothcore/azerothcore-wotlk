-- Mini Tyrael (entry 29089): fix overly frequent sleep/enrage text spam and dance behavior
-- Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/19781
--
-- Root causes:
-- 1. Spell 69205 (periodic trigger, every 30s) → spell 69204 → SMART_EVENT_SPELLHIT
--    always fired SMART_ACTION_TALK "falls asleep" unconditionally, spamming chat every 30s
--    even when the pet woke up instantly (action list 2908900 path).
--    Fix: remove the unconditional TALK from the main event. Move it into the action lists
--    that actually put the pet to sleep (2908901 and 2908902). Action list 2908900 remains
--    silent, so visible chat spam is reduced by ~33%.
-- 2. Dance response used SMART_ACTION_PLAY_EMOTE (one-shot anim, prevents follow movement).
--    Fix: use SMART_ACTION_CAST with spell 54398 (Tyrael Dance, DUMMY aura visual) which
--    allows the pet to keep following while the dance animation plays.
--    Cooldown increased from 5s to 60s to prevent excessive response spam.
-- 3. Event structure: remove the now-unnecessary linked event (id=2) that was only needed
--    to chain from the unconditional TALK to the random action list.

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (29089, 2908900, 2908901, 2908902) AND `source_type` IN (0, 9);

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- On /dance emote received: cast Tyrael Dance spell (allows movement, 60s cooldown)
(29089, 0, 0, 0, 22, 0, 100, 0, 34, 60000, 60000, 0, 0, 0, 11, 54398, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - On Receive Emote Dance: Cast Tyrael Dance'),
-- On spell 69204 hit (every 30s from aura 69205): pick random behavior (1/3 each)
(29089, 0, 1, 0, 8, 0, 100, 0, 69204, 0, 0, 0, 0, 0, 87, 2908900, 2908901, 2908902, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - On Spell Hit 69204: Random Behavior'),
-- Action list 2908900: silent immediate wake (no chat, ~33% of triggers)
(2908900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 69204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Wake immediately (silent)'),
-- Action list 2908901: say "falls asleep", wake after 15s (~33% of triggers)
(2908901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Say: falls asleep'),
(2908901, 9, 1, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 0, 28, 69204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Wake after 15s'),
-- Action list 2908902: say "falls asleep", wake after 15s, say "becomes enraged" (~33% of triggers)
(2908902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Say: falls asleep'),
(2908902, 9, 1, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 0, 28, 69204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Wake after 15s'),
(2908902, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Say: becomes enraged');
