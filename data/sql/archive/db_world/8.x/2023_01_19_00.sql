-- DB update 2023_01_16_14 -> 2023_01_19_00
--
UPDATE `creature_formations` SET `groupAI`=`groupAI`|0x020 WHERE `leaderGUID` IN (84634,84648);
