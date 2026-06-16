-- Mini Tyrael (entry 29089): fix sleep text spam and frozen dance
-- Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/19781
--
-- Retail behavior (WotLK 3.3.5a):
--   - Companion pet that follows the player behind (MINI_PET_FOLLOW_ANGLE).
--   - Occasionally emits "%s falls asleep." and sometimes "%s becomes enraged." after.
--   - When the player /dances at the pet, it starts the Tyrael Dance animation while
--     continuing to follow the player (it does NOT stop moving).
--
-- Root cause 1 — Chat spam every 30 seconds:
--   creature_template_addon has auras='69205'. Spell 69205 is SPELL_AURA_PERIODIC_TRIGGER_SPELL
--   with amplitude=30000ms that triggers spell 69204 on the pet every 30 seconds. The old
--   SMART_EVENT_SPELLHIT handler always fired SMART_ACTION_TALK unconditionally, regardless of
--   which random action list was chosen, causing "%s falls asleep." to appear in chat every 30s.
--   Fix: remove aura 69205 from creature_template_addon. Replace the 30s hard-coded DBC trigger
--   with a SmartAI UPDATE_OOC timer (5–10 min random) so the behavior fires much less frequently
--   and at a retail-appropriate cadence. The SPELLHIT handler and action lists that remove aura
--   69204 are also removed since 69204 is never applied anymore.
--
-- Root cause 2 — Dance freezes the pet in place:
--   The old SMART_EVENT_RECEIVE_EMOTE response used SMART_ACTION_PLAY_EMOTE with emote 94
--   (EMOTE_ONESHOT_DANCE). ONESHOT emotes interrupt the movement generator momentarily and
--   leave the creature root-looking until the emote finishes. Spell 54398 ("Tyrael Dance") is
--   SPELL_AURA_DUMMY with the dance visual that plays as an overlay without affecting movement.
--   Fix: replace PLAY_EMOTE with SMART_ACTION_CAST spell 54398 (SMARTCAST_TRIGGERED flag).
--
-- Spell reference:
--   69205: SPELL_AURA_PERIODIC_TRIGGER_SPELL (amplitude 30s) — removed from addon.auras
--   69204: SPELL_AURA_DUMMY — no longer applied, handler removed
--   54398: "Tyrael Dance" — SPELL_AURA_DUMMY with dance visual; does not stop movement

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (29089, 2908900, 2908901, 2908902) AND `source_type` IN (0, 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- On /dance emote: cast Tyrael Dance (triggered, no cast time, 60s cooldown to avoid spam)
(29089, 0, 0, 0, 22, 0, 100, 0, 34, 60000, 60000, 0, 0, 0, 11, 54398, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - On Receive Emote Dance: Cast Tyrael Dance'),
-- Out of combat: randomly say falls asleep (50%) or falls asleep then enrages (50%) every 5-10 min
(29089, 0, 1, 0, 2, 0, 100, 0, 300000, 600000, 0, 0, 0, 0, 87, 2908901, 2908902, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Update OOC: Occasional sleep or enrage (5-10 min random)'),
-- Action list 2908901: say falls asleep (50% of triggers)
(2908901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Say: falls asleep'),
-- Action list 2908902: say falls asleep, then becomes enraged after 15s (50% of triggers)
(2908902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Say: falls asleep'),
(2908902, 9, 1, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Say: becomes enraged');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 29089 AND `SourceId` = 0;
DELETE FROM `creature_template_addon` WHERE `entry` = 29089;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(29089, 0, 0, 0, 0, 0, 0, '');
