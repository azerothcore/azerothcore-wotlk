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
(@PATH,5,1653.3759,-5971.8735,132.25667,0,0,1,0,100,0),
(@PATH,6,1685.0416,-5887.038,116.1461,0,0,1,0,100,0);

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
(28912, 8, 0, 'The death of the High Inquisitor of New Avalon will not go unnoticed. You need to get out of here at once! Go, before more of them show up. I\'ll be fine on my own.', 12, 0, 100, 0, 0, 0, 29239, 0, 'koltira deathweaver'),
(28912, 9, 0, 'I\'ll draw their fire, you make your escape behind me.', 12, 0, 100, 0, 0, 0, 29240, 0, 'koltira deathweaver'),
(28912, 10, 0, 'Your High Inquisitor is nothing more than a pile of meat, Crusaders! There are none beyond the grasp of the Scourge!', 14, 0, 100, 0, 0, 0, 29241, 0, 'koltira deathweaver'),
(28912, 11, 0, '%s collapses to the ground.', 41, 0, 100, 0, 0, 0, 29230, 0, 'koltira deathweaver');