-- DB update 2026_01_23_00 -> 2026_01_23_01
--
UPDATE `creature` SET `spawntimesecs` = 3600 WHERE `id1` = 16029 AND `guid` IN (97718, 97724, 97736, 97747);
