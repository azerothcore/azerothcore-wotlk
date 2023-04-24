-- DB update 2023_04_09_04 -> 2023_04_09_05
-- Terokkarantula and Arconus the Insatiable
UPDATE `creature` SET `spawntimesecs` = 180 WHERE `guid` IN (86843, 87039) AND `id1` IN (20554, 20682);
