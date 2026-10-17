-- DB update 2025_09_15_02 -> 2025_09_15_03
ALTER TABLE `creature_model_info` ADD COLUMN `VerifiedBuild` MEDIUMINT NULL DEFAULT NULL AFTER `DisplayID_Other_Gender`;
UPDATE `creature_model_info` SET `VerifiedBuild` = 0;
