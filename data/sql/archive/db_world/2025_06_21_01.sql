-- DB update 2025_06_21_00 -> 2025_06_21_01
--
-- Pathing for  Entry: 29007
SET @NPC := 29007;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1649.966,-6042.5713,127.57849,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0000465DB5 .go xyz 1649.966 -6042.5713 127.57849

-- Pathing for  Entry: 29007
SET @NPC := 29008;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1649.966,-6042.5713,127.57849,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0000465DD2 .go xyz 1649.966 -6042.5713 127.57849

-- Pathing for  Entry: 29007
SET @NPC := 29009;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1649.966,-6042.5713,127.57849,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0000465DE7 .go xyz 1649.966 -6042.5713 127.57849

-- Pathing for  Entry: 29007
SET @NPC := 29010;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1640.7407,-6032.02,134.73505,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0000C65DB5 .go xyz 1640.7407 -6032.02 134.73505

-- Pathing for  Entry: 29007
SET @NPC := 29011;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1640.7958,-6030.307,134.73505,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0000C65DD2 .go xyz 1640.7958 -6030.307 134.73505

-- Pathing for  Entry: 29007
SET @NPC := 29012;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1646.2389,-6032.526,134.73506,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0000C65DE7 .go xyz 1646.2389 -6032.526 134.73506

-- Pathing for  Entry: 29007
SET @NPC := 29013;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1640.6724,-6032.0527,134.73506,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0001465DB5 .go xyz 1640.6724 -6032.0527 134.73506

-- Pathing for  Entry: 29007
SET @NPC := 29014;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1638.7998,-6036.4976,132.57643,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0001465DD2 .go xyz 1638.7998 -6036.4976 132.57643

-- Pathing for  Entry: 29007
SET @NPC := 29015;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1638.2631,-6030.1514,134.73505,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0001465DE7 .go xyz 1638.2631 -6030.1514 134.73505

-- Pathing for  Entry: 29007
SET @NPC := 29016;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1642.4694,-6029.949,134.73505,0,0,1,0,100,0);
-- 0x202F2C4C201C53C000084E0001C65DE7 .go xyz 1642.4694 -6029.949 134.73505

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29007;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29007) AND (`source_type` = 0) AND (`id` IN (1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29007, 0, 1, 0, 0, 0, 100, 0, 1000, 4000, 4000, 6000, 0, 0, 11, 15498, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Acolyte - In Combat - Cast \'Holy Smite\''),
(29007, 0, 2, 0, 0, 0, 100, 0, 6000, 9000, 25000, 30000, 0, 0, 11, 19725, 64, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Acolyte - In Combat - Cast \'Turn Undead\''),
(29007, 0, 3, 4, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crimson Acolyte - On Path 0 Finished - Remove Flags Immune To Players'),
(29007, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 9, 0, 0, 50, 0, 0, 0, 0, 0, 'Crimson Acolyte - On Path 0 Finished - Set In Combat With Zone');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|256 WHERE `entry` = 29007;

-- Pathing for  Entry: 29001
SET @NPC := 29001;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1648.3103,-6043.6396,127.57861,0,0,1,0,100,0);

DELETE FROM `script_waypoint` WHERE `entry` = 28912;

SET @NPC := 28912;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1653.36,-6038.34,127.584,0,0,0,0,100,0),
(@PATH,2,1653.7653,-6035.075,127.5844,1.596199,5000,0,0,100,0),
(@PATH,3,1651.8898,-6037.1006,127.5844,0,0,0,0,100,0),
(@PATH,4,1651.8898,-6037.1006,127.5844,3.839724302291870117,0,0,0,100,0);

SET @PATH := (@NPC + 1) * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1653.3759,-5971.8735,132.25667,0,0,1,0,100,0),
(@PATH,2,1685.0416,-5887.038,116.1461,0,0,1,0,100,0);

DELETE FROM `creature_text` WHERE `CreatureID` = 28912;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28912, 0, 0, 'Damn the Crusade! I think my ribs are broken and I might be bleeding internally.', 12, 0, 100, 0, 0, 0, 29197, 0, 'koltira deathweaver'),
(28912, 1, 0, 'I\'ll need to get my runeblade and armor... Just need a little more time.', 12, 0, 100, 0, 0, 0, 29201, 0, 'koltira deathweaver'),
(28912, 2, 0, 'I\'m still weak, but I think I can get an anti-magic barrier up. Stay inside it or you\'ll be destroyed by their spells.', 12, 0, 100, 0, 0, 0, 29203, 0, 'koltira deathweaver'),
(28912, 3, 0, 'Maintaining this barrier will require all of my concentration. Kill them all!', 12, 0, 100, 0, 0, 0, 29205, 0, 'koltira deathweaver'),
(28912, 4, 0, 'There are more coming. Defend yourself! Don\'t fall out of the anti-magic field! They\'ll tear you apart without its protection!', 12, 0, 100, 0, 0, 0, 29207, 0, 'koltira deathweaver'),
(28912, 5, 0, 'I can\'t keep this barrier up much longer... Where is that coward?', 12, 0, 100, 0, 0, 0, 29208, 0, 'koltira deathweaver'),
(28912, 6, 0, 'The High Inquisitor comes! Be ready, death knight! Do not let him draw you out of the protective bounds of my anti-magic field! Kill him and take his head!', 12, 0, 100, 0, 0, 0, 29210, 0, 'koltira deathweaver'),
(28912, 7, 0, 'Stay in the anti-magic field! Make them come to you!', 12, 0, 100, 0, 0, 0, 29225, 0, 'koltira deathweaver'),
(28912, 8, 0, 'The death of the High Inquisitor of New Avalon will not go unnoticed. You need to get out of here at once! Go, before more of them show up. I\'ll be fine on my own.', 12, 0, 100, 1, 0, 0, 29239, 0, 'koltira deathweaver'),
(28912, 9, 0, 'I\'ll draw their fire, you make your escape behind me.', 12, 0, 100, 1, 0, 0, 29240, 0, 'koltira deathweaver'),
(28912, 10, 0, 'Your High Inquisitor is nothing more than a pile of meat, Crusaders! There are none beyond the grasp of the Scourge!', 14, 0, 100, 5, 0, 0, 29241, 0, 'koltira deathweaver'),
(28912, 11, 0, '%s collapses to the ground.', 41, 0, 100, 0, 0, 0, 29230, 0, 'koltira deathweaver');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 29001;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29001) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29001, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 1000, 3000, 0, 0, 11, 52926, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Valroth - In Combat - Cast \'Valroth`s Smite\''),
(29001, 0, 1, 0, 2, 0, 100, 0, 0, 50, 0, 0, 0, 0, 11, 38210, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Valroth - Between 0-50% Health - Cast \'Renew\''),
(29001, 0, 2, 3, 0, 0, 100, 0, 2000, 7000, 2000, 7000, 0, 0, 11, 52922, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Valroth - In Combat - Cast \'The Inquisitor`s Penance\''),
(29001, 0, 3, 0, 61, 0, 50, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Valroth - In Combat - Say Line 2'),
(29001, 0, 4, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Valroth - On Path 0 Finished - Remove Flags Immune To Players'),
(29001, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Valroth - On Just Died - Cast \'Summon Valroth`s Remains\''),
(29001, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Valroth - On Just Died - Say Line 3'),
(29001, 0, 7, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Valroth - On Aggro - Say Line 6');

DELETE FROM `creature_text` WHERE `CreatureID` = 29001;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29001, 0, 0, 'The Crusade will purge your kind from this world!', 14, 0, 100, 0, 0, 0, 29215, 0, 'high inquisitor valroth'),
(29001, 1, 0, 'It seems that I\'ll need to deal with you myself. The High Inquisitor comes for you, Scourge!', 14, 0, 100, 0, 0, 0, 29216, 0, 'high inquisitor valroth'),
(29001, 2, 0, 'You have come seeking deliverance? I have come to deliver!', 12, 0, 100, 0, 0, 0, 29222, 0, 'high inquisitor valroth'),
(29001, 2, 1, 'LIGHT PURGE YOU!', 12, 0, 100, 0, 0, 0, 29221, 0, 'high inquisitor'),
(29001, 2, 2, 'Coward!', 12, 0, 100, 0, 0, 0, 30699, 0, 'high inquisitor valroth'),
(29001, 3, 0, '%s\'s remains fall to the ground.', 41, 0, 100, 0, 0, 0, 29223, 0, 'high inquisitor'),
(29001, 4, 0, 'Acolytes, chain them all up! Prepare them for questioning!', 14, 0, 100, 0, 0, 0, 29202, 0, 'high inquisitor'),
(29001, 5, 0, 'Scourge filth! By the Light be cleansed!', 14, 0, 100, 0, 0, 0, 29214, 0, 'high inquisitor'),
(29001, 6, 0, 'Your dark Scourge magic won\'t protect you from the Light!', 12, 0, 100, 0, 0, 0, 29218, 0, 'high inquisitor');

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 9762;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`) VALUES
(9762, 0, 0, 'Koltira, let\'s get out of here!', 29243, 1, 1, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9762) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12727) AND (`ConditionValue2` = 8) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9762, 0, 0, 0, 47, 0, 12727, 8, 0, 0, 0, 0, '', 'Only show Koltira gossip if player has quest Bloody Breakout incomplete');

UPDATE `creature_addon` SET `auras` = '' WHERE `guid` IN (130354, 129716);
