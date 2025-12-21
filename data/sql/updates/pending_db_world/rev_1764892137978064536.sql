--
-- Brandon Eiredeck (31023) should cower and say "Please, I'm just a delivery man!"
-- Agitated Stratholme Citizens (31126) near Brandon should chastise him about the grain
--
DELETE FROM `creature_text` WHERE `CreatureID` = 31023;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(31023, 0, 0, 'Please, I''m just a delivery man!', 12, 0, 100, 431, 0, 0, 32044, 0, 'Brandon Eiredeck - Ambient');

-- Add group 3 for the Brandon Eiredeck crowd (different from Barthilas crowd)
DELETE FROM `creature_text` WHERE `CreatureID` = 31126 AND `GroupID` = 3;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(31126, 3, 0, 'I think it''s your grain that''s making us sick!', 12, 0, 100, 5, 0, 0, 32032, 0, 'Agitated Stratholme Citizen - Brandon Crowd'),
(31126, 3, 1, 'We were fine until we ate from this tainted grain of yours!', 12, 0, 100, 5, 0, 0, 32035, 0, 'Agitated Stratholme Citizen - Brandon Crowd');

-- Enable SmartAI for Brandon Eiredeck
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31023;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 31023 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31023, 0, 0, 0, 1, 0, 100, 0, 5000, 15000, 15000, 25000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brandon Eiredeck - OOC - Say Line 0'),
(31023, 0, 1, 0, 1, 0, 100, 0, 0, 0, 3000, 3000, 0, 0, 17, 431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brandon Eiredeck - OOC - Set Emote State Cower');
