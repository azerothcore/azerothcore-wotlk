-- QAston Proc System - Add DisableEffectsMask column to spell_proc table
-- Schema change separated from data changes to avoid re-run issues
ALTER TABLE `spell_proc` ADD COLUMN `DisableEffectsMask` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `AttributesMask`;
