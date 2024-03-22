--
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ashtongue_channeler', `faction` = 1692 WHERE (`entry` = 23421);
UPDATE `creature_template_addon` SET `auras` = '39833' WHERE (`entry` = 22841);
UPDATE `creature_template` SET `faction` = 1847 WHERE (`entry` = 23210);
UPDATE `creature_template` SET `faction` = 1813 WHERE (`entry` = 23319);

DELETE FROM `creature_text` WHERE `CreatureID` = 23191;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23191, 0, 0, 'Broken of the Ashtongue tribe, your leader speaks!', 14, 0, 100, 15, 0, 0, 21342, 0, 'Akama SAY_BROKEN_FREE_0');
(23191, 1, 0, 'The Betrayer no longer holds sway over us.  His dark magic over the Ashtongue soul has been destroyed!', 14, 0, 100, 1, 0, 0, 21343, 0, 'Akama SAY_BROKEN_FREE_1');
(23191, 2, 0, 'Come out from the shadows!  I\'ve returned to lead you against our true enemy!  Shed your chains and raise your weapons against your Illidari masters!', 14, 0, 100, 397, 0, 0, 21344, 0, 'Akama SAY_BROKEN_FREE_2');
(23191, 3, 0, 'I will not last much longer!', 14, 0, 100, 0, 0, 11385, 21784, 0, 'Akama SAY_LOW_HEALTH');
(23191, 4, 0, 'No! Not yet!', 14, 0, 100, 0, 0, 11386, 21785, 0, 'Akama SAY_DEAD');

UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id1` = 23191 AND `map` = 564;

DELETE FROM `creature_formations` WHERE `leaderGUID` = 148236;
INSERT INTO `creature_formations` (`memberGUID`, `leaderGUID`, `groupAI`) VALUES
(148236, 148236, 24),
(148237, 148236, 24),
(148238, 148236, 24),
(148239, 148236, 24),
(148240, 148236, 24),
(148241, 148236, 24),
(148242, 148236, 24);
