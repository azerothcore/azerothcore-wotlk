-- DB update 2022_07_20_14 -> 2022_07_20_15
-- 
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (15325, 15343, 15320, 15335, 15336, 15319, 15461, 15462, 15505);

DELETE FROM `smart_scripts` WHERE `entryorguid`IN (15325, 15343, 15320, 15335, 15336, 15319, 15461, 15462, 15505);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- swarmguard
(15343, 0, 0, 0, 9, 0, 100, 0, 0, 5, 8000, 12000, 0, 11, 25174, 3, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Swarmguard - Within 0-5 Range - Cast \'Sundering Cleave\''),

-- hive wasp
(15325, 0, 0, 0, 9, 0, 100, 0, 0, 40, 5000, 7000, 0, 11, 25185, 4, 32, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Wasp - Within 0-40 Range - Cast \'Itch\''),

-- hive soldier
(15320, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 19000, 23000, 0, 11, 22857, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Soldier - In Combat - Cast \'Retaliation\''),
(15320, 0, 1, 0, 9, 0, 100, 0, 0, 30, 5000, 7000, 0, 11, 25497, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Soldier - Within 0-30 Range - Cast \'Venom Spit\''),

-- flesh hunter
(15335, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flesh Hunter - On Respawn - Cast \'Thrash\''),
(15335, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flesh Hunter - On Aggro - Set Event Phase 1'),
(15335, 0, 2, 0, 9, 0, 100, 0, 0, 45, 5000, 7000, 0, 11, 25424, 4, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Flesh Hunter - Within 0-45 Range - Cast \'Poison Bolt\''),
(15335, 0, 3, 0, 24, 2, 100, 0, 25371, 1, 5000, 5000, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flesh Hunter - On Target Buffed With \'Consume\' - Set Event Phase 2 (Phase 2)'),
(15335, 0, 4, 0, 28, 0, 100, 0, 5000, 5000, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flesh Hunter - On Passenger Removed - Set Event Phase 1'),
(15335, 0, 5, 0, 9, 1, 100, 0, 0, 10, 21000, 24000, 0, 11, 25371, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Flesh Hunter - Within 0-10 Range - Cast \'Consume\' (Phase 1)'),
(15335, 0, 6, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flesh Hunter - On Evade - Set Event Phase 1'),

-- tail lasher
(15336, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Tail Lasher - On Aggro - Set Event Phase 1'),
(15336, 0, 1, 0, 9, 1, 100, 0, 0, 5, 6000, 9000, 0, 11, 25645, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Tail Lasher - Within 0-5 Range - Cast \'Poison\' (Phase 1)'),
(15336, 0, 2, 0, 24, 1, 100, 0, 25645, 5, 5000, 5000, 0, 22, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Tail Lasher - On Target Buffed With \'Poison\' - Set Event Phase 2 (Phase 1)'),
(15336, 0, 3, 0, 24, 2, 100, 0, 25645, 1, 5000, 5000, 0, 22, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Tail Lasher - On Target Buffed With \'Poison\' - Set Event Phase 1 (Phase 2)'),
(15336, 0, 4, 0, 9, 0, 100, 0, 0, 30, 7000, 10000, 0, 11, 25654, 4, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Tail Lasher - Within 0-30 Range - Cast \'Tail Lash\''),
(15336, 0, 5, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Tail Lasher - On Evade - Set Event Phase 0'),

-- hive collector
(15319, 0, 0, 0, 9, 0, 100, 0, 0, 30, 10000, 16000, 0, 11, 12252, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Collector - Within 0-30 Range - Cast \'Web Spray\''),
(15319, 0, 1, 0, 0, 0, 100, 0, 7000, 11000, 12000, 15000, 0, 11, 3589, 4, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zara Collector - In Combat - Cast \'Deafening Screech\''),

-- shrieker scarab
(15461, 0, 0, 0, 9, 0, 100, 0, 0, 40, 14000, 18000, 0, 11, 22886, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shrieker Scarab - Within 0-40 Range - Cast \'Berserker Charge\''),
(15461, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 10000, 15000, 0, 11, 26379, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shrieker Scarab - In Combat - Cast \'Piercing Shriek\''),

-- spitting scarab
(15462, 0, 0, 0, 9, 0, 100, 0, 0, 40, 14000, 18000, 0, 11, 22886, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spitting Scarab - Within 0-40 Range - Cast \'Berserker Charge\''),
(15462, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 4000, 6000, 0, 11, 24334, 4, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spitting Scarab - In Combat - Cast \'Acid Spit\''),

-- canal frenzy
(15505, 0, 0, 0, 9, 0, 100, 0, 0, 5, 5000, 8000, 0, 11, 12097, 4, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Canal Frenzy - Within 0-5 Range - Cast \'Pierce Armor\'');
