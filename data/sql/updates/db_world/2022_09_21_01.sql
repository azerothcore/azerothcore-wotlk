-- DB update 2022_09_21_00 -> 2022_09_21_01
--
UPDATE `creature_formations` SET `groupAI` = 515 WHERE `leaderGUID` = 87648 AND `memberGUID` IN (87649, 87650, 87651);
