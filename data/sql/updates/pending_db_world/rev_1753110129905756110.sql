--
-- Friendship Bread and Freshly-Squeezed Lemonade
DELETE FROM `npc_vendor` WHERE `entry` IN (2482, 3044, 4165, 5173, 5698, 15006) AND `item` IN (23160, 23161);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(2482, 0, 23160, 0, 0, 0, 0),  -- Zarena Cromwind
(2482, 0, 23161, 0, 0, 0, 0),
(3044, 0, 23160, 0, 0, 0, 0),  -- Miles Welsh
(3044, 0, 23161, 0, 0, 0, 0),
(4165, 0, 23160, 0, 0, 0, 0),  -- Elissa Dumas
(4165, 0, 23161, 0, 0, 0, 0),
(5173, 0, 23160, 0, 0, 0, 0),  -- Alexander Calder
(5173, 0, 23161, 0, 0, 0, 0),
(5698, 0, 23160, 0, 0, 0, 0),  -- Joanna Whitehall
(5698, 0, 23161, 0, 0, 0, 0),
(15006, 0, 23160, 0, 0, 0, 0), -- Deze Snowbane
(15006, 0, 23161, 0, 0, 0, 0);

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
