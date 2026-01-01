-- DB update 2026_01_01_00 -> 2026_01_01_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 3000711 AND 3000716);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3000711, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 10, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Say Line'),
(3000711, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12932, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Give Quest Credit'),
(3000711, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12954, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Give Quest Credit'),

(3000712, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 12, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Say Line'),
(3000712, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12933, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Give Quest Credit'),

(3000713, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 11, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Say Line'),
(3000713, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12934, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Give Quest Credit'),

(3000714, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 11, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Say Line'),
(3000714, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12935, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Give Quest Credit'),

(3000715, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 11, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Say Line'),
(3000715, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12936, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Give Quest Credit'),

(3000716, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 14, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Say Line'),
(3000716, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12948, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Actionlist - Give Quest Credit');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30007);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30007, 0, 0, 7, 19, 0, 100, 512, 12932, 0, 0, 0, 0, 0, 80, 3000701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Amphitheater of Anguish: Yggdras!\' Taken - Run Script'),
(30007, 0, 1, 7, 19, 0, 100, 512, 12954, 0, 0, 0, 0, 0, 80, 3000701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Amphitheater of Anguish: Yggdras!\' Taken - Run Script'),
(30007, 0, 2, 7, 19, 0, 100, 512, 12933, 0, 0, 0, 0, 0, 80, 3000702, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Amphitheater of Anguish: Magnataur!\' Taken - Run Script'),
(30007, 0, 3, 7, 19, 0, 100, 512, 12934, 0, 0, 0, 0, 0, 87, 3000703, 3000707, 3000708, 3000709, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Amphitheater of Anguish: From Beyond!\' Taken - Run Random Script'),
(30007, 0, 4, 7, 19, 0, 100, 512, 12935, 0, 0, 0, 0, 0, 80, 3000704, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Amphitheater of Anguish: Tuskarrmageddon!\' Taken - Run Script'),
(30007, 0, 5, 7, 19, 0, 100, 512, 12936, 0, 0, 0, 0, 0, 80, 3000705, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Amphitheater of Anguish: Korrak the Bloodrager!\' Taken - Run Script'),
(30007, 0, 6, 7, 19, 0, 100, 512, 12948, 0, 0, 0, 0, 0, 80, 3000706, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Champion of Anguish\' Taken - Run Script'),
(30007, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Any Quest Taken - Set Npc Flags Gossip'),
(30007, 0, 8, 20, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Any Quest Taken - Set Event Phase 2'),
(30007, 0, 9, 16, 38, 0, 100, 0, 10, 10, 60000, 60000, 0, 0, 1, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 10 10 - Say Line 15'),
(30007, 0, 10, 16, 38, 0, 100, 0, 11, 11, 0, 0, 0, 0, 80, 3000711, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 11 11 - Run Script'),
(30007, 0, 11, 16, 38, 0, 100, 0, 12, 12, 0, 0, 0, 0, 80, 3000712, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 12 12 - Run Script'),
(30007, 0, 12, 16, 38, 0, 100, 0, 13, 13, 0, 0, 0, 0, 80, 3000713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 13 13 - Run Script'),
(30007, 0, 13, 16, 38, 0, 100, 0, 14, 14, 0, 0, 0, 0, 80, 3000714, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 14 14 - Run Script'),
(30007, 0, 14, 16, 38, 0, 100, 0, 15, 15, 0, 0, 0, 0, 80, 3000715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 15 15 - Run Script'),
(30007, 0, 15, 16, 38, 0, 100, 0, 16, 16, 0, 0, 0, 0, 80, 3000716, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 16 16 - Run Script'),
(30007, 0, 16, 17, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Fight Finished - Set Npc Flags Gossip & Questgiver'),
(30007, 0, 17, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Fight Finished - Set Event Phase 0'),
(30007, 0, 18, 19, 1, 2, 100, 512, 300000, 300000, 300000, 300000, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Out of Combat - Set Npc Flags Gossip & Questgiver (Phase 2)'),
(30007, 0, 19, 0, 61, 2, 100, 512, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Out of Combat - Set Event Phase 0 (Phase 2)'),
(30007, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Any Quest Taken - Store Targetlist');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30014);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30014, 0, 0, 0, 9, 0, 100, 0, 0, 0, 9000, 15000, 0, 5, 11, 40504, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Yggdras - Within 0-5 Range - Cast \'Cleave\''),
(30014, 0, 1, 0, 9, 0, 100, 0, 0, 0, 6000, 11000, 0, 5, 11, 57076, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Yggdras - Within 0-5 Range - Cast \'Corrode Flesh\''),
(30014, 0, 2, 3, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 55859, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yggdras - On Just Died - Cast \'Jormungar Spawn\''),
(30014, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 11, 11, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Yggdras - On Just Died - Set Data 11 11'),
(30014, 0, 4, 5, 7, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 10, 10, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Yggdras - On Evade - Set Data 10 10 (No Repeat)'),
(30014, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yggdras - On Evade - Despawn Instant (No Repeat)'),
(30014, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yggdras - On Respawn - Say Line 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30017);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30017, 0, 0, 1, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Respawn - Set Flags Immune To Players & Immune To NPC\'s'),
(30017, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Respawn - Say Line 1'),
(30017, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 30017, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Respawn - Start Waypoint Path 30017'),
(30017, 0, 3, 4, 40, 0, 100, 512, 7, 30017, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Point 7 of Path 30017 Reached - Remove Flags Immune To Players & Immune To NPC\'s'),
(30017, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Point 7 of Path 30017 Reached - Set Reactstate Aggressive'),
(30017, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Point 7 of Path 30017 Reached - Set Home Position'),
(30017, 0, 6, 0, 6, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 12, 12, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Just Died - Set Data 12 12 (No Repeat)'),
(30017, 0, 7, 8, 7, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 10, 10, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Evade - Set Data 10 10 (No Repeat)'),
(30017, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Evade - Despawn Instant (No Repeat)'),
(30017, 0, 9, 0, 9, 0, 100, 512, 0, 0, 10000, 16000, 0, 10, 11, 31389, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - Within 0-10 Range - Cast \'Knock Away\''),
(30017, 0, 10, 0, 0, 0, 100, 512, 11000, 15000, 12000, 18000, 0, 0, 11, 55867, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - In Combat - Cast \'Stinky Beard\''),
(30017, 0, 11, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 55866, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - On Aggro - Cast \'Thunderblade\''),
(30017, 0, 12, 13, 2, 0, 100, 513, 0, 20, 0, 0, 0, 0, 11, 50420, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - Between 0-20% Health - Cast \'Enrage\' (No Repeat)'),
(30017, 0, 13, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - Between 0-20% Health - Say Line 0 (No Repeat)'),
(30017, 0, 14, 0, 2, 0, 100, 513, 0, 10, 0, 0, 0, 0, 11, 15588, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stinkbeard - Between 0-10% Health - Cast \'Thunderclap\' (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30020);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30020, 0, 0, 1, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - On Respawn - Set Flags Immune To Players & Immune To NPC\'s'),
(30020, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - On Respawn - Say Line 0'),
(30020, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 97, 20, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 5776.32, -2981.01, 273.1, 0, 'Orinoko Tuskbreaker - On Respawn - Jump To Pos'),
(30020, 0, 3, 4, 1, 0, 100, 513, 5000, 5000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - Out of Combat - Remove Flags Immune To Players & Immune To NPC\'s (No Repeat)'),
(30020, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - Out of Combat - Set Reactstate Aggressive (No Repeat)'),
(30020, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - Out of Combat - Set Home Position (No Repeat)'),
(30020, 0, 6, 0, 6, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 14, 14, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - On Just Died - Set Data 14 14 (No Repeat)'),
(30020, 0, 7, 8, 7, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 10, 10, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - On Evade - Set Data 10 10 (No Repeat)'),
(30020, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - On Evade - Despawn Instant (No Repeat)'),
(30020, 0, 9, 0, 0, 0, 100, 0, 20000, 25000, 35000, 45000, 0, 0, 11, 55937, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - In Combat - Cast \'Fishy Scent\''),
(30020, 0, 10, 0, 0, 0, 100, 0, 0, 0, 60000, 60000, 0, 0, 11, 32064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - In Combat - Cast \'Battle Shout\''),
(30020, 0, 11, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 55929, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - On Aggro - Cast \'Impale\''),
(30020, 0, 12, 13, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - Between 0-50% Health - Say Line 1 (No Repeat)'),
(30020, 0, 13, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 55946, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - Between 0-50% Health - Cast \'Summon Whisker\' (No Repeat)'),
(30020, 0, 14, 0, 9, 0, 100, 512, 0, 0, 15000, 25000, 10, 60, 11, 55929, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Orinoko Tuskbreaker - Within 10-60 Range - Cast \'Impale\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30023);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30023, 0, 0, 1, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Respawn - Set Flags Immune To Players & Immune To NPC\'s'),
(30023, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Respawn - Say Line 1'),
(30023, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 30023, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Respawn - Start Waypoint Path 30023'),
(30023, 0, 3, 4, 40, 0, 100, 512, 6, 30023, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Point 6 of Path 30023 Reached - Remove Flags Immune To Players & Immune To NPC\'s'),
(30023, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Point 6 of Path 30023 Reached - Say Line 2'),
(30023, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Point 6 of Path 30023 Reached - Set Reactstate Aggressive'),
(30023, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Point 6 of Path 30023 Reached - Set Home Position'),
(30023, 0, 7, 0, 6, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 15, 15, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Just Died - Set Data 15 15 (No Repeat)'),
(30023, 0, 8, 9, 7, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 10, 10, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Evade - Set Data 10 10 (No Repeat)'),
(30023, 0, 9, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Evade - Despawn Instant (No Repeat)'),
(30023, 0, 10, 0, 9, 0, 100, 512, 0, 0, 15000, 21000, 8, 25, 11, 24193, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - Within 8-25 Range - Cast \'Charge\''),
(30023, 0, 11, 0, 9, 0, 100, 512, 0, 0, 12000, 17000, 0, 5, 11, 30471, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - Within 0-5 Range - Cast \'Uppercut\''),
(30023, 0, 12, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 55948, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - On Aggro - Cast \'Grow\''),
(30023, 0, 13, 0, 2, 0, 100, 513, 0, 20, 0, 0, 0, 0, 11, 42745, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Korrak the Bloodrager - Between 0-20% Health - Cast \'Enrage\' (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30022);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30022, 0, 0, 1, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - On Respawn - Set Flags Immune To Players & Immune To NPC\'s'),
(30022, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 43, 30021, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - On Respawn - Mount To Creature Enormos'),
(30022, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 97, 20, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 5776.32, -2981.01, 273.1, 0, 'Vladof the Butcher - On Respawn - Jump To Pos'),
(30022, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 3002200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - On Respawn - Run Script'),
(30022, 0, 4, 0, 4, 0, 100, 513, 0, 0, 0, 0, 0, 0, 80, 3002201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - On Aggro - Run Script'),
(30022, 0, 5, 0, 6, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 16, 16, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - On Just Died - Set Data 16 16 (No Repeat)'),
(30022, 0, 6, 7, 7, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 10, 10, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - On Evade - Set Data 10 10 (No Repeat)'),
(30022, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - On Evade - Despawn Instant (No Repeat)'),
(30022, 0, 8, 0, 9, 0, 100, 512, 0, 0, 7000, 12000, 0, 5, 11, 55973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - Within 0-5 Range - Cast \'Blood Plague\' (No Repeat)'),
(30022, 0, 9, 0, 106, 0, 100, 512, 15000, 21000, 15000, 21000, 0, 5, 11, 55974, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - Within 0-5 Range - Cast \'Blood Boil\' (No Repeat)'),
(30022, 0, 10, 0, 0, 0, 100, 512, 21000, 26000, 21000, 26000, 0, 0, 11, 55975, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - In Combat - Cast \'Hysteria\' (No Repeat)'),
(30022, 0, 11, 12, 0, 0, 100, 0, 15000, 21000, 21000, 29000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - In Combat - Say Line 4'),
(30022, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 55976, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vladof the Butcher - In Combat - Cast \'Spell Deflection\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30026) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30026, 0, 1, 5, 6, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 13, 13, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Az\'Barin, Prince of the Gust - On Just Died - Set Data 13 13 (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30019) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30019, 0, 1, 5, 6, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 13, 13, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Duke Singen - On Just Died - Set Data 13 13 (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30025) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30025, 0, 1, 5, 6, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 13, 13, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Erathius, King of Dirt - On Just Died - Set Data 13 13 (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30024) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30024, 0, 1, 5, 6, 0, 100, 513, 0, 0, 0, 0, 0, 0, 45, 13, 13, 0, 0, 0, 0, 19, 30007, 0, 0, 0, 0, 0, 0, 0, 'Gargoral the Water Lord - On Just Died - Set Data 13 13 (No Repeat)');
