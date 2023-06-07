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
