-- DB update 2023_04_02_08 -> 2023_04_02_09
-- Form Rhok'delar and Lok'delar at once
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=23192;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (23192, 24872, 0, 'Form Rhok\'delar and Lok\'delar at once ');

-- Gossip_menu_option (30201) conditions (QUEST_REWARDED & _ITEM)
-- Require both quests 7636(Stave of the Ancients) & 7635(A Proper String) to be rewarded, to not have either Sinew or Rune and to not have either Bow or Stave.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 30201;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 30201, 0, 0, 0, 8, 0, 7636, 0, 0, 0, 0, 0, '', '(AND) Require quest 7636(Stave of the Ancients) to be rewarded.'),
(15, 30201, 0, 0, 0, 8, 0, 7635, 0, 0, 0, 0, 0, '', '(AND) Require quest 7635(A Proper String) to be rewarded.'),
(15, 30201, 0, 0, 0, 2, 0, 18713, 1, 1, 1, 0, 0, '', '(AND) Require item 18713(Rhok\'delar) to not be in inventory or bank.'),
(15, 30201, 0, 0, 0, 2, 0, 18707, 1, 1, 1, 0, 0, '', '(AND) Require item 18707(Ancient Rune Etched Stave) to not be in inventory or bank.'),
(15, 30201, 0, 0, 0, 2, 0, 18724, 1, 1, 1, 0, 0, '', '(AND) Require item 18724(Enchanted Black Dragon Sinew) to not be in inventory or bank.'),
(15, 30201, 1, 0, 0, 8, 0, 7636, 0, 0, 0, 0, 0, '', '(AND) Require quest 7636(Stave of the Ancients) to be rewarded.'),
(15, 30201, 1, 0, 0, 8, 0, 7635, 0, 0, 0, 0, 0, '', '(AND) Require quest 7635(A Proper String) to be rewarded.'),
(15, 30201, 1, 0, 0, 2, 0, 18715, 1, 1, 1, 0, 0, '', '(AND) Require item 18715(Lok\'delar) to not be in inventory or bank.'),
(15, 30201, 1, 0, 0, 2, 0, 18707, 1, 1, 1, 0, 0, '', '(AND) Require item 18707(Ancient Rune Etched Stave) to not be in inventory or bank.'),
(15, 30201, 1, 0, 0, 2, 0, 18724, 1, 1, 1, 0, 0, '', '(AND) Require item 18724(Enchanted Black Dragon Sinew) to not be in inventory or bank.');

-- Vartus the Ancient 
DELETE FROM `gossip_menu_option` WHERE `MenuID`=30201;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(30201, 0, 0, 'Greetings, ancient one. I have done all that has been asked of me. I now ask that you grant me Rhok\'delar.', 10784, 1, 1, 0, 0, 0, 0, '', 0, 0),
(30201, 1, 0, 'Greetings, ancient one. I have done all that has been asked of me. I now ask that you grant me Lok\'delar.', 10785, 1, 1, 0, 0, 0, 0, '', 0, 0);

-- SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14524;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 14524;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14524, 0, 0, 2, 62, 0, 100, 0, 30201, 0, 0, 0, 0, 56, 18713, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vartrus the Ancient - On Gossip Option 0 Selected - Add Item \'Rhok\'delar, Longbow of the Ancient Keepers\' '),
(14524, 0, 1, 2, 62, 0, 100, 0, 30201, 1, 0, 0, 0, 56, 18715, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vartrus the Ancient - On Gossip Option 1 Selected - Add Item \'Lok\'delar, Stave of the Ancient Keepers\''),
(14524, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vartrus the Ancient - On Gossip Option - Close Gossip');
