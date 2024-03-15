DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (9610, 9611, 9612, 11277) AND `OptionID`=1;

DELETE FROM `creature_text` WHERE `CreatureID`=26499 AND `GroupID`=39 AND `ID`=0 ;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(26499, 39, 0, 'I can\'t afford to spare you.', 12, 0, 100, 0, 0, 0, 31355, 0, 'culling SAY_PHASE305_1');

DELETE FROM `creature_text` WHERE `CreatureID`=28169 AND `GroupID`=1 AND `ID`=0 ;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(28169, 1, 0, 'Oh, no...', 12, 0, 100, 0, 0, 0, 27552, 0, 'culling SAY_PHASE204_1');

DELETE FROM `creature_text` WHERE `CreatureID`=32281 AND `GroupID`=0 AND `ID`=0 ;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(32281, 0, 0, 'You have my thanks for saving my existence in this timeline. Now I must report back to my superiors. They must know immediately of what I just experienced.', 12, 0, 100, 0, 0, 0, 32645, 0, 'culling SAY_THANKS');
