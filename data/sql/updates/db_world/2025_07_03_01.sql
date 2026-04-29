-- DB update 2025_07_03_00 -> 2025_07_03_01
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
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 9832 AND `SourceEntry` IN (11, 12) AND `ConditionTypeOrReference` IN (2, 8);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Alliance check for Tabard Arathor Battle Tabard and quest Control Five Bases
(15, 9832, 11, 0, 0, 2, 0, 20132, 1, 1, 1, 0, 0, '', 'Only show gossip if player doesn\'t have Arathor Battle Tabard'),
(15, 9832, 11, 0, 0, 8, 0, 8115, 0, 0, 0, 0, 0, '', 'Only show gossip if player already finished quest Control Five Bases'),
-- Horde check for Tabard Battle Tabard of the Defilers and quest Take Five Bases
(15, 9832, 12, 0, 0, 2, 0, 20131, 1, 1, 1, 0, 0, '', 'Only show gossip if player doesn\'t have Battle Tabard of the Defilers'),
(15, 9832, 12, 0, 0, 8, 0, 8122, 0, 0, 0, 0, 0, '', 'Only show gossip if player already finished quest Take Five Bases');

-- This changes the link from 10 to 100, allowing more tabards to be added and not havign the close gossip lost in the middle SAI (makes harder to see)
UPDATE `smart_scripts` SET `link` = 100 WHERE `source_type` = 0 AND `link` = 10 AND `entryorguid` IN (5049, 5188, 5189, 5190, 5191, 16610, 16766, 28776);

-- Changes the ID from 10 to 100
UPDATE `smart_scripts`SET `id` = 100 WHERE `source_type` = 0 AND `id` = 10 AND `entryorguid` IN (5049, 5188, 5189, 5190, 5191, 16610, 16766, 28776);

-- Removes and adds the for the Arathor and Defilers tabard
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `id` IN (10, 11) AND `entryorguid` IN (5049, 5188, 5189, 5190, 5191, 16610, 16766, 28776);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5049, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 11, 54971, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 11 Selected - Cast \'Create Arathor Battle Tabard\''),
(5049, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 11, 54973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 12 Selected - Cast \'Create Battle Tabard of the Defilers\'');

-- Removes and adds the for the Arathor and Defilers tabard
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `id` IN (10, 11) AND `entryorguid` IN (5049, 5188, 5189, 5190, 5191, 16610, 16766, 28776);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Lyesa Steelbrow (5049) Alliance
(5049, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 11, 54971, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 11 Selected - Cast \'Create Arathor Battle Tabard\''),
(5049, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 11, 54973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lyesa Steelbrow - On Gossip Option 12 Selected - Cast \'Create Battle Tabard of the Defilers\''),

-- Garyl (5188) Horde
(5188, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 11, 54971, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 11 Selected - Cast \'Create Arathor Battle Tabard\''),
(5188, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 11, 54973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Garyl - On Gossip Option 12 Selected - Cast \'Create Battle Tabard of the Defilers\''),

-- Thrumn (5189) Horde
(5189, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 11, 54971, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 11 Selected - Cast \'Create Arathor Battle Tabard\''),
(5189, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 11, 54973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thrumn - On Gossip Option 12 Selected - Cast \'Create Battle Tabard of the Defilers\''),

-- Merill Pleasance (5190) Horde
(5190, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 11, 54971, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 11 Selected - Cast \'Create Arathor Battle Tabard\''),
(5190, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 11, 54973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Merill Pleasance - On Gossip Option 12 Selected - Cast \'Create Battle Tabard of the Defilers\''),

-- Shalumon (5191) Alliance
(5191, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 11, 54971, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 11 Selected - Cast \'Create Arathor Battle Tabard\''),
(5191, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 11, 54973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shalumon - On Gossip Option 12 Selected - Cast \'Create Battle Tabard of the Defilers\''),

-- Kredis (16610) Horde
(16610, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 11, 54971, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 11 Selected - Cast \'Create Arathor Battle Tabard\''),
(16610, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 11, 54973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kredis - On Gossip Option 12 Selected - Cast \'Create Battle Tabard of the Defilers\''),

-- Issca (16766) Alliance
(16766, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 11, 54971, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 11 Selected - Cast \'Create Arathor Battle Tabard\''),
(16766, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 11, 54973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Issca - On Gossip Option 12 Selected - Cast \'Create Battle Tabard of the Defilers\''),

-- Elizabeth Ross (28776) Neutral (Dalaran)
(28776, 0, 10, 100, 62, 0, 100, 512, 9832, 11, 0, 0, 0, 0, 11, 54971, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 11 Selected - Cast \'Create Arathor Battle Tabard\''),
(28776, 0, 11, 100, 62, 0, 100, 512, 9832, 12, 0, 0, 0, 0, 11, 54973, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Elizabeth Ross - On Gossip Option 12 Selected - Cast \'Create Battle Tabard of the Defilers\'');
