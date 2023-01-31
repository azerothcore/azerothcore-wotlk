-- DB update 2022_10_01_01 -> 2022_10_01_02
--
UPDATE `creature_formations` SET `groupAI`=`groupAI`|0x008 WHERE `leaderguid` BETWEEN 88000 AND 88007;
