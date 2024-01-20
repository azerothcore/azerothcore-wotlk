-- DB update 2023_08_19_01 -> 2023_08_19_02
--
SET @GEVENT := 46;
SET @CGUID := 152340;

DELETE FROM `game_event` WHERE `eventEntry` = @GEVENT;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(@GEVENT, '2008-09-08 12:00:00', '2008-09-24 12:00:00', 1051897, 23040 , 0, 0, 'Spirit of Competition', 0, 2);

UPDATE `creature_template` SET `gossip_menu_id` = 9517, `npcflag` = 1 WHERE `entry` = 27399;

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 9517 AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`) VALUES
(9517, 0, 0, 'I would like to enter the secret code to receive my Competitor''s Souvenir.', 26513, 1, 1);

DELETE FROM `creature` WHERE `id1` IN (27346, 27398, 27399);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@CGUID, 27398, 0, 0, 0, 1537, 1537, 0, 1, 0, -5040.92, -1250.81, 507.76, 0.70, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0), -- Grandhammer
(@CGUID+1, 27346, 0, 0, 0, 1537, 1537, 0, 1, 0, -5041.91, -1250.2, 507.76, 1.37, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0), -- IF Dragon
(@CGUID+2, 27399, 0, 0, 1, 1637, 1637, 0, 1, 0, 1964.39, -4798.77, 56.99, 0.08, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0), -- Muja
(@CGUID+3, 27346, 0, 0, 1, 1637, 1637, 0, 1, 0, 1963.26, -4797.62, 56.99, 0.72, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0); -- Org Dragon
-- Positions based on screenshots.
DELETE FROM `game_event_creature` WHERE `eventEntry` = @GEVENT;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@GEVENT, @CGUID),
(@GEVENT, @CGUID+1),
(@GEVENT, @CGUID+2),
(@GEVENT, @CGUID+3),

-- Goblin Commoneers
(@GEVENT, 724),
(@GEVENT, 725),
(@GEVENT, 726),
(@GEVENT, 727),
(@GEVENT, 91115),
(@GEVENT, 91116),
(@GEVENT, 91117),
(@GEVENT, 91118),
(@GEVENT, 91579),
(@GEVENT, 91580),
(@GEVENT, 91752),
(@GEVENT, 91753),
(@GEVENT, 91754),
(@GEVENT, 91756),
(@GEVENT, 91757),
(@GEVENT, 91758),
(@GEVENT, 91759),
(@GEVENT, 91760),
(@GEVENT, 91761),
(@GEVENT, 91762),
(@GEVENT, 91766),
(@GEVENT, 91767),
(@GEVENT, 91768),
(@GEVENT, 91769),
(@GEVENT, 91770),
(@GEVENT, 91771),
(@GEVENT, 91801),
(@GEVENT, 240327),
(@GEVENT, 240328),
(@GEVENT, 240329),
(@GEVENT, 240330),
(@GEVENT, 240331),
(@GEVENT, 240332),
(@GEVENT, 240333),
(@GEVENT, 240334),
(@GEVENT, 240335),
(@GEVENT, 240336),
(@GEVENT, 240337),
(@GEVENT, 240338);

DELETE FROM `creature_text` WHERE `CreatureID` = 20102 AND `GroupID` = 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `BroadcastTextId`) VALUES
(20102, 1, 1, 'The Spirits of Competition have grown strong again.', 12, 0, 100, 26564);

DELETE FROM `smart_scripts` WHERE `entryorguid`=20102 AND `source_type`=0 AND `id`=1 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20102, 0, 1, 0, 1, 0, 100, 0, 3000, 15000, 45000, 90000, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goblin Commoner - OOC - Say');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=2 AND `SourceEntry`=20102 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=12 AND `ConditionTarget`=1 AND `ConditionValue1`=46 AND `ConditionValue2`=0 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 20102, 0, 0, 12, 1, 46, 0, 0, 0, 0, 0, '', 'Commoner - Spirit of Competition must be active');

DELETE FROM `gossip_menu` WHERE `MenuID` = 10248 AND `TextID` IN (12819);
DELETE FROM `gossip_menu` WHERE `MenuID` = 90000 AND `TextID` IN (12820);
DELETE FROM `gossip_menu` WHERE `MenuID` = 90001 AND `TextID` IN (12821);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(10248, 12819),
(90000, 12820),
(90001, 12821);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=10248 AND `SourceEntry`=12819 AND `ConditionTypeOrReference`=12 AND `ConditionTarget`=0 AND `ConditionValue1`=46;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10248 AND `SourceEntry` IN (0,1) AND `ConditionTypeOrReference`=12 AND `ConditionValue1`=46;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 10248, 12819, 0, 0, 12, 0, 46, 0, 0, 0, 0, 0, '', 'Show gossip text if event 46 is active'),
(15, 10248, 0, 0, 0, 12, 0, 46, 0, 0, 0, 0, 0, '', 'Show gossip option if event 46 is active'),
(15, 10248, 1, 0, 0, 12, 0, 46, 0, 0, 0, 0, 0, '', 'Show gossip option if event 46 is active');

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 10248 AND `OptionID` IN (0,1);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`) VALUES
(10248, 0, 0, 'How do I earn a Competitor''s Tabard?', 26508, 1, 1, 90000),
(10248, 1, 0, 'How can I gain the favor of a Spirit of Competition?', 26509, 1, 1, 90001);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (48163,48164);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(48163,'spell_gen_spirit_of_competition_participant'),
(48164,'spell_gen_spirit_of_competition_winner');
