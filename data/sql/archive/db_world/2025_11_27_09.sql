-- DB update 2025_11_27_08 -> 2025_11_27_09
-- Update SAI Comments (Image of Megalith)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24381;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24381);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24381, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2438100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Megalith - On Just Summoned - Run Script');

-- Update Action List (Image of Megalith)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2438100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2438100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24385, 7, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2410.14, -5727.26, 270.986, 4.28769, 'Image of Megalith - Actionlist - Summon Creature \'Image of Stone Giant\''),
(2438100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24385, 7, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2414.86, -5729.5, 272.095, 3.98296, 'Image of Megalith - Actionlist - Summon Creature \'Image of Stone Giant\''),
(2438100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24385, 7, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2417.34, -5733.23, 273.029, 3.60361, 'Image of Megalith - Actionlist - Summon Creature \'Image of Stone Giant\''),
(2438100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24385, 7, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2419.4, -5738.03, 274.121, 3.24154, 'Image of Megalith - Actionlist - Summon Creature \'Image of Stone Giant\''),
(2438100, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Megalith - Actionlist - Say Line 0'),
(2438100, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Megalith - Actionlist - Say Line 1'),
(2438100, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Megalith - Actionlist - Say Line 2'),
(2438100, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 223, 45, 0, 0, 0, 0, 0, 204, 24385, 0, 0, 0, 0, 0, 0, 0, 'Image of Megalith - Actionlist - Do Action ID 45'), -- Action Changed with do action / target summoned creatures
(2438100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43693, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Image of Megalith - Actionlist - Cast \'Image of Megalith Kill Credit\''),
(2438100, 9, 9, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Megalith - Actionlist - Say Line 3'),
(2438100, 9, 10, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Megalith - Actionlist - Despawn Instant');

-- Add SAI (Image of Stone Giant)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24385;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24385);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24385, 0, 0, 0, 72, 0, 100, 0, 45, 0, 0, 0, 0, 0, 80, 2438500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Stone Giant - On Action 45 Done - Run Script'); -- Added this event.

-- Update Action List comments (Image of Stone Giant)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2438500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2438500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Stone Giant - Actionlist - Set Run Off'),
(2438500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2515.45, -5670.36, 298.778, 0.618311, 'Image of Stone Giant - Actionlist - Move To Position'),
(2438500, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Stone Giant - Actionlist - Despawn Instant');
