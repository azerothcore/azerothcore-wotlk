-- Glyph of Life Tap: include the actual Life Tap cast (positive magic spell).
-- The aura script excludes the secondary energize spells to avoid duplicate procs.
UPDATE `spell_proc` SET `ProcFlags` = `ProcFlags` | 16384 WHERE `SpellId` = 63320;
