-- DB update 2022_09_28_04 -> 2022_09_28_05
-- Vekniss Wasp (15236)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15236;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15236) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15236, 0, 0, 1, 9, 0, 100, 0, 0, 40, 9700, 16000, 0, 11, 26077, 4, 3, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Wasp - Within 0-40 Range - Cast \'Itch\''),
(15236, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 26077, 4, 3, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Wasp - Within 0-40 Range - Cast \'Itch\''),
(15236, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 26077, 4, 3, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Wasp - Within 0-40 Range - Cast \'Itch\'');

-- Qiraji Lasher (15249)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15249) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15249, 0, 0, 0, 0, 0, 100, 0, 26600, 31500, 26600, 31500, 0, 11, 26027, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Lasher - In Combat - Cast \'Knockback\''),
(15249, 0, 1, 0, 0, 0, 100, 0, 8400, 18200, 8400, 18200, 0, 11, 26038, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Lasher - In Combat - Cast \'Whirlwind\'');

-- Vekniss Soldier (15229) - Cmangos
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15229) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15229, 0, 0, 0, 0, 0, 100, 0, 0, 0, 60000, 60000, 0, 11, 25152, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Soldier - In Combat - Cast \'Agro Drones\''),
(15229, 0, 1, 0, 9, 0, 100, 0, 0, 5, 5000, 7000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Soldier - Within 0-5 Range - Cast \'Cleave\''),
(15229, 0, 2, 0, 9, 0, 100, 0, 5, 25, 8000, 12000, 0, 11, 1906, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Soldier - Within 5-25 Range - Cast \'Debilitating Charge\'');

-- Qiraji Mindslayer (15246) - Cmangos
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15246) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15246, 0, 0, 0, 0, 0, 100, 0, 15000, 18000, 10000, 15000, 0, 11, 26079, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Mindslayer - In Combat - Cast \'Cause Insanity\''),
(15246, 0, 1, 0, 0, 0, 100, 0, 9000, 13000, 13000, 16000, 0, 11, 26049, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Mindslayer - In Combat - Cast \'Mana Burn\''),
(15246, 0, 2, 0, 0, 0, 100, 0, 0, 20, 3000, 5000, 0, 11, 26048, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Mindslayer - In Combat - Cast \'Mind Blast\''),
(15246, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 12000, 17000, 0, 11, 26044, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Mindslayer - In Combat - Cast \'Mind Flay\'');

-- Qiraji Brainwasher (15247) - Cmangos
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15247) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15247, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 16000, 21000, 0, 11, 26079, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Brainwasher - In Combat - Cast \'Cause Insanity\''),
(15247, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 9000, 13000, 0, 11, 26046, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Brainwasher - In Combat - Cast \'Mana Burn\''),
(15247, 0, 2, 0, 0, 0, 100, 0, 8000, 11000, 14000, 17000, 0, 11, 26044, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Brainwasher - In Combat - Cast \'Mind Flay\'');

-- Vekniss Hive Crawler (15240) - Cmangos
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15240) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15240, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 9000, 14000, 0, 11, 25809, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Hive Crawler - In Combat - Cast \'Crippling Poison\''),
(15240, 0, 1, 0, 0, 0, 100, 0, 9000, 15000, 12000, 16000, 0, 11, 25810, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Hive Crawler - In Combat - Cast \'Mind-numbing Poison\''),
(15240, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 10000, 14000, 0, 11, 26601, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Hive Crawler - In Combat - Cast \'Poison Bolt\''),
(15240, 0, 3, 0, 9, 1, 100, 0, 0, 5, 6000, 9000, 0, 11, 25051, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Hive Crawler - Within 0-5 Range - Cast \'Sunder Armor\' (Phase 1)'),
(15240, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Hive Crawler - On Aggro - Set Event Phase 1'),
(15240, 0, 5, 0, 24, 1, 100, 0, 25051, 5, 5000, 5000, 0, 22, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Hive Crawler - On Target Buffed With \'Sunder Armor\' - Set Event Phase 2 (Phase 1)'),
(15240, 0, 6, 0, 24, 2, 100, 0, 25051, 1, 5000, 5000, 0, 22, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Hive Crawler - On Target Buffed With \'Sunder Armor\' - Set Event Phase 1 (Phase 2)'),
(15240, 0, 7, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Hive Crawler - On Evade - Set Event Phase 0');

-- Vekniss Guardian (15233) - Cmangos
DELETE FROM `creature_text` WHERE `CreatureID`=15233 AND `GroupID`=1 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Probability`, `BroadcastTextId`, `comment`) VALUES
(15233, 1, 0, '%s emits a strange noise.', 16, 100, 10755, 'Vekniss Guardian');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15233) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15233, 0, 0, 1, 2, 0, 100, 1, 0, 20, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Guardian - Between 0-20% Health - Cast \'Enrage\' (No Repeat)'),
(15233, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Guardian - Between 0-20% Health - Say Line 0 (No Repeat)'),
(15233, 0, 2, 0, 0, 0, 100, 0, 8000, 11000, 11000, 21000, 0, 11, 26025, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Guardian - In Combat - Cast \'Impale\''),
(15233, 0, 3, 0, 4, 0, 50, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Guardian - On Aggro - Say Line 1 (No Repeat)');

-- Vekniss Warrior (15230)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15230) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15230, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 6122, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Warrior - On Just Died - Cast \'Summon Vekniss Borer\''),
(15230, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Warrior - On Reset - Set Run On'),
(15230, 0, 2, 0, 0, 0, 100, 0, 8000, 11000, 11000, 21000, 0, 11, 26025, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Warrior - In Combat - Cast \'Impale\'');

-- Qiraji Slayer (15250) - Battle Shout and Whirlwind timers taken from Cmangos
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15250) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15250, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 21000, 30500, 0, 11, 26043, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Slayer - In Combat - Cast \'Battle Shout\''),
(15250, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 21800, 29200, 0, 11, 26041, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Slayer - In Combat - Cast \'Enrage\''),
(15250, 0, 2, 0, 9, 0, 100, 0, 0, 10, 15800, 15800, 0, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Slayer - Within 0-10 Range - Cast \'Knock Away\''),
(15250, 0, 3, 0, 0, 0, 100, 0, 5000, 9000, 8000, 10000, 0, 11, 13736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Slayer - In Combat - Cast \'Whirlwind\'');

-- Spawn of Fankriss (15630) - Cmangos and Sniffs
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15630) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15630, 0, 0, 0, 0, 0, 100, 1, 30000, 30000, 0, 0, 0, 11, 26662, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spawn of Fankriss - In Combat - Cast \'Berserk\' (No Repeat)');

-- Anubisath Warrior (15537) - Cmangos
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15537) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15537, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anubisath Warrior - Between 0-30% Health - Cast \'Enrage\' (No Repeat)'),
(15537, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anubisath Warrior - Between 0-30% Health - Say Line 0 (No Repeat)'),
(15537, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 9000, 13000, 0, 11, 15550, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anubisath Warrior - In Combat - Cast \'Trample\''),
(15537, 0, 3, 0, 9, 0, 100, 0, 0, 10, 7000, 11000, 0, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anubisath Warrior - In Combat - Cast \'Uppercut\'');

-- Anubisath Swarmguard (15538) - Cmangos
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15538) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15538, 0, 0, 0, 9, 0, 100, 0, 0, 5, 5000, 7000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anubisath Swarmguard - Within 0-5 Range - Cast \'Cleave\'');

-- Yauj Brood (15621) - Cmangos
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15621;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15621) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15621, 0, 0, 0, 9, 0, 100, 0, 0, 5, 9000, 13000, 0, 11, 25788, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Yauj Brood - Within 0-5 Range - Cast \'Head Butt\''),
(15621, 0, 1, 0, 13, 0, 100, 0, 8000, 10000, 0, 0, 0, 11, 25788, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Yauj Brood - On Victim Casting - Cast \'Head Butt\'');

-- Vekniss Borer (15622)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15622;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15622) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15622, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Borer - On Just Died - Despawn Instant');
