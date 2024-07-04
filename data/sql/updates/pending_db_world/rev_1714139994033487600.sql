DELETE FROM `gossip_menu` WHERE `MenuID` = 7175;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7175, 8454),
(7175, 8455);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` IN (7175));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES 
(14, 7175, 8455, 0, 0, 5, 0, 529, 240, 0, 0, 'Player for which gossip text is shown has at least reputation Friendly, Honored, Revered, Exalted to faction 529');

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 7175;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7175, 0, 0, 'I am diseased. Please cure me, medic.', 12154, 1, 1, 0, 0, 0, 0, NULL, 0, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` IN (7175));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES 
(15, 7175, 0, 0, 0, 1, 0, 12541, 0, 0, 0, 'Player for which gossip text is shown has aura of spell Ghoul Rot (Ghoul Rot12541), effect EFFECT_0'),
(15, 7175, 0, 0, 1, 1, 0, 3427, 0, 0, 0, 'Player for which gossip text is shown has aura of spell Infected Wound (3427), effect EFFECT_0'),
(15, 7175, 0, 0, 2, 1, 0, 16449, 0, 0, 0, 'Player for which gossip text is shown has aura of spell Maggot Slime (16449), effect EFFECT_0');

-- Argent Medic smart ai
SET @ENTRY := 16284;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Argent Medic - Self: Flee for assist'),
(@ENTRY, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Argent Medic - On reset - Set event phase to phase 1'),
(@ENTRY, 0, 2, 0, 62, 0, 100, 512, 7175, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Player - On gossip action 0 from menu 7175 selected - Gossip player: Close gossip'),
(@ENTRY, 0, 3, 4, 62, 1, 100, 512, 7175, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Player - On gossip action 0 from menu 7175 selected - Set event phase to phase 2'),
(@ENTRY, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 28133, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Player - On gossip action 0 from menu 7175 selected - Self: Cast spell  Cure Disease (28133) on Gossip player'),
(@ENTRY, 0, 5, 0, 31, 0, 100, 0, 28133, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Argent Medic - On spell Cure Disease (28133)  hit a target - Set event phase to phase 1');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 16284 AND `SourceId` = 0;

