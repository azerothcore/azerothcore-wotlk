
DELETE FROM `creature_text`
WHERE `CreatureID` = 36856
  AND `GroupID` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9);

INSERT INTO `creature_text`(`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES  
(36856,0,0,'You\'re in luck. I\'ve got just what you need in the load I\'m about to wash.',12,0,100,0,0,0,36761,0,'Shandy Glossgleam'),
(36856,1,0,'Well done!',12,0,16,4,0,0,3287,0,'Shandy say 2'),
(36856,1,1,'Aquanos can hardly keep up!',12,0,14,4,0,0,37988,0,'Shandy say 2'),
(36856,1,2,'Nice. I don\'t want to know what that stain was.',12,0,14,4,0,0,37987,0,'Shandy say 2'),
(36856,1,3,'I should keep you around.',12,0,14,0,0,0,37989,0,'Shandy Glossgleam'),
(36856,1,4,'That\'s how it\'s done!',12,0,14,0,0,0,37986,0,'Shandy Glossgleam'),
(36856,1,5,'Clean and tidy!',12,0,14,0,0,0,37985,0,'Shandy Glossgleam'),
(36856,1,6,'Nice. I don\'t want to know what that stain was.',12,0,14,0,0,0,37987,0,'Shandy Glossgleam'),
(36856,1,7,'Aquanos can hardly keep up!',12,0,14,0,0,0,37988,0,'Shandy Glossgleam'),
(36856,2,0,'See the piles of laundry and the bucket of water? I\'ll call out what I need next, and you put it in the tub. Ready?',12,0,100,0,0,0,36762,0,'Shandy Glossgleam'),
(36856,3,0,'The tub needs more water!',12,0,100,25,0,0,36790,0,'Shandy Glossgleam'),
(36856,4,0,'Quick, add some shirts to the laundry!',12,0,100,0,0,0,36788,0,'Shandy Glossgleam'),
(36856,5,0,'Toss some pants in to the tub!',12,0,100,25,0,0,36787,0,'Shandy Glossgleam'),
(36856,6,0,'Add the unmentionables... uh, I mean, the \'delicates\'!',12,0,100,25,0,0,36789,0,'Shandy Glossgleam'),
(36856,7,0,'Aquanos, stop sending the clothes so high! You didn\'t have to see the look on Aethas Sunreaver\'s face when he found his pants in the fountain!',12,0,100,0,0,0,36817,0,'Shandy Glossgleam'),
(36856,8,0,'See how easy that was with everyone working together? Just take what you need from the clean laundry here, but don\'t forget to return it when you\'re finished.',12,0,100,0,0,0,36791,0,'Shandy Glossgleam'),
(36856,9,0,'Oh, no! That wasn\'t right. Now I\'ll have to go get more detergent so we can start over!',12,0,100,0,0,0,36763,0,'Shandy Glossgleam');

UPDATE `gossip_menu_option`
SET `BoxBroadcastTextID` = 0
WHERE `menuid` = 10854 AND `OptionBroadcastTextID` IN (37552, 36760);
