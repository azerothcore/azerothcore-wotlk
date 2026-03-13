-- DB update 2026_02_18_01 -> 2026_02_18_02
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

-- Mage spell scripts from TrinityCore proc system port
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-5143, -31661, -44614, 45438, 44401);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-5143, 'spell_mage_arcane_missiles'),
(-31661, 'spell_mage_dragon_breath'),
(-44614, 'spell_mage_frostfire_bolt'),
(45438, 'spell_mage_ice_block'),
(44401, 'spell_mage_missile_barrage_proc');

-- Paladin scripts refactored from hardcoded SpellAuras.cpp and Spell.cpp to proper scripts
-- Aura Mastery (31821) - Applies/removes Aura Mastery Immune aura
DELETE FROM `spell_script_names` WHERE `spell_id` = 31821;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(31821, 'spell_pal_aura_mastery');

-- Aura Mastery Immune (64364) - Area target check to filter immunity to only Concentration Aura targets
DELETE FROM `spell_script_names` WHERE `spell_id` = 64364;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(64364, 'spell_pal_aura_mastery_immune');

-- Beacon of Light (53563) - Periodic tick handler to ensure correct caster GUID propagation
DELETE FROM `spell_script_names` WHERE `spell_id` = 53563 AND `ScriptName` = 'spell_pal_beacon_of_light';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(53563, 'spell_pal_beacon_of_light');

-- Sacred Shield (58597) - Absorb amount calculation with ICC buff support
DELETE FROM `spell_script_names` WHERE `spell_id` = 58597 AND `ScriptName` = 'spell_pal_sacred_shield';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(58597, 'spell_pal_sacred_shield');

-- Divine Protection (498), Divine Shield (642), Hand of Protection (-1022)
-- Applies Forbearance, Avenging Wrath marker, and Immune Shield marker
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_pal_immunities';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(498, 'spell_pal_immunities'),
(642, 'spell_pal_immunities'),
(-1022, 'spell_pal_immunities');

-- Improved Concentration Aura (-20254), Improved Devotion Aura (-20138)
-- Sanctified Retribution (31869), Swift Retribution (-53379)
-- Handles applying/removing the improved aura buff effects
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_pal_improved_concentraction_aura', 'spell_pal_improved_devotion_aura', 'spell_pal_sanctified_retribution', 'spell_pal_swift_retribution');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-20254, 'spell_pal_improved_concentraction_aura'),
(-20138, 'spell_pal_improved_devotion_aura'),
(31869, 'spell_pal_sanctified_retribution'),
(-53379, 'spell_pal_swift_retribution');

-- Warrior scripts - Vigilance redirect threat and Warrior's Wrath (T2 5P)
DELETE FROM `spell_script_names` WHERE `spell_id` IN (59665, 21977);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(59665, 'spell_warr_vigilance_redirect_threat'),
(21977, 'spell_warr_warriors_wrath');

-- Druid Forms Trinket (37336) - SpellPhaseMask required for proc system
-- ProcFlags=0 uses DBC flags (0x15414), Chance=0 uses DBC chance (3%)
DELETE FROM `spell_proc` WHERE `SpellId` = 37336;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(37336, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0);

-- Living Root of the Wildheart (37336) - Item trinket script
DELETE FROM `spell_script_names` WHERE `spell_id` = 37336;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37336, 'spell_item_living_root_of_the_wildheart');

-- Druid scripts ported from TrinityCore
-- Frenzied Regeneration (22842) - Converts rage to health
-- Nourish (50464) - Glyph of Nourish support
-- Insect Swarm (-5570) - T8 Balance Relic support
-- T9 Feral Relic (67353) - Idol of Mutilation form-specific procs
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_dru_frenzied_regeneration', 'spell_dru_nourish', 'spell_dru_insect_swarm', 'spell_dru_t9_feral_relic');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(22842, 'spell_dru_frenzied_regeneration'),
(50464, 'spell_dru_nourish'),
(-5570, 'spell_dru_insect_swarm'),
(67353, 'spell_dru_t9_feral_relic');

-- Priest scripts ported from TrinityCore
-- Pain and Suffering (-47580) - Prevents EFFECT_1 DUMMY from proccing
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_pri_pain_and_suffering_dummy';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(47580, 'spell_pri_pain_and_suffering_dummy'),
(47581, 'spell_pri_pain_and_suffering_dummy');
