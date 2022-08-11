-- DB update 2022_05_17_04 -> 2022_05_17_05
-- Gossips where already on the database, just not linked to each other
DELETE FROM `gossip_menu` WHERE `MenuID` IN (5812, 5813, 5814, 5815, 5816);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES 
(5812, 6985),
(5813, 6986),
(5814, 6987),
(5815, 6988),
(5816, 6989);

-- Conditions to display the first gossip menu option
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 5812) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ConditionTypeOrReference` IN (2, 47));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 5812, 0, 0, 5, 2, 0, 18563, 1, 0, 0, 0, 0, '', 'If player has \'Bindings of the Windseeker\' Left half in inventory'),
(15, 5812, 0, 0, 4, 2, 0, 18563, 1, 1, 0, 0, 0, '', 'If player has \'Bindings of the Windseeker\' Left half in bank'),
(15, 5812, 0, 0, 2, 2, 0, 18563, 1, 0, 0, 0, 0, '', 'If player has \'Bindings of the Windseeker\' Left half in inventory'),
(15, 5812, 0, 0, 3, 2, 0, 18564, 1, 1, 0, 0, 0, '', 'If player has \'Bindings of the Windseeker\' Left half in bank'),
(15, 5812, 0, 0, 1, 47, 0, 7786, 74, 0, 0, 0, 0, '', 'If player has quest \'Thunderaan the Windseeker\'');

UPDATE `creature_template` SET `gossip_menu_id` = 5812, `npcflag` = 3 WHERE (`entry` = 14348);
