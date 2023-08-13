-- DB update 2023_08_13_01 -> 2023_08_13_02
--
DELETE FROM `creature` WHERE `id1` IN (16179, 16180, 16181);
DELETE FROM `linked_respawn` WHERE `guid` = 135369;
