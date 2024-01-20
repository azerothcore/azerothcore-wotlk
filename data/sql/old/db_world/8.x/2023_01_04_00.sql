-- DB update 2023_01_03_03 -> 2023_01_04_00
--
UPDATE `creature_formations` SET `groupAI`=`groupAI`&~0x020 WHERE `leaderGUID` IN (84634,84648);
