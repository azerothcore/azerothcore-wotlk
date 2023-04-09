-- DB update 2023_02_18_08 -> 2023_02_19_00
--
DELETE FROM `creature` WHERE `id1`=22102 AND `guid` IN (86101, 86102);
