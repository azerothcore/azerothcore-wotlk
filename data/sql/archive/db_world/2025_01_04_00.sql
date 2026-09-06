-- DB update 2025_01_03_00 -> 2025_01_04_00
DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (8346) AND `locale` = 'deDE';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(8346,'deDE','Ihr habt Euch heute bewiesen, $N. Euer Wille zu lernen zeigt, dass Ihr Euch sehr wohl gegenüber dem endlosen Verlangen, welches jeden Blutelfen beherrscht, durchsetzen könnt.$B$BRuht Euch nicht auf Euren Lorbeeren aus, sondern versucht zu meistern, was Ihr gelernt habt. Nur durch Tatendrang können wir als Volk überleben.$B$BNehmt dies - es wird Euch von Nutzen sein. Geht nun und macht unserem Volk noch einmal Ehre.',0);
