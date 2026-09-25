-- DB update 2025_01_15_01 -> 2025_01_15_02

-- Nerub'ar Corpse Harvester
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25445;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25445);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25445, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 18000, 0, 0, 11, 6917, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Corpse Harvester - In Combat - Cast \'Venom Spit\'');

-- Nerub'ar Web Lord
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25294;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25294);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25294, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 14000, 16000, 0, 0, 11, 50284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Web Lord - In Combat - Cast \'Blinding Swarm\'');

-- Unliving Swine
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25600;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25600, 0, 0, 0, 9, 0, 100, 0, 1000, 2000, 10000, 15000, 0, 3, 11, 50303, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unliving Swine - Within 0-3 Range - Cast \'Swine Flu\'');

-- En'Kilah Necrolord
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25609;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25609);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25609, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 8000, 10000, 0, 0, 11, 50324, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - In Combat - Cast \'Bone Armor\''),
(25609, 0, 1, 0, 0, 0, 100, 0, 4000, 5000, 5000, 8000, 0, 0, 11, 50323, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Necrolord - In Combat - Cast \'Sharpened Bone\'');

-- Bloodspore Moth
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25464;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25464);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25464, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 20000, 25000, 0, 0, 11, 32914, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodspore Moth - In Combat - Cast \'Wing Buffet\'');

-- Skadir Mariner
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25523;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25523);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25523, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 15000, 20000, 0, 0, 11, 13730, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skadir Mariner - In Combat - Cast \'Demoralizing Shout\''),
(25523, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 25000, 30000, 0, 0, 11, 10966, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skadir Mariner - In Combat - Cast \'Uppercut\'');

-- Skadir Runecaster
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25520;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25520);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25520, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 30000, 30000, 0, 0, 11, 49871, 32, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skadir Runecaster - In Combat - Cast \'Rune of Retribution\''),
(25520, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 6000, 8000, 0, 0, 11, 9532, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skadir Runecaster - In Combat - Cast \'Lightning Bolt\'');

-- Gamel the Cruel
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26449;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26449);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26449, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 8000, 15000, 0, 0, 11, 19643, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gamel the Cruel - In Combat - Cast \'Mortal Strike\'');

-- Ragnar Drakkarlund
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26451;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26451);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26451, 0, 0, 0, 0, 0, 100, 0, 6000, 8000, 8000, 12000, 0, 0, 11, 41056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragnar Drakkarlund - In Combat - Cast \'Whirlwind\'');

-- Glacial Ancient
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25709;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25709);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25709, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 12000, 16000, 0, 0, 11, 50505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Glacial Ancient - In Combat - Cast \'Frost Breath\'');

-- Coldarra Scalesworn
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25717;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25717);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25717, 0, 0, 0, 0, 0, 100, 0, 12000, 15000, 12000, 15000, 0, 0, 11, 12748, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coldarra Scalesworn - In Combat - Cast \'Frost Nova\''),
(25717, 0, 1, 0, 0, 0, 100, 0, 12000, 15000, 12000, 15000, 0, 0, 11, 11977, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coldarra Scalesworn - In Combat - Cast \'Rend\'');

-- Crypt Crawler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25227;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25227);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25227, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 11, 31600, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Crawler - In Combat - Cast \'Crypt Scarabs\'');

-- Scourged Footman
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25981;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25981);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25981, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 3000, 8000, 0, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourged Footman - In Combat - Cast \'Mortal Strike\'');

-- Ziggurat Defender
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26202;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26202, 0, 0, 1, 0, 0, 100, 0, 4000, 5000, 10000, 15000, 0, 0, 11, 50306, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ziggurat Defender - In Combat - Cast \'Thrash Kick\'');

-- Clam Master K
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25800;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25800, 0, 0, 0, 9, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 5, 11, 49711, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Clam Master K - Within 0-5 Range - Cast \'Hooked Net\''),
(25800, 0, 1, 0, 9, 0, 100, 0, 1000, 2000, 2000, 2000, 5, 60, 11, 54431, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Clam Master K - Within 5-60 Range - Cast \'Throw Spear\'');

-- Nerub'ar Warrior
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25619;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25619);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25619, 0, 0, 0, 9, 0, 100, 0, 1000, 1000, 1000, 1000, 8, 25, 11, 50347, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Warrior - Within 8-25 Range - Cast \'Rush\'');

-- Nerub'ar Tunneler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25622;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25622);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25622, 0, 0, 0, 0, 0, 100, 0, 12000, 15000, 12000, 15000, 0, 0, 11, 50364, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nerub\'ar Tunneler - In Combat - Cast \'Rock Shield\'');

-- Claximus
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25209;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25209);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25209, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 15000, 20000, 0, 0, 11, 50275, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Claximus - In Combat - Cast \'Stabilized Magic\''),
(25209, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 2000, 10000, 0, 0, 11, 50273, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Claximus - In Combat - Cast \'Arcane Barrage\'');

-- Kaganishu
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25427;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25427);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25427, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 11, 19816, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaganishu - In Combat - Cast \'Fireball\''),
(25427, 0, 1, 0, 106, 0, 100, 0, 1000, 2000, 35000, 45000, 0, 10, 11, 15744, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaganishu - On Hostile in Range - Cast \'Blast Wave\'');

-- Magmoth Crusher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25434;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25434);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25434, 0, 0, 0, 6, 0, 100, 513, 0, 0, 0, 0, 0, 0, 33, 25505, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Magmoth Crusher - On Just Died - Quest Credit \'null\' (No Repeat)'),
(25434, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 20000, 25000, 0, 0, 11, 50410, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Magmoth Crusher - In Combat - Cast \'Tusk Strike\''),
(25434, 0, 2, 0, 106, 0, 100, 0, 2000, 2000, 15000, 20000, 10, 100, 11, 50413, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magmoth Crusher - On Hostile in Range - Cast \'Magnataur Charge\'');

-- Tundra Crawler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25454;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25454);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25454, 0, 0, 0, 0, 0, 100, 0, 10000, 12000, 12000, 15000, 0, 0, 11, 50293, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tundra Crawler - In Combat - Cast \'Corrosive Poison\'');

-- Plagued Magnataur
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25615;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25615);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25615, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 30000, 30000, 0, 0, 11, 50366, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plagued Magnataur - In Combat - Cast \'Plague Cloud\'');

-- Talramas Abomination
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25684;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25684);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25684, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 30000, 30000, 0, 0, 11, 50366, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talramas Abomination - In Combat - Cast \'Plague Cloud\'');

-- Gorloc Gibberer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25686;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25686);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25686, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 6000, 12000, 0, 0, 11, 50520, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorloc Gibberer - In Combat - Cast \'Deep Dredge\'');

-- Gorloc Steam Belcher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25687;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25687);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25687, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 0, 0, 11, 50538, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorloc Steam Belcher - In Combat - Cast \'Belch Blast\'');

-- Gorloc Waddler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25685;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25685);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25685, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 15000, 20000, 0, 0, 11, 50522, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorloc Waddler - In Combat - Cast \'Gorloc Stomp\'');

-- Gorloc Mud Splasher
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25699;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25699);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25699, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 15000, 20000, 0, 0, 11, 50522, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorloc Waddler - In Combat - Cast \'Gorloc Stomp\'');

-- Gorloc Dredger
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25701;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25701, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 6000, 12000, 0, 0, 11, 50520, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorloc Gibberer - In Combat - Cast \'Deep Dredge\'');

-- En'kilah Abomination
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25383;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25383);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25383, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 6000, 12000, 0, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Abomination - In Combat - Cast \'Cleave\''),
(25383, 0, 1, 0, 9, 0, 100, 0, 4000, 6000, 4000, 6000, 8, 40, 11, 50335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Abomination - Within 8-40 Range - Cast \'Scourge Hook\'');

-- En'kilah Crypt Fiend
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25386;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25386);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25386, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 11, 31600, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Crawler - In Combat - Cast \'Crypt Scarabs\'');

-- En'kilah Ghoul
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25393;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25393);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25393, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 24000, 26000, 0, 0, 11, 38056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'En\'kilah Ghoul - In Combat - Cast \'Flesh Rip\'');

-- Sentry-bot 57-K (modified old smartai)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25753;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25753) AND (`source_type` = 0) AND (`id` IN (0, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25753, 0, 0, 0, 0, 0, 100, 0, 3000, 13000, 13000, 26000, 0, 0, 11, 6668, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentry-bot 57-K - In Combat - Cast \'Red Firework\''),
(25753, 0, 4, 0, 6, 1, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46443, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sentry-bot 57-K - On Just Died - Cast \'Weakness to Lightning: Kill Credit Direct to Player\' (Phase 1)');

-- High Priest Naferset
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26076;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26076);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26076, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Naferset - On Reset - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(26076, 0, 1, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Naferset - On Respawn - Set Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(26076, 0, 2, 3, 1, 0, 100, 512, 2000, 2000, 5000, 5000, 0, 0, 19, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Naferset - Out of Combat - Remove Flags Immune To Players & Immune To NPC\'s & Not Selectable'),
(26076, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Naferset - Out of Combat - Say Line 0'),
(26076, 0, 4, 0, 0, 0, 100, 0, 3000, 5000, 20000, 25000, 0, 0, 11, 15587, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Naferset - In Combat - Cast \'Mind Blast\''),
(26076, 0, 5, 0, 2, 0, 100, 0, 0, 50, 2000, 5000, 0, 0, 11, 11640, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Naferset - Between 0-50% Health - Cast \'Renew\'');

-- Darkfallen Deathblade
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26103;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26103);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26103, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 20000, 30000, 0, 0, 11, 50668, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Deathblade - In Combat - Cast \'Death Coil\''),
(26103, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 8000, 12000, 0, 0, 11, 50349, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkfallen Deathblade - In Combat - Cast \'Icy Touch\'');

-- Heigarr the Horrible
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26266;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26266);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26266, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 5000, 20000, 0, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Heigarr the Horrible - In Combat - Cast \'Cleave\''),
(26266, 0, 1, 0, 0, 0, 100, 0, 15000, 20000, 20000, 25000, 0, 0, 11, 32588, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Heigarr the Horrible - In Combat - Cast \'Concussion Blow\'');

-- Boiling Spirit
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25419;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25419);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25419, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 25000, 30000, 0, 0, 11, 50206, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Boiling Spirit - In Combat - Cast \'Scalding Steam\'');

-- Raging Boiler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25417;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25417);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25417, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 25000, 30000, 0, 0, 11, 50207, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Boiling Spirit - In Combat - Cast \'Scalding Steam\'');

-- Enraged Tempest
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25415;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25415);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25415, 0, 0, 0, 2, 0, 100, 0, 0, 50, 0, 0, 0, 0, 11, 50420, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Tempest - Between 0-50% Health - Cast \'Enrage\''),
(25415, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 50215, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Tempest - On Just Died - Cast \'Zephyr\'');
