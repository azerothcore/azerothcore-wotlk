-- DB update 2023_02_12_03 -> 2023_02_12_04
--
DELETE FROM `creature_text` WHERE `CreatureID`=18405;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Probability`, `Emote`, `BroadcastTextId`, `comment`) VALUES
(18405, 0, 0, 'Protect the Botanica at all costs!', 14, 100, 0, 16784, 'Tempest-Forge Peacekeeper'),
(18405, 0, 1, 'Any intruders must be eliminated!', 14, 100, 0, 16785, 'Tempest-Forge Peacekeeper');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -147039) AND (`source_type` = 0) AND (`id` IN (1003));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-147039, 0, 1003, 0, 1, 0, 100, 0, 450000, 600000, 450000, 600000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - Out of Combat - Say Line 0');
