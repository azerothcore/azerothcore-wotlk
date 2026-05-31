-- DB update 2026_05_31_01 -> 2026_05_31_02
--
-- =============================================================================
-- QUEST 10935 — "The Exorcism of Colonel Jules"
-- COMPLETE REBUILD FROM SCRATCH — all SAI scripts, conditions, movement
-- =============================================================================
--
-- This file rebuilds the entire scripted event from zero. It superseeds the
-- previous patch file (2026_05_30_02_quest_exorcism_colonel_jules_fix.sql).
--
-- Scope:
--   * smart_scripts source_type=0 (creature):  22431, 22432, 22505, 22507
--   * smart_scripts source_type=9 (script9) :  2243100, 2243200, 2243201
--   * conditions: SourceTypeOrReferenceId=22, Jules gossip kill-credit
--   * creature_template_movement: Jules (22432) Swim=0
--
-- Cast of NPCs:
--   22431 — Anchorite Barada      Draenei exorcist, kneels and chants
--   22432 — Colonel Jules         Possessed soldier, floats and circles
--   22505 — Bubbling Slimer Bunny Invisible, emits green vomit visual
--   22506 — Foul Purge            Invisible, particle effect (no AI/no SAI)
--   22507 — Darkness Released     Shadow ghost, 6-waypoint oval near ceiling
--
-- Spell cheatsheet:
--   39277  Barada Commands         (cast once, anchor of the ritual)
--   39278  Barada Falters          (cast 2x — progress markers)
--   39283  Jules Goes Prone        (horizontal aura on bed; re-cast at end)
--   39284  Jules Threatens         (periodic loop while possessed)
--   39294  Jules Goes Upright      (vertical levitation; cast 2x)
--   39295  Jules Vomits            (every 15 s triggers 39296 → Slimer Bunny)
--   39300  Slimer Visual           (cast once at Slimer Bunny spawn)
--   39303  Flying Skull aura       (Ghost: every 12 s triggers 39320)
--   39307  Flying Skull Despawn    (cast by Ghost on death)
--   39320  Flying Skull Attack     (Ghost shadow-damage AoE)
--
-- Timeline (≈193 s from gossip click):
--   T+0    player picks gossip option 8539
--   T+1    Barada: "It is time. The rite of exorcism will now commence..."
--   T+5    Barada: "Prepare yourself..."
--   T+7-11 Barada walks into ritual position
--   T+11   Barada signals Jules (SET_DATA 1,1) → Script9 2243200 begins
--   T+12.5 Barada kneels
--   T+14   Barada casts 39277 (Commands)
--   T+19   Barada random chant
--   T+35   Barada casts 39278 (first Falters)
--   T+63   Barada: "The power of light compells you! Back to your pit!"
--   T+88   Barada random chant
--   T+128  Barada: "Be cleansed with Light, human!"
--   T+146  Barada random chant
--   T+164  Barada random chant
--   T+179  Barada random chant
--   T+188  Barada: "I must not... falter", casts 39278, despawns all summons
--   T+190  Barada: "Back! I cast you back..." (victory speech — group 7)
--   T+198  Barada stands up, clears all auras
--   T+204  Barada walks home
--   T+213  Barada evades, regen on
--
--   Jules timeline (offsets from when SET_DATA 1,1 fires Script9 2243200):
--   J+1    Talk group 0 "Keep away. The fool is mine."
--   J+15   Talk group 2 "This is fruitless, draenei!"
--   J+24   START_WP path 22432 (44 waypoints cyclic)
--   J+28   Cast 39284 (threatens aura)
--   J+37   Talk group 3 "I see your ancestors..."
--   J+62   Talk group 4 "I will tear your soul..."
--   J+92   Cast 39294 (upright levitation)
--   J+97   Cast 39294 (reinforce)
--   J+100.5 Cast 39295 (vomit, every 15 s spawns Slimer Bunny)
--   J+109  Talk group 1 (random)
--   J+127  Talk group 1 (random)
--   J+145  Talk group 1 (random)
--   J+163  Talk group 1 (random)
--   J+174  SET_PHASE 0, REMOVE auras 39295 & 39284, WP_STOP
--   J+179  REMOVE_ALL_AURAS, CAST 39283 prone, SET_NPC_FLAGS GOSSIP
--
-- Bugs corrected in this rebuild:
--   1. Barada gossip cannot re-fire while running   (NOT_REPEATABLE 512→513)
--   2. Jules swim animation                          (Swim=0)
--   3. Jules evades to bed immediately on quest end  (EVADE at 0 ms)
--   4. Barada stays kneeling until Jules clickable   (REMOVE_BYTE delay 10 s)
--   5. Darkness Released spawn rate sane             (35-50 s, 30 s lifespan)
--   6. JUST_DIED chain on Barada → Jules evade + despawn all summons
--   7. Jules waypoint id=5 NOT_REPEATABLE            (512→513)
--   8. Dead player cannot gossip Jules               (CONDITION_ALIVE)
--   9. Jules stops circling at exorcism end          (WP_STOP in 2243200)
--   10. Barada's victory speech (group 7) now fires
--   11. Jules uses his specific groups 2/3/4 lines
--
-- =============================================================================
-- creature_template_movement: stop Jules from playing the swim animation
-- =============================================================================
UPDATE `creature_template_movement` SET `Swim` = 0 WHERE `CreatureId` = 22432;

-- =============================================================================
-- conditions: dead players cannot gossip Jules to claim quest credit
-- =============================================================================
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 0 AND `SourceEntry` = 22432 AND `SourceId` = 8;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 0, 22432, 8, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Colonel Jules - Gossip Hello Kill Credit - Player must be alive');

-- =============================================================================
-- SMART_SCRIPTS: wipe everything for this event before rebuild
-- =============================================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (22431, 22432, 22505, 22507) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2243100, 2243200, 2243201) AND `source_type` = 9;

-- =============================================================================
-- Anchorite Barada (22431) — source_type=0
--   id=0..2  Initialization chain on first update (kneel, gossip flag, passive)
--   id=3..4  Gossip select 8539 → store player → call Script9 2243100
--   id=5..8  JUST_DIED handler: signal Jules + despawn all summons
-- =============================================================================
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22431, 0, 0, 1, 60, 0, 100, 513, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update OOC (NOT_REPEATABLE) - Set Byte 0 (kneel pose)'),
(22431, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update Linked - Set NPC Flags 3 (gossip + questgiver)'),
(22431, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update Linked - Set React State Passive'),
(22431, 0, 3, 4, 62, 0, 100, 513, 8539, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Select (menu 8539) NOT_REPEATABLE - Store Target (player)'),
(22431, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2243100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Select Linked - Run Script9 2243100 on Self'),
(22431, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 11, 22432, 100, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Just Died - Signal Jules via Set Data (2,0)'),
(22431, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22507, 100, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Just Died Linked - Force Despawn Darkness Released (100yd)'),
(22431, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22506, 100, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Just Died Linked - Force Despawn Foul Purge (100yd)'),
(22431, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22505, 100, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Just Died Linked - Force Despawn Slimer Bunny (100yd)');

-- =============================================================================
-- Colonel Jules (22432) — source_type=0
--   id=0..3  Initialization chain (npc flags off, passive, cast 39283, fly)
--   id=4     On Data Set (1,1) from Barada → run Script9 2243200 (event begin)
--   id=5..6  Waypoint 2 reached → pause WP 70 s, set phase 1 (ghost spawning)
--   id=7     Phase 1: every 35-50 s summon Darkness Released (TIMED_DESPAWN 30s)
--   id=8..9  On Gossip Hello (player ends event) → kill credit + Script9 2243201
--   id=10    On Data Set (2,0) from Barada-death → Evade
-- =============================================================================
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22432, 0, 0, 1, 60, 0, 100, 513, 500, 500, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Update OOC 500ms (NOT_REPEATABLE) - Clear NPC Flags'),
(22432, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Update Linked - Set React State Passive'),
(22432, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 39283, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Update Linked - Cast 39283 (Goes Prone, triggered)'),
(22432, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 60, 1, 30, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Update Linked - Set Fly (enabled, speed 30, disable gravity)'),
(22432, 0, 4, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 80, 2243200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set (1,1) - Run Script9 2243200 (event begin)'),
(22432, 0, 5, 6, 40, 0, 100, 513, 2, 0, 0, 0, 0, 0, 54, 70000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - WP Reached 2 (NOT_REPEATABLE) - Pause Movement 70s'),
(22432, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - WP Reached 2 Linked - Set Event Phase 1 (ghost spawning on)'),
(22432, 0, 7, 0, 60, 1, 100, 0, 35000, 50000, 35000, 50000, 0, 0, 12, 22507, 3, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -710, 2754.28, 105.3, 4.7, 'Colonel Jules - Update OOC Phase 1 (35-50s) - Summon Darkness Released (TIMED_DESPAWN 30s) at bed top'),
(22432, 0, 8, 9, 64, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 22432, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Gossip Hello (Player alive via condition) - Kill Credit 22432'),
(22432, 0, 9, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2243201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Gossip Hello Linked - Run Script9 2243201 (evade to bed)'),
(22432, 0, 10, 0, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set (2,0) Barada Death - Evade (stop WP, reset AI)');

-- =============================================================================
-- Bubbling Slimer Bunny DND (22505) — source_type=0
--   id=0  On spawn cast 39300 (Slimer visual) once, NOT_REPEATABLE
--   id=1  Spawn Foul Purge (22506) every 5-30 s for green particle ambience
-- =============================================================================
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22505, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 39300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Slimer Bunny - On Update OOC (NOT_REPEATABLE) - Cast 39300 (slimer visual)'),
(22505, 0, 1, 0, 60, 0, 100, 0, 5000, 10000, 15000, 30000, 0, 0, 12, 22506, 2, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Slimer Bunny - On Update OOC (5-10s, repeat 15-30s) - Summon Foul Purge (30s)');

-- =============================================================================
-- Darkness Released (22507) — source_type=0
--   id=0  On spawn set passive react state, NOT_REPEATABLE
--   id=1  Cast 39303 (Flying Skull aura — triggers 39320 every 12 s)
--   id=2  Enable fly (speed 40, gravity off)
--   id=3  Start waypoint path 22507 (6-point oval near ceiling above bed)
--   id=4  Periodic cast 39320 (Shadow AoE) every 3-6 s initial, 5-8 s repeat
--   id=5  On death cast 39307 (Flying Skull Despawn — visual cleanup)
-- =============================================================================
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22507, 0, 0, 1, 60, 0, 100, 513, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkness Released - On Update OOC (NOT_REPEATABLE) - Set React State Passive'),
(22507, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 39303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkness Released - On Update Linked - Cast 39303 (Flying Skull aura, triggers 39320)'),
(22507, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 60, 1, 40, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkness Released - On Update Linked - Set Fly (enabled, speed 40, no gravity)'),
(22507, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 1, 22507, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkness Released - On Update Linked - Start Waypoint Path 22507 (run, cyclic)'),
(22507, 0, 4, 0, 60, 0, 100, 0, 3000, 6000, 5000, 8000, 0, 0, 11, 39320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkness Released - On Update OOC (3-6s/5-8s) - Cast 39320 (Shadow AoE damage)'),
(22507, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39307, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkness Released - On Just Died - Cast 39307 (despawn visual cleanup)');

-- =============================================================================
-- Script9 2243100 — Anchorite Barada's ritual (runs on Barada when gossip taken)
-- Total runtime ≈213 s. Every step uses delays in event_param1==event_param2.
-- =============================================================================
--   id=0      enable regen on (re-arm safety)
--   id=1      remove kneel byte (stand up at start)
--   id=2      clear npc flags (no gossip while ritual running)
--   id=3      Talk 0 "It is time. The rite of exorcism..."           +1 s
--   id=4      Talk 1 "Prepare yourself..."                           +4 s
--   id=5      Move To Pos (-707.68, 2747.8, 101.6)                   +2 s
--   id=6      Move To Pos (-710.87, 2747.8, 101.6)                   +2 s
--   id=7      Set Orientation 1.57 (face Jules)                      +2 s
--   id=8      Set Home Pos                                           +0 s
--   id=9      Set Data (1,1) on Jules (CLOSEST 50yd) → fire 2243200  +0 s
--   id=10     Kneel (Set Byte 0 = 8)                                 +1.5 s
--   id=11     Cast 39277 Barada Commands                             +1.5 s
--   id=12     Talk 2 (random chant)                                  +5 s
--   id=13     Cast 39278 first Falters                               +16 s
--   id=14     Talk 2 (random chant)                                  +28 s
--   id=15     Talk 5 specific "Power of light compells you!"         +25 s
--   id=16     Talk 2 (random chant)                                  +40 s
--   id=17     Talk 6 specific "Be cleansed with Light, human!"       +18 s
--   id=18     Talk 2 (random chant)                                  +18 s
--   id=19     Talk 2 (random chant)                                  +15 s
--   id=20     Talk 3 "I must not... falter"                          +9 s
--   id=21     Cast 39278 second Falters                              +0 s
--   id=22     Force Despawn Slimer Bunny (50yd)                      +0 s
--   id=23     Force Despawn Foul Purge (50yd)                        +0 s
--   id=24     Force Despawn Darkness Released (50yd)                 +0 s
--   id=25     Talk 7 victory speech "Back! I cast you back..."       +2 s
--   id=26     Remove kneel byte (stand up)                           +10 s
--   id=27     Remove All Auras                                       +0 s
--   id=28     Move To Pos (-707.68, 2747.8, 101.6)                   +6 s
--   id=29     Move To Pos home (-707.211, 2754.11, 101.675)          +2 s
--   id=30     Set Orientation 2.74                                   +4 s
--   id=31     Set Home Pos                                           +2 s
--   id=32     Evade                                                  +1 s
--   id=33     Enable regen                                           +0 s
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2243100, 9,  0, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0, 102,       0, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Disable HP regen (no healing during ritual)'),
(2243100, 9,  1, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0,  91,       8, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Remove Byte 0 (stand up from initial kneel)'),
(2243100, 9,  2, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0,  81,       0, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Clear NPC Flags (gossip locked while running)'),
(2243100, 9,  3, 0, 0, 0, 100, 0,  1000,  1000, 0, 0, 0, 0,   1,       0, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 0 "It is time. The rite of exorcism..."'),
(2243100, 9,  4, 0, 0, 0, 100, 0,  4000,  4000, 0, 0, 0, 0,   1,       1, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 1 "Prepare yourself. Do not allow ritual to be interrupted..."'),
(2243100, 9,  5, 0, 0, 0, 100, 0,  2000,  2000, 0, 0, 0, 0,  69,       0, 0, 0, 0, 0, 0,  8,     0,   0, 0, 0,  -707.68,  2747.8,   101.6,    0, 'Barada Ritual - Move to ritual approach (-707.68, 2747.8, 101.6)'),
(2243100, 9,  6, 0, 0, 0, 100, 0,  2000,  2000, 0, 0, 0, 0,  69,       0, 0, 0, 0, 0, 0,  8,     0,   0, 0, 0,  -710.87,  2747.8,   101.6,    0, 'Barada Ritual - Move to ritual position (-710.87, 2747.8, 101.6)'),
(2243100, 9,  7, 0, 0, 0, 100, 0,  2000,  2000, 0, 0, 0, 0,  66,       0, 0, 0, 0, 0, 0,  8,     0,   0, 0, 0,        0,       0,       0, 1.57, 'Barada Ritual - Set Orientation 1.57 (face Jules)'),
(2243100, 9,  8, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0, 101,       0, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Set Home Position (lock current spot during ritual)'),
(2243100, 9,  9, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0,  45,       1, 1, 0, 0, 0, 0, 19, 22432,  50, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Set Data (1,1) on Jules (closest 50yd) → trigger Script9 2243200'),
(2243100, 9, 10, 0, 0, 0, 100, 0,  1500,  1500, 0, 0, 0, 0,  90,       8, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Set Byte 0 = 8 (kneel pose for ritual)'),
(2243100, 9, 11, 0, 0, 0, 100, 0,  1500,  1500, 0, 0, 0, 0,  11,   39277, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Cast 39277 (Barada Commands — ritual anchor)'),
(2243100, 9, 12, 0, 0, 0, 100, 0,  5000,  5000, 0, 0, 0, 0,   1,       2, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 2 (random chant)'),
(2243100, 9, 13, 0, 0, 0, 100, 0, 16000, 16000, 0, 0, 0, 0,  11,   39278, 3, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Cast 39278 first (Barada Falters - progress marker 1)'),
(2243100, 9, 14, 0, 0, 0, 100, 0, 28000, 28000, 0, 0, 0, 0,   1,       2, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 2 (random chant)'),
(2243100, 9, 15, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 0, 0,   1,       5, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 5 "The power of light compells you! Back to your pit!"'),
(2243100, 9, 16, 0, 0, 0, 100, 0, 40000, 40000, 0, 0, 0, 0,   1,       2, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 2 (random chant)'),
(2243100, 9, 17, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 0, 0,   1,       6, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 6 "Be cleansed with Light, human!..."'),
(2243100, 9, 18, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 0, 0,   1,       2, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 2 (random chant)'),
(2243100, 9, 19, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 0,   1,       2, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 2 (random chant)'),
(2243100, 9, 20, 0, 0, 0, 100, 0,  9000,  9000, 0, 0, 0, 0,   1,       3, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 3 "I... must not... falter"'),
(2243100, 9, 21, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0,  11,   39278, 3, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Cast 39278 second (Barada Falters - progress marker 2)'),
(2243100, 9, 22, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0,  41,       0, 0, 0, 0, 0, 0, 11, 22505,  50, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Force Despawn Slimer Bunny (50yd)'),
(2243100, 9, 23, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0,  41,       0, 0, 0, 0, 0, 0, 11, 22506,  50, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Force Despawn Foul Purge (50yd)'),
(2243100, 9, 24, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0,  41,       0, 0, 0, 0, 0, 0, 11, 22507,  50, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Force Despawn Darkness Released (50yd)'),
(2243100, 9, 25, 0, 0, 0, 100, 0,  2000,  2000, 0, 0, 0, 0,   1,       7, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Talk group 7 "Back! I cast you back..." (VICTORY SPEECH)'),
(2243100, 9, 26, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0,  91,       8, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Remove Byte 0 (stand up from kneel after 10s — keeps pose during Jules transition)'),
(2243100, 9, 27, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0,  28,       0, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Remove All Auras (clear residual ritual auras)'),
(2243100, 9, 28, 0, 0, 0, 100, 0,  6000,  6000, 0, 0, 0, 0,  69,       0, 0, 0, 0, 0, 0,  8,     0,   0, 0, 0,  -707.68,  2747.8,   101.6,    0, 'Barada Ritual - Move To Pos (back away from bed)'),
(2243100, 9, 29, 0, 0, 0, 100, 0,  2000,  2000, 0, 0, 0, 0,  69,       0, 0, 0, 0, 0, 0,  8,     0,   0, 0, 0, -707.211, 2754.11, 101.675,    0, 'Barada Ritual - Move To Pos home (-707.211, 2754.11, 101.675)'),
(2243100, 9, 30, 0, 0, 0, 100, 0,  4000,  4000, 0, 0, 0, 0,  66,       0, 0, 0, 0, 0, 0,  8,     0,   0, 0, 0,        0,       0,       0, 2.74, 'Barada Ritual - Set Orientation 2.74 (face away from bed at home)'),
(2243100, 9, 31, 0, 0, 0, 100, 0,  2000,  2000, 0, 0, 0, 0, 101,       0, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Set Home Position (commit final home)'),
(2243100, 9, 32, 0, 0, 0, 100, 0,  1000,  1000, 0, 0, 0, 0,  24,       0, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Evade (resets AI, re-arms NOT_REPEATABLE events)'),
(2243100, 9, 33, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0, 102,       1, 0, 0, 0, 0, 0,  1,     0,   0, 0, 0,        0,       0,       0,    0, 'Barada Ritual - Enable HP regen');

-- =============================================================================
-- Script9 2243200 — Colonel Jules's exorcism behaviour (runs on Jules)
-- Fired by Barada Set Data (1,1). Total runtime ≈179 s.
-- =============================================================================
--   id=0   Talk group 0 "Keep away. The fool is mine."           +1 s
--   id=1   Talk group 2 "This is fruitless, draenei!"            +14 s
--   id=2   Start Waypoint path 22432 (44-wp cyclic fly route)    +9 s
--   id=3   Cast 39284 (Jules Threatens aura, triggered)          +4 s
--   id=4   Talk group 3 "I see your ancestors, Anchorite!"       +9 s
--   id=5   Talk group 4 "I will tear your soul..."               +25 s
--   id=6   Cast 39294 (Goes Upright — first cast)                +30 s
--   id=7   Cast 39294 (Goes Upright — reinforce)                 +5 s
--   id=8   Cast 39295 (Vomits aura — every 15 s spawns Slimer)   +3.5 s
--   id=9   Talk group 1 (random)                                 +8.5 s
--   id=10  Talk group 1 (random)                                 +18 s
--   id=11  Talk group 1 (random)                                 +18 s
--   id=12  Talk group 1 (random)                                 +18 s
--   id=13  Set Phase 0 (Barada wins; ghost spawn id=7 stops)     +11 s
--   id=14  Remove Aura 39295 (vomit off)                         +0 s
--   id=15  Remove Aura 39284 (threats off)                       +0 s
--   id=16  WP_STOP (Jules stops circling immediately)            +0 s
--   id=17  Remove All Auras (visual cleanup transition)          +5 s
--   id=18  Cast 39283 (Goes Prone — Jules lays back down)        +0 s
--   id=19  Set NPC Flags 1 (gossip) — Jules is clickable         +0 s
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2243200, 9,  0, 0, 0, 0, 100, 0,  1000,  1000, 0, 0, 0, 0,  1,     0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Talk group 0 "Keep away. The fool is mine." (demonic intro)'),
(2243200, 9,  1, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 0, 0,  1,     2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Talk group 2 "This is fruitless, draenei!" (specific opening)'),
(2243200, 9,  2, 0, 0, 0, 100, 0,  9000,  9000, 0, 0, 0, 0, 53,     1, 22432, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Start Waypoint path 22432 (44-waypoint cyclic fly route, repeat=1)'),
(2243200, 9,  3, 0, 0, 0, 100, 0,  4000,  4000, 0, 0, 0, 0, 11, 39284, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Cast 39284 (Jules Threatens aura, triggered)'),
(2243200, 9,  4, 0, 0, 0, 100, 0,  9000,  9000, 0, 0, 0, 0,  1,     3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Talk group 3 "I see your ancestors, Anchorite!"'),
(2243200, 9,  5, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 0, 0,  1,     4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Talk group 4 "I will tear your soul into morsels..."'),
(2243200, 9,  6, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 0, 0, 11, 39294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Cast 39294 (Goes Upright — first cast, levitates vertical)'),
(2243200, 9,  7, 0, 0, 0, 100, 0,  5000,  5000, 0, 0, 0, 0, 11, 39294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Cast 39294 (Goes Upright — reinforce levitation)'),
(2243200, 9,  8, 0, 0, 0, 100, 0,  3500,  3500, 0, 0, 0, 0, 11, 39295, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Cast 39295 (Vomits aura, every 15s triggers Slimer Bunny)'),
(2243200, 9,  9, 0, 0, 0, 100, 0,  8500,  8500, 0, 0, 0, 0,  1,     1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Talk group 1 (random threat)'),
(2243200, 9, 10, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 0, 0,  1,     1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Talk group 1 (random threat)'),
(2243200, 9, 11, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 0, 0,  1,     1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Talk group 1 (random threat)'),
(2243200, 9, 12, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 0, 0,  1,     1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Talk group 1 (random threat)'),
(2243200, 9, 13, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 0, 22,     0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Set Phase 0 (Barada wins, ghost spawning halts)'),
(2243200, 9, 14, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0, 28, 39295, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Remove Aura 39295 (vomit off)'),
(2243200, 9, 15, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0, 28, 39284, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Remove Aura 39284 (threats off)'),
(2243200, 9, 16, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0, 55,     0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - WP Stop (Jules stops circling immediately)'),
(2243200, 9, 17, 0, 0, 0, 100, 0,  5000,  5000, 0, 0, 0, 0, 28,     0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Remove All Auras (visual transition before prone)'),
(2243200, 9, 18, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0, 11, 39283, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Cast 39283 (Goes Prone — Jules lays back down)'),
(2243200, 9, 19, 0, 0, 0, 100, 0,     0,     0, 0, 0, 0, 0, 81,     1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Exorcism - Set NPC Flags 1 (Gossip on — Jules clickable to finish quest)');

-- =============================================================================
-- Script9 2243201 — Colonel Jules quest-completion epilogue (runs on Jules)
-- Fired when the player clicks Jules after the exorcism succeeded.
-- =============================================================================
--   id=0   Evade immediately (Jules flies straight back to bed at spawn)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2243201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jules Quest Complete - Evade immediately (flies straight back to bed at spawn)');

-- =============================================================================
-- END OF REBUILD — Quest 10935 "The Exorcism of Colonel Jules"
-- =============================================================================
