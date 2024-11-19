-- DB update 2023_09_25_03 -> 2023_09_25_04
--
DELETE FROM `creature_text` WHERE `CreatureId` = 15689;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15689, 0, 0, '%s goes into a nether-fed rage!', 41, 0, 100, 19877, 3, 'Netherspite EMOTE_PHASE_BANISH'),
(15689, 1, 0, '%s cries out in withdrawal, opening gates to the nether.', 41, 0, 100, 19880, 3, 'Netherspite EMOTE_PHASE_PORTAL');
