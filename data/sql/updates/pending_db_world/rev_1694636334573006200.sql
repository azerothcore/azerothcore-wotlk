--
ALTER TABLE `creature`
    ADD COLUMN `Comment` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `CreateObject`;

ALTER TABLE `gameobject`
    ADD COLUMN `Comment` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `VerifiedBuild`;

UPDATE `creature` SET `Comment` = 'Original Orientation: 3.141592741012573242' WHERE `id1` = 18634 AND `guid` = 146209;
