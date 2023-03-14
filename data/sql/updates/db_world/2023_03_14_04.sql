-- DB update 2023_03_14_03 -> 2023_03_14_04
DELETE FROM `quest_request_items` WHERE `ID` IN (124, 191, 192, 257, 258, 289, 457, 511);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(124, 1, 0, 'My horses still seem skittish, and I still hear that cursed wolf cry at night. Please, $N, do something about those Gnolls!', 0),
(191, 1, 0, 'Go kill 10 panthers! Show us what you\'ve got!', 0),
(192, 1, 0, 'What are you doing here, $n! You should be crawling through the brush, trying to kill 10 Shadowmaw Panthers. I thought you fancied yourself a big game $c?', 0),
(257, 1, 1, 'No luck? Don\'t feel too bad, $ner...$B$BNot everyone can be me.', 0),
(258, 1, 1, 'It\'s only natural to feel sorry for yourself when shown up by someone so new to this world. You shouldn\'t feel bad, $nah.$B$BHm? Did I get your name wrong?', 0),
(289, 1, 0, 'In my dreams, I can sometimes hear the doomed moans of my brethren! Please, good $gsir:lady;, free them from the bonds and quiet their cries.', 0),
(457, 25, 25, 'Your task is not yet complete, $N. Return to me once 5 mangy nightsabers and 5 thistle boars have been killed.', 0),
(511, 6, 0, 'Yes, $Gsir:ma\'am;? Do you have some business with me?', 0);
