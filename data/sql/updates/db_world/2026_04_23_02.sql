-- DB update 2026_04_23_01 -> 2026_04_23_02

-- Remove Mount from Creature Addon (it is setted using SAI).
UPDATE `creature_addon` SET `mount` = 0 WHERE (`guid` IN (86873));

-- Set General SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 20159;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20159);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20159, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Respawn - Remove Npc Flags Questgiver'),
(20159, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Respawn - Set Flags Immune To Players'),
(20159, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 43, 0, 18696, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Respawn - Mount To Model 18696'),
(20159, 0, 3, 4, 62, 0, 100, 0, 8081, 0, 0, 0, 0, 0, 64, 23, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Gossip Option 0 Selected - Store Targetlist'),
(20159, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Gossip Option 0 Selected - Remove Npc Flags Gossip'),
(20159, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Gossip Option 0 Selected - Set Event Phase 1'),
(20159, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2015900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Gossip Option 0 Selected - Run Script'),
(20159, 0, 7, 8, 2, 1, 100, 0, 0, 20, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Between 0-20% Health - Set Event Phase 2 (Phase 1)'),
(20159, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2015901, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Between 0-20% Health - Run Script (Phase 1)'),
(20159, 0, 9, 10, 7, 1, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Evade - Set Event Phase 0 (Phase 1)'),
(20159, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2015902, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Evade - Run Script (Phase 1)'),
(20159, 0, 11, 0, 0, 0, 100, 0, 0, 0, 5000, 8000, 0, 0, 11, 20823, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - In Combat - Cast \'Fireball\''),
(20159, 0, 12, 0, 106, 0, 100, 0, 5000, 10000, 12000, 18000, 0, 10, 11, 11831, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - On Hostile in Range - Cast \'Frost Nova\'');

-- Set Action Lists.
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2015900, 2015901, 2015902));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2015900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Set Invincibility Hp 1%'),
(2015900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 206, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Dismount'),
(2015900, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Say Line 0'),
(2015900, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Remove Flags Immune To Players'),
(2015900, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Set Faction 14'),
(2015900, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 23, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Start Attacking'),
(2015901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Stop Attack'),
(2015901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Set Flags Immune To Players'),
(2015901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1604, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Set Faction 1604'),
(2015901, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Add Npc Flags Questgiver'),
(2015901, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Say Line 1'),
(2015901, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 60000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Despawn In 60000 ms'),
(2015902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Add Npc Flags Gossip'),
(2015902, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Set Flags Immune To Players'),
(2015902, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Reset Invincibility Hp'),
(2015902, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1604, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Set Faction 1604'),
(2015902, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 43, 0, 18696, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Aledis - Actionlist - Mount To Model 18696');
