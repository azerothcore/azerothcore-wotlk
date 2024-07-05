-- DB update 2023_03_21_00 -> 2023_03_21_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1922000, 1922001, 1922002));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1922000, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 11, 34426, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Gauntlet On Spawn - Actionlist - Cast \'Greater Invisibility\''),
(1922000, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 18, 33600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Gauntlet On Spawn - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),

(1922001, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Gauntlet Engage - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(1922001, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 28, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Gauntlet Engage - Actionlist - Remove Aura \'Greater Invisibility\''),
(1922001, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Gauntlet Engage - Actionlist - Cast \'Ethereal Teleport\''),
(1922001, 9, 3, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Gauntlet Engage - Actionlist - Start Attacking Closest Player'),

(1922002, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 28, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Gauntlet Engage 2 - Actionlist - Remove Aura \'Greater Invisibility\''),
(1922002, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Gauntlet Engage 2 - Actionlist - Cast \'Ethereal Teleport\''),
(1922002, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Gauntlet Engage 2 - Actionlist - Start Attacking Closest Player');

DELETE FROM `creature_text` WHERE `CreatureID` = 19510 AND `comment` = 'Bloodwarder Centurion - Gauntlet Event';
INSERT INTO `creature_text` (`CreatureID`, `Text`, `Type`, `Probability`, `BroadcastTextId`, `comment`) VALUES
(19510, 'Intruders have breached the factory!  Engage emergency defense protocol immediately!', 14, 100, 17366, 'Bloodwarder Centurion - Gauntlet Event');

-- Stage 1
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-138817, -138818, -138890, -138831, -138863, -138891, -138876, -138877));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Wave 1

(-138817, 0, 0, 0, 0, 0, 100, 0, 4800, 16100, 3000, 5000, 0, 11, 35265, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Fire Shield\''),
(-138817, 0, 1, 0, 0, 0, 100, 2, 3100, 7600, 12100, 21700, 0, 11, 17195, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Normal Dungeon)'),
(-138817, 0, 2, 0, 0, 0, 100, 4, 3100, 7600, 12100, 21700, 0, 11, 36807, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Heroic Dungeon)'),
(-138817, 0, 3, 0, 0, 0, 100, 0, 4800, 26700, 13200, 27700, 0, 11, 35267, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Solarburn\''),
(-138817, 0, 1001, 0, 11, 0, 100, 513, 0, 0, 0, 0, 0, 11, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Respawn - Cast \'Greater Invisibility\''),
(-138817, 0, 1002, 0, 10, 0, 100, 257, 0, 25, 0, 0, 1, 80, 1922002, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - Within 0-25 Range Out of Combat LoS - Run Script'),
(-138817, 0, 1003, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 138863, 19735, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Just Died - Set Counter for Next Wave'),

(-138818, 0, 0, 0, 0, 0, 100, 0, 4800, 16100, 3000, 5000, 0, 11, 35265, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Fire Shield\''),
(-138818, 0, 1, 0, 0, 0, 100, 2, 3100, 7600, 12100, 21700, 0, 11, 17195, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Normal Dungeon)'),
(-138818, 0, 2, 0, 0, 0, 100, 4, 3100, 7600, 12100, 21700, 0, 11, 36807, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Heroic Dungeon)'),
(-138818, 0, 3, 0, 0, 0, 100, 0, 4800, 26700, 13200, 27700, 0, 11, 35267, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Solarburn\''),
(-138818, 0, 1001, 0, 11, 0, 100, 513, 0, 0, 0, 0, 0, 11, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Respawn - Cast \'Greater Invisibility\''),
(-138818, 0, 1002, 0, 4, 0, 100, 257, 0, 0, 0, 0, 0, 80, 1922002, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Aggro - Run Script'),
(-138818, 0, 1003, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 138863, 19735, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Just Died - Set Counter for Next Wave'),

(-138890, 0, 0, 0, 0, 0, 100, 0, 8400, 19300, 7200, 19300, 0, 11, 36340, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Holy Shock\''),
(-138890, 0, 1, 0, 74, 0, 100, 0, 0, 75, 10000, 16000, 15, 11, 36348, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Friendly Between 0-75% Health - Cast \'Bandage\''),
(-138890, 0, 2, 0, 0, 0, 100, 0, 9000, 14000, 12000, 16000, 0, 11, 36333, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Anesthetic\''),
(-138890, 0, 1001, 0, 11, 0, 100, 513, 0, 0, 0, 0, 0, 11, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Respawn - Cast \'Greater Invisibility\''),
(-138890, 0, 1002, 0, 4, 0, 100, 257, 0, 0, 0, 0, 0, 80, 1922002, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Aggro - Run Script'),
(-138890, 0, 1003, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 138863, 19735, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Just Died - Set Counter for Next Wave'),

(-138831, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 88, 1951000, 1951003, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Respawn - Run Random Script'),
(-138831, 0, 1, 0, 0, 0, 100, 0, 6200, 19300, 12100, 16900, 0, 11, 35178, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - In Combat - Cast \'Shield Bash\''),
(-138831, 0, 1001, 0, 1, 0, 100, 769, 1000, 1000, 0, 0, 0, 11, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - Out Of Combat - Cast \'Greater Invisibility\''), -- Delayed due to id 0 can *sometimes* cancel one another
(-138831, 0, 1002, 0, 4, 0, 100, 257, 0, 0, 0, 0, 0, 80, 1922002, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Aggro - Run Script'),
(-138831, 0, 1003, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 138863, 19735, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - On Just Died - Set Counter for Next Wave'),
(-138831, 0, 1004, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - In Combat - Say Line 0'), -- Intruders have breached the factory!  Engage emergency defense protocol immediately!

-- Wave 2

(-138863, 0, 0, 0, 0, 0, 100, 0, 8400, 16900, 9600, 20500, 0, 11, 36582, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - In Combat - Cast \'Charged Fist\''),
(-138863, 0, 1, 0, 0, 0, 100, 0, 9700, 10800, 10900, 22900, 0, 11, 35783, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - In Combat - Cast \'Knockdown\''),
(-138863, 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1922000, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Respawn - Run Script'),
(-138863, 0, 1002, 0, 77, 0, 100, 512, 1, 4, 0, 0, 0, 80, 1922001, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Counter Set 4/4 - Run Script Engage'),
(-138863, 0, 1003, 1004, 6, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 138891, 20990, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Just Died - Set Data for Next Wave'),
(-138863, 0, 1004, 1005, 61, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 138876, 20988, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Just Died - Set Data for Next Wave'),
(-138863, 0, 1005, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 138877, 20988, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Just Died - Set Data for Next Wave'),

-- Wave 3

(-138891, 0, 0, 0, 0, 0, 100, 0, 8400, 19300, 7200, 19300, 0, 11, 36340, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Holy Shock\''),
(-138891, 0, 1, 0, 74, 0, 100, 0, 0, 75, 10000, 16000, 15, 11, 36348, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Friendly Between 0-75% Health - Cast \'Bandage\''),
(-138891, 0, 2, 0, 0, 0, 100, 0, 9000, 14000, 12000, 16000, 0, 11, 36333, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Anesthetic\''),
(-138891, 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1922000, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Respawn - Run Script'),
(-138891, 0, 1002, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 1922001, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Data Set 1 1 - Run Script'),

(-138876, 0, 0, 0, 0, 0, 100, 0, 1300, 9600, 21700, 30200, 0, 11, 36341, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Super Shrink Ray\''),
(-138876, 0, 1, 0, 0, 0, 100, 0, 5100, 16400, 12100, 22900, 0, 11, 36345, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Death Ray\''),
(-138876, 0, 2, 0, 0, 0, 100, 0, 18100, 24100, 18100, 24100, 0, 11, 36346, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Growth Ray\''),
(-138876, 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1922000, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Respawn - Run Script'),
(-138876, 0, 1002, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 1922001, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Data Set 1 1 - Run Script'),

(-138877, 0, 0, 0, 0, 0, 100, 0, 1300, 9600, 21700, 30200, 0, 11, 36341, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Super Shrink Ray\''),
(-138877, 0, 1, 0, 0, 0, 100, 0, 5100, 16400, 12100, 22900, 0, 11, 36345, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Death Ray\''),
(-138877, 0, 2, 0, 0, 0, 100, 0, 18100, 24100, 18100, 24100, 0, 11, 36346, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Growth Ray\''),
(-138877, 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1922000, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Respawn - Run Script'),
(-138877, 0, 1002, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 1922001, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Data Set 1 1 - Run Script');

-- Stage 2
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-138819, -138892, -138878, -138864, -138820, -138869, -138893, -138879));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Wave 1

(-138819, 0, 0, 0, 0, 0, 100, 0, 4800, 16100, 3000, 5000, 0, 11, 35265, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Fire Shield\''),
(-138819, 0, 1, 0, 0, 0, 100, 2, 3100, 7600, 12100, 21700, 0, 11, 17195, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Normal Dungeon)'),
(-138819, 0, 2, 0, 0, 0, 100, 4, 3100, 7600, 12100, 21700, 0, 11, 36807, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Heroic Dungeon)'),
(-138819, 0, 3, 0, 0, 0, 100, 0, 4800, 26700, 13200, 27700, 0, 11, 35267, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Solarburn\''),
(-138819, 0, 1001, 0, 11, 0, 100, 513, 0, 0, 0, 0, 0, 11, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Respawn - Cast \'Greater Invisibility\''),
(-138819, 0, 1002, 0, 10, 0, 100, 257, 0, 35, 0, 0, 1, 80, 1922002, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - Within 0-35 Range Out of Combat LoS - Run Script'),
(-138819, 0, 1003, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 138864, 19735, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Just Died - Set Counter for Next Wave'),

(-138892, 0, 0, 0, 0, 0, 100, 0, 8400, 19300, 7200, 19300, 0, 11, 36340, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Holy Shock\''),
(-138892, 0, 1, 0, 74, 0, 100, 0, 0, 75, 10000, 16000, 15, 11, 36348, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Friendly Between 0-75% Health - Cast \'Bandage\''),
(-138892, 0, 2, 0, 0, 0, 100, 0, 9000, 14000, 12000, 16000, 0, 11, 36333, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Anesthetic\''),
(-138892, 0, 1001, 0, 11, 0, 100, 513, 0, 0, 0, 0, 0, 11, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Respawn - Cast \'Greater Invisibility\''),
(-138892, 0, 1002, 0, 4, 0, 100, 257, 0, 0, 0, 0, 0, 80, 1922002, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Aggro - Run Script'),
(-138892, 0, 1003, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 138864, 19735, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Just Died - Set Counter for Next Wave'),

(-138878, 0, 0, 0, 0, 0, 100, 0, 1300, 9600, 21700, 30200, 0, 11, 36341, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Super Shrink Ray\''),
(-138878, 0, 1, 0, 0, 0, 100, 0, 5100, 16400, 12100, 22900, 0, 11, 36345, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Death Ray\''),
(-138878, 0, 2, 0, 0, 0, 100, 0, 18100, 24100, 18100, 24100, 0, 11, 36346, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Growth Ray\''),
(-138878, 0, 1001, 0, 11, 0, 100, 513, 0, 0, 0, 0, 0, 11, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Respawn - Cast \'Greater Invisibility\''),
(-138878, 0, 1002, 0, 4, 0, 100, 257, 0, 0, 0, 0, 0, 80, 1922002, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Aggro - Run Script'),
(-138878, 0, 1003, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 138864, 19735, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Just Died - Set Counter for Next Wave'),

-- Wave 2

(-138864, 0, 0, 0, 0, 0, 100, 0, 8400, 16900, 9600, 20500, 0, 11, 36582, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - In Combat - Cast \'Charged Fist\''),
(-138864, 0, 1, 0, 0, 0, 100, 0, 9700, 10800, 10900, 22900, 0, 11, 35783, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - In Combat - Cast \'Knockdown\''),
(-138864, 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1922000, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Respawn - Run Script'),
(-138864, 0, 1002, 0, 77, 0, 100, 512, 1, 3, 0, 0, 0, 80, 1922001, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Counter Set 3/3 - Run Script Engage'),
(-138864, 0, 1003, 1004, 6, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 138820, 19168, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Just Died - Set Data for Next Wave'),
(-138864, 0, 1004, 1005, 61, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 138869, 20059, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Just Died - Set Data for Next Wave'),
(-138864, 0, 1005, 1006, 61, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 138893, 20990, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Just Died - Set Data for Next Wave'),
(-138864, 0, 1006, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 138879, 20988, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - On Just Died - Set Data for Next Wave'),

-- Wave 3

(-138820, 0, 0, 0, 0, 0, 100, 0, 4800, 16100, 3000, 5000, 0, 11, 35265, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Fire Shield\''),
(-138820, 0, 1, 0, 0, 0, 100, 2, 3100, 7600, 12100, 21700, 0, 11, 17195, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Normal Dungeon)'),
(-138820, 0, 2, 0, 0, 0, 100, 4, 3100, 7600, 12100, 21700, 0, 11, 36807, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Scorch\' (Heroic Dungeon)'),
(-138820, 0, 3, 0, 0, 0, 100, 0, 4800, 26700, 13200, 27700, 0, 11, 35267, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast \'Solarburn\''),
(-138820, 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1922000, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Respawn - Run Script'),
(-138820, 0, 1002, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 1922001, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Data Set 1 1 - Run Script'),
(-138820, 0, 1003, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 138823, 19220, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - On Just Died - Do Action on Pathaleon'),

(-138869, 0, 0, 0, 0, 0, 100, 0, 12100, 19300, 10800, 25300, 0, 11, 35243, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Starfire\''),
(-138869, 0, 1, 0, 9, 0, 100, 0, 0, 8, 10800, 25300, 0, 11, 35261, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - Within 0-8 Range - Cast \'Arcane Nova\''),
(-138869, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 0, 11, 17201, 0, 0, 0, 0, 0, 26, 30, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Dispel Magic\''),
(-138869, 0, 3, 4, 0, 0, 100, 0, 14100, 18900, 63200, 68100, 0, 11, 35251, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Summon Arcane Golem\''),
(-138869, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35260, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast \'Summon Arcane Golem\''),
(-138869, 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1922000, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - On Respawn - Run Script'),
(-138869, 0, 1002, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 1922001, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - On Data Set 1 1 - Run Script'),
(-138869, 0, 1003, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 138823, 19220, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - On Just Died - Do Action on Pathaleon'),

(-138893, 0, 0, 0, 0, 0, 100, 0, 8400, 19300, 7200, 19300, 0, 11, 36340, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Holy Shock\''),
(-138893, 0, 1, 0, 74, 0, 100, 0, 0, 75, 10000, 16000, 15, 11, 36348, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Friendly Between 0-75% Health - Cast \'Bandage\''),
(-138893, 0, 2, 0, 0, 0, 100, 0, 9000, 14000, 12000, 16000, 0, 11, 36333, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast \'Anesthetic\''),
(-138893, 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1922000, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Respawn - Run Script'),
(-138893, 0, 1002, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 1922001, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Data Set 1 1 - Run Script'),
(-138893, 0, 1003, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 223, 3, 0, 0, 0, 0, 0, 10, 138823, 19220, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - On Just Died - Do Action on Pathaleon'),

(-138879, 0, 0, 0, 0, 0, 100, 0, 1300, 9600, 21700, 30200, 0, 11, 36341, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Super Shrink Ray\''),
(-138879, 0, 1, 0, 0, 0, 100, 0, 5100, 16400, 12100, 22900, 0, 11, 36345, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Death Ray\''),
(-138879, 0, 2, 0, 0, 0, 100, 0, 18100, 24100, 18100, 24100, 0, 11, 36346, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast \'Growth Ray\''),
(-138879, 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1922000, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Respawn - Run Script'),
(-138879, 0, 1002, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 1922001, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Data Set 1 1 - Run Script'),
(-138879, 0, 1003, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 10, 138823, 19220, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - On Just Died - Do Action on Pathaleon');
