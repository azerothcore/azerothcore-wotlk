ALTER TABLE `creature_model_info` ADD COLUMN `VerifiedBuild` MEDIUMINT NULL DEFAULT NULL AFTER `DisplayID_Other_Gender`;
UPDATE `creature_model_info` SET `VerifiedBuild` = 0;
