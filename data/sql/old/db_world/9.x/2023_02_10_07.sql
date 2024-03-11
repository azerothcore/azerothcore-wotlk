-- DB update 2023_02_10_06 -> 2023_02_10_07
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (24029);


DELETE FROM `smart_scripts` WHERE `entryorguid` = 24029 AND `id` IN (0,1,2,3,4,5); -- Wyrmcaller Vile
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 

(24029, 0, 0, 0, 1, 0, 100, 513, 0, 0, 3000, 3000, 0, 11, 43576, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcaller Vile - OOC - Cast \'Frost Power\''),
(24029, 0, 1, 0, 0, 0, 100, 0, 0, 0, 4000, 4000, 0, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcaller Vile - IC - Cast \'Frostbolt\''),
(24029, 0, 2, 0, 0, 0, 100, 0, 0, 0, 6000, 10000, 0, 11, 15532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcaller Vile - IC - Cast \'Frost Nova\''),
(24029, 0, 3, 0, 1, 0, 100, 512, 0, 0, 3000, 3000, 0, 45, 0, 1, 0, 0, 0, 0, 19, 23033, 10, 0, 0, 0, 0, 0, 0, 'Wyrmcaller Vile - OOC - Cast \'Set Data\''),
(24029, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcaller Vile - On Aggro - Say Line 0'),
(24029, 0, 5, 0, 23, 0, 100, 0, 12544, 0, 3000, 3000, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmcaller Vile - On missing aura - Cast Frost Armor');

DELETE FROM `creature_text` WHERE `CreatureID`=24029 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(24029, 0, 0, 'Did you really think that by facing me, you have any hope of saving your friends?', 12, 0, 100, 0, 0, 0, 23696, 0, 'Wyrmcaller Vile');
