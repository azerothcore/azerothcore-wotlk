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

-- Light's Grace (31834) - Remove erroneous spell_proc entry that caused buff to consume itself immediately
-- The buff should passively reduce Holy Light cast time while active, not have proc behavior
DELETE FROM `spell_proc` WHERE `SpellId` = 31834;

-- Mage spell scripts from TrinityCore proc system port
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-5143, -31661, -44614, 45438, 44401);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-5143, 'spell_mage_arcane_missiles'),
(-31661, 'spell_mage_dragon_breath'),
(-44614, 'spell_mage_frostfire_bolt'),
(45438, 'spell_mage_ice_block'),
(44401, 'spell_mage_missile_barrage_proc');
