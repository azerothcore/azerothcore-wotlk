--
DELETE FROM `creature_text_option_sets` WHERE `SetID` = 8;
INSERT INTO `creature_text_option_sets` (`SetID`, `Cooldown`, `TriggerChance`, `PlayerOnly`, `comment`) VALUES
(8, 8000, 100, 1, 'Player-only kill yell: 8s cooldown');

-- Eydis Darkbane, Fjola Lightbane SAY_KILL_PLAYER
DELETE FROM `creature_text_options` WHERE `CreatureID` IN (34496, 34497) AND `GroupID` = 6;
INSERT INTO `creature_text_options` (`CreatureID`, `GroupID`, `OptionSetID`) VALUES
(34496, 6, 8),
(34497, 6, 8);
