--
-- Captured Rageclaw: drop Immune To NPC on release so it fights Drakuru trolls, despawn once out of combat
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = 29686);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29686, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Respawn - Set Flag Standstate Kneel'),
(29686, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 54990, 0, 0, 0, 0, 0, 9, 29700, 0, 5, 1, 0, 0, 0, 0, 'Captured Rageclaw - On Respawn - Cast \'Chains of the Scourge\''),
(29686, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Respawn - Set Flag Immune To NPC'),
(29686, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Respawn - Remove Timed Event 1'),
(29686, 0, 4, 5, 72, 0, 100, 0, 27, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Remove Flag Standstate Kneel'),
(29686, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Remove Aura \'all\''),
(29686, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 55085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Cast \'Unshackled!\''),
(29686, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Say Line 0'),
(29686, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Remove Flag Immune To NPC'),
(29686, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Start Random Movement'),
(29686, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 10000, 12000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Create Timed Event 1'),
(29686, 0, 11, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Timed Event 1 Triggered - Set Event Phase 1'),
(29686, 0, 12, 13, 1, 1, 100, 1, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - Out of Combat - Set Flag Immune To NPC (Phase 1)'),
(29686, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - Out of Combat - Despawn Instant (Phase 1)'),
(29686, 0, 14, 15, 7, 1, 100, 1, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Evade - Set Flag Immune To NPC (Phase 1)'),
(29686, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Evade - Despawn Instant (Phase 1)'),
(29686, 0, 16, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Death - Set Flag Immune To NPC');
