-- Add the securitygroup field to the characters table
-- for in-game permissions
ALTER TABLE `characters`
ADD COLUMN `securitygroup` int unsigned NULL DEFAULT '0' AFTER `extraBonusTalentCount`;