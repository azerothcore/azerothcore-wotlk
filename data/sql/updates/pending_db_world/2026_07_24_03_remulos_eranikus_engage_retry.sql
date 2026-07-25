-- Issue #26755: after Keeper Remulos (11832) reaches Eranikus, Tyrant of the Dream (15491)
-- during "The Nightmare Manifests", he stands next to him and neither ever enters combat,
-- stalling the encounter.
--
-- Remulos's own "Start Attacking" trigger (id 29) fires once, on his own waypoint 21 - a
-- single one-shot attempt with no retry. Live testing (`.npc info`) confirmed Remulos still
-- carries UNIT_FLAG_IN_COMBAT at that point - a leftover from the Nightmare Phantasm fight
-- earlier on the same path, which never fully clears - so a plain out-of-combat retry pulse
-- would never fire either. See also 2026_07_24_04_eranikus_missing_waypoints.sql for the
-- other half of this bug (Eranikus himself never actually becomes attackable at all).
--
-- Fixed by switching to a phase-gated retry: reaching waypoint 21 now also sets event phase
-- 1, and a new pulse - active in or out of combat, so Remulos's own stuck in-combat flag
-- doesn't block it - retries "Start Attacking" against Eranikus every ~3s until it lands.
--
-- Separately, Remulos never actually deals damage to anything (confirmed live he doesn't even
-- fight the Nightmare Phantasm shades earlier in the same encounter) - his faction (635) has
-- HostileMask=0 and no listed enemies, so by faction rules alone he can never be hostile to
-- anything, regardless of react state or Start Attacking. He never changes faction anywhere in
-- his own script even though he already reverts to a peaceful faction (35) once the fight is
-- over (Text 11 Over) - that reversion was always there, the switch INTO a combat-capable
-- faction beforehand was missing. Added at "Text 7 Over" (the same dialogue beat that already
-- sets him aggressive, right before the Phantasm shades spawn) using faction template 231
-- (HostileMask includes Monster) - best-effort pick pending live confirmation it doesn't also
-- make him attackable by players.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 11832 AND `source_type` = 0 AND `id` IN (45, 46, 47);
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`, `target_param1`, `target_param2`, `comment`)
VALUES
    (11832, 0, 45, 0, 40, 0, 100, 0, 21, 11832, 0, 0, 22, 1, 0, 0, 1, 0, 0, 'Keeper Remulos - On Waypoint 21 Reached - Set Event Phase 1 (engage-retry window)'),
    (11832, 0, 46, 0, 60, 1, 100, 0, 2000, 2000, 3000, 3000, 49, 0, 0, 0, 11, 15491, 30, 'Keeper Remulos - Update Pulse (Phase 1) - Retry Start Attacking Eranikus'),
    (11832, 0, 47, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 2, 231, 0, 0, 1, 0, 0, 'Keeper Remulos - On Text 7 Over - Set Faction 231 (combat-capable, test)');
