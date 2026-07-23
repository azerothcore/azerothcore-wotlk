-- DB update 2025_09_04_03 -> 2025_09_05_00
-- Prevent removal on evade
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (50665, 50681, 50695);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(50665, 2048),
(50681, 2048),
(50695, 2048);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28148);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28148, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Reset - Set Event Phase 1'),
(28148, 0, 1, 2, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50695, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Cast \'Bleeding Out\''),
(28148, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Start Follow Invoker'),
(28148, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Just Summoned - Remove FlagStandstate Sit Down'),
(28148, 0, 4, 0, 23, 1, 100, 513, 50695, 0, 0, 0, 0, 0, 80, 2814800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Aura \'Bleeding Out\' - Run Script (Phase 1) (No Repeat)'),
(28148, 0, 5, 6, 40, 0, 100, 513, 4, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Point 4 of Path Any Reached - Set Flag Standstate Sit Down (No Repeat)'),
(28148, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Point 4 of Path Any Reached - Despawn In 20000 ms (No Repeat)'),
(28148, 0, 7, 8, 8, 1, 100, 512, 50669, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Set Event Phase 2 (Phase 1)'),
(28148, 0, 8, 9, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Cast \'Kill Credit Jospehine 01\' (Phase 1)'),
(28148, 0, 9, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50711, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Cast \'Strip Aura Josephine 01\' (Phase 1)'),
(28148, 0, 10, 11, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 86, 50699, 2, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Cross Cast \'Josephine Kill Credit\' (Phase 1)'),
(28148, 0, 11, 12, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 86, 50712, 2, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Cross Cast \'Strip Aura Josephine\' (Phase 1)'),
(28148, 0, 12, 13, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Stop Follow  (Phase 1)'),
(28148, 0, 13, 14, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Say Line 0 (Phase 1)'),
(28148, 0, 14, 15, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 0, 28148, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Start Waypoint Path 28148 (Phase 1)'),
(28148, 0, 15, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Josephine - On Spellhit \'Quest Credit\' - Remove Npc Flags Gossip (Phase 1)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28142) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28142, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Reset - Set Event Phase 1'),
(28142, 0, 1, 2, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50681, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Just Summoned - Cast \'Bleeding Out\''),
(28142, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Just Summoned - Start Follow Invoker'),
(28142, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Just Summoned - Remove FlagStandstate Sit Down'),
(28142, 0, 4, 0, 23, 1, 100, 513, 50681, 0, 0, 0, 0, 0, 80, 2814200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Aura \'Bleeding Out\' - Run Script (Phase 1) (No Repeat)'),
(28142, 0, 5, 6, 40, 0, 100, 513, 5, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Point 5 of Path Any Reached - Set Flag Standstate Sit Down (No Repeat)'),
(28142, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Point 5 of Path Any Reached - Despawn In 20000 ms (No Repeat)'),
(28142, 0, 7, 8, 8, 1, 100, 512, 50669, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Set Event Phase 2 (Phase 1)'),
(28142, 0, 8, 9, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50683, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Cast \'Kill Credit Lamoof 01\' (Phase 1)'),
(28142, 0, 9, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50723, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Cast \'Strip Aura Lamoof 01\' (Phase 1)'),
(28142, 0, 10, 11, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 86, 50684, 2, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Cross Cast \'Lamoof Kill Credit\' (Phase 1)'),
(28142, 0, 11, 12, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 86, 50722, 2, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Cross Cast \'Strip Aura Lamoof\' (Phase 1)'),
(28142, 0, 12, 13, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Stop Follow  (Phase 1)'),
(28142, 0, 13, 14, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Say Line 0 (Phase 1)'),
(28142, 0, 14, 15, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 0, 28142, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Start Waypoint Path 28142 (Phase 1)'),
(28142, 0, 15, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Lamoof - On Spellhit \'Quest Credit\' - Remove Npc Flags Gossip (Phase 1)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28136);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28136, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Reset - Set Event Phase 1'),
(28136, 0, 1, 2, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50665, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Just Summoned - Cast \'Bleeding Out\''),
(28136, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Just Summoned - Start Follow Invoker'),
(28136, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Just Summoned - Remove FlagStandstate Sit Down'),
(28136, 0, 4, 0, 23, 1, 100, 513, 50665, 0, 0, 0, 0, 0, 80, 2813600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Aura \'Bleeding Out\' - Run Script (Phase 1) (No Repeat)'),
(28136, 0, 5, 6, 40, 0, 100, 513, 5, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Point 5 of Path Any Reached - Set Flag Standstate Sit Down (No Repeat)'),
(28136, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Point 5 of Path Any Reached - Despawn In 20000 ms (No Repeat)'),
(28136, 0, 7, 8, 8, 1, 100, 512, 50669, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Set Event Phase 2 (Phase 1)'),
(28136, 0, 8, 9, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50671, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Cast \'Kill Credit Jonathan 01\' (Phase 1)'),
(28136, 0, 9, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Cast \'Strip Aura Jonathan 01\' (Phase 1)'),
(28136, 0, 10, 11, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 86, 50680, 2, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Cross Cast \'Jonathan Kill Credit\' (Phase 1)'),
(28136, 0, 11, 12, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 86, 50710, 2, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Cross Cast \'Strip Aura Jonanthan\' (Phase 1)'),
(28136, 0, 12, 13, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Stop Follow  (Phase 1)'),
(28136, 0, 13, 14, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Say Line 0 (Phase 1)'),
(28136, 0, 14, 15, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 0, 28136, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Start Waypoint Path 28136 (Phase 1)'),
(28136, 0, 15, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Jonathan - On Spellhit \'Quest Credit\' - Remove Npc Flags Gossip (Phase 1)');
