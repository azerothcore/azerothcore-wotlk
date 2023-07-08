-- DB update 2023_03_29_02 -> 2023_03_29_03
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (33480, 32863);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(33480, 33480, 38226),
(32863, 32863, 38252);

-- BroadcastID
UPDATE `creature_text` SET `BroadcastTextId` = 16798 WHERE `Text` = 'Ruin finds us all!';
UPDATE `creature_text` SET `BroadcastTextId` = 16799 WHERE `Text` = 'In Sargeras\' name!';
UPDATE `creature_text` SET `BroadcastTextId` = 16800 WHERE `Text` = 'The end comes for you!';
UPDATE `creature_text` SET `BroadcastTextId` = 16801 WHERE `Text` = 'I do as I must!';
UPDATE `creature_text` SET `BroadcastTextId` = 16802 WHERE `Text` = 'The Legion reigns!';
UPDATE `creature_text` SET `BroadcastTextId` = 16803 WHERE `Text` = 'I shall be rewarded!';

-- Cabal Cultist (18631)
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '8876' WHERE (`entry` = 18631); -- This is from ACID / TC - I don't believe this creature uses an aura
DELETE FROM `creature_template_addon` WHERE (`entry` = 20640);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20640, 0, 0, 0, 1, 0, 0, '8876');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18631);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18631, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - On Aggro - Say Line 0'),
(18631, 0, 1, 0, 13, 0, 100, 0, 5000, 10000, 0, 0, 0, 11, 15614, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - On Victim Casting \'null\' - Cast \'Kick\''),
(18631, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Cultist - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Cabal Executioner (18632)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18632);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18632, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Executioner - On Aggro - Say Line 0'),
(18632, 0, 1, 0, 0, 0, 100, 2, 7200, 15900, 15700, 32500, 0, 11, 33500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Executioner - In Combat - Cast \'Whirlwind\' (Normal Dungeon)'),
(18632, 0, 2, 0, 0, 0, 100, 4, 7200, 15900, 15700, 32500, 0, 11, 15578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Executioner - In Combat - Cast \'Whirlwind\' (Heroic Dungeon)'),
(18632, 0, 3, 0, 12, 0, 100, 0, 0, 20, 8000, 12000, 0, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Executioner - Target Between 0-20% Health - Cast \'Execute\''),
(18632, 0, 4, 0, 2, 0, 100, 1, 0, 25, 0, 0, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Executioner - Between 0-25% Health - Cast \'Enrage\' (No Repeat)');

-- Cabal Acolyte (18633)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18633);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18633, 0, 0, 0, 23, 0, 100, 0, 33482, 0, 3600, 3600, 0, 11, 33482, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - On Aura Missing - Cast \'Shadow Defense\''),
(18633, 0, 1, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - On Aggro - Say Line 0'),
(18633, 0, 2, 0, 74, 0, 100, 2, 0, 60, 15700, 27700, 40, 11, 12039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - On Friendly Between 0-60% Health - Cast \'Heal\' (Normal Dungeon)'),
(18633, 0, 3, 0, 74, 0, 100, 4, 0, 60, 15700, 27700, 40, 11, 38209, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - On Friendly Between 0-60% Health - Cast \'Heal\' (Heroic Dungeon)'),
(18633, 0, 4, 0, 74, 0, 100, 2, 0, 50, 13200, 19300, 40, 11, 25058, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - On Friendly Between 0-50% Health - Cast \'Renew\' (Normal Dungeon)'),
(18633, 0, 5, 0, 74, 0, 100, 4, 0, 50, 13200, 19300, 40, 11, 38210, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - On Friendly Between 0-50% Health - Cast \'Renew\' (Heroic Dungeon)'),
(18633, 0, 6, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Acolyte - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Cabal Summoner (18634)
DELETE FROM `creature_text` WHERE `CreatureID` = 18634;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18634, 0, 0, 'Ruin finds us all!', 12, 0, 100, 0, 0, 0, 16798, 0, 'Cabal Summoner'),
(18634, 0, 1, 'In Sargeras\' name!', 12, 0, 100, 0, 0, 0, 16799, 0, 'Cabal Summoner'),
(18634, 0, 2, 'The end comes for you!', 12, 0, 100, 0, 0, 0, 16800, 0, 'Cabal Summoner'),
(18634, 0, 3, 'I do as I must!', 12, 0, 100, 0, 0, 0, 16801, 0, 'Cabal Summoner'),
(18634, 0, 4, 'The Legion reigns!', 12, 0, 100, 0, 0, 0, 16802, 0, 'Cabal Summoner'),
(18634, 0, 5, 'I shall be rewarded!', 12, 0, 100, 0, 0, 0, 16803, 0, 'Cabal Summoner'),
(18634, 1, 0, '%s begins to summon in a Cabal Deathsworn!', 16, 0, 100, 0, 0, 0, 16271, 0, 'Cabal Summoner'),
(18634, 2, 0, '%s begins to summon in a Cabal Acolyte!', 16, 0, 100, 0, 0, 0, 16275, 0, 'Cabal Summoner'),
(18634, 3, 0, '%s summons a Cabal Acolyte to his aid!', 16, 0, 100, 0, 0, 0, 16278, 0, 'Cabal Summoner'),
(18634, 4, 0, '%s summons a Cabal Deathsworn to his aid!', 16, 0, 100, 0, 0, 0, 16280, 0, 'Cabal Summoner');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18634);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18634, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Aggro - Say Line 0'),
(18634, 0, 1, 0, 0, 0, 100, 2, 1800, 6200, 4800, 16900, 0, 11, 14034, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - In Combat - Cast \'Fireball\' (Normal Dungeon)'),
(18634, 0, 2, 0, 0, 0, 100, 4, 1800, 6200, 4800, 16900, 0, 11, 15228, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - In Combat - Cast \'Fireball\' (Heroic Dungeon)'),
(18634, 0, 3, 5, 0, 0, 100, 0, 4300, 17200, 13300, 25300, 0, 11, 33506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - In Combat - Cast \'Summon Cabal Deathsworn\''),
(18634, 0, 4, 6, 0, 0, 100, 0, 3600, 33200, 12100, 27900, 0, 11, 33507, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - In Combat - Cast \'Summon Cabal Acolyte\''),
(18634, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Link - Say Line 1'),
(18634, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Link - Say Line 2'),
(18634, 0, 7, 0, 17, 0, 100, 0, 19208, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Summoned Unit - Say Line 3'),
(18634, 0, 8, 0, 17, 0, 100, 0, 19209, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Summoner - On Summoned Unit - Say Line 4');

-- Cabal Deathsworn (18635)
DELETE FROM `creature_text` WHERE `CreatureID`=18635 AND `GroupID`=1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (18635, 1, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 2384, 0, 'Cabal Deathsworn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18635);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18635, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - On Aggro - Say Line 0'),
(18635, 0, 1, 0, 0, 0, 100, 0, 10200, 18100, 14100, 26200, 0, 11, 33480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - In Combat - Cast \'Black Cleave\''),
(18635, 0, 2, 0, 0, 0, 100, 0, 10900, 28200, 12100, 22900, 0, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - In Combat - Cast \'Knockdown\''),
(18635, 0, 3, 4, 2, 0, 100, 1, 0, 25, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - Between 0-25% Health - Cast \'Enrage\'(No Repeat)'),
(18635, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Deathsworn - On Link - Say Line 1');

-- Cabal Assassin (18636)
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '30982 30991 30998' WHERE (`entry` = 18636);
DELETE FROM `creature_template_addon` WHERE (`entry` = 20639);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20639, 0, 0, 0, 1, 0, 0, '30982 30991 30998');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18636);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18636, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - On Aggro - Say Line 0'),
(18636, 0, 1, 0, 0, 0, 100, 1, 0, 1000, 0, 0, 0, 11, 30986, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - In Combat - Cast \'Cheap Shot\' (No Repeat)'),
(18636, 0, 2, 0, 0, 0, 100, 0, 5000, 7000, 4500, 6500, 0, 11, 30992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - In Combat - Cast \'Backstab\'');

-- Cabal Shadow Priest (18637)
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '16592' WHERE (`entry` = 18637);
DELETE FROM `creature_template_addon` WHERE (`entry` = 20646);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20646, 0, 0, 0, 1, 0, 0, '16592');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18637);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18637, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - On Aggro - Say Line 0'),
(18637, 0, 1, 0, 0, 0, 100, 2, 3200, 10800, 4800, 9700, 0, 11, 17165, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - In Combat - Cast \'Mind Flay\' (Normal Dungeon)'),
(18637, 0, 2, 0, 0, 0, 100, 4, 3200, 10800, 2400, 4800, 0, 11, 38243, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - In Combat - Cast \'Mind Flay\' (Heroic Dungeon)'),
(18637, 0, 3, 0, 0, 0, 100, 2, 3600, 12100, 5400, 12900, 0, 11, 14032, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - In Combat - Cast \'Shadow Word: Pain\' (Normal Dungeon)'),
(18637, 0, 4, 0, 0, 0, 100, 4, 3100, 12100, 4800, 7200, 0, 11, 17146, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Shadow Priest - In Combat - Cast \'Shadow Word: Pain\' (Heroic Dungeon)');

-- Cabal Zealot (18638)
DELETE FROM `creature_text` WHERE `CreatureID` = 18638;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18638, 0, 0, 'Ruin finds us all!', 12, 0, 100, 0, 0, 0, 16798, 0, 'Cabal Zealot'),
(18638, 0, 1, 'In Sargeras\' name!', 12, 0, 100, 0, 0, 0, 16799, 0, 'Cabal Zealot'),
(18638, 0, 2, 'The end comes for you!', 12, 0, 100, 0, 0, 0, 16800, 0, 'Cabal Zealot'),
(18638, 0, 3, 'I do as I must!', 12, 0, 100, 0, 0, 0, 16801, 0, 'Cabal Zealot'),
(18638, 0, 4, 'The Legion reigns!', 12, 0, 100, 0, 0, 0, 16802, 0, 'Cabal Zealot'),
(18638, 0, 5, 'I shall be rewarded!', 12, 0, 100, 0, 0, 0, 16803, 0, 'Cabal Zealot'),
(18638, 1, 0, '%s makes some strange gestures.', 16, 8, 100, 0, 0, 0, 16259, 0, 'Cabal Zealot');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18638);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18638, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - On Aggro - Say Line 0'),
(18638, 0, 1, 0, 0, 0, 100, 2, 0, 0, 3400, 4500, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - In Combat CMC - Cast \'Shadow Bolt\' (Normal Dungeon)'),
(18638, 0, 2, 0, 0, 0, 100, 4, 0, 0, 3400, 4500, 0, 11, 15472, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - In Combat CMC - Cast \'Shadow Bolt\' (Heroic Dungeon)'),
(18638, 0, 3, 4, 2, 0, 100, 1, 0, 50, 0, 0, 0, 11, 33949, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - Between 0-50% Health - Cast \'Shape of the Beast\' (No Repeat)'),
(18638, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 33499, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - On Link - Cast \'Shape of the Beast\''),
(18638, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Zealot - On Link - Say Line 1');

-- Cabal Spellbinder (18639)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18639);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18639, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - On Aggro - Say Line 0'),
(18639, 0, 1, 0, 0, 0, 100, 0, 5700, 19300, 9600, 16900, 0, 11, 32691, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - In Combat - Cast \'Spell Shock\''),
(18639, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 20000, 30000, 0, 11, 33502, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - In Combat - Cast \'Brain Wash\''),
(18639, 0, 3, 0, 23, 0, 100, 1, 8734, 1, 0, 0, 0, 11, 8734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Spellbinder - On Has Aura - Cast \'Blackfathom Channeling\' (No Repeat)');

-- Cabal Warlock (18640)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18640);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18640, 0, 0, 0, 23, 0, 100, 0, 13787, 0, 3600, 3600, 0, 11, 13787, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - On Aura Missing - Cast \'Demon Armor\''),
(18640, 0, 1, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - On Aggro - Say Line 0'),
(18640, 0, 2, 0, 0, 0, 100, 2, 0, 0, 3600, 4800, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - In Combat - Cast \'Shadow Bolt\' (Normal Dungeon)'),
(18640, 0, 3, 0, 0, 0, 100, 4, 0, 0, 3600, 4800, 0, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - In Combat - Cast \'Shadow Bolt\' (Heroic Dungeon)'),
(18640, 0, 4, 0, 0, 0, 100, 0, 7800, 24100, 19300, 36200, 0, 11, 32863, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Warlock - In Combat - Cast \'Seed of Corruption\'');

-- Cabal Familiar (18641)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18641);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18641, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2400, 3600, 0, 11, 20801, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Familiar - In Combat - Cast \'Firebolt\' (Normal Dungeon)'),
(18641, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2400, 3600, 0, 11, 38239, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Familiar - In Combat - Cast \'Firebolt\' (Heroic Dungeon)');

-- Fel Guardhound (18642)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18642);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18642, 0, 0, 0, 0, 0, 100, 0, 4800, 14500, 12100, 18100, 0, 11, 30849, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Guardhound - In Combat - Cast \'Spell Lock\'');

-- Invisible Target (18793)
UPDATE `creature_template_addon` SET `bytes2` = 1, `visibilityDistanceType` = 4 WHERE (`entry` = 18793);

-- Cabal Ritualist (18794)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18794);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18794, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 32958, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Reset - Cast \'Crystal Channel\''),
(18794, 0, 1, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 88, 1879400, 1879403, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Aggro - Run Random Script'),
(18794, 0, 2, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Aggro - Say Line 0'),
(18794, 0, 3, 0, 0, 1, 100, 2, 0, 0, 3400, 4500, 0, 11, 15497, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat CMC - Cast \'Frostbolt\' (Normal Dungeon) (Phase 1)'),
(18794, 0, 4, 0, 0, 1, 100, 4, 0, 0, 3400, 4500, 0, 11, 12675, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat CMC - Cast \'Frostbolt\' (Heroic Dungeon) (Phase 1)'),
(18794, 0, 5, 0, 0, 1, 100, 2, 10000, 18000, 12100, 16900, 0, 11, 15532, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast \'Frost Nova\' (Normal Dungeon) (Phase 1)'),
(18794, 0, 6, 0, 0, 1, 100, 4, 10000, 18000, 12100, 16900, 0, 11, 15063, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast \'Frost Nova\' (Normal Dungeon) (Phase 1)'),
(18794, 0, 7, 0, 0, 2, 100, 2, 0, 0, 5000, 5000, 0, 11, 33832, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat CMC - Cast \'Arcane Missiles\' (Normal Dungeon) (Phase 2)'),
(18794, 0, 8, 0, 0, 2, 100, 4, 0, 0, 5000, 5000, 0, 11, 38263, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat CMC - Cast \'Arcane Missiles\' (Heroic Dungeon) (Phase 2)'),
(18794, 0, 9, 0, 0, 2, 100, 0, 2400, 14300, 5200, 21700, 0, 11, 33487, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast \'Addle Humanoid\' (Phase 2)'),
(18794, 0, 10, 0, 0, 4, 100, 0, 3600, 6200, 4800, 11200, 0, 11, 9574, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast \'Flame Buffet\' (Phase 3)'),
(18794, 0, 11, 0, 0, 4, 100, 2, 6100, 20200, 8400, 22900, 0, 11, 20795, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast \'Fire Blast\' (Normal Dungeon) (Phase 3)'),
(18794, 0, 12, 0, 0, 4, 100, 4, 6100, 20200, 8400, 22900, 0, 11, 14145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast \'Fire Blast\' (Heroic Dungeon) (Phase 3)'),
(18794, 0, 13, 0, 0, 8, 100, 0, 10000, 15000, 12100, 19300, 0, 11, 12540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - In Combat - Cast \'Gouge\' (Phase 4)'),
(18794, 0, 14, 0, 15, 0, 100, 4, 15, 15000, 20000, 0, 0, 11, 17201, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - Friendly Crowd Controlled - Cast \'Dispel Magic\' (Heroic Dungeon)'),
(18794, 0, 15, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - Between 0-15% Health - Flee For Assist (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 1879400 AND 1879403);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1879400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Script - Set Event Phase 1'),
(1879400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 12421, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Script - Set Mainhand Item'),
(1879401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Script - Set Event Phase 2'),
(1879401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 14618, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Script - Set Mainhand Item'),
(1879402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Script - Set Event Phase 3'),
(1879402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 13718, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Script - Set Mainhand Item'),
(1879403, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Script - Set Event Phase 4'),
(1879403, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 1, 19980, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Script - Set Mainhand Item'),
(1879403, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 2, 0, 19980, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Script - Set Offhand Item');

-- Fel Overseer (18796)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18796);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18796, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - On Aggro - Say Line 0'),
(18796, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 27577, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - On Aggro - Cast \'Intercept\''),
(18796, 0, 2, 0, 0, 0, 100, 4, 4800, 9300, 15700, 20300, 0, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - In Combat - Cast \'Mortal Strike\' (Heroic Dungeon)'),
(18796, 0, 3, 0, 0, 0, 100, 4, 30000, 30000, 30000, 30000, 0, 11, 19134, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - In Combat - Cast \'Frightening Shout\' (Heroic Dungeon)'),
(18796, 0, 4, 0, 0, 0, 100, 0, 13300, 18900, 15700, 26500, 0, 11, 30471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Overseer - In Combat - Cast \'Uppercut\'');

-- Tortured Skeleton
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33587200 WHERE (`entry` IN (18797, 20662));

DELETE FROM `creature_template_addon` WHERE (`entry` IN (18797, 20662));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18797);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18797, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tortured Skeleton - On Aggro - Remove FlagStandstate Dead'),
(18797, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tortured Skeleton - On Aggro - Remove Flags Not Selectable'),
(18797, 0, 2, 3, 25, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tortured Skeleton - On Reset - Set Flags Not Selectable'),
(18797, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tortured Skeleton - On Reset - Set Flag Standstate Dead');

-- Cabal Fanatic (18830)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18830);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18830, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Fanatic - On Aggro - Say Line 0'),
(18830, 0, 1, 0, 0, 0, 100, 0, 9600, 20500, 13300, 22900, 0, 11, 12021, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Fanatic - In Combat - Cast \'Fixate\'');

-- Malicious Instructor (18848)
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '19818' WHERE (`entry` IN (18848, 20656));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18848);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18848, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Malicious Instructor - On Aggro - Say Line 0'),
(18848, 0, 1, 0, 0, 0, 100, 4, 16100, 25300, 21700, 25300, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Malicious Instructor - In Combat - Cast \'Disarm\' (Heroic Dungeon)'),
(18848, 0, 2, 0, 0, 0, 100, 0, 10800, 15700, 18100, 29100, 0, 11, 33493, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Malicious Instructor - In Combat - Cast \'Mark of Malice\''),
(18848, 0, 3, 0, 0, 0, 100, 0, 9600, 16900, 7200, 18100, 0, 11, 33501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malicious Instructor - In Combat - Cast \'Shadow Nova\'');

-- Spy To'gun (18891)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18891;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18891);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18891, 0, 0, 0, 19, 0, 100, 1, 10091, 0, 0, 0, 0, 80, 1889100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spy To\'gun - On Quest \'The Soul Devices\' Taken - Run Script (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1889100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1889100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 182942, 0, 0, 0, 0, 0, 0, 0, 'Spy To\'gun - On Script - Activate Closest Gameobject (Cage)'),
(1889100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spy To\'gun - On Script - Set Run Off'),
(1889100, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -63.5416, 42.9283, 0.206252, 2.42972, 'Spy To\'gun - On Script - Move To Position');

-- Summoned Cabal Deathsworn (19209)
DELETE FROM `creature_text` WHERE `CreatureID`=19209;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19209, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 2384, 0, 'Summoned Cabal Deathsworn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19209);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19209, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - On Just Summoned - Set In Combat With Zone'),
(19209, 0, 1, 0, 0, 0, 100, 0, 10200, 18100, 14100, 26200, 0, 11, 33480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - In Combat - Cast \'Black Cleave\''),
(19209, 0, 2, 0, 0, 0, 100, 0, 10900, 28200, 12100, 22900, 0, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - In Combat - Cast \'Knockdown\''),
(19209, 0, 3, 4, 2, 0, 100, 1, 0, 25, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - Between 0-25% Health - Cast \'Enrage\' (No Repeat)'),
(19209, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - On Link - Say Line 0'),
(19209, 0, 5, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - On Evade - Despawn (0)'),
(19209, 0, 6, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Deathsworn - On Evade - Set Flag Not Selectable');

-- Summoned Cabal Acolyte (19208)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19208);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19208, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 11, 33482, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - On Just Summoned - Cast \'Shadow Defense\''),
(19208, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - On Link - Set In Combat With Zone'),
(19208, 0, 2, 0, 74, 0, 100, 2, 0, 60, 15700, 27700, 40, 11, 12039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - On Friendly Between 0-60% Health - Cast \'Heal\' (Normal Dungeon)'),
(19208, 0, 3, 0, 74, 0, 100, 4, 0, 60, 15700, 27700, 40, 11, 38209, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - On Friendly Between 0-60% Health - Cast \'Heal\' (Heroic Dungeon)'),
(19208, 0, 4, 0, 74, 0, 100, 2, 0, 50, 13200, 19300, 40, 11, 25058, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - On Friendly Between 0-50% Health - Cast \'Renew\' (Normal Dungeon)'),
(19208, 0, 5, 0, 74, 0, 100, 4, 0, 50, 13200, 19300, 40, 11, 38210, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - On Friendly Between 0-50% Health - Cast \'Renew\' (Heroic Dungeon)'),
(19208, 0, 6, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - Between 0-15% Health - Flee For Assist (No Repeat)'),
(19208, 0, 7, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - On Evade - Despawn (0)'),
(19208, 0, 8, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Cabal Acolyte - On Evade - Set Flag Not Selectable');

-- Ambassador Hellmaw Arena
-- Target Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (32958, 36220)) AND (`ConditionTypeOrReference` = 31) AND (`ConditionValue2` IN (21159, 18731, 18793));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 32958, 0, 0, 31, 0, 3, 18793, 0, 0, 0, 0, '', 'Spell Crystal Channel (32958) only targets Invisible Target (18793)'),
(13, 1, 36220, 0, 0, 31, 0, 3, 18731, 0, 0, 0, 0, '', 'Spell Containment Beam (36220) only targets Ambassador Hellmaw (18731)');

-- Containment Beam
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 21159;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21159) AND (`source_type` = 0);

-- Invisible Target
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18793);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18793, 0, 0, 0, 23, 0, 100, 0, 32958, 1, 3600, 3600, 0, 86, 36220, 0, 19, 21159, 10, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Invisible Target - On Aura \'Crystal Channel\' - Cross Cast \'Containment Beam\''),
(18793, 0, 1, 0, 23, 0, 100, 0, 32958, 0, 3600, 3600, 0, 28, 36220, 0, 0, 0, 0, 0, 19, 21159, 10, 0, 0, 0, 0, 0, 0, 'Invisible Target - On Aura \'Crystal Channel\' Missing - Remove Aura \'Containment Beam\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 18793);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 18793, 0, 0, 29, 1, 18794, 20, 0, 1, 0, 0, '', 'Only play if there are no Cabal Ritualists alive nearby');

-- Cabal Ritualist
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18794) AND (`source_type` = 0) AND (`id` IN (16));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18794, 0, 16, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 18731, 200, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Just Died - Do Action on \'Ambassador Hellmaw\'');

UPDATE `smart_scripts` SET `action_param2`=0 WHERE (`entryorguid` = 18794) AND (`source_type` = 0) AND (`id` IN (3, 4, 7, 8));

-- Targets
UPDATE `creature_template_addon` SET `visibilityDistanceType` = 5 WHERE (`entry` IN (18793, 21159));
