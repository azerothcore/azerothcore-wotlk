-- Kraz = 24024/24444
-- Tanzar = 23790/24442
-- Harkor = 23999/24443
-- Ashli = 24001/24441

SET @GUID := 100396;

DELETE FROM `creature` WHERE `id1` IN (24024, 24444, 23790, 24442, 23999, 24443, 24001, 24441);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@GUID+0, 24024, 0, 0, 568, 0, 0, 1, 1, 0, -73.82075,  1164.7422, 5.2878876, 4.590215682983398437, 7200, 0, 0, 5624, 0, 0, 0, 0, 0, '', 53788, 1, NULL), -- Kraz
(@GUID+1, 23790, 0, 0, 568, 0, 0, 1, 1, 0, -147.69608, 1333.2717, 48.25721,  0.820304751396179199, 7200, 0, 0, 4890, 0, 0, 0, 0, 0, '', 53788, 1, NULL), -- Tanzar
(@GUID+2, 23999, 0, 0, 568, 0, 0, 1, 1, 0, 296.2255,   1468.3542, 81.589294, 5.375614166259765625, 7200, 0, 0, 4890, 0, 0, 0, 0, 0, '', 53788, 1, NULL), -- Harkor
(@GUID+3, 24001, 0, 0, 568, 0, 0, 1, 1, 0, 383.77628,  1082.9733, 6.0476613, 1.588249564170837402, 7200, 0, 0, 3260, 0, 0, 0, 0, 0, '', 53788, 1, NULL); -- Ashli

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` IN (24024, 23790, 23999, 24001);

DELETE FROM `gossip_menu` WHERE `MenuID` = 8924;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8924, 11882);

DELETE FROM `npc_text` WHERE `ID` = 11882;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(11882, 'This place reeks of death, stranger.$b$bYou must leave before you fill a cage like Kraz.', '', 23088, 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 53788);

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (8799, 8924, 8927, 8876, 8883);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8799, 0, 0, 'Nalorakk is dead, you''re free to go.',                 23015, 1, 1, 0, 0, 0, 0, '', 0, 53788),
(8924, 0, 0, 'We''ve killed your captors, Kraz. You''re free to go.', 0,     1, 1, 0, 0, 0, 0, '', 0, 53788), -- 23090 is BCT, likely changed with Cata.
(8927, 0, 0, 'It''s safe, little gnome. You can come out now.',       23154, 1, 1, 0, 0, 0, 0, '', 0, 53788),

(8876, 0, 0, 'How''d a perky little gnome like you get caught up in a mess like this?', 22612, 1, 1, 0, 0, 0, 0, '', 0, 53788),
(8883, 0, 0, 'What happened to you, orc?',                                              22631, 1, 1, 0, 0, 0, 0, '', 0, 53788);
