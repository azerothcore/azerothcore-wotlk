-- DB update 2026_05_03_00 -> 2026_05_09_00
DELETE FROM `rbac_linked_permissions` WHERE `id` = 198 AND `linkedId` = 471;
DELETE FROM `rbac_permissions` WHERE `id` = 471;
