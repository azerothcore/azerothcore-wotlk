-- DB update 2023_01_16_06 -> 2023_01_16_07
--
-- Mok'rash respawn timer 3hr
UPDATE `creature` SET `spawntimesecs`=10800 WHERE `guid`=1672;
