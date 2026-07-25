-- Adds a generic "ghost charge" window for charge-based proc auras: keeps the aura
-- alive for ChargeDropDelay ms after its last charge is consumed instead of removing
-- it immediately, so an instant cast already queued in the same batch can still use it.
ALTER TABLE `spell_proc` ADD COLUMN `ChargeDropDelay` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `Charges`;

-- 74396 - Fingers of Frost (Mage): already has a row, just add the delay.
UPDATE `spell_proc` SET `ChargeDropDelay` = 400 WHERE `SpellId` = 74396;

-- 20216 - Divine Favor (Paladin): had no row (ran purely on the DBC-derived auto-generated
-- proc entry). Values below mirror exactly what SpellMgr::LoadSpellProcs() auto-generates
-- for it today, so this only adds ChargeDropDelay without changing existing proc behavior.
DELETE FROM `spell_proc` WHERE `SpellId` = 20216;
INSERT INTO `spell_proc`
    (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`, `ChargeDropDelay`)
VALUES
    (20216, 0, 10, 3223322624, 0, 0, 81920, 7, 2, 0, 8, 0, 0, 100, 0, 1, 400);
