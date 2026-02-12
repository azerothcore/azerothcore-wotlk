-- DB update 2025_12_18_01 -> 2025_12_18_02
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2662500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2662500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 92, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - Actionlist - Interrupt Spell'),
(2662500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - Actionlist - Set Event Phase 0'),
(2662500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - Actionlist - Set Reactstate Passive'),
(2662500, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 19, 26675, 40, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - Actionlist - Move To Closest Creature \'Spider Summon Target\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2662501);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2662501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 86, 48870, 2, 19, 26675, 50, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - Actionlist - Cross Cast \'Summon Draknid Spiders Trigger\''),
(2662501, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - Actionlist - Set Reactstate Aggressive'),
(2662501, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - Actionlist - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26625);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26625, 0, 0, 0, 0, 1, 100, 0, 3000, 6000, 8000, 11000, 0, 0, 11, 49708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - In Combat - Cast \'Poison Spit\' (Phase 1)'),
(26625, 0, 1, 0, 0, 1, 100, 0, 3000, 6000, 6000, 9000, 0, 0, 11, 49704, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - In Combat - Cast \'Encasing Webs\' (Phase 1)'),
(26625, 0, 2, 0, 34, 0, 100, 513, 8, 1, 0, 0, 0, 0, 80, 2662501, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - On Reached Point 1 - Run Script (No Repeat)'),
(26625, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 0, 80, 2662500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - Between 0-20% Health - Run Script (No Repeat)'),
(26625, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - On Reset - Set Event Phase 1');
