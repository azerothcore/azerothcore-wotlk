-- fix(DB/SmartAI): Quest 11280 "Draconis Gastritis" - Proto-Drake now properly
-- reacts to the plagued meat instead of attacking the player.
--
-- Problem: The Proto-Drake (NPC 23689) would attack the player on sight instead
-- of following the Draconis Gastritis Bunny (NPC 24170) to eat the plagued meat.
-- The quest could not be completed because the drake's aggressive behavior
-- prevented the OOC (Out of Combat) follow event from firing.
--
-- Fix: Set the Proto-Drake to passive react state when it detects the quest bunny,
-- preventing it from aggroing the player. After completing the quest sequence
-- (following the bunny and casting Overpowering Sickness), the drake properly
-- kills the bunny (granting quest credit), then despawns after a delay.
-- Also added an emote for the drake eating the meat for visual feedback.

-- ============================================================================
-- Proto-Drake (NPC 23689) - SmartAI fix for quest "Draconis Gastritis" (11280)
-- ============================================================================
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23689);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Quest sequence: When the quest bunny is nearby, drake goes passive and follows it
(23689, 0, 0, 1, 1, 0, 100, 512, 10000, 10000, 10000, 10000, 0, 0, 29, 0, 0, 24170, 0, 0, 0, 19, 24170, 75, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Out of Combat - Start Follow Closest Creature ''Draconis Gastritis Bunny'''),
-- Set react state to passive so the drake does not attack the player during the quest sequence
(23689, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Link - Set React State Passive'),
-- When the drake reaches the bunny (follow complete), cast the vomit visual and kill the bunny for quest credit
(23689, 0, 2, 3, 65, 0, 100, 512, 0, 0, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Follow Complete - Play Emote ''ONESHOT_EAT_NO_SHEATHE'''),
-- Cast Overpowering Sickness to visually show the drake getting sick from the plagued meat
(23689, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 36809, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Follow Complete - Cast ''Overpowering Sickness'''),
-- Kill the invisible quest bunny to grant the player quest credit (creature kill objective = 24170)
(23689, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 19, 24170, 10, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Follow Complete - Kill Closest ''Draconis Gastritis Bunny'''),
-- Move to phase 1 so the despawn timer starts
(23689, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Follow Complete - Set Event Phase 1'),
-- Despawn the drake 45 seconds after quest completion to clean up
(23689, 0, 6, 0, 1, 1, 100, 512, 45000, 45000, 45000, 45000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Out of Combat (Phase 1) - Despawn Instant'),
-- Separate quest: Malister Frost Wand (spell 40969) also attracts the Proto-Drake to the caster
(23689, 0, 8, 0, 8, 0, 100, 0, 40969, 0, 120000, 120000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Spellhit ''Malister''s Frost Wand'' - Move To Invoker'),
-- Combat abilities below only trigger when not in quest mode (normal combat behavior)
(23689, 0, 9, 0, 9, 0, 100, 513, 0, 0, 0, 0, 0, 20, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Within 0-20 Range - Set Home Position (No Repeat)'),
(23689, 0, 10, 0, 9, 0, 100, 0, 0, 0, 2000, 3500, 0, 5, 11, 51219, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Within 0-5 Range - Cast ''Flame Breath'''),
(23689, 0, 11, 0, 0, 0, 100, 0, 3000, 9000, 30000, 45000, 0, 0, 11, 42362, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - In Combat - Cast ''Flames of Birth'''),
(23689, 0, 12, 0, 9, 0, 100, 0, 0, 0, 10000, 15000, 0, 20, 11, 41572, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Within 0-20 Range - Cast ''Wing Buffet''');
