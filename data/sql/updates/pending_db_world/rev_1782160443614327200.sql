-- Commander Eligor Dawnbringer (27784): Pinnacle of Naxxramas Mr. Bigglesworth gag lines.
DELETE FROM `creature_text` WHERE `CreatureID`=27784 AND `GroupID` IN (27,28,29);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27784, 27, 0, 'Mr. Bigglesworth. The last living creature in Naxxramas, this cat is said to be the last thread connecting Kel\'Thuzad to his mortal life. It is said that any who dare to harm a hair on his head doom themselves to... wait a second, what is he doing on there?', 12, 7, 100, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - Bigglesworth gag'),
(27784, 28, 0, '%s pounds on the display.', 16, 0, 100, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - Bigglesworth gag'),
(27784, 29, 0, 'Well, nevermind. I\'m sure no one would be foolish enough to lay a hand on Kel\'Thuzad\'s precious pet.', 12, 7, 100, 0, 0, 0, 0, 0, 'Commander Eligor Dawnbringer - Bigglesworth gag');

-- Commander Eligor Dawnbringer (27784): on-click gossip greeting (menu 9600 -> npc_text 12958/12961).
DELETE FROM `npc_text` WHERE `ID` IN (12958, 12961);
INSERT INTO `npc_text` VALUES
(12958,'Yes, $c, what can I do for you?$B$BIf you\'re here for a lesson on Naxxramas, there\'s plenty of room.','',0,0,1,1000,1,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,11685),
(12961,'Yes, $c, what can I do for you?$B$BIf you\'re here for a lesson on Naxxramas, there\'s plenty of room.','',0,0,1,0,1,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,0,11723);

-- Commander Eligor Dawnbringer (27784): don't pause his scripted narration walk when a player interacts.
-- InteractionPauseTimer 0 disables the gossip-hello movement pause (default is the 3s Creature.MovingStopTimeForPlayer).
DELETE FROM `creature_template_movement` WHERE `CreatureId`=27784;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(27784, 1, 1, 0, 0, 0, 0, 0);
