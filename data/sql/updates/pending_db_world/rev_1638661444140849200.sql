INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638661444140849200');

/* Nathanos Blightcaller Text Lines
*/

DELETE FROM `smart_scripts` WHERE `entryorguid`=11878 AND `source_type`=0 AND `id` IN (9, 10);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11878, 0, 9, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Nathanos Blightcaller - On Aggro - Say Line 0"),
(11878, 0, 10, 0, 5, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Nathanos Blightcaller - On Killed Unit - Say Line 1");

DELETE FROM `creature_text` WHERE `CreatureID`=11878;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11878, 0, 0, "Prepare for a severe beating.", 12, 0, 100, 0, 0, 0, 7229, 0, "Nathanos Blightcaller"),
(11878, 0, 1, "I shall wear your entrails as a necklace.", 12, 0, 100, 0, 0, 0, 7230, 0, "Nathanos Blightcaller"),
(11878, 0, 2, "I can smell your fear, $r.", 12, 0, 100, 0, 0, 0, 7231, 0, "Nathanos Blightcaller"),
(11878, 0, 3, "If you run now, you may live.", 12, 0, 100, 0, 0, 0, 7232, 0, "Nathanos Blightcaller"),
(11878, 0, 4, "How dare you!", 12, 0, 100, 0, 0, 0, 7233, 0, "Nathanos Blightcaller"),
(11878, 1, 0, "Pathetic.", 12, 0, 100, 0, 0, 0, 7234, 0, "Nathanos Blightcaller"),
(11878, 1, 1, "The reckoning is upon you, weakling!", 12, 0, 100, 0, 0, 0, 7235, 0, "Nathanos Blightcaller"),
(11878, 1, 2, "Disappointing.", 12, 0, 100, 0, 0, 0, 7236, 0, "Nathanos Blightcaller"),
(11878, 1, 3, "Is that the best you can do?", 12, 0, 100, 0, 0, 0, 7237, 0, "Nathanos Blightcaller"),
(11878, 1, 4, "You weren't worth the energy expenditure. <Nathanos spits.>", 12, 0, 100, 0, 0, 0, 7238, 0, "Nathanos Blightcaller"),
(11878, 1, 5, "Next time, bring friends.", 12, 0, 100, 0, 0, 0, 7239, 0, "Nathanos Blightcaller");

/* Nathanos Blightcaller Combat Script
*/

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11878;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11878) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 7, 8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11878, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nathanos Blightcaller - In Combat - Cast \'Shoot\''),
(11878, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 8000, 11000, 0, 11, 18651, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Nathanos Blightcaller - In Combat - Cast \'Multi-Shot\''),
(11878, 0, 2, 0, 0, 0, 100, 0, 0, 5, 7000, 9000, 0, 11, 6253, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nathanos Blightcaller - In Combat - Cast \'Backhand\''),
(11878, 0, 3, 0, 0, 0, 100, 0, 3000, 4000, 15000, 20000, 0, 11, 13704, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nathanos Blightcaller - In Combat - Cast \'Psychic Scream\''),
(11878, 0, 4, 5, 19, 0, 100, 0, 6148, 0, 0, 0, 0, 112, 87, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nathanos Blightcaller - On Quest \'The Scarlet Oracle, Demetria\' Taken - Start game event 0'),
(11878, 0, 5, 0, 61, 0, 100, 0, 6148, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nathanos Blightcaller - On Quest \'The Scarlet Oracle, Demetria\' Taken - Set Active On'),
(11878, 0, 7, 0, 0, 0, 100, 0, 0, 0, 6000, 8000, 0, 11, 18649, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Nathanos Blightcaller - In Combat - Cast \'Shadow Shot\''),
(11878, 0, 8, 0, 0, 0, 100, 0, 1000, 2000, 4000, 5000, 0, 12, 12208, 4, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nathanos Blightcaller - In Combat - Summon Creature \'Conquered Soul of the Blightcaller\'');
