-- DB update 2023_01_21_01 -> 2023_01_21_02
--
DELETE FROM `creature` WHERE `id1` IN (20357, 20358) AND `guid` IN (84016, 84017);
