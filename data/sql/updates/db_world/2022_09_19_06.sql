-- DB update 2022_09_19_05 -> 2022_09_19_06
--
UPDATE `creature_formations` SET `GroupAI`=515 WHERE `leaderGUID`=14514 AND `memberGUID` IN (14515, 14516, 14517);
