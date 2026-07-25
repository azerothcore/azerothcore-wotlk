-- DB update 2025_09_04_02 -> 2025_09_04_03
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24170);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24170, 0, 0, 3, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - On Just Summoned - Store Targetlist'),
(24170, 0, 1, 4, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 24170, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - On Just Died - Quest Credit \'null\''),
(24170, 0, 2, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - On Just Summoned - Set Visibility Off'),
(24170, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 186598, 45, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - On Just Summoned - Summon Gameobject \'Tillinghast\'s Plagued Meat\''),
(24170, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 1, 0, 0, 0, 20, 186598, 10, 0, 0, 0, 0, 0, 0, 'Draconis Gastritis Bunny - On Just Died - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23689);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23689, 0, 1, 4, 65, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 36809, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Follow Complete - Cast \'Overpowering Sickness\''),
(23689, 0, 3, 5, 1, 0, 100, 512, 10000, 10000, 10000, 10000, 0, 0, 29, 0, 0, 24170, 0, 0, 0, 19, 24170, 75, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Out of Combat - Start Follow Closest Creature \'Draconis Gastritis Bunny\''),
(23689, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 19, 24170, 10, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Follow Complete - Kill Target'),
(23689, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Out of Combat - Set Event Phase 1'),
(23689, 0, 6, 0, 1, 1, 100, 512, 45000, 45000, 45000, 45000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Out of Combat - Despawn Instant (Phase 1)'),
-- update comments with Keira
(23689, 0, 8, 0, 8, 0, 100, 0, 40969, 0, 120000, 120000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - On Spellhit \'Malister`s Frost Wand\' - Move To Invoker'),
(23689, 0, 9, 0, 9, 0, 100, 513, 0, 0, 0, 0, 0, 20, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Within 0-20 Range - Set Home Position (No Repeat)'),
(23689, 0, 10, 0, 9, 0, 100, 0, 0, 0, 2000, 3500, 0, 5, 11, 51219, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Within 0-5 Range - Cast \'Flame Breath\''),
(23689, 0, 11, 0, 0, 0, 100, 0, 3000, 9000, 30000, 45000, 0, 0, 11, 42362, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - In Combat - Cast \'Flames of Birth\''),
(23689, 0, 12, 0, 9, 0, 100, 0, 0, 0, 10000, 15000, 0, 20, 11, 41572, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Proto-Drake - Within 0-20 Range - Cast \'Wing Buffet\'');
