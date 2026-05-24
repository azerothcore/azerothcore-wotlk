-- ============================================================================
-- Black Rose: pre-launch polish pass #2
--
-- Three follow-up fixes after live testing of the 2026_05_24_00 polish:
--
--   1. Trinket buff display. The "Power of the Black Rose" aura was firing
--      and applying its socket-bonus dummy correctly, but the buff icon
--      never appeared on the player's buff bar. Two reasons:
--        a. Attributes = 384 (0x100 | 0x80) = SPELL_ATTR0_DO_NOT_DISPLAY +
--           SPELL_ATTR0_PASSIVE. PASSIVE auras are hidden from the buff bar
--           by client design; DO_NOT_DISPLAY also hides combat log entries.
--        b. SpellIconID = 0, so even if the buff weren't passive, the
--           client would have nothing to draw.
--      Fix: clear Attributes (it's an active on-use, not a passive aura) and
--      point at SpellIconID 209 (the universal Shadow_ShadowBolt swirl that
--      every 3.3.5a client ships with), which fits the gothic theme without
--      shipping a new icon in the patch.
--
--   2. Quest objective text. The 2026_05_23 boss migration repointed the
--      quests' RequiredNpcOrGo / LogTitle / LogDescription / etc. at
--      Faegrim, but missed `ObjectiveText1`, so the tracker still reads
--      "Gruff Swiftbite slain". Purely visual but jarring.
--
--   3. Boss patrol. Faegrim now walks a small loop around the Fire Scar
--      Shrine when out of combat. Implemented as a SmartAI WP path:
--        - waypoints rows define the path (entry = creature entry).
--        - SMART_ACTION_WP_START (53) on SMART_EVENT_RESPAWN (11) starts
--          the path on initial spawn.
--        - Same action on SMART_EVENT_RESET (8) restarts the path after
--          combat ends, so he picks up patrolling again after a wipe/kill.
--      Path repeats indefinitely; reactState 1 = defensive (resumes combat
--      naturally if a player aggros mid-walk).
--
-- Idempotent: every statement is an UPDATE / DELETE+INSERT on a known row.
-- ============================================================================

SET @BR_BOSS                    := 900200;
SET @BR_QUEST_ALLI              := 900100;
SET @BR_QUEST_HORDE             := 900101;
SET @BLACK_ROSE_AURA            := 900900;

-- ----------------------------------------------------------------------------
-- 1. Trinket on-use: make the buff actually show on the buff bar.
-- ----------------------------------------------------------------------------
UPDATE `spell_dbc`
   SET `Attributes`   = 0,
       `SpellIconID`  = 209,
       `ActiveIconID` = 209
 WHERE `ID` = @BLACK_ROSE_AURA;

-- ----------------------------------------------------------------------------
-- 2. Quest tracker text: replace the leftover Gruff reference.
-- ----------------------------------------------------------------------------
UPDATE `quest_template`
   SET `ObjectiveText1` = 'Faegrim, the Putrid Husk slain'
 WHERE `ID` IN (@BR_QUEST_ALLI, @BR_QUEST_HORDE);

-- ----------------------------------------------------------------------------
-- 3. Boss patrol path
--
-- Spawn point: (2204.98, 102.90, 111.55) at Fire Scar Shrine, Ashenvale.
-- Path is a tight ~10-yard square loop kept at the spawn Z; AC pathfinding
-- handles small terrain deltas. Each waypoint pauses 3s so the boss feels
-- like he's surveying the shrine rather than racing around it.
-- ----------------------------------------------------------------------------
DELETE FROM `waypoints` WHERE `entry` = @BR_BOSS;

INSERT INTO `waypoints`
    (`entry`, `pointid`, `position_x`, `position_y`, `position_z`,
     `orientation`, `delay`, `point_comment`)
VALUES
    (@BR_BOSS, 1, 2210.0, 108.0, 111.55, NULL, 3000,
     'Faegrim - patrol - NE corner'),
    (@BR_BOSS, 2, 2210.0,  98.0, 111.55, NULL, 3000,
     'Faegrim - patrol - SE corner'),
    (@BR_BOSS, 3, 2200.0,  98.0, 111.55, NULL, 3000,
     'Faegrim - patrol - SW corner'),
    (@BR_BOSS, 4, 2200.0, 108.0, 111.55, NULL, 3000,
     'Faegrim - patrol - NW corner');

-- SmartAI: start the patrol on respawn AND on combat reset, so the path
-- resumes correctly across kills/wipes.
--
-- WP_START (action 53) param layout:
--   p1 = forcedMovement (1 = walk, 2 = run)
--   p2 = pathID         (matches waypoints.entry)
--   p3 = repeat         (1 = loop forever)
--   p4 = quest          (0)
--   p5 = despawnTime    (0 = never on path end)
--   p6 = reactState     (1 = defensive)

DELETE FROM `smart_scripts`
 WHERE `entryorguid` = @BR_BOSS
   AND `source_type` = 0
   AND `id` IN (13, 14);

INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`,
     `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`,
     `event_param4`, `event_param5`,
     `action_type`, `action_param1`, `action_param2`,
     `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`,
     `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
    (@BR_BOSS, 0, 13, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0,
     53, 1, @BR_BOSS, 1, 0, 0, 1,
     1, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - on respawn - start patrol path (walk, repeat, defensive)'),
    (@BR_BOSS, 0, 14, 0, 8,  0, 100, 0, 0, 0, 0, 0, 0,
     53, 1, @BR_BOSS, 1, 0, 0, 1,
     1, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - on reset (post-combat) - resume patrol path');
