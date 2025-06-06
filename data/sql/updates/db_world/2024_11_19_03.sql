-- DB update 2024_11_19_02 -> 2024_11_19_03

DELETE FROM `linked_respawn` WHERE `guid` IN (89266, 89267, 89272, 89275);
DELETE FROM `creature` WHERE `id1` = 24217;
