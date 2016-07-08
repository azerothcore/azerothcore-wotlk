
-- -------------------------------------------
-- REPUTATION FIXES
-- -------------------------------------------
-- Minion's Scourgestones (5402)
-- Invader's Scourgestones (5403)
-- Corruptor's Scourgestones (5406)
UPDATE quest_template SET RewardFactionValueId1=0, RewardFactionValueIdOverride1=5000 WHERE Id IN(5402, 5403, 5406);

-- Encrypted Twilight Texts (8319)
-- Preparing for the Worst (11945)
UPDATE quest_template SET RewardFactionValueId1=0, RewardFactionValueIdOverride1=50000 WHERE Id IN(8319, 11945);

-- The Mag'har dailies
UPDATE reputation_reward_rate SET quest_daily_rate=2, quest_repeatable_rate=2 WHERE faction=941;

-- Kurenai Dailies
UPDATE reputation_reward_rate SET quest_daily_rate=2, quest_repeatable_rate=2 WHERE faction=978;

-- Timbermaw Hold dailies
UPDATE reputation_reward_rate SET quest_daily_rate=4, quest_repeatable_rate=4 WHERE faction=576;
