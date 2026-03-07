-- DB update 2026_01_13_00 -> 2026_01_13_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2936800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2936800, 9, 0 , 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 12, 29801, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 0, 7725, 105, 1010.64, 1.6, 'Valduran the Stormborn - Actionlist - Summon Creature \'Bouldercrag the Rockshaper\''),
(2936800, 9, 1 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - Actionlist - Set Fly Off'),
(2936800, 9, 2 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 30152, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 0, 7734, 113, 1010.64, 3, 'Valduran the Stormborn - Actionlist - Summon Creature \'Bruor Ironbane\''),
(2936800, 9, 3 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 11, 0, 30, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - Actionlist - Set Npc Flag '),
(2936800, 9, 4 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 29801, 30, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - Actionlist - Say Line 0'),
(2936800, 9, 5 , 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 30152, 30, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - Actionlist - Say Line 0'),
(2936800, 9, 6 , 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 30152, 30, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - Actionlist - Say Line 1'),
(2936800, 9, 7 , 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - Actionlist - Say Line 0'),
(2936800, 9, 8 , 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - Actionlist - Say Line 1'),
(2936800, 9, 9, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2936800, 9, 10, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - Actionlist - Start Attacking');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29368);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29368, 0, 1, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 56220, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - On Reset - Cast \'Valduran`s Channel\''),
(29368, 0, 2, 3, 8, 0, 100, 513, 56189, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - On Spellhit \'Sound War Horn\' - Remove Auras (No Repeat)'),
(29368, 0, 3, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 80, 2936800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - On Spellhit \'Sound War Horn\' - Run Script (No Repeat)'),
(29368, 0, 5, 0, 0, 0, 100, 0, 2000, 4000, 15000, 17000, 0, 0, 11, 56319, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - In Combat - Cast \'Ball Lightning\''),
(29368, 0, 6, 0, 0, 0, 100, 0, 5000, 7000, 8000, 10000, 0, 0, 11, 56326, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - In Combat - Cast \'Lightning Bolt\''),
(29368, 0, 7, 0, 0, 0, 100, 0, 11000, 13000, 25000, 30000, 0, 0, 11, 56322, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - In Combat - Cast \'Spark Frenzy\''),
(29368, 0, 8, 9, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 29801, 30, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - On Just Died - Say Line 1'),
(29368, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 30152, 30, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - On Just Died - Say Line 2'),
(29368, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 29368, 0, 0, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - On Just Died - Quest Credit'),
(29368, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valduran the Stormborn - On Reset - Set Flags Immune To Players & Immune To NPC\'s');
