DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (9610, 9611, 9612, 11277) AND `OptionID`=1;

DELETE FROM `creature_text` WHERE `CreatureID`=26499 AND `GroupID`=39 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26499, 39, 0, 'I can\'t afford to spare you.', 12, 0, 100, 0, 0, 0, 31355, 0, 'culling SAY_PHASE305_1');

DELETE FROM `creature_text` WHERE `CreatureID`=28169 AND `GroupID`=1 AND `ID`=0 ;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(28169, 1, 0, 'Oh, no...', 12, 0, 100, 0, 0, 0, 27552, 0, 'culling SAY_PHASE204_1');

DELETE FROM `creature_text` WHERE `CreatureID`=32281 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(32281, 0, 0, 'You have my thanks for saving my existence in this timeline. Now I must report back to my superiors. They must know immediately of what I just experienced.', 12, 0, 100, 0, 0, 0, 32645, 0, 'culling SAY_THANKS');

DELETE FROM `creature_text` WHERE `CreatureID` IN (28167, 28169);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(28167, 0, 0, 'Prince Arthas, may the light be praised! Many people in the town have begun to fall seriously ill, can you help us?', 12, 0, 100, 0, 0, 0, 27547, 0, 'culling SAY_PHASE202'),
(28167, 1, 0, 'What? This can\'t be!', 12, 0, 100, 274, 0, 0, 27549, 0, 'culling SAY_PHASE204'),
(28169, 0, 0, 'Oh, no...', 12, 0, 100, 0, 0, 0, 27552, 0, 'culling SAY_PHASE204_1');

DELETE FROM `creature_text_locale` WHERE `CreatureID` IN (34799, 35144) AND `GroupID`=2 AND `ID`=0 AND `Locale`='ruRU';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(34799, 2, 0, 'ruRU', '%s вылезает из-под земли!'),
(35144, 2, 0, 'ruRU', '%s вылезает из-под земли!');
