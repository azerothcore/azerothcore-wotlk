-- DB update 2026_07_05_00 -> 2026_07_05_01

-- Set Correct GroupAI (it was 5).
UPDATE `creature_formations` SET `groupAI` = 3 WHERE `leaderGUID` = 136057;
