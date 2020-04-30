INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584790013870207000');

-- Set rates to 1 for faction "The Mag'har" & "Kurenai" to be blizzlike
UPDATE `reputation_reward_rate` SET `quest_rate`=1, `quest_daily_rate`=1, `quest_repeatable_rate`=1 WHERE `faction`=941;
UPDATE `reputation_reward_rate` SET `quest_daily_rate`=1, `quest_repeatable_rate`=1, `spell_rate`=1 WHERE `faction`=978;
