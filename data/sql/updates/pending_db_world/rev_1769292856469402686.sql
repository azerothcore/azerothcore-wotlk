-- Lock and Load - Add spell_proc entry with correct SpellPhaseMask for periodic damage procs
-- SpellPhaseMask changed from 4 (PROC_SPELL_PHASE_FINISH) to 2 (PROC_SPELL_PHASE_HIT)
-- This allows Black Arrow, Explosive Trap, and Immolation Trap periodic damage to trigger Lock and Load
DELETE FROM `spell_proc` WHERE `SpellId` = -56342;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-56342, 0, 9, 24, 134217728, 147456, 0, 0, 2, 0, 2, 0, 0, 0, 22000, 0);

-- Killing Machine - register spell script
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_dk_killing_machine';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51124, 'spell_dk_killing_machine');

-- Elemental Focus - register spell script to prevent weapon imbue attacks from proccing Clearcasting
DELETE FROM `spell_script_names` WHERE `spell_id` = 16164 AND `ScriptName` = 'spell_sha_elemental_focus';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(16164, 'spell_sha_elemental_focus');

-- Light's Beacon (53651) - Beacon of Light heal transfer script
DELETE FROM `spell_script_names` WHERE `spell_id` = 53651;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(53651, 'spell_pal_light_s_beacon');
