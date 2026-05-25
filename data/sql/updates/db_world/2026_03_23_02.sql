-- DB update 2026_03_23_01 -> 2026_03_23_02
-- Convert npc_slim (entry 19679) from C++ script to database gossip + conditions

-- Remove ScriptName from creature_template
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 19679;

-- Add gossip_menu entry for non-friendly text (9895)
DELETE FROM `gossip_menu` WHERE `MenuID` = 8021 AND `TextID` = 9895;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (8021, 9895);

-- Add conditions for gossip_menu text display
-- Show text 9896 (vendor greeting) only if player is Friendly+ with Consortium (faction 933)
-- Friendly(16) + Honored(32) + Revered(64) + Exalted(128) = 240
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 8021 AND `SourceEntry` IN (9895, 9896);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8021, 9896, 0, 0, 5, 0, 933, 240, 0, 0, 0, 0, '', 'Gossip Menu 8021 - Show text 9896 if player is Friendly+ with Consortium'),
(14, 8021, 9895, 0, 0, 5, 0, 933, 240, 0, 1, 0, 0, '', 'Gossip Menu 8021 - Show text 9895 if player is not Friendly+ with Consortium');

-- Add condition for gossip_menu_option vendor option
-- Show vendor option only if player is Friendly+ with Consortium
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 8021 AND `SourceEntry` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8021, 0, 0, 0, 5, 0, 933, 240, 0, 0, 0, 0, '', 'Gossip Option 8021/0 - Show vendor option if player is Friendly+ with Consortium');
