INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626545461944168600');

-- We change the quest reward to use the name and gender of our character.
UPDATE `quest_offer_reward` SET `RewardText` = 'Incredible! Improbable! Simply amazing! You\'ve got talent, $N. Either that or you\'re the luckiest $gman:woman; alive!$b$bHere\'s your cut of the action. I\'m sure you would make better use of this stuff than I could.$b$b' WHERE (`ID` = 2381);


