-- DB update 2023_04_19_27 -> 2023_04_19_28
--
UPDATE `creature_formations` SET `groupAI`=`groupAI`|1 WHERE `leaderGUID`=37385 AND `memberGUID`=37385;
