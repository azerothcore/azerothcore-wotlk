-- DB update 2025_12_19_00 -> 2025_12_19_01

-- Remove ScriptName from Mistwhisper Treasure
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE (`entry` = 190578);

-- Set Unit Flags (Zeptek the Destroyer & Warlord Tartek)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |256|512|32768 WHERE (`entry` IN (28105, 28399));

-- Set Right Faction (Warlord Tartek)
UPDATE `creature_template` SET `faction` = 2061 WHERE (`entry` = 28105);

-- Set Vehicle accessory (Zeptek the Destroyer)
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 28399;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(28399, 28105, 0, 0, 'Zeptek the Destroyer', 7, 0);

-- Set spellclick (Zeptek the Destroyer)
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 28399;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(28399, 46598, 1, 0);

-- Update SAI (pearborn Encampment Bunny)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28457;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28457);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28457, 0, 0, 0, 10, 0, 100, 512, 1, 200, 10000, 10000, 0, 0, 11, 51642, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Spearborn Encampment Bunny - Within 1-200 Range Out of Combat LoS - Cast \'Spearborn Encampment Aura\''),
(28457, 0, 1, 2, 38, 0, 100, 512, 1, 1, 300000, 300000, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spearborn Encampment Bunny - On Data Set 1 1 - Set Data 1 0'),
(28457, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 28399, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 6710.42, 5162.31, -20.7284, 4.79058, 'Spearborn Encampment Bunny - On Data Set 1 1 - Summon Creature \'Zeptek the Destroyer\'');

-- Update SAI (Zeptek the Destroyer)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28399;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28399);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28399, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 24, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6712.46, 5136.46, -19.4286, 0, 'Zeptek the Destroyer - On Respawn - Move To Position'),
(28399, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 24, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6712.46, 5136.46, -19.4286, 0, 'Zeptek the Destroyer - On Respawn - Set Home Position'),
(28399, 0, 2, 0, 34, 0, 100, 0, 8, 24, 0, 0, 0, 0, 223, 47, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 'Zeptek the Destroyer - On Reached Point 24 - Do Action ID 47');

-- Update SAI (Warlord Tartek)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28105;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28105);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28105, 0, 0, 0, 60, 0, 100, 513, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Tartek - On Update - Say Line 0 (No Repeat)'),
(28105, 0, 1, 0, 72, 0, 100, 0, 47, 0, 0, 0, 0, 0, 80, 2810500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Tartek - On Action 47 Done - Run Script'),
(28105, 0, 2, 0, 9, 0, 100, 0, 5000, 8000, 5000, 8000, 0, 5, 11, 29426, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Tartek - Within 0-5 Range - Cast \'Heroic Strike\''),
(28105, 0, 3, 0, 0, 0, 100, 0, 5000, 15000, 5000, 15000, 0, 0, 11, 35429, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Tartek - In Combat - Cast \'Sweeping Strikes\''),
(28105, 0, 4, 0, 0, 0, 100, 0, 6000, 15000, 6000, 15000, 0, 0, 11, 15572, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Tartek - In Combat - Cast \'Sunder Armor\''),
(28105, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 28121, 0, 50, 0, 0, 0, 0, 0, 'Warlord Tartek - On Just Died - Set Data 1 1'),
(28105, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12575, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Tartek - On Just Died - Quest Credit \'The Lost Mistwhisper Treasure\'');

-- Set Action List (Warlord Tartek)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2810500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2810500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6707.92, 5130.93, -19.3989, 4.86164, 'Warlord Tartek - Actionlist - Set Home Position'),
(2810500, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Tartek - Actionlist - Exit vehicle'),
(2810500, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Tartek - Actionlist - Say Line 1'),
(2810500, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 9, 28399, 0, 10, 0, 0, 0, 0, 0, 'Warlord Tartek - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2810500, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Tartek - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s');
