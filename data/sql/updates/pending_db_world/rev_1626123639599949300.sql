INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626123639599949300');

DELETE FROM `quest_offer_reward` WHERE (`ID` = 1507);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(1507, 0, 0, 0, 0, 0, 0, 0, 0, 'Hm... $N. You are still new to your path, but I sense the possibility for greatness in you.$B$BYou were born with gifts, $N. See that they do not go to waste.', 12340);
