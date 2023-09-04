--
ALTER TABLE `creature`
	ADD COLUMN `CreateObject` TINYINT UNSIGNED NOT NULL DEFAULT '0' AFTER `VerifiedBuild`;

-- Haggle
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` = 53788 AND `id1` = 14041;
