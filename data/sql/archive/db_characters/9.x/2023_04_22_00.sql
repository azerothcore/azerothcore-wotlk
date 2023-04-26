-- DB update 2023_03_04_00 -> 2023_04_22_00
--
ALTER TABLE `characters`
    ADD COLUMN `extraBonusTalentCount` INT NOT NULL DEFAULT '0' AFTER `innTriggerId`;
