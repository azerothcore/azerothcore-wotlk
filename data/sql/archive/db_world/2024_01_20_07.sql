-- DB update 2024_01_20_06 -> 2024_01_20_07
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (188049, 188130, 188134, 188135, 188137, 188138, 188139, 188143, 188144, 188145, 188146, 188147, 188148, 188149, 188150, 188151, 188152, 188153, 188154);

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` IN (188049, 188130, 188134, 188135, 188137, 188138, 188139, 188143, 188144, 188145, 188146, 188147, 188148, 188149, 188150, 188151, 188152, 188153, 188154));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(188049, 1, 0, 0, 62, 0, 100, 0, 9213, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188049, 1, 1, 0, 62, 0, 100, 0, 9213, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188130, 1, 0, 0, 62, 0, 100, 0, 9251, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188130, 1, 1, 0, 62, 0, 100, 0, 9251, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188134, 1, 0, 0, 62, 0, 100, 0, 9254, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188134, 1, 1, 0, 62, 0, 100, 0, 9254, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188135, 1, 0, 0, 62, 0, 100, 0, 9255, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188135, 1, 1, 0, 62, 0, 100, 0, 9255, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188137, 1, 0, 0, 62, 0, 100, 0, 9256, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188137, 1, 1, 0, 62, 0, 100, 0, 9256, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188138, 1, 0, 0, 62, 0, 100, 0, 9257, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188138, 1, 1, 0, 62, 0, 100, 0, 9257, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188139, 1, 0, 0, 62, 0, 100, 0, 9258, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188139, 1, 1, 0, 62, 0, 100, 0, 9258, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188143, 1, 0, 0, 62, 0, 100, 0, 9264, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188143, 1, 1, 0, 62, 0, 100, 0, 9264, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188144, 1, 0, 0, 62, 0, 100, 0, 9265, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188144, 1, 1, 0, 62, 0, 100, 0, 9265, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188145, 1, 0, 0, 62, 0, 100, 0, 9266, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188145, 1, 1, 0, 62, 0, 100, 0, 9266, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188146, 1, 0, 0, 62, 0, 100, 0, 9267, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188146, 1, 1, 0, 62, 0, 100, 0, 9267, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188147, 1, 0, 0, 62, 0, 100, 0, 9268, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188147, 1, 1, 0, 62, 0, 100, 0, 9268, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188148, 1, 0, 0, 62, 0, 100, 0, 9269, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188148, 1, 1, 0, 62, 0, 100, 0, 9269, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188149, 1, 0, 0, 62, 0, 100, 0, 9271, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188149, 1, 1, 0, 62, 0, 100, 0, 9271, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188150, 1, 0, 0, 62, 0, 100, 0, 9272, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188150, 1, 1, 0, 62, 0, 100, 0, 9272, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188151, 1, 0, 0, 62, 0, 100, 0, 9273, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188151, 1, 1, 0, 62, 0, 100, 0, 9273, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188152, 1, 0, 0, 62, 0, 100, 0, 9274, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188152, 1, 1, 0, 62, 0, 100, 0, 9274, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188153, 1, 0, 0, 62, 0, 100, 0, 9275, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188153, 1, 1, 0, 62, 0, 100, 0, 9275, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188154, 1, 0, 0, 62, 0, 100, 0, 9276, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188154, 1, 1, 0, 62, 0, 100, 0, 9276, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip');

DELETE FROM `creature` WHERE (`guid` IN (245628, 245629, 245630, 245631, 245632, 245633) AND `id1` IN (26116, 26178, 26204, 26214, 26215, 26216));
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1 AND `guid` IN (245628, 245629, 245630, 245631, 245632, 245633));

DELETE FROM `creature_text` WHERE `CreatureID` = 26116;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26116, 0, 0, 'You will not stop the Frost Lord from entering this world, mortal. The Tidehunter\'s might will crush that of Ragnaros once and for all, leaving your land a frozen paradise!', 12, 0, 100, 1, 2000, 0, 25372, 0, 'Frostwave Lieutenant intro speech');

UPDATE `creature_text` SET `comment` = 'Hailstone Lieutenant intro speech' WHERE `CreatureID` = 26178; -- Formerly 'Frostwave Lieutenant intro speech'
UPDATE `creature_text` SET `comment` = 'Glacial Templar intro speech' WHERE `CreatureID` = 26216; -- Formerly 'Templar intro speech'

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (9251, 9254, 9255);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9251, 0, 0, 'Lay your hand on the Ice Stone.', 25218, 1, 1, 0, 0, 0, 0, '', 0, 0),
(9254, 0, 0, 'Lay your hand on the Ice Stone.', 25218, 1, 1, 0, 0, 0, 0, '', 0, 0),
(9255, 0, 0, 'Lay your hand on the Ice Stone.', 25218, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15 AND `SourceGroup` IN (9213, 9251, 9254, 9255, 9256, 9257, 9258, 9264, 9265, 9266, 9267, 9268, 9269, 9271, 9272, 9273, 9274, 9275, 9276) AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9213, 0, 0, 0, 47, 0, 11917, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9251, 0, 0, 0, 47, 0, 11947, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9254, 0, 0, 0, 47, 0, 11947, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9255, 0, 0, 0, 47, 0, 11947, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9256, 0, 0, 0, 47, 0, 11917, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9257, 0, 0, 0, 47, 0, 11917, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9258, 0, 0, 0, 47, 0, 11948, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9264, 0, 0, 0, 47, 0, 11948, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9265, 0, 0, 0, 47, 0, 11948, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9266, 0, 0, 0, 47, 0, 11952, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9267, 0, 0, 0, 47, 0, 11952, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9268, 0, 0, 0, 47, 0, 11952, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9269, 0, 0, 0, 47, 0, 11953, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9271, 0, 0, 0, 47, 0, 11953, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9272, 0, 0, 0, 47, 0, 11953, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9273, 0, 0, 0, 47, 0, 11954, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9274, 0, 0, 0, 47, 0, 11954, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9275, 0, 0, 0, 47, 0, 11954, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress'),
(15, 9276, 0, 0, 0, 47, 0, 11954, 8, 0, 0, 0, 0, '', 'If player has quest \'Striking Back\' in progress');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (26116, 26178, 26204, 26214, 26215, 26216);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (26116, 26178, 26204, 26214, 26215, 26216));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26116, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwave Lieutenant - On Just Summoned - Say Line 0'),
(26116, 0, 1, 0, 0, 0, 100, 0, 12000, 20000, 28000, 40000, 0, 11, 122, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwave Lieutenant - In Combat - Cast \'Frost Nova\''),
(26116, 0, 2, 0, 0, 0, 100, 0, 4000, 12000, 8000, 24000, 0, 11, 8056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwave Lieutenant - In Combat - Cast \'Frost Shock\''),

(26178, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hailstone Lieutenant - On Just Summoned - Say Line 0'),
(26178, 0, 1, 0, 0, 0, 100, 0, 4000, 12000, 12000, 24000, 0, 11, 5164, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hailstone Lieutenant - In Combat - Cast \'Knockdown\''),
(26178, 0, 2, 0, 0, 0, 100, 1, 12000, 30000, 0, 0, 0, 11, 5276, 128, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hailstone Lieutenant - In Combat - Cast \'Freeze\' (No Repeat)'),

(26204, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillwind Lieutenant - On Just Summoned - Say Line 0'),
(26204, 0, 1, 0, 0, 0, 100, 1, 4000, 8000, 0, 0, 0, 11, 6982, 128, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillwind Lieutenant - In Combat - Cast \'Gust of Wind\' (No Repeat)'),
(26204, 0, 2, 0, 0, 0, 100, 0, 4000, 12000, 12000, 24000, 0, 11, 23115, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillwind Lieutenant - In Combat - Cast \'Frost Shock\''),

(26214, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frigid Lieutenant - On Just Summoned - Say Line 0'),
(26214, 0, 1, 0, 0, 0, 100, 0, 4000, 12000, 12000, 24000, 0, 11, 3131, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frigid Lieutenant - In Combat - Cast \'Frost Breath\''),

(26215, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glacial Lieutenant - On Just Summoned - Say Line 0'),
(26215, 0, 1, 0, 0, 0, 100, 0, 12000, 20000, 28000, 40000, 0, 11, 14907, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Glacial Lieutenant - In Combat - Cast \'Frost Nova\''),
(26215, 0, 2, 0, 0, 0, 100, 0, 4000, 12000, 8000, 24000, 0, 11, 15089, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Glacial Lieutenant - In Combat - Cast \'Frost Shock\''),

(26216, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glacial Templar - On Just Summoned - Say Line 0'),
(26216, 0, 1, 0, 0, 0, 100, 0, 4000, 12000, 12000, 24000, 0, 11, 5164, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hailstone Lieutenant - In Combat - Cast \'Knockdown\''),
(26216, 0, 2, 0, 0, 0, 100, 0, 12000, 20000, 28000, 40000, 0, 11, 14907, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Glacial Templar - In Combat - Cast \'Frost Nova\''),
(26216, 0, 3, 0, 0, 0, 100, 0, 4000, 12000, 8000, 24000, 0, 11, 15089, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Glacial Templar - In Combat - Cast \'Frost Shock\'');

DELETE FROM `spell_script_names` WHERE `spell_id` = 46592 AND `ScriptName` = 'spell_midsummer_summon_ahune_lieutenant';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (46592, 'spell_midsummer_summon_ahune_lieutenant');
