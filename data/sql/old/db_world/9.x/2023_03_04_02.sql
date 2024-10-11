-- DB update 2023_03_04_01 -> 2023_03_04_02
-- Rift Spawn (Mage Quest NPC)
DELETE FROM `creature_text` WHERE `CreatureID`=6492;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(6492, 0, 0, '%s is angered and attacks!', 16, 0, 100, 0, 0, 0, 3074, 0, 'Rift Spawn'),
(6492, 1, 0, '%s escapes into the void!', 16, 0, 100, 0, 0, 0, 2564, 0, 'Rift Spawn'),
(6492, 2, 0, '%s is sucked into the coffer!', 16, 0, 100, 0, 0, 0, 2553, 0, 'Rift Spawn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 6492);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6492, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 9093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Reset - Cast \'Rift Spawn Invisibility\''),
(6492, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Reset - Set Invincibility Hp 1'),
(6492, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Reset - Set Event Phase 0'),
(6492, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 19, 33685508, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Reset - Remove Flags Disable Movement & Pacified & Not Selectable'),
(6492, 0, 4, 5, 8, 0, 100, 512, 9095, 0, 0, 0, 0, 28, 9093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Spellhit \'Cantation of Manifestation\' - Remove Aura \'Rift Spawn Invisibility\''),
(6492, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Spellhit \'Cantation of Manifestation\' - Set Event Phase 1'),
(6492, 0, 6, 7, 61, 0, 100, 513, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Spellhit \'Cantation of Manifestation\' - Say Line 0 " is angered and attacks!"'),
(6492, 0, 7, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Spellhit \'Cantation of Manifestation\' - Start Attacking'),
(6492, 0, 8, 9, 2, 1, 100, 0, 0, 1, 1000, 1000, 0, 11, 9032, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - Between 0-1% Health - Cast \'Self Stun - 30 seconds\' (Phase 1)'),
(6492, 0, 9, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - Between 0-1% Health - Despawn In 30000 ms (Phase 1)'),
(6492, 0, 10, 11, 61, 0, 100, 512, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - Between 0-1% Health - Set Event Phase 2 (Phase 1)'),
(6492, 0, 11, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 18, 33685508, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - Between 0-1% Health - Set Flags Disable Movement & Pacified & Not Selectable'),
(6492, 0, 12, 0, 60, 2, 100, 0, 29000, 29000, 10000, 10000, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Update - Say Line 1 "escapes into the void" (Phase 2)'),
(6492, 0, 13, 14, 38, 2, 100, 512, 1, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Data Set 1 0 - Remove All Auras (Phase 2)'),
(6492, 0, 14, 15, 61, 0, 100, 512, 0, 0, 0, 0, 0, 11, 9010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Data Set 1 0 - Cast \'Create Filled Containment Coffer\' (Phase 2)'),
(6492, 0, 15, 16, 61, 0, 100, 512, 0, 0, 0, 0, 0, 41, 2500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Data Set 1 0 - Despawn In 2500 ms (Phase 2)'),
(6492, 0, 16, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Spawn - On Data Set 1 0 - Say Line 2 "is sucked into the coffer!" (Phase 2)');
