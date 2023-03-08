DELETE FROM `quest_request_items` WHERE `ID` IN (124, 191, 192, 257, 258, 289, 457, 511);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(124, 1, 0, 'My horses still seem skittish, and I still hear that cursed wolf cry at night. Please, $N, do something about those Gnolls!', 12340),
(191, 1, 0, 'Go kill 10 panthers! Show us what you\'ve got!', 12340),
(192, 1, 0, 'What are you doing here, $n! You should be crawling through the brush, trying to kill 10 Shadowmaw Panthers. I thought you fancied yourself a big game $c?', 12340),
(257, 1, 1, 'No luck? Don\'t feel too bad, $ner...$B$BNot everyone can be me.', 12340),
(258, 1, 1, 'It\'s only natural to feel sorry for yourself when shown up by someone so new to this world. You shouldn\'t feel bad, $nah.$B$BHm? Did I get your name wrong?', 12340),
(289, 1, 0, 'In my dreams, I can sometimes hear the doomed moans of my brethren! Please, good $gsir:lady;, free them from the bonds and quiet their cries.', 12340),
(457, 25, 25, 'Your task is not yet complete, $N. Return to me once 5 mangy nightsabers and 5 thistle boars have been killed.', 12340),
(511, 6, 0, 'Yes, $Gsir:ma\'am;? Do you have some business with me?', 12340);
