-- DB update 2022_10_25_00 -> 2022_10_25_01
--
UPDATE `creature_formations` SET `groupAI` = 539 WHERE `leaderGUID` = 87648 AND `memberGUID` IN (87648, 87649, 87650, 87651);
