-- DB update 2025_12_17_02 -> 2025_12_17_03
-- Lykul Wasp
DELETE FROM `creature_template_model` WHERE (`CreatureID` = 17732);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(17732, 0, 18722, 1, 1, 51831),
(17732, 1, 6633, 1, 0, 51831),
(17732, 2, 7350, 1, 0, 51831),
(17732, 3, 11091, 1, 0, 51831);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17732) AND (`source_type` = 0) AND (`id` IN (3));

-- Underbog Lord
DELETE FROM `creature_template_model` WHERE (`CreatureID` = 17734);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(17734, 0, 17758, 1, 1, 51831),
(17734, 1, 12293, 1, 0, 51831);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17734) AND (`source_type` = 0) AND (`id` IN (3));

-- Lykul Stinger
DELETE FROM `creature_template_model` WHERE (`CreatureID` = 19632);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(19632, 0, 19367, 1, 1, 51831),
(19632, 1, 6633, 1, 0, 51831),
(19632, 2, 7350, 1, 0, 51831),
(19632, 3, 11091, 1, 0, 51831);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19632) AND (`source_type` = 0) AND (`id` IN (2));

-- Behemothon, King of the Colossi
DELETE FROM `creature_template_model` WHERE `CreatureID` = 22054;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(22054, 0, 20261, 1, 0, 51831),
(22054, 1, 20577, 1, 1, 51831);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22054);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22054, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Behemothon, King of the Colossi - On Respawn - Set Active On'),
(22054, 0, 1, 0, 38, 0, 100, 0, 1, 1, 60000, 60000, 0, 0, 80, 2205400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Behemothon, King of the Colossi - On Data Set 1 1 - Run Script');
