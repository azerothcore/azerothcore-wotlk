-- Remove non-existent Fingers of Frost script entries
-- spell_mage_fingers_of_frost_proc and spell_mage_fingers_of_frost_proc_aura don't exist in code
-- The proc system now handles charge consumption via PrepareProcToTrigger
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_mage_fingers_of_frost_proc';
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_mage_fingers_of_frost_proc_aura';

-- Sheath of Light: procs on critical heals (from TrinityCore)
-- ProcFlags=0 uses DBC flags, SpellTypeMask=2 (HEAL), SpellPhaseMask=2 (HIT), HitMask=2 (CRITICAL)
DELETE FROM `spell_proc` WHERE `SpellId` = -53501;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-53501, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0);
