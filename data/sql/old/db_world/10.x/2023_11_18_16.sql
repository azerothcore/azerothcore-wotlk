-- DB update 2023_11_18_15 -> 2023_11_18_16
--
DELETE FROM `creature` WHERE `id1` = 21215 AND `guid` = 93773;
UPDATE `linked_respawn` SET `linkedGuid` = 15016 WHERE `linkedGuid` = 93773;
