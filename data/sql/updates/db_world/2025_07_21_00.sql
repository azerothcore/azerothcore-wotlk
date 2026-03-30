-- DB update 2025_07_20_02 -> 2025_07_21_00
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 23 AND `SourceGroup` IN (2482, 3044, 4165, 5173, 5698, 11038, 14450, 15006, 16543);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` IN (4533, 4566, 4821, 6470, 8730);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
`ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
--
(23, 2482,  23160, 0, 0, 8, 0, 9301, 0, 0, 0, 0, 0, '', 'Zarena Cromwind will not sell Friendship Bread until the player has completed \'Envelope from the Front\''),
(23, 2482,  23161, 0, 1, 8, 0, 9301, 0, 0, 0, 0, 0, '', 'Zarena Cromwind will not sell Freshly-Squeezed Lemonade until the player has completed \'Envelope from the Front\''),
--
(23, 3044,  23160, 0, 0, 8, 0, 9300, 0, 0, 0, 0, 0, '', 'Miles Welsh will not sell Friendship Bread until the player has completed \'Page from the Front\''),
(23, 3044,  23161, 0, 0, 8, 0, 9300, 0, 0, 0, 0, 0, '', 'Miles Welsh will not sell Freshly-Squeezed Lemonade until the player has completed \'Page from the Front\''),
(15, 4533,  3,     0, 0, 8, 0, 9300, 0, 0, 0, 0, 0, '', 'Miles Welsh will not show vendor gossip option until the player has completed \'Page from the Front\''),
--
(23, 4165,  23160, 0, 0, 8, 0, 9300, 0, 0, 0, 0, 0, '', 'Elissa Dumas will not sell Friendship Bread until the player has completed \'Page from the Front\''),
(23, 4165,  23161, 0, 0, 8, 0, 9300, 0, 0, 0, 0, 0, '', 'Elissa Dumas will not sell Freshly-Squeezed Lemonade until the player has completed \'Page from the Front\''),
(15, 4821,  1,     0, 0, 8, 0, 9300, 0, 0, 0, 0, 0, '', 'Elissa Dumas will not show vendor gossip option until the player has completed \'Page from the Front\''),
--
(23, 5173,  23160, 0, 0, 8, 0, 9299, 0, 0, 0, 0, 0, '', 'Alexander Calder will not sell Friendship Bread until the player has completed \'Note from the Front\''),
(23, 5173,  23161, 0, 0, 8, 0, 9299, 0, 0, 0, 0, 0, '', 'Alexander Calder will not sell Freshly-Squeezed Lemonade until the player has completed \'Note from the Front\''),
(15, 4566,  3,     0, 0, 8, 0, 9299, 0, 0, 0, 0, 0, '', 'Alexander Calder will not show vendor gossip option until the player has completed \'Note from the Front\''),
--
(23, 5698,  23160, 0, 0, 8, 0, 9295, 0, 0, 0, 0, 0, '', 'Joanna Whitehall will not sell Friendship Bread until the player has completed \'Letter from the Front\''),
(23, 5698,  23161, 0, 0, 8, 0, 9295, 0, 0, 0, 0, 0, '', 'Joanna Whitehall will not sell Freshly-Squeezed Lemonade until the player has completed \'Letter from the Front\''),
(15, 8730,  0,     0, 0, 8, 0, 9295, 0, 0, 0, 0, 0, '', 'Joanna Whitehall will not show vendor gossip option until the player has completed \'Letter from the Front\''),
--
(23, 11038, 23160, 0, 0, 8, 0, 9304, 0, 0, 0, 0, 0, '', 'Caretaker Alen will not sell Friendship Bread until the player has completed \'Document from the Front\''),
(23, 11038, 23161, 0, 1, 8, 0, 9304, 0, 0, 0, 0, 0, '', 'Caretaker Alen will not sell Freshly-Squeezed Lemonade until the player has completed \'Document from the Front\''),
--
(23, 14450, 23160, 0, 0, 8, 0, 9295, 0, 0, 0, 0, 0, '', 'Orphan Matron Nightingale will not sell Friendship Bread until the player has completed \'Letter from the Front\''),
(23, 14450, 23161, 0, 1, 8, 0, 9295, 0, 0, 0, 0, 0, '', 'Orphan Matron Nightingale will not sell Freshly-Squeezed Lemonade until the player has completed \'Letter from the Front\''),
--
(23, 15006, 23160, 0, 0, 8, 0, 9299, 0, 0, 0, 0, 0, '', 'Deze Snowbane will not sell Friendship Bread until the player has completed \'Note from the Front\''),
(23, 15006, 23161, 0, 0, 8, 0, 9299, 0, 0, 0, 0, 0, '', 'Deze Snowbane will not sell Freshly-Squeezed Lemonade until the player has completed \'Note from the Front\''),
(15, 6470,  1,     0, 0, 8, 0, 9299, 0, 0, 0, 0, 0, '', 'Deze Snowbane will not show vendor gossip option until the player has completed \'Note from the Front\''),
--
(23, 16543, 23160, 0, 0, 8, 0, 9302, 0, 0, 0, 0, 0, '', 'Garon Hutchins will not sell Friendship Bread until the player has completed \'Missive from the Front\''),
(23, 16543, 23161, 0, 1, 8, 0, 9302, 0, 0, 0, 0, 0, '', 'Garon Hutchins will not sell Freshly-Squeezed Lemonade until the player has completed \'Missive from the Front\'');

SET @NPCFLAG_VENDOR := 128;
-- Alexander Calder
UPDATE `creature_template` SET `npcflag`=`npcflag`|@NPCFLAG_VENDOR WHERE (`entry` = 5173);
-- Miles Welsh
UPDATE `creature_template` SET `npcflag`=`npcflag`|@NPCFLAG_VENDOR WHERE (`entry` = 3044);
-- Joanna Whitehall
UPDATE `creature_template` SET `npcflag`=`npcflag`|@NPCFLAG_VENDOR WHERE (`entry` = 5698);
-- Elissa Dumas
UPDATE `creature_template` SET `npcflag`=`npcflag`|@NPCFLAG_VENDOR WHERE (`entry` = 4165);
-- Deze Snowbane
UPDATE `creature_template` SET `npcflag`=`npcflag`|@NPCFLAG_VENDOR WHERE (`entry` = 15006);

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 4533 AND `OptionID` = 3;
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 4566 AND `OptionID` = 3;
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 4821 AND `OptionID` = 1;
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 5849 AND `OptionID` = 2;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (6470, 8730);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`,
`ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(4533, 3, 1, 'Show me what you have for sale.', 29959, 3, 128, 0, 0, 0, 0, '', 0, 0),
(4566, 3, 1, 'Show me what you have for sale.', 29959, 3, 128, 0, 0, 0, 0, '', 0, 0),
(4821, 1, 1, 'Show me what you have for sale.', 29959, 3, 128, 0, 0, 0, 0, '', 0, 0),
(6470, 0, 9, 'I would like to go to the battleground.', 10355, 12, 1048576, 0, 0, 0, 0, '', 0, 0),
(6470, 1, 1, 'Show me what you have for sale.', 29959, 3, 128, 0, 0, 0, 0, '', 0, 0),
(8730, 0, 1, 'Show me what you have for sale.', 29959, 3, 128, 0, 0, 0, 0, '', 0, 0),
(5849, 2, 1, 'Show me what you have for sale.', 29959, 3, 128, 0, 0, 0, 0, '', 0, 0);
