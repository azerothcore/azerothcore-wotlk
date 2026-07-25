-- Issue #26755: during "The Nightmare Manifests" (Moonglade), Eranikus and Keeper Remulos
-- never actually fight, permanently stalling the encounter. Confirmed live via `.npc info` on
-- the summoned instances: three unrelated breaks, plus one design gap.
--
-- Eranikus: his "become fightable" unlock (real faction, aggressive reactstate, remove
-- UNIT_FLAG_IMMUNE_TO_PC|IMMUNE_TO_NPC) is gated behind waypoint 4 of an escort path keyed to
-- his own entry (15491) that has zero rows in `waypoint_data` - unreachable. Moved onto "Text 7
-- Over", the last line of his existing dialogue chain, which already fires fine on its own.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15491 AND `source_type` = 0 AND `id` IN (7, 10, 38, 41) AND `link` = 0;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`, `comment`)
VALUES
    (15491, 0, 7, 0, 52, 0, 100, 0, 4, 15491, 1, 5, 10000, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 4 Over - Say Line 5'),
    (15491, 0, 10, 0, 52, 0, 100, 512, 7, 15491, 2, 14, 0, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 7 Over - Set Faction 14'),
    (15491, 0, 38, 0, 52, 0, 100, 512, 7, 15491, 8, 2, 0, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 7 Over - Set Reactstate Aggressive'),
    (15491, 0, 41, 0, 52, 0, 100, 512, 7, 15491, 19, 768, 0, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 7 Over - Remove unitflag');

-- Remulos: his own "Start Attacking Eranikus" (waypoint-triggered) is a one-shot attempt with
-- no retry, and live testing showed he's stuck with UNIT_FLAG_IN_COMBAT (leftover from the
-- earlier Nightmare Phantasm fight), so an out-of-combat-only retry wouldn't fire either.
-- Fixed with a phase-gated pulse (active in or out of combat) that retries every ~3s.
--
-- He also never deals damage to anything at all (confirmed live he doesn't even fight the
-- Phantasm shades) - his faction (635) has HostileMask=0 and no listed enemies, so he can
-- never be hostile by faction rules regardless of reactstate. He already reverts to a peaceful
-- faction once the fight ends; the switch INTO a combat-capable one was simply missing. Added
-- at the same dialogue beat that already sets him aggressive, using faction template 231
-- (HostileMask includes Monster) - best-effort pick pending live confirmation it doesn't also
-- make him attackable by players.
--
-- Third break, same pattern: his post-fight return escort (path 1183201, meant to walk him
-- back and restore UNIT_NPC_FLAG_GOSSIP|QUESTGIVER) also has zero `waypoint_data` rows, so the
-- quest could never be turned in even after a successful fight. Moved the flag-restore and
-- facing-reset onto his last dialogue line directly, without reconstructing the physical
-- walk-back (no coordinates available for it, and it isn't what blocks completion).
DELETE FROM `smart_scripts` WHERE `entryorguid` = 11832 AND `source_type` = 0 AND `id` IN (34, 35, 45, 46, 47) AND `link` = 0;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`, `target_param1`, `target_param2`, `comment`)
VALUES
    (11832, 0, 34, 0, 52, 0, 100, 0, 9, 11832, 0, 0, 82, 3, 0, 0, 1, 0, 0, 'Keeper Remulos - On Text 9 Over - Add Npc Flags Gossip & Questgiver'),
    (11832, 0, 35, 0, 52, 0, 100, 0, 9, 11832, 0, 0, 66, 0, 0, 0, 1, 0, 0, 'Keeper Remulos - On Text 9 Over - Set Orientation Home Position'),
    (11832, 0, 45, 0, 40, 0, 100, 0, 21, 11832, 0, 0, 22, 1, 0, 0, 1, 0, 0, 'Keeper Remulos - On Waypoint 21 Reached - Set Event Phase 1 (engage-retry window)'),
    (11832, 0, 46, 0, 60, 1, 100, 0, 2000, 2000, 3000, 3000, 49, 0, 0, 0, 11, 15491, 30, 'Keeper Remulos - Update Pulse (Phase 1) - Retry Start Attacking Eranikus'),
    (11832, 0, 47, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 2, 231, 0, 0, 1, 0, 0, 'Keeper Remulos - On Text 7 Over - Set Faction 231 (combat-capable, test)');
