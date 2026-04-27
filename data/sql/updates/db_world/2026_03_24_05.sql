-- DB update 2026_03_24_04 -> 2026_03_24_05

-- Set High Priest Talet-Kha SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26073;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26073);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26073, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Reset - Set Event Phase 0'),
(26073, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Reset - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(26073, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 85118, 25422, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Reset - Respawn Closest Creature \'Mystical Webbing\''),
(26073, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 85098, 25422, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Reset - Respawn Closest Creature \'Mystical Webbing\''),
(26073, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 23, 0, 0, 0, 0, 0, 10, 85175, 23033, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Reset - Do Action ID 23'),
(26073, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 23, 0, 0, 0, 0, 0, 10, 85176, 23033, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Reset - Do Action ID 23'),
(26073, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 23, 0, 0, 0, 0, 0, 10, 85098, 25422, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Reset - Do Action ID 23'),
(26073, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 23, 0, 0, 0, 0, 0, 10, 85118, 25422, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Reset - Do Action ID 23'),
(26073, 0, 8, 0, 72, 0, 100, 1, 25, 0, 0, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Action 25 Done - Increment Phase (No Repeat)'),
(26073, 0, 9, 0, 72, 0, 100, 1, 26, 0, 0, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Action 26 Done - Increment Phase (No Repeat)'),
(26073, 0, 10, 0, 66, 0, 100, 1, 2, 0, 0, 0, 0, 0, 80, 2607300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - On Event Phase 2 Set - Run Script (No Repeat)'),
(26073, 0, 11, 0, 2, 0, 100, 0, 1, 45, 1000, 3000, 0, 0, 11, 11640, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - Between 1-45% Health - Cast \'Renew\''),
(26073, 0, 12, 0, 0, 0, 100, 0, 4000, 6000, 5000, 8000, 0, 0, 11, 15587, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - In Combat - Cast \'Mind Blast\'');

-- Set Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2607300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2607300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - Actionlist - Remove FlagStandstate Sit Down'),
(2607300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - Actionlist - Set Fly Off'),
(2607300, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3788.44, 3418.25, 85.0562, 0, 'High Priest Talet-Kha - Actionlist - Move To Position'),
(2607300, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.1672, 'High Priest Talet-Kha - Actionlist - Set Orientation 1.1672'),
(2607300, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - Actionlist - Say Line 0'),
(2607300, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 11, 45492, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - Actionlist - Cast \'Shadow Nova\''),
(2607300, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 19, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(2607300, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'High Priest Talet-Kha - Actionlist - Start Attacking');

-- Set Invisible Stalker & Mystical Webbing Guid SAIs.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-85175, -85176, -85098, -85118));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-85176, 0, 0, 0, 72, 0, 100, 0, 23, 0, 0, 0, 0, 0, 11, 45497, 2, 0, 0, 0, 0, 11, 26073, 40, 0, 0, 0, 0, 0, 0, 'Invisible Stalker (Floating) - On Action 23 Done - Cast \'Web Beam\''),
(-85176, 0, 1, 0, 72, 0, 100, 0, 24, 0, 0, 0, 0, 0, 92, 0, 45497, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Invisible Stalker (Floating) - On Action 24 Done - Interrupt Spell \'Web Beam\''),
(-85175, 0, 0, 0, 72, 0, 100, 0, 23, 0, 0, 0, 0, 0, 11, 45497, 2, 0, 0, 0, 0, 11, 26073, 40, 0, 0, 0, 0, 0, 0, 'Invisible Stalker (Floating) - On Action 23 Done - Cast \'Web Beam\''),
(-85175, 0, 1, 0, 72, 0, 100, 0, 24, 0, 0, 0, 0, 0, 92, 0, 45497, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Invisible Stalker (Floating) - On Action 24 Done - Interrupt Spell \'Web Beam\''),
(-85098, 0, 0, 1, 72, 0, 100, 0, 23, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mystical Webbing - On Action 23 Done - Set Reactstate Passive'),
(-85098, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45497, 2, 0, 0, 0, 0, 11, 26073, 40, 0, 0, 0, 0, 0, 0, 'Mystical Webbing - On Action 23 Done - Cast \'Web Beam\''),
(-85098, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 24, 0, 0, 0, 0, 0, 10, 85176, 23033, 0, 0, 0, 0, 0, 0, 'Mystical Webbing - On Just Died - Do Action ID 24'),
(-85098, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 26, 0, 0, 0, 0, 0, 10, 85240, 26073, 0, 0, 0, 0, 0, 0, 'Mystical Webbing - On Just Died - Do Action ID 26'),
(-85118, 0, 0, 1, 72, 0, 100, 0, 23, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mystical Webbing - On Action 23 Done - Set Reactstate Passive'),
(-85118, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45497, 2, 0, 0, 0, 0, 11, 26073, 40, 0, 0, 0, 0, 0, 0, 'Mystical Webbing - On Action 23 Done - Cast \'Web Beam\''),
(-85118, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 24, 0, 0, 0, 0, 0, 10, 85175, 23033, 0, 0, 0, 0, 0, 0, 'Mystical Webbing - On Just Died - Do Action ID 24'),
(-85118, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 25, 0, 0, 0, 0, 0, 10, 85240, 26073, 0, 0, 0, 0, 0, 0, 'Mystical Webbing - On Just Died - Do Action ID 25');
