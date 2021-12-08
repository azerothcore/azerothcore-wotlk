INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638937668620182300');

/* Add completion quest text for 4485, 4486
*/

DELETE FROM `quest_offer_reward` WHERE `ID` IN (4485, 4486);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(4485, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, you\'ve returned to the Cathedral, $N. Good. A lot has happened recently, and I would seek your aid if you prove worthy.$B$BMany treacherous enemies are about. I will need your help to stop them.', 0),
(4486, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, you\'ve returned to the Cathedral, $N. Good. A lot has happened recently, and I would seek your aid if you prove worthy.$B$BMany treacherous enemies are about. I will need your help to stop them.', 0);

