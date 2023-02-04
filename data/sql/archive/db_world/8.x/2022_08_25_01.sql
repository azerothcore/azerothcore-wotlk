-- DB update 2022_08_25_00 -> 2022_08_25_01
--
DELETE FROM `creature_addon` WHERE `guid` IN (144680, 144679);
DELETE FROM `creature` WHERE `id1` = 15428;
