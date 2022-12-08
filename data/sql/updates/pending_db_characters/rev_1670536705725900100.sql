--
ALTER TABLE `characters`
    ADD COLUMN `extraBonusTalentCount` INT NOT NULL DEFAULT '0' AFTER `innTriggerId`;
