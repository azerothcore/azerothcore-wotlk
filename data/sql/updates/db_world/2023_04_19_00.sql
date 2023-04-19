-- DB update 2023_04_18_03 -> 2023_04_19_00
-- Strider Clutchmother (2172)
UPDATE `creature_formations` SET `groupAI`=`groupAI`|1 WHERE `leaderGUID`=36692 AND`memberGUID`=36692;
UPDATE `creature_formations` SET `groupAI`=`groupAI`|1 WHERE `leaderGUID`=37385 AND`memberGUID`=36692;
UPDATE `creature_formations` SET `groupAI`=`groupAI`|1 WHERE `leaderGUID`=37385 AND `memberGUID`=205803;
