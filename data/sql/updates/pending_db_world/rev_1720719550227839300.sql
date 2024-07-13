-- Time-Lost Skettis High Priest
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '37411 37816 37509 33900' WHERE (`entry` = 21787);

-- Nothing to override from template_addon
DELETE FROM `creature_addon` WHERE (`guid` IN (132574, 132575, 132576, 132577, 132578, 132579, 132580, 132581, 132582, 132583, 132584, 132585, 132586, 132587, 132588, 132589, 132590, 132591, 132592, 132593, 132594, 132595, 132596, 132597, 132598, 132599, 132600, 132601, 132602, 132603, 132604, 132605, 132606, 132607, 132608));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21787);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21787, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 7000, 16000, 0, 0, 11, 11639, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - In Combat - Cast \'Shadow Word: Pain\''),
(21787, 0, 1, 0, 0, 0, 100, 0, 2300, 3000, 8000, 12000, 0, 0, 11, 9734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - In Combat - Cast \'Holy Smite\''),
(21787, 0, 2, 0, 74, 0, 100, 0, 0, 0, 10000, 15000, 40, 40, 11, 42420, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - On Friendly Below 40% Health - Cast \'Flash Heal\'');

-- Talonpriest Ishaal (+duplicate)
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '11919 37411 37509 37816' WHERE (`entry` = 23066);
DELETE FROM `creature_addon` WHERE (`guid` = 132571);
DELETE FROM `creature` WHERE `guid`=132571 AND `id1` = 23066;

-- Talonpriest Skizzik, no sheath state
UPDATE `creature_template_addon` SET `auras` = '37411 37509 37816' WHERE (`entry` = 23067);

-- Talonpriest Skizzik (+duplicate)
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '37411 37509 37816' WHERE (`entry` = 23068);
DELETE FROM `creature_addon` WHERE (`guid` = 132610);
DELETE FROM `creature` WHERE `guid` = 132610 AND `id1` = 23068;
