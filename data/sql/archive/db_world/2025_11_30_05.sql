-- DB update 2025_11_30_04 -> 2025_11_30_05
--
-- Remove the RewardNextQuest, previously: 12070 (Rallying the Troops), link from 12249 (Ursoc, the Bear God)
UPDATE `quest_template` SET `RewardNextQuest` = 0 WHERE (`ID` = 12249);
