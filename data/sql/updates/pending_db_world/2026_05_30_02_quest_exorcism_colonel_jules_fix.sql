-- DB update 2026_05_23_00 -> 2026_05_30_02
--
-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/638
-- Quest "The Exorcism of Colonel Jules" (10935) — 8 scripting fixes

-- -------------------------------------------------------------------------
-- Bug 1: Barada's "start exorcism" gossip menu can be triggered while the
--        event is already running, potentially starting a second parallel
--        event. Adding NOT_REPEATABLE (flag 0x001) prevents re-triggering
--        until Barada resets (evade → OnReset clears runOnce).
-- -------------------------------------------------------------------------
-- Anchorite Barada (entry 22431), id=3: ON_GOSSIP_SELECT → event_flags 512 → 513
UPDATE `smart_scripts` SET `event_flags` = 513 -- was 512 (WHILE_CHARMED); add NOT_REPEATABLE (0x001)
    WHERE `entryorguid` = 22431 AND `source_type` = 0 AND `id` = 3;

-- -------------------------------------------------------------------------
-- Bug 2: Colonel Jules (entry 22432) uses swimming animation when floating.
--        creature_template_movement has Swim=1, causing the swim anim to
--        play instead of the hover/fly anim. Setting Swim=0 fixes this.
-- -------------------------------------------------------------------------
UPDATE `creature_template_movement` SET `Swim` = 0 -- was 1 (caused swim animation while hovering)
    WHERE `CreatureId` = 22432;

-- -------------------------------------------------------------------------
-- Bug 3: After the player subdues Jules (gossip click → kill credit),
--        Jules evades back to his bed after only 5 000 ms — far too fast.
--        The original also left Jules walking his 44-waypoint cyclic loop
--        during any delay before evading.
--
-- Fix: single EVADE (24) at 0 ms. SMART_ACTION_EVADE calls EnterEvadeMode()
-- which calls MoveTargetedHome() — this immediately overrides any current
-- motion (waypoint, walk) and sends Jules straight back to his spawn
-- position (his bed). No WP_STOP needed; EVADE handles it internally.
-- -------------------------------------------------------------------------
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2243201 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2243201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Quest Complete - Evade immediately back to bed');

-- -------------------------------------------------------------------------
-- Bug 4: Barada stops kneeling (UNIT_FIELD_BYTES_1 cleared) 5 seconds
--        before the player can even click Jules to end the event, making
--        the exorcist appear to snap out of his ritual pose prematurely.
--        Adding a 10 000 ms delay before REMOVE_UNIT_FIELD_BYTES_1 keeps
--        Barada kneeling until after Jules is available for interaction.
-- -------------------------------------------------------------------------
-- Script9 2243100 id=25: REMOVE_UNIT_FIELD_BYTES_1 delay 0 → 10 000 ms
UPDATE `smart_scripts` SET `event_param1` = 10000, -- was 0
    `event_param2` = 10000 -- was 0
    WHERE `entryorguid` = 2243100 AND `source_type` = 9 AND `id` = 25;

-- -------------------------------------------------------------------------
-- Bug 5: "Darkness Released" ghost (entry 22507) spawns too frequently and
--        accumulates to lethal numbers, making it impossible to keep the
--        Draenei alive.
--
-- The SUMMON_CREATURE event on Colonel Jules (entry 22432, id=7) has:
--   repeat timer   : 3 000–8 000 ms  (avg ~5.5 s)
--   summon type    : 2 = TIMED_OR_CORPSE_DESPAWN (may fail to despawn if
--                    ghost is in combat with Barada or the player)
--   ghost despawn  : 60 000 ms (60 s)
--
-- At steady state this produces ~11 ghosts simultaneously, each casting a
-- damage spell every 3–8 s — the Draenei dies within seconds once ghosts
-- accumulate, making the quest unkillable without extraordinary healing.
--
-- Fix: slow spawn rate to 35–50 s, change summon type to TIMED_DESPAWN (3)
-- so ghosts always despawn regardless of combat state, and shorten lifespan
-- to 30 s. This keeps at most 1–2 ghosts active at any given moment,
-- matching the intended difficulty of a solo TBC quest.
-- -------------------------------------------------------------------------
-- Colonel Jules (entry 22432), id=7: SUMMON_CREATURE "Darkness Released"
--   event_param3 (repeat min): 3 000  → 35 000 ms
--   event_param4 (repeat max): 8 000  → 50 000 ms
--   action_param2 (summon type): 2   → 3 (TIMED_DESPAWN, guaranteed)
--   action_param3 (despawn)  : 60 000 → 30 000 ms
UPDATE `smart_scripts` SET `event_param3` = 35000, -- was 3000 (repeat min)
    `event_param4` = 50000, -- was 8000 (repeat max)
    `action_param2` = 3, -- was 2 (TIMED_OR_CORPSE_DESPAWN → TIMED_DESPAWN, guaranteed)
    `action_param3` = 30000 -- was 60000 (ghost despawn time)
    WHERE `entryorguid` = 22432 AND `source_type` = 0 AND `id` = 7;

-- -------------------------------------------------------------------------
-- Bug 6: If Anchorite Barada dies while the exorcism is in progress, Colonel
--        Jules remains in phase 1 and continues summoning Darkness Released
--        ghosts indefinitely. There is no JUST_DIED handler to stop the event.
--
-- IMPORTANT: SMART_ACTION_SET_EVENT_PHASE (22) always acts on the script
-- owner (GetBaseObject()) — it ignores any target list. The fix uses a
-- two-step signal via SET_DATA → Jules handles it himself with EVADE.
--   • Barada JUST_DIED → SMART_ACTION_SET_DATA (45) {field=2, data=0} on
--     Jules (CREATURE_DISTANCE entry 22432 ≤ 100 yd). SET_DATA uses targets.
--   • Jules ON_DATA_SET(2, 0) → SMART_ACTION_EVADE (24) on self.
-- EVADE causes Jules to: abort his waypoint loop, return to spawn, call
-- OnReset() which clears runOnce flags (restoring all NOT_REPEATABLE events),
-- and re-run his initialization chain (id=0-3). Ghost spawning stops because
-- EVADE resets his phase to 0. The waypoint loop is also stopped, preventing
-- id=5 (WP_REACHED) from re-activating phase 1 in future loops.
-- Additionally Barada despawns all summons from the event within 100 yards.
-- -------------------------------------------------------------------------
-- Anchorite Barada (22431), ids 5–8: new JUST_DIED chain
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22431 AND `source_type` = 0 AND `id` IN (5, 6, 7, 8);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22431, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 11, 22432, 100, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Death - Signal Jules to Evade'),
(22431, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22507, 100, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Death - Despawn Darkness Released (22507)'),
(22431, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22506, 100, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Death - Despawn Foul Purge (22506)'),
(22431, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22505, 100, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Death - Despawn Slimer Bunny DND (22505)');
-- Colonel Jules (22432), id=5: add NOT_REPEATABLE — without this, every loop of
-- Jules' 44-waypoint cyclic path re-triggers SET_PHASE 1 when passing wp2,
-- causing infinite ghost spawning even after the event should have ended.
-- OnReset() (called on evade) clears runOnce so the flag works again next event.
UPDATE `smart_scripts` SET `event_flags` = 513 -- was 512; add NOT_REPEATABLE (0x001)
    WHERE `entryorguid` = 22432 AND `source_type` = 0 AND `id` = 5;
-- Colonel Jules (22432), id=10: respond to Barada-death signal with EVADE
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22432 AND `source_type` = 0 AND `id` = 10;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22432, 0, 10, 0, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set (2,0) - Evade (stop loop, reset AI, clear runOnce)');

-- -------------------------------------------------------------------------
-- Bug 7: A dead player (ghost / pre-release spirit form) can gossip with
--        Colonel Jules while he is charmed/possessed (event_flags=WHILE_CHARMED)
--        and receive the quest kill-credit for "Colonel Jules Saved" without
--        actually being alive during the exorcism.
--
-- Fix: condition on Jules SAI event id=8 (SMART_EVENT_GOSSIP_HELLO).
--        ConditionType 36 = CONDITION_ALIVE.
--        ConditionTarget 0 = the unit that fired the event (the player),
--        which maps to ConditionSourceInfo.mConditionTargets[0] = `unit`
--        (the first argument passed to ProcessEventsFor for GOSSIP_HELLO).
--        ConditionTarget 1 = GetBaseObject() = Jules himself — WRONG choice.
-- -------------------------------------------------------------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 0 AND `SourceEntry` = 22432 AND `SourceId` = 8;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 0, 22432, 8, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Colonel Jules - On Gossip Hello Kill Credit - Player must be alive');

-- -------------------------------------------------------------------------
-- Bug 8: After the exorcism ends (Jules' Script9 2243200 reaches its final
--        phase), Jules has SET_PHASE(0) applied and the GOSSIP flag set for
--        the player to click him — but his 44-waypoint cyclic fly path is
--        still running. Jules keeps floating in circles with the "prone"
--        aura active (visually lying down while orbiting the room).
--
-- Fix: Rebuild Script9 2243200 with SMART_ACTION_WP_STOP (55) inserted
--        immediately after the combat auras are stripped (ids 14-15). Jules
--        stops circling at once. A 5 s window (REMOVE_ALL_AURAS delay)
--        gives a visual transition before spell 39283 ("goes prone") is
--        re-cast and the GOSSIP flag is set.
--
-- Sequential order (same total ~182 s duration as before):
--   ids 0-15  identical to original
--   id  16    WP_STOP(55) 0 ms       ← NEW: stop circling immediately
--   id  17    REMOVE_ALL_AURAS 5 s   (was 8 s; reduced — WP already stopped)
--   id  18    CAST 39283             (unchanged)
--   id  19    SET_NPC_FLAGS GOSSIP   (unchanged, Jules floats in place)
-- -------------------------------------------------------------------------
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2243200 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2243200,9, 0,0,0,0,100,0, 1000,1000,0,0,0,0, 1,0,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Talk: Keep away, the fool is mine'),
(2243200,9, 1,0,0,0,100,0, 14000,14000,0,0,0,0, 1,1,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Talk: threat line (random)'),
(2243200,9, 2,0,0,0,100,0, 9000,9000,0,0,0,0, 53,1,22432,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Start Waypoint fly path 22432'),
(2243200,9, 3,0,0,0,100,0, 4000,4000,0,0,0,0, 11,39284,3,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Cast 39284 threatens aura'),
(2243200,9, 4,0,0,0,100,0, 9000,9000,0,0,0,0, 1,1,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Talk: threat line (random)'),
(2243200,9, 5,0,0,0,100,0, 25000,25000,0,0,0,0, 1,1,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Talk: threat line (random)'),
(2243200,9, 6,0,0,0,100,0, 30000,30000,0,0,0,0, 11,39294,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Cast 39294 goes upright (levitates vertical)'),
(2243200,9, 7,0,0,0,100,0, 5000,5000,0,0,0,0, 11,39294,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Cast 39294 upright reinforced'),
(2243200,9, 8,0,0,0,100,0, 3500,3500,0,0,0,0, 11,39295,2,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Cast 39295 vomit aura (every 15s spawns Slimer Bunny)'),
(2243200,9, 9,0,0,0,100,0, 8500,8500,0,0,0,0, 1,1,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Talk: threat line (random)'),
(2243200,9,10,0,0,0,100,0, 18000,18000,0,0,0,0, 1,1,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Talk: threat line (random)'),
(2243200,9,11,0,0,0,100,0, 18000,18000,0,0,0,0, 1,1,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Talk: threat line (random)'),
(2243200,9,12,0,0,0,100,0, 18000,18000,0,0,0,0, 1,1,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Talk: threat line (random)'),
(2243200,9,13,0,0,0,100,0, 11000,11000,0,0,0,0, 22,0,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Set Phase 0 (Barada wins, ghost spawn stops)'),
(2243200,9,14,0,0,0,100,0, 0,0,0,0,0,0, 28,39295,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Remove Aura 39295 (vomit)'),
(2243200,9,15,0,0,0,100,0, 0,0,0,0,0,0, 28,39284,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Remove Aura 39284 (threats)'),
(2243200,9,16,0,0,0,100,0, 0,0,0,0,0,0, 55,0,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Stop Waypoint (Jules stops circling immediately)'),
(2243200,9,17,0,0,0,100,0, 5000,5000,0,0,0,0, 28,0,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Remove All Auras (visual transition)'),
(2243200,9,18,0,0,0,100,0, 0,0,0,0,0,0, 11,39283,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Cast 39283 (goes prone, lays back down)'),
(2243200,9,19,0,0,0,100,0, 0,0,0,0,0,0, 81,1,0,0,0,0,0, 1,0,0,0,0, 0,0,0,0, 'Colonel Jules - Event - Set NPC Flags Gossip (Jules clickable for quest completion)');
