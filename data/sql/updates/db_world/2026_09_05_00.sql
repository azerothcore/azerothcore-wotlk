-- DB update 2026_09_04_02 -> 2026_09_05_00

-- Newly landed invaders have no threat for the taunt aura to update. Explicitly start their attack.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (27709, 27753, 27754));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (27709, 27753, 27754));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27709, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -250, -672.92, 26.54, 0, 'Drakkari Invader - On Update - Move To Position (No Repeat)'),
(27709, 0, 1, 2, 34, 0, 100, 512, 8, 1, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Dismount'),
(27709, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Remove Flags Immune To Players & Immune To NPC\'s'),
(27709, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 49405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Cast \'Invader Taunt Trigger\''),
(27709, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 26630, 100, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Start Attacking'),
(27753, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -254, -665.92, 26.54, 0, 'Drakkari Invader - On Update - Move To Position (No Repeat)'),
(27753, 0, 1, 2, 34, 0, 100, 512, 8, 1, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Dismount'),
(27753, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Remove Flags Immune To Players & Immune To NPC\'s'),
(27753, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 49405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Cast \'Invader Taunt Trigger\''),
(27753, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 26630, 100, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Start Attacking'),
(27754, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -250, -658.92, 26.54, 0, 'Drakkari Invader - On Update - Move To Position (No Repeat)'),
(27754, 0, 1, 2, 34, 0, 100, 512, 8, 1, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Dismount'),
(27754, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Remove Flags Immune To Players & Immune To NPC\'s'),
(27754, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 49405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Cast \'Invader Taunt Trigger\''),
(27754, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 26630, 100, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - On Reached Point 1 - Start Attacking');
