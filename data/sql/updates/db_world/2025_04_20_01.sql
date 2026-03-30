-- DB update 2025_04_20_00 -> 2025_04_20_01
DELETE FROM `arena_season_reward_group` WHERE `arena_season` IN (1, 2, 3, 4);
INSERT INTO `arena_season_reward_group` (`id`, `arena_season`, `criteria_type`, `min_criteria`, `max_criteria`, `reward_mail_template_id`, `reward_mail_subject`, `reward_mail_body`, `gold_reward`) VALUES
-- Season 4 (Brutal)
(21, 4, 'abs', 1, 1, 0, '', '', 0),
(22, 4, 'pct', 0, 0.5, 262, '', '', 0),
(23, 4, 'pct', 0.5, 3, 0, '', '', 0),
(24, 4, 'pct', 3, 10, 0, '', '', 0),
(25, 4, 'pct', 10, 35, 0, '', '', 0),
-- Season 3 (Vengeful)
(26, 3, 'abs', 1, 1, 0, '', '', 0),
(27, 3, 'pct', 0, 0.5, 211, '', '', 0),
(28, 3, 'pct', 0.5, 3, 0, '', '', 0),
(29, 3, 'pct', 3, 10, 0, '', '', 0),
(30, 3, 'pct', 10, 35, 0, '', '', 0),
-- Season 2 (Merciless)
(31, 2, 'abs', 1, 1, 0, '', '', 0),
(32, 2, 'pct', 0, 0.5, 0, 'Congratulations!', 'On behalf of the Steamwheedle Fighting Circuit, we congratulate you for your successes in this arena season.$B$BIn recognition of your skill and savagery, we hereby bestow upon you this Merciless Nether Drake.  May it serve you well.', 0),
(33, 2, 'pct', 0.5, 3, 0, '', '', 0),
(34, 2, 'pct', 3, 10, 0, '', '', 0),
(35, 2, 'pct', 10, 35, 0, '', '', 0),
-- Season 1
(36, 1, 'pct', 0, 0.5, 0, 'Congratulations!', 'On behalf of the Steamwheedle Fighting Circuit, we congratulate you for your successes in this arena season.$B$BIn recognition of your skill and savagery, we hereby bestow upon you this Swift Nether Drake.  May it serve you well.', 0),
(37, 1, 'pct', 0.5, 3, 0, '', '', 0),
(38, 1, 'pct', 3, 10, 0, '', '', 0),
(39, 1, 'pct', 10, 35, 0, '', '', 0);

DELETE FROM `arena_season_reward` WHERE `group_id` IN (1, 6, 11, 16, 21, 22, 22, 23, 24, 25, 26, 27, 27, 28, 29, 30, 31, 32, 32, 33, 34, 35, 36, 36, 37, 38, 39);
INSERT INTO `arena_season_reward` (`group_id`, `type`, `entry`) VALUES
-- Season 8 (Wrathful)
(1, 'achievement', 4599),
-- Season 7 (Relentless)
(6, 'achievement', 3758),
-- Season 6 (Furious)
(11, 'achievement', 3436),
-- Season 5 (Deadly)
(16, 'achievement', 3336),
-- Season 4 (Brutal)
(21, 'achievement', 420),
(22, 'item', 43516),
(22, 'achievement', 2091),
(23, 'achievement', 2092),
(24, 'achievement', 2093),
(25, 'achievement', 2090),
-- Season 3 (Vengeful)
(26, 'achievement', 419),
(27, 'item', 37676),
(27, 'achievement', 2091),
(28, 'achievement', 2092),
(29, 'achievement', 2093),
(30, 'achievement', 2090),
-- Season 2 (Merciless)
(31, 'achievement', 418),
(32, 'item', 34092),
(32, 'achievement', 2091),
(33, 'achievement', 2092),
(34, 'achievement', 2093),
(35, 'achievement', 2090),
-- Season 1
(36, 'item', 30609),
(36, 'achievement', 2091),
(37, 'achievement', 2092),
(38, 'achievement', 2093),
(39, 'achievement', 2090);

DELETE FROM `achievement_reward` WHERE `ID` IN (418, 419, 420, 3436, 3758, 4599);
INSERT INTO `achievement_reward` (`ID`, `TitleA`, `TitleH`, `ItemID`, `Sender`, `Subject`, `Body`, `MailTemplateID`) VALUES
(418, 62, 62, 0, 0, '', '', 0),
(419, 71, 71, 0, 0, '', '', 0),
(420, 80, 80, 0, 0, '', '', 0),
(3436, 167, 167, 0, 0, '', '', 0),
(3758, 169, 169, 0, 0, '', '', 0),
(4599, 177, 177, 0, 0, '', '', 0);
