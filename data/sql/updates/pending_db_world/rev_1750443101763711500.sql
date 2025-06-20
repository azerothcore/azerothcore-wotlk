-- Bracket 20-29 | `The Battle for Arathi Basin!` (1/4) (Alliance and Horde).
UPDATE `quest_template_addon` SET `MaxLevel` = 29 WHERE `ID` IN (8168, 8171);

-- Bracket 30-39 | `The Battle for Arathi Basin!` (2/4) (Alliance and Horde).
UPDATE `quest_template_addon` SET `MaxLevel` = 39 WHERE `ID` IN (8167, 8170);

-- Bracket 40-49 | `The Battle for Arathi Basin!` (3/4) (Alliance and Horde).
UPDATE `quest_template_addon` SET `MaxLevel` = 49 WHERE `ID` IN (8166, 8169);

-- `Control Four Bases` requires `The Battle for Arathi Basin!` (4/4) - Alliance to be completed.
UPDATE `quest_template_addon` SET `PrevQuestID` = 8105 WHERE `ID` = 8114;

-- `Take Four Bases` requires `The Battle for Arathi Basin!` (4/4) - Horde to be completed.
UPDATE `quest_template_addon` SET `PrevQuestID` = 8120 WHERE `ID` = 8121;

-- Player requires to be `Friendly` with `The Defilers` to access `Take Four Bases`.
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = 510, `RequiredMinRepValue` = 3000 WHERE `ID` = 8121;

-- Player requires to be `Friendly` with `The League of Arathor` to access `Control Four Bases`.
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = 509, `RequiredMinRepValue` = 3000 WHERE `ID` = 8114;

-- Adds to gossip_menu: 9832 (Tabard Vendors Gossip) the gossip_menu_option to match the BrodcastTextID for Arathor and Defilers Tabard
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 9832) AND (`OptionID` IN (11, 12));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9832, 11, 0, 'I\'ve lost my Arathor Battle Tabard.', 30354, 1, 1, 0, 0, 0, 0, '', 0, 0),
(9832, 12, 0, 'I\'ve lost my Battle Tabard of the Defilers.', 30355, 1, 1, 0, 0, 0, 0, '', 0, 0);

-- Alliance check for Tabard Arathor Battle Tabard and quest Control Five Bases
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9832) AND (`SourceEntry` = 11) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 2) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 20132) AND (`ConditionValue2` = 1) AND (`ConditionValue3` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9832, 11, 0, 0, 2, 0, 20132, 1, 1, 1, 0, 0, '', 'Only show gossip if player doesn\'t have Arathor Battle Tabard');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9832) AND (`SourceEntry` = 11) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 8) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 8115) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9832, 11, 0, 0, 8, 0, 8115, 0, 0, 0, 0, 0, '', 'Only show gossip if player already finished quest Control Five Bases');

-- Horde check for Tabard Battle Tabard of the Defilers and quest Take Five Bases
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9832) AND (`SourceEntry` = 12) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 2) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 20131) AND (`ConditionValue2` = 1) AND (`ConditionValue3` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9832, 12, 0, 0, 2, 0, 20131, 1, 1, 1, 0, 0, '', 'Only show gossip if player doesn\'t have Battle Tabard of the Defilers');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9832) AND (`SourceEntry` = 12) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 8) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 8122) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9832, 12, 0, 0, 8, 0, 8122, 0, 0, 0, 0, 0, '', 'Only show gossip if player already finished quest Take Five Bases');

-- From "SMART_ACTION_CAST" to "SMART_ACTION_ADD_ITEM" (CAST creates "Made by" and no sniffs to compare if it's spell or given item via gossips, if it's the spell i will revert this and spells need to be corrected to not make "Made by"
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (5049, 5188, 5189, 5190, 5191, 16610, 16766, 28776) AND source_type = 0 AND event_type IN (61, 62);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Lyesa Steelbrow (5049) Alliance
(5049, 0, 0, 100, 62, 0, 100, 512, 9832, 1, 0, 0, 0, 0, 56, 25549, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 1 Selected - Add Item \'Blood Knight Tabard\' 1 Time'),
(5049, 0, 1, 100, 62, 0, 100, 512, 9832, 2, 0, 0, 0, 0, 56, 24344, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 2 Selected - Add Item \'Tabard of the Hand\' 1 Time'),
(5049, 0, 2, 100, 62, 0, 100, 512, 9832, 3, 0, 0, 0, 0, 56, 28788, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 3 Selected - Add Item \'Tabard of the Protector\' 1 Time'),
(5049, 0, 3, 100, 62, 0, 100, 512, 9832, 4, 0, 0, 0, 0, 56, 31404, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 4 Selected - Add Item \'Green Trophy Tabard of the Illidari\' 1 Time'),
(5049, 0, 4, 100, 62, 0, 100, 512, 9832, 5, 0, 0, 0, 0, 56, 31405, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 5 Selected - Add Item \'Purple Trophy Tabard of the Illidari\' 1 Time'),
(5049, 0, 5, 100, 62, 0, 100, 512, 9832, 6, 0, 0, 0, 0, 56, 35279, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 6 Selected - Add Item \'Tabard of Summer Skies\' 1 Time'),
(5049, 0, 6, 100, 62, 0, 100, 512, 9832, 7, 0, 0, 0, 0, 56, 35280, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 7 Selected - Add Item \'Tabard of Summer Flames\' 1 Time'),
(5049, 0, 7, 100, 62, 0, 100, 512, 9832, 8, 0, 0, 0, 0, 56, 43300, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 8 Selected - Add Item \'Loremaster\'s Colors\' 1 Time'),
(5049, 0, 8, 100, 62, 0, 100, 512, 9832, 9, 0, 0, 0, 0, 56, 43348, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 9 Selected - Add Item \'Tabard of the Explorer\' 1 Time'),
(5049, 0, 9, 100, 62, 0, 100, 512, 9832, 10, 0, 0, 0, 0, 56, 40643, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 10 Selected - Add Item \'Tabard of the Achiever\' 1 Time'),
(5049, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 56, 20132, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 11 Selected - Add Item \'Arathor Battle Tabard\' 1 Time'),
(5049, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 56, 20131, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 10 Selected - Add Item \'Battle Tabard of the Defilers\' 1 Time'),
(5049, 0, 100, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 1 Selected - Close Gossip'),

-- Garyl (5188) Horde
(5188, 0, 0, 100, 62, 0, 100, 512, 9832, 1, 0, 0, 0, 0, 56, 25549, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 1 Selected - Add Item \'Blood Knight Tabard\' 1 Time'),
(5188, 0, 1, 100, 62, 0, 100, 512, 9832, 2, 0, 0, 0, 0, 56, 24344, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 2 Selected - Add Item \'Tabard of the Hand\' 1 Time'),
(5188, 0, 2, 100, 62, 0, 100, 512, 9832, 3, 0, 0, 0, 0, 56, 28788, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 3 Selected - Add Item \'Tabard of the Protector\' 1 Time'),
(5188, 0, 3, 100, 62, 0, 100, 512, 9832, 4, 0, 0, 0, 0, 56, 31404, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 4 Selected - Add Item \'Green Trophy Tabard of the Illidari\' 1 Time'),
(5188, 0, 4, 100, 62, 0, 100, 512, 9832, 5, 0, 0, 0, 0, 56, 31405, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 5 Selected - Add Item \'Purple Trophy Tabard of the Illidari\' 1 Time'),
(5188, 0, 5, 100, 62, 0, 100, 512, 9832, 6, 0, 0, 0, 0, 56, 35279, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 6 Selected - Add Item \'Tabard of Summer Skies\' 1 Time'),
(5188, 0, 6, 100, 62, 0, 100, 512, 9832, 7, 0, 0, 0, 0, 56, 35280, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 7 Selected - Add Item \'Tabard of Summer Flames\' 1 Time'),
(5188, 0, 7, 100, 62, 0, 100, 512, 9832, 8, 0, 0, 0, 0, 56, 43300, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 8 Selected - Add Item \'Loremaster\'s Colors\' 1 Time'),
(5188, 0, 8, 100, 62, 0, 100, 512, 9832, 9, 0, 0, 0, 0, 56, 43348, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 9 Selected - Add Item \'Tabard of the Explorer\' 1 Time'),
(5188, 0, 9, 100, 62, 0, 100, 512, 9832, 10, 0, 0, 0, 0, 56, 40643, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 10 Selected - Add Item \'Tabard of the Achiever\' 1 Time'),
(5188, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 56, 20132, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 11 Selected - Add Item \'Arathor Battle Tabard\' 1 Time'),
(5188, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 56, 20131, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 10 Selected - Add Item \'Battle Tabard of the Defilers\' 1 Time'),
(5188, 0, 100, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 1 Selected - Close Gossip'),

-- Thrumn (5189) Horde
(5189, 0, 0, 100, 62, 0, 100, 512, 9832, 1, 0, 0, 0, 0, 56, 25549, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 1 Selected - Add Item \'Blood Knight Tabard\' 1 Time'),
(5189, 0, 1, 100, 62, 0, 100, 512, 9832, 2, 0, 0, 0, 0, 56, 24344, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 2 Selected - Add Item \'Tabard of the Hand\' 1 Time'),
(5189, 0, 2, 100, 62, 0, 100, 512, 9832, 3, 0, 0, 0, 0, 56, 28788, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 3 Selected - Add Item \'Tabard of the Protector\' 1 Time'),
(5189, 0, 3, 100, 62, 0, 100, 512, 9832, 4, 0, 0, 0, 0, 56, 31404, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 4 Selected - Add Item \'Green Trophy Tabard of the Illidari\' 1 Time'),
(5189, 0, 4, 100, 62, 0, 100, 512, 9832, 5, 0, 0, 0, 0, 56, 31405, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 5 Selected - Add Item \'Purple Trophy Tabard of the Illidari\' 1 Time'),
(5189, 0, 5, 100, 62, 0, 100, 512, 9832, 6, 0, 0, 0, 0, 56, 35279, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 6 Selected - Add Item \'Tabard of Summer Skies\' 1 Time'),
(5189, 0, 6, 100, 62, 0, 100, 512, 9832, 7, 0, 0, 0, 0, 56, 35280, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 7 Selected - Add Item \'Tabard of Summer Flames\' 1 Time'),
(5189, 0, 7, 100, 62, 0, 100, 512, 9832, 8, 0, 0, 0, 0, 56, 43300, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 8 Selected - Add Item \'Loremaster\'s Colors\' 1 Time'),
(5189, 0, 8, 100, 62, 0, 100, 512, 9832, 9, 0, 0, 0, 0, 56, 43348, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 9 Selected - Add Item \'Tabard of the Explorer\' 1 Time'),
(5189, 0, 9, 100, 62, 0, 100, 512, 9832, 10, 0, 0, 0, 0, 56, 40643, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 10 Selected - Add Item \'Tabard of the Achiever\' 1 Time'),
(5189, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 56, 20132, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 11 Selected - Add Item \'Arathor Battle Tabard\' 1 Time'),
(5189, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 56, 20131, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 10 Selected - Add Item \'Battle Tabard of the Defilers\' 1 Time'),
(5189, 0, 100, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 1 Selected - Close Gossip'),

-- Merill Pleasance (5190) Horde
(5190, 0, 0, 100, 62, 0, 100, 512, 9832, 1, 0, 0, 0, 0, 56, 25549, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 1 Selected - Add Item \'Blood Knight Tabard\' 1 Time'),
(5190, 0, 1, 100, 62, 0, 100, 512, 9832, 2, 0, 0, 0, 0, 56, 24344, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 2 Selected - Add Item \'Tabard of the Hand\' 1 Time'),
(5190, 0, 2, 100, 62, 0, 100, 512, 9832, 3, 0, 0, 0, 0, 56, 28788, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 3 Selected - Add Item \'Tabard of the Protector\' 1 Time'),
(5190, 0, 3, 100, 62, 0, 100, 512, 9832, 4, 0, 0, 0, 0, 56, 31404, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 4 Selected - Add Item \'Green Trophy Tabard of the Illidari\' 1 Time'),
(5190, 0, 4, 100, 62, 0, 100, 512, 9832, 5, 0, 0, 0, 0, 56, 31405, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 5 Selected - Add Item \'Purple Trophy Tabard of the Illidari\' 1 Time'),
(5190, 0, 5, 100, 62, 0, 100, 512, 9832, 6, 0, 0, 0, 0, 56, 35279, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 6 Selected - Add Item \'Tabard of Summer Skies\' 1 Time'),
(5190, 0, 6, 100, 62, 0, 100, 512, 9832, 7, 0, 0, 0, 0, 56, 35280, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 7 Selected - Add Item \'Tabard of Summer Flames\' 1 Time'),
(5190, 0, 7, 100, 62, 0, 100, 512, 9832, 8, 0, 0, 0, 0, 56, 43300, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 8 Selected - Add Item \'Loremaster\'s Colors\' 1 Time'),
(5190, 0, 8, 100, 62, 0, 100, 512, 9832, 9, 0, 0, 0, 0, 56, 43348, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 9 Selected - Add Item \'Tabard of the Explorer\' 1 Time'),
(5190, 0, 9, 100, 62, 0, 100, 512, 9832, 10, 0, 0, 0, 0, 56, 40643, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 10 Selected - Add Item \'Tabard of the Achiever\' 1 Time'),
(5190, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 56, 20132, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 11 Selected - Add Item \'Arathor Battle Tabard\' 1 Time'),
(5190, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 56, 20131, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 10 Selected - Add Item \'Battle Tabard of the Defilers\' 1 Time'),
(5190, 0, 100, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 1 Selected - Close Gossip'),

-- Shalumon (5191) Alliance
(5191, 0, 0, 100, 62, 0, 100, 512, 9832, 1, 0, 0, 0, 0, 56, 25549, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 1 Selected - Add Item \'Blood Knight Tabard\' 1 Time'),
(5191, 0, 1, 100, 62, 0, 100, 512, 9832, 2, 0, 0, 0, 0, 56, 24344, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 2 Selected - Add Item \'Tabard of the Hand\' 1 Time'),
(5191, 0, 2, 100, 62, 0, 100, 512, 9832, 3, 0, 0, 0, 0, 56, 28788, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 3 Selected - Add Item \'Tabard of the Protector\' 1 Time'),
(5191, 0, 3, 100, 62, 0, 100, 512, 9832, 4, 0, 0, 0, 0, 56, 31404, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 4 Selected - Add Item \'Green Trophy Tabard of the Illidari\' 1 Time'),
(5191, 0, 4, 100, 62, 0, 100, 512, 9832, 5, 0, 0, 0, 0, 56, 31405, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 5 Selected - Add Item \'Purple Trophy Tabard of the Illidari\' 1 Time'),
(5191, 0, 5, 100, 62, 0, 100, 512, 9832, 6, 0, 0, 0, 0, 56, 35279, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 6 Selected - Add Item \'Tabard of Summer Skies\' 1 Time'),
(5191, 0, 6, 100, 62, 0, 100, 512, 9832, 7, 0, 0, 0, 0, 56, 35280, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 7 Selected - Add Item \'Tabard of Summer Flames\' 1 Time'),
(5191, 0, 7, 100, 62, 0, 100, 512, 9832, 8, 0, 0, 0, 0, 56, 43300, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 8 Selected - Add Item \'Loremaster\'s Colors\' 1 Time'),
(5191, 0, 8, 100, 62, 0, 100, 512, 9832, 9, 0, 0, 0, 0, 56, 43348, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 9 Selected - Add Item \'Tabard of the Explorer\' 1 Time'),
(5191, 0, 9, 100, 62, 0, 100, 512, 9832, 10, 0, 0, 0, 0, 56, 40643, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 10 Selected - Add Item \'Tabard of the Achiever\' 1 Time'),
(5191, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 56, 20132, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 11 Selected - Add Item \'Arathor Battle Tabard\' 1 Time'),
(5191, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 56, 20131, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 10 Selected - Add Item \'Battle Tabard of the Defilers\' 1 Time'),
(5191, 0, 100, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 1 Selected - Close Gossip'),

-- Kredis (16610) Horde
(16610, 0, 0, 100, 62, 0, 100, 512, 9832, 1, 0, 0, 0, 0, 56, 25549, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 1 Selected - Add Item \'Blood Knight Tabard\' 1 Time'),
(16610, 0, 1, 100, 62, 0, 100, 512, 9832, 2, 0, 0, 0, 0, 56, 24344, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 2 Selected - Add Item \'Tabard of the Hand\' 1 Time'),
(16610, 0, 2, 100, 62, 0, 100, 512, 9832, 3, 0, 0, 0, 0, 56, 28788, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 3 Selected - Add Item \'Tabard of the Protector\' 1 Time'),
(16610, 0, 3, 100, 62, 0, 100, 512, 9832, 4, 0, 0, 0, 0, 56, 31404, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 4 Selected - Add Item \'Green Trophy Tabard of the Illidari\' 1 Time'),
(16610, 0, 4, 100, 62, 0, 100, 512, 9832, 5, 0, 0, 0, 0, 56, 31405, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 5 Selected - Add Item \'Purple Trophy Tabard of the Illidari\' 1 Time'),
(16610, 0, 5, 100, 62, 0, 100, 512, 9832, 6, 0, 0, 0, 0, 56, 35279, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 6 Selected - Add Item \'Tabard of Summer Skies\' 1 Time'),
(16610, 0, 6, 100, 62, 0, 100, 512, 9832, 7, 0, 0, 0, 0, 56, 35280, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 7 Selected - Add Item \'Tabard of Summer Flames\' 1 Time'),
(16610, 0, 7, 100, 62, 0, 100, 512, 9832, 8, 0, 0, 0, 0, 56, 43300, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 8 Selected - Add Item \'Loremaster\'s Colors\' 1 Time'),
(16610, 0, 8, 100, 62, 0, 100, 512, 9832, 9, 0, 0, 0, 0, 56, 43348, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 9 Selected - Add Item \'Tabard of the Explorer\' 1 Time'),
(16610, 0, 9, 100, 62, 0, 100, 512, 9832, 10, 0, 0, 0, 0, 56, 40643, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 10 Selected - Add Item \'Tabard of the Achiever\' 1 Time'),
(16610, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 56, 20132, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 11 Selected - Add Item \'Arathor Battle Tabard\' 1 Time'),
(16610, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 56, 20131, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 10 Selected - Add Item \'Battle Tabard of the Defilers\' 1 Time'),
(16610, 0, 100, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 1 Selected - Close Gossip'),

-- Issca (16766) Alliance
(16766, 0, 0, 100, 62, 0, 100, 512, 9832, 1, 0, 0, 0, 0, 56, 25549, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 1 Selected - Add Item \'Blood Knight Tabard\' 1 Time'),
(16766, 0, 1, 100, 62, 0, 100, 512, 9832, 2, 0, 0, 0, 0, 56, 24344, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 2 Selected - Add Item \'Tabard of the Hand\' 1 Time'),
(16766, 0, 2, 100, 62, 0, 100, 512, 9832, 3, 0, 0, 0, 0, 56, 28788, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 3 Selected - Add Item \'Tabard of the Protector\' 1 Time'),
(16766, 0, 3, 100, 62, 0, 100, 512, 9832, 4, 0, 0, 0, 0, 56, 31404, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 4 Selected - Add Item \'Green Trophy Tabard of the Illidari\' 1 Time'),
(16766, 0, 4, 100, 62, 0, 100, 512, 9832, 5, 0, 0, 0, 0, 56, 31405, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 5 Selected - Add Item \'Purple Trophy Tabard of the Illidari\' 1 Time'),
(16766, 0, 5, 100, 62, 0, 100, 512, 9832, 6, 0, 0, 0, 0, 56, 35279, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 6 Selected - Add Item \'Tabard of Summer Skies\' 1 Time'),
(16766, 0, 6, 100, 62, 0, 100, 512, 9832, 7, 0, 0, 0, 0, 56, 35280, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 7 Selected - Add Item \'Tabard of Summer Flames\' 1 Time'),
(16766, 0, 7, 100, 62, 0, 100, 512, 9832, 8, 0, 0, 0, 0, 56, 43300, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 8 Selected - Add Item \'Loremaster\'s Colors\' 1 Time'),
(16766, 0, 8, 100, 62, 0, 100, 512, 9832, 9, 0, 0, 0, 0, 56, 43348, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 9 Selected - Add Item \'Tabard of the Explorer\' 1 Time'),
(16766, 0, 9, 100, 62, 0, 100, 512, 9832, 10, 0, 0, 0, 0, 56, 40643, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 10 Selected - Add Item \'Tabard of the Achiever\' 1 Time'),
(16766, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 56, 20132, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 11 Selected - Add Item \'Arathor Battle Tabard\' 1 Time'),
(16766, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 56, 20131, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 10 Selected - Add Item \'Battle Tabard of the Defilers\' 1 Time'),
(16766, 0, 100, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 1 Selected - Close Gossip'),

-- Elizabeth Ross (28776) Neutral (Dalaran)
(28776, 0, 0, 100, 62, 0, 100, 512, 9832, 1, 0, 0, 0, 0, 56, 25549, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 1 Selected - Add Item \'Blood Knight Tabard\' 1 Time'),
(28776, 0, 1, 100, 62, 0, 100, 512, 9832, 2, 0, 0, 0, 0, 56, 24344, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 2 Selected - Add Item \'Tabard of the Hand\' 1 Time'),
(28776, 0, 2, 100, 62, 0, 100, 512, 9832, 3, 0, 0, 0, 0, 56, 28788, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 3 Selected - Add Item \'Tabard of the Protector\' 1 Time'),
(28776, 0, 3, 100, 62, 0, 100, 512, 9832, 4, 0, 0, 0, 0, 56, 31404, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 4 Selected - Add Item \'Green Trophy Tabard of the Illidari\' 1 Time'),
(28776, 0, 4, 100, 62, 0, 100, 512, 9832, 5, 0, 0, 0, 0, 56, 31405, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 5 Selected - Add Item \'Purple Trophy Tabard of the Illidari\' 1 Time'),
(28776, 0, 5, 100, 62, 0, 100, 512, 9832, 6, 0, 0, 0, 0, 56, 35279, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 6 Selected - Add Item \'Tabard of Summer Skies\' 1 Time'),
(28776, 0, 6, 100, 62, 0, 100, 512, 9832, 7, 0, 0, 0, 0, 56, 35280, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 7 Selected - Add Item \'Tabard of Summer Flames\' 1 Time'),
(28776, 0, 7, 100, 62, 0, 100, 512, 9832, 8, 0, 0, 0, 0, 56, 43300, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 8 Selected - Add Item \'Loremaster\'s Colors\' 1 Time'),
(28776, 0, 8, 100, 62, 0, 100, 512, 9832, 9, 0, 0, 0, 0, 56, 43348, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 9 Selected - Add Item \'Tabard of the Explorer\' 1 Time'),
(28776, 0, 9, 100, 62, 0, 100, 512, 9832, 10, 0, 0, 0, 0, 56, 40643, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 10 Selected - Add Item \'Tabard of the Achiever\' 1 Time'),
(28776, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 56, 20132, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 11 Selected - Add Item \'Arathor Battle Tabard\' 1 Time'),
(28776, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 56, 20131, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 10 Selected - Add Item \'Battle Tabard of the Defilers\' 1 Time'),
(28776, 0, 100, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 1 Selected - Close Gossip');
