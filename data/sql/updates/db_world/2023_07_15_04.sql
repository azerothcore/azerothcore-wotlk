-- DB update 2023_07_15_03 -> 2023_07_15_04
--
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_anzu_spirit' WHERE (`entry` IN (23134, 23135, 23136));

DELETE FROM `creature_template_addon` WHERE (`entry` IN (23134, 23135, 23136));
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES
(23134, '40250'),
(23135, '40250'),
(23136, '40250');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23136) AND (`source_type` = 0);

DELETE FROM `creature_text` WHERE `CreatureID` IN (23134, 23135, 23136);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23134, 0, 0, '%s returns to stone.', 16, 0, 100, 0, 0, 0, 20980, 0, 'Hawk Spirit'),
(23135, 0, 0, '%s returns to stone.', 16, 0, 100, 0, 0, 0, 20980, 0, 'Falcon Spirit'),
(23136, 0, 0, '%s returns to stone.', 16, 0, 100, 0, 0, 0, 20980, 0, 'Eagle Spirit');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` IN (40240, 40237, 40241));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 40240, 0, 0, 31, 0, 3, 23035, 0, 0, 0, 0, '', 'Spite of the Eagle (40240) only targets Anzu (23035)'),
(13, 1, 40237, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Protection of the Hawk (40237) only targets Players'),
(13, 1, 40241, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Speed of the Falcon (40241) only targets Players');

-- Hack: Add PLAYER_CONTROLLED to allow for players to heal them. Flag 64 is sniffed, though
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|64|8 WHERE (`entry` IN (23134, 23135, 23136));
