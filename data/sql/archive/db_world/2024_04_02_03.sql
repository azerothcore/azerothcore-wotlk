-- DB update 2024_04_02_02 -> 2024_04_02_03
--
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ashtongue_channeler', `faction` = 1692 WHERE (`entry` = 23421);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ashtongue_sorcerer' WHERE (`entry` = 23215);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23215) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '39833' WHERE (`entry` = 22841);
UPDATE `creature_template` SET `faction` = 1847 WHERE (`entry` = 23210);
UPDATE `creature_template` SET `faction` = 1813 WHERE (`entry` = 23319);

DELETE FROM `creature_text` WHERE `CreatureID` = 23191;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23191, 0, 0, 'Broken of the Ashtongue tribe, your leader speaks!', 14, 0, 100, 15, 0, 0, 21342, 0, 'Akama SAY_BROKEN_FREE_0'),
(23191, 1, 0, 'The Betrayer no longer holds sway over us.  His dark magic over the Ashtongue soul has been destroyed!', 14, 0, 100, 1, 0, 0, 21343, 0, 'Akama SAY_BROKEN_FREE_1'),
(23191, 2, 0, 'Come out from the shadows!  I\'ve returned to lead you against our true enemy!  Shed your chains and raise your weapons against your Illidari masters!', 14, 0, 100, 397, 0, 0, 21344, 0, 'Akama SAY_BROKEN_FREE_2'),
(23191, 3, 0, 'I will not last much longer!', 14, 0, 100, 0, 0, 11385, 21784, 0, 'Akama SAY_LOW_HEALTH'),
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

-- Delete leftover gobs
DELETE FROM `gameobject` WHERE `guid` IN (20523,20558,20559,20561,20563,20567) AND `map` = 564;

DELETE FROM `creature_text` WHERE `CreatureID` = 23089 AND `GroupID` IN (9, 10);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23089, 9, 0, 'Those who\'ve defiled this temple have all been defeated.  All but one!', 12, 0, 100, 1, 0, 0, 21518, 0, 'SAY_AKAMA_COUNCIL_1'),
(23089, 10, 0, 'Let us finish what we\'ve started.  I will lead you to Illidan\'s abode once you\'ve recovered your strength.', 12, 0, 100, 1, 0, 0, 21520, 0, 'SAY_AKAMA_COUNCIL_2');

DELETE FROM `waypoint_data` WHERE `id` = 230891;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `move_type`) VALUES
(230891, 1, 642.5905, 305.6287, 271.6885, 1),
(230891, 2, 660.76465, 305.76627, 271.70413, 1);

UPDATE `creature` SET `phaseMask` = 3 WHERE `guid` = 148734;
UPDATE `creature` SET `phaseMask` = 5 WHERE `guid` = 148733;

DELETE FROM `smart_scripts` WHERE `source_type` = 2 AND `entryorguid` = 4665;
INSERT INTO `smart_scripts` VALUES (4665, 2, 0, 0, 46, 0, 100, 1, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 148358, 22871, 0, 0, 0, 0, 0, 0, 'Area Trigger - On Trigger - Teron Gorefiend Talk');
