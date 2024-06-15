-- DB update 2022_12_27_00 -> 2022_12_27_01
--
UPDATE `creature_formations` SET `groupAI`=`groupAI`|0x020 WHERE `leaderGUID` IN (84634,84648);
