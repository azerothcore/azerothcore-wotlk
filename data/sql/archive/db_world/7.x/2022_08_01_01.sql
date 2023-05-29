-- DB update 2022_08_01_00 -> 2022_08_01_01
--
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id1` IN (11406, 14724, 16013, 22026);
