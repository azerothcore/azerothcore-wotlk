-- Issue #26755: during "The Nightmare Manifests", Eranikus, Tyrant of the Dream (15491) never
-- becomes attackable/hostile - he keeps UNIT_FLAG_IMMUNE_TO_PC|IMMUNE_TO_NPC (768) and his
-- default (non-hostile) faction forever, confirmed live via `.npc info` on the actual summoned
-- instance. Neither Keeper Remulos nor a player can ever engage him, permanently stalling the
-- encounter.
--
-- Root cause: the "become fightable" unlock (set faction 14, react aggressive, remove the
-- immune flags) is gated behind SMART_EVENT_WAYPOINT_REACHED on point 4 of an escort path keyed
-- to his own entry (15491). That path has zero rows in `waypoint_data` - confirmed via direct
-- lookup - so that waypoint can never be reached, and the unlock never fires. Everything else
-- about his sequence (landing, dialogue, shade-summon waves) already works as originally
-- authored and is left untouched here - only the unreachable unlock needed rewiring.
--
-- Fixed by moving the unlock actions onto "Text 7 Over" instead - the last line of dialogue in
-- the existing shade-wave/dialogue chain (said via the nested action lists 1549100/1549101),
-- already proven to fire independent of any waypoint data. That chain starts from "Text 4 Over"
-- (id 7, previously gated behind the same unreachable waypoint 3 - moved alongside the unlock
-- so the dialogue leading up to it isn't itself stuck).
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15491 AND `source_type` = 0 AND `id` IN (7, 10, 38, 41);
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`, `comment`)
VALUES
    (15491, 0, 7, 0, 52, 0, 100, 0, 4, 15491, 1, 5, 10000, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 4 Over - Say Line 5'),
    (15491, 0, 10, 0, 52, 0, 100, 512, 7, 15491, 2, 14, 0, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 7 Over - Set Faction 14'),
    (15491, 0, 38, 0, 52, 0, 100, 512, 7, 15491, 8, 2, 0, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 7 Over - Set Reactstate Aggressive'),
    (15491, 0, 41, 0, 52, 0, 100, 512, 7, 15491, 19, 768, 0, 0, 1, 'Eranikus, Tyrant of the Dream - On Text 7 Over - Remove unitflag');
