-- DB update 2022_06_14_04 -> 2022_06_14_05
--
DELETE FROM `creature_text` WHERE `CreatureID`=15111 AND `GroupID` IN (0,1);
INSERT INTO `creature_text` (`CreatureID`, `ID`, `Text`, `Type`, `Probability`, `BroadcastTextId`) VALUES 
(15111, 0, 'I gonna make you into mojo!', 12, 100, 10435),
(15111, 1, 'Troll mojo da strongest mojo!', 12, 100, 10437);

DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 15111) AND (`Index` IN (0, 1));
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(15111, 0, 24611, 0),
(15111, 1, 24612, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15111;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15111) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15111, 0, 3, 0, 4, 0, 15, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mad Servant - On Aggro - Say Line GroupID 0');
