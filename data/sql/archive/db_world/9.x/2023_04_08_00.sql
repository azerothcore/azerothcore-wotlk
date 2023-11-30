-- DB update 2023_04_06_01 -> 2023_04_08_00
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (22911,36023,30481,30636,34100,30932);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(22911, 22911, 37511),
(36023, 36023, 36054),
(30481, 30481, 35945),
(30636, 30636, 35942),
(34100, 34100, 35950),
(30932, 30932, 40248);

UPDATE `creature_text` SET `Text` = 'For Kargath!  For Victory!', `BroadcastTextId` = 16698 WHERE `Text` = 'For Kargath! For Victory!';
UPDATE `creature_text` SET `BroadcastTextId` = 16699 WHERE `Text` = 'Gakarah ma!';
UPDATE `creature_text` SET `BroadcastTextId` = 16703 WHERE `Text` = 'Lok narash!';
UPDATE `creature_text` SET `BroadcastTextId` = 16701 WHERE `Text` = 'Lok\'tar Illadari!';
UPDATE `creature_text` SET `BroadcastTextId` = 16700 WHERE `Text` = 'The blood is our power!';
UPDATE `creature_text` SET `BroadcastTextId` = 16702 WHERE `Text` = 'This world is OURS!';
UPDATE `creature_text` SET `BroadcastTextId` = 16697 WHERE `Text` = 'We are the true Horde!';

-- Shattered Hand Sentry
DELETE FROM `creature_template_addon` WHERE (`entry` IN (16507, 20593));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(16507, 0, 0, 0, 1, 0, 0, '18950'),
(20593, 0, 0, 0, 1, 0, 0, '18950');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16507);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16507, 0, 0, 0, 0, 0, 100, 0, 1000, 3500, 13000, 16000, 0, 11, 31553, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sentry - In Combat - Cast \'Hamstring\''),
(16507, 0, 1, 0, 4, 0, 15, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sentry - On Aggro - Say Line 1 (No Repeat)'),
(16507, 0, 2, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 0, 11, 22911, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sentry - In Combat - Cast \'Charge\' (No Repeat)');

-- Shattered Hand Savage
DELETE FROM `creature_text` WHERE `CreatureID` = 16523 AND `GroupID` = 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16523, 1, 0, 'For Kargath!  For Victory!', 12, 0, 100, 0, 0, 0, 16698, 0, 'Shattered Hand Savage'),
(16523, 1, 1, 'Gakarah ma!', 12, 0, 100, 0, 0, 0, 16699, 0, 'Shattered Hand Savage'),
(16523, 1, 2, 'Lok narash!', 12, 0, 100, 0, 0, 0, 16703, 0, 'Shattered Hand Savage'),
(16523, 1, 3, 'Lok\'tar Illadari!', 12, 0, 100, 0, 0, 0, 16701, 0, 'Shattered Hand Savage'),
(16523, 1, 4, 'The blood is our power!', 12, 0, 100, 0, 0, 0, 16700, 0, 'Shattered Hand Savage'),
(16523, 1, 5, 'This world is OURS!', 12, 0, 100, 0, 0, 0, 16702, 0, 'Shattered Hand Savage'),
(16523, 1, 6, 'We are the true Horde!', 12, 0, 100, 0, 0, 0, 16697, 0, 'Shattered Hand Savage');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16523);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16523, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36023, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - On Just Died - Cast \'Deathblow\''),
(16523, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 20000, 25000, 0, 11, 30470, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - In Combat - Cast \'Slice and Dice\''),
(16523, 0, 2, 3, 2, 0, 100, 0, 0, 30, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - Between 0-30% Health - Cast \'Enrage\''),
(16523, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - Between 0-30% Health - Say Line 0'),
(16523, 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Savage - On Aggro - Say Line 1');

-- Shattered Hand Brawler
DELETE FROM `creature_template_addon` WHERE (`entry` IN (16593, 20582));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(16593, 0, 0, 0, 1, 0, 0, '8876'),
(20582, 0, 0, 0, 1, 0, 0, '8876');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16593);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16593, 0, 0, 0, 9, 0, 100, 0, 0, 5, 12000, 21000, 0, 11, 36020, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - Within 0-5 Range - Cast \'Curse of the Shattered Hand\''),
(16593, 0, 1, 0, 13, 0, 100, 0, 6000, 15000, 0, 0, 0, 11, 36033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - On Victim Casting - Cast \'Kick\''),
(16593, 0, 2, 3, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - On Aggro - Say Line 1'),
(16593, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 16093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Brawler - On Aggro - Remove Aura \'Self Visual - Sleep Until Cancelled (DND)\'');

-- Shattered Hand Reaver
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16699);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16699, 0, 0, 0, 0, 0, 100, 0, 1500, 1500, 5000, 9000, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - In Combat - Cast \'Cleave\''),
(16699, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 9000, 13000, 0, 11, 30471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - In Combat - Cast \'Uppercut\''),
(16699, 0, 2, 3, 2, 0, 100, 0, 0, 25, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - Between 0-25% Health - Cast \'Enrage\''),
(16699, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - Between 0-25% Health - Say Line 0'),
(16699, 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Aggro - Say Line 1');

-- Shattered Hand Legionnaire //TODO: Proper Scripting for summons
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16700, 0, 0, 0, 0, 0, 100, 0, 1500, 5000, 240000, 240000, 0, 11, 30472, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - In Combat - Cast \'Aura of Discipline\''),
(16700, 0, 2, 0, 13, 0, 100, 0, 10000, 15000, 0, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Victim Casting - Cast \'Pummel\''),
(16700, 0, 3, 4, 2, 0, 100, 0, 0, 25, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Between 0-25% Health - Cast \'Enrage\''),
(16700, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Between 0-25% Health - Say Line 0'),
(16700, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Aggro - Say Line 1');

-- Shattered Hand Sharpshooter
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16704);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16704, 0, 0, 0, 9, 0, 100, 2, 5, 30, 2300, 5000, 0, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - Within 5-30 Range - Cast \'Shoot\' (Normal Dungeon)'),
(16704, 0, 1, 0, 9, 0, 100, 4, 5, 30, 2300, 5000, 0, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - Within 5-30 Range - Cast \'Shoot\' (Heroic Dungeon)'),
(16704, 0, 2, 0, 9, 0, 100, 0, 5, 30, 6000, 9000, 0, 11, 30481, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - Within 5-30 Range - Cast \'Incendiary Shot\''),
(16704, 0, 3, 0, 9, 0, 100, 4, 5, 30, 10000, 14000, 0, 11, 37551, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - Within 5-30 Range - Cast \'Viper Sting\' (Heroic Dungeon)');

-- Creeping Ooze
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17356);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17356, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 3800, 6600, 0, 11, 30494, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Creeping Ooze - In Combat - Cast \'Sticky Ooze\'');

-- Creeping Oozeling
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17357;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17357);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17357, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 3800, 6500, 0, 11, 30494, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Creeping Oozeling - In Combat - Cast \'Sticky Ooze\'');

-- Shattered Hand Heathen
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17420);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17420, 0, 0, 0, 0, 0, 100, 2, 6000, 13000, 12000, 16000, 0, 11, 30474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Normal Dungeon)'),
(17420, 0, 1, 0, 0, 0, 100, 4, 6000, 13000, 12000, 16000, 0, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - In Combat - Cast \'Bloodthirst\' (Heroic Dungeon)'),
(17420, 0, 2, 3, 2, 0, 100, 0, 0, 30, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Cast \'Enrage\''),
(17420, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - Between 0-30% Health - Say Line 0'),
(17420, 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Aggro - Say Line 1');

-- Shattered Hand Archer
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17427);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17427, 0, 0, 0, 9, 0, 100, 2, 5, 30, 2300, 5000, 0, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Archer - Within 5-30 Range - Cast \'Shoot\' (Normal Dungeon)'),
(17427, 0, 1, 0, 9, 0, 100, 4, 5, 30, 2300, 5000, 0, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Archer - Within 5-30 Range - Cast \'Shoot\' (Heroic Dungeon)'),
(17427, 0, 2, 0, 9, 0, 100, 0, 5, 30, 6000, 9000, 0, 11, 30990, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Archer - Within 5-30 Range - Cast \'Multi-Shot\'');

-- Shattered Hand Zealot
DELETE FROM `creature_template_addon` WHERE (`entry` IN (17462, 20595));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17462, 0, 0, 0, 1, 0, 0, '18950'),
(20595, 0, 0, 0, 1, 0, 0, '18950');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17462);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17462, 0, 0, 0, 9, 0, 100, 0, 0, 5, 10000, 13000, 0, 11, 30989, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Within 0-5 Range - Cast \'Hamstring\'');

-- Shattered Hand Gladiator // TODO: Sparring
DELETE FROM `creature_template_addon` WHERE (`entry` IN (17464, 20586));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17464, 0, 0, 0, 1, 0, 0, '19818'),
(20586, 0, 0, 0, 1, 0, 0, '19818');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17464);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17464, 0, 0, 0, 0, 0, 100, 0, 6000, 18000, 10000, 20000, 0, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Gladiator - In Combat - Cast \'Mortal Strike\'');

-- Shattered Hand Centurion
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17465);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17465, 0, 0, 0, 0, 0, 100, 2, 1500, 2500, 4000, 6000, 0, 11, 15572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Centurion - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(17465, 0, 1, 0, 0, 0, 100, 4, 1500, 2500, 4000, 6000, 0, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Centurion - In Combat - Cast \'Sunder Armor\' (Heroic Dungeon)'),
(17465, 0, 2, 0, 0, 0, 100, 2, 3000, 7000, 17000, 21000, 0, 11, 30931, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Centurion - In Combat - Cast \'Battle Shout\' (Normal Dungeon)'),
(17465, 0, 3, 0, 0, 0, 100, 4, 3000, 7000, 17000, 21000, 0, 11, 31403, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Centurion - In Combat - Cast \'Battle Shout\' (Heroic Dungeon)'),
(17465, 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Centurion - On Aggro - Say Line 1');

-- Rabid Warhound
DELETE FROM `creature_template_addon` WHERE (`entry` IN (17669, 20574));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17669, 0, 0, 0, 1, 0, 0, '18950'),
(20574, 0, 0, 0, 1, 0, 0, '18950');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17669);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17669, 0, 0, 0, 0, 0, 100, 0, 500, 500, 7000, 10000, 0, 11, 30639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rabid Warhound - In Combat - Cast \'Carnivorous Bite\''),
(17669, 0, 1, 0, 0, 0, 40, 0, 2000, 2000, 8000, 14000, 0, 11, 30636, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rabid Warhound - In Combat - Cast \'Furious Howl\'');

-- Shattered Hand Houndmaster
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17670);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17670, 0, 0, 0, 9, 0, 100, 2, 5, 30, 2300, 5000, 0, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Houndmaster - Within 5-30 Range - Cast \'Shoot\' (Normal Dungeon)'),
(17670, 0, 1, 0, 9, 0, 100, 4, 5, 30, 2300, 5000, 0, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Houndmaster - Within 5-30 Range - Cast \'Shoot\' (Heroic Dungeon)'),
(17670, 0, 2, 0, 0, 0, 100, 0, 7000, 12000, 60000, 70000, 0, 11, 34100, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Houndmaster - In Combat - Cast \'Volley\''),
(17670, 0, 3, 0, 9, 0, 100, 0, 5, 30, 12000, 16000, 0, 11, 30932, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Houndmaster - Within 5-30 Range - Cast \'Impaling Bolt\'');

-- Shattered Hand Champion // Uncertain if Aggro Drop is related to Concussive Blow
DELETE FROM `creature_template_addon` WHERE (`entry` IN (17671, 20584));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17671, 0, 0, 0, 1, 0, 0, '12782 18950'),
(20584, 0, 0, 0, 1, 0, 0, '12782 18950');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17671);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17671, 0, 0, 4, 0, 0, 100, 0, 1500, 1500, 10000, 14000, 0, 11, 32588, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Champion - In Combat - Cast \'Concussion Blow\''),
(17671, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 12000, 15000, 0, 11, 32587, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Champion - In Combat - Cast \'Shield Block\''),
(17671, 0, 2, 0, 13, 0, 100, 0, 13000, 16000, 0, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Champion - On Victim Casting - Cast \'Shield Bash\''),
(17671, 0, 3, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Champion - On Aggro - Say Line 1'),
(17671, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 13, 0, 100, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Champion - Linked - Drop Threat');

-- Shadowmoon Darkcaster
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17694);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17694, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2400, 3800, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - In Combat - Cast \'Shadow Bolt\' (Normal Dungeon)'),
(17694, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2400, 3800, 0, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - In Combat - Cast \'Shadow Bolt\' (Heroic Dungeon)'),
(17694, 0, 2, 0, 0, 0, 100, 0, 4000, 8000, 13000, 18000, 0, 11, 12542, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - In Combat - Cast \'Fear\''),
(17694, 0, 3, 0, 0, 0, 100, 2, 2000, 6000, 14000, 18000, 0, 11, 11990, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - In Combat - Cast \'Rain of Fire\' (Normal Dungeon)'),
(17694, 0, 4, 0, 0, 0, 100, 4, 2000, 6000, 14000, 18000, 0, 11, 33508, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - In Combat - Cast \'Rain of Fire\' (Heroic Dungeon)'),
(17694, 0, 5, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Aggro - Say Line 1'),
(17694, 0, 6, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Shattered Hand Assassin
DELETE FROM `creature_template_addon` WHERE (`entry` IN (17695, 20580));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17695, 0, 0, 0, 1, 0, 0, '30991'),
(20580, 0, 0, 0, 1, 0, 0, '30991');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17695);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17695, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Assassin - On Respawn - Set Reactstate Defensive'),
(17695, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Assassin - On Aggro - Set Reactstate Aggressive'),
(17695, 0, 2, 0, 67, 0, 100, 0, 4500, 6500, 0, 0, 0, 11, 30992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Assassin - On Behind Target - Cast \'Backstab\''),
(17695, 0, 3, 0, 0, 0, 100, 0, 8000, 11000, 22000, 25000, 0, 11, 36974, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Assassin - In Combat - Cast \'Wound Poison\''),
(17695, 0, 4, 0, 0, 0, 100, 0, 2000, 4500, 12000, 20000, 0, 11, 30981, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Assassin - In Combat - Cast \'Crippling Poison\''),
(17695, 0, 5, 0, 10, 0, 100, 0, 0, 15, 12000, 15000, 1, 11, 30980, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Assassin - Within 0-15 Range Out of Combat LoS - Cast \'Sap\''),
(17695, 0, 6, 0, 10, 0, 100, 0, 0, 8, 4000, 8000, 0, 11, 30986, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Assassin - Within 0-8 Range Out of Combat LoS - Cast \'Cheap Shot\''),
(17695, 0, 7, 0, 9, 0, 100, 0, 0, 8, 4000, 8000, 0, 11, 30986, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Assassin - Within 0-8 Range - Cast \'Cheap Shot\'');

-- Kargath Adds // These are sniffed
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17621);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17621, 0, 0, 0, 0, 0, 100, 0, 7300, 18300, 15550, 26450, 0, 11, 30474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Heathen Guard - In Combat - Cast \'Bloodthirst\''),
(17621, 0, 1, 2, 2, 0, 100, 0, 0, 20, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heathen Guard - Between 0-20% Health - Cast \'Enrage\''),
(17621, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heathen Guard - Between 0-20% Health - Say Line 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17622);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17622, 0, 0, 0, 0, 0, 100, 2, 1200, 6100, 3100, 5600, 0, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sharpshooter Guard - In Combat - Cast \'Shoot\' (Normal Dungeon)'),
(17622, 0, 1, 0, 0, 0, 100, 4, 1200, 6100, 3100, 5600, 0, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sharpshooter Guard - In Combat - Cast \'Shoot\' (Heroic Dungeon)'),
(17622, 0, 2, 0, 0, 0, 100, 0, 12150, 30400, 12150, 30400, 0, 11, 30481, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sharpshooter Guard - In Combat - Cast \'Incendiary Shot\''),
(17622, 0, 3, 0, 0, 0, 100, 0, 13350, 21000, 20700, 39250, 0, 11, 23601, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sharpshooter Guard - In Combat - Cast \'Scatter Shot\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17623);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17623, 0, 0, 0, 0, 0, 100, 0, 7300, 14250, 950, 14550, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reaver Guard - In Combat - Cast \'Cleave\''),
(17623, 0, 1, 0, 0, 0, 100, 0, 12150, 30400, 15800, 30700, 0, 11, 30471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reaver Guard - In Combat - Cast \'Uppercut\''),
(17623, 0, 2, 3, 2, 0, 100, 0, 0, 25, 120000, 120000, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reaver Guard - Between 0-25% Health - Cast \'Enrage\''),
(17623, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reaver Guard - Between 0-25% Health - Say Line 0');

-- Shattered Hand Scout
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '18950' WHERE (`entry` = 17462);

-- Blood Guard
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '18950' WHERE (`entry` IN (17461, 20581, 20923));

-- Fel Orc Convert
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|33554432 WHERE (`entry` = 17083);
