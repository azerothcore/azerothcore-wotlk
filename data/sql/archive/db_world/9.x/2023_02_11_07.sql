-- DB update 2023_02_11_06 -> 2023_02_11_07
--
-- Karazhan Image of Medivh (17651) and Image of Arcanagos (17652) missing creature text
DELETE FROM `creature_text` WHERE `CreatureID` IN (17651,17652);
INSERT INTO `creature_text`(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17651, 0, 0, "You've got my attention, dragon.  You'll find I'm not as easily scared as the villagers below.", 14, 0, 100, 0, 0, 0, 14295, 0, 'Image of Medivh'),
(17651, 1, 0, "You dare challenge me at my own dwelling?  Your arrogance is astounding, even for a dragon!", 14, 0, 100, 0, 0, 0, 14297, 0, 'Image of Medivh'),
(17651, 2, 0, "I do not know what you speak of, dragon... but  I will not be bullied by this display of insolence.  I'll leave Karazhan when it suits me!", 14, 0, 100, 0, 0, 0, 14299, 0, 'Image of Medivh'),
(17651, 3, 0, "%s begins to cast a spell of great power, weaving his own essence into the magic.", 16, 0, 100, 0, 0, 0, 14308, 0, 'Image of Medivh'),
(17651, 4, 0, "He should not have angered me.  I must go... recover my strength now...", 12, 0, 100, 0, 0, 0, 14316, 0, 'Image of Medivh'),

(17652, 0, 0, "Your dabbling in the arcane has gone too far, Medivh.  You've attracted the attention of powers beyond your understanding.  You must leave Karazhan at once!", 14, 0, 100, 0, 0, 0, 14296, 0, 'Image of Arcanagos'),
(17652, 1, 0, "A dark power seeks to use you, Medivh!  If you stay, dire days will follow.  You must hurry, we don't have much time!", 14, 0, 100, 0, 0, 0, 14298, 0, 'Image of Arcanagos'),
(17652, 2, 0, "You leave me no alternative.  I will stop you by force if you won't listen to reason!", 14, 0, 100, 0, 0, 0, 14300, 0, 'Image of Arcanagos'),
(17652, 3, 0, "What have you done, wizard?  This cannot be!  I'm burning from... within!", 14, 0, 100, 0, 0, 0, 14294, 0, 'Image of Arcanagos');

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (7421, 7422) AND `OptionID`=0;
INSERT INTO `gossip_menu_option`(`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7421, 0, 0, 'I\'m not an actor.', 14052, 0, 0, 0, 0, 0, 0, NULL, 0, 0),
(7422, 0, 0, 'Ok, I\'ll give it a try, then.', 14054, 0, 0, 0, 0, 0, 0, NULL, 0, 0);
