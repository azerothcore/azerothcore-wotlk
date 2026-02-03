-- DB update 2026_02_02_01 -> 2026_02_03_00
-- Add parent rotation columns to gameobject_addon table for transport rotation support
ALTER TABLE `gameobject_addon`
  ADD COLUMN `parent_rotation0` FLOAT NOT NULL DEFAULT 0 AFTER `guid`,
  ADD COLUMN `parent_rotation1` FLOAT NOT NULL DEFAULT 0 AFTER `parent_rotation0`,
  ADD COLUMN `parent_rotation2` FLOAT NOT NULL DEFAULT 0 AFTER `parent_rotation1`,
  ADD COLUMN `parent_rotation3` FLOAT NOT NULL DEFAULT 1 AFTER `parent_rotation2`;
