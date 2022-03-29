INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647677899565690722');

ALTER TABLE `spell_proc`
    CHANGE `spellId` `SpellId` int(11) NOT NULL DEFAULT 0 FIRST,
    CHANGE `schoolMask` `SchoolMask` tinyint(3) unsigned NOT NULL DEFAULT 0 AFTER `SpellId`,
    CHANGE `spellFamilyName` `SpellFamilyName` smallint(5) unsigned NOT NULL DEFAULT 0 AFTER `SchoolMask`,
    CHANGE `spellFamilyMask0` `SpellFamilyMask0` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellFamilyName`,
    CHANGE `spellFamilyMask1` `SpellFamilyMask1` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellFamilyMask0`,
    CHANGE `spellFamilyMask2` `SpellFamilyMask2` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellFamilyMask1`,
    CHANGE `typeMask` `ProcFlags` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellFamilyMask2`,
    CHANGE `spellTypeMask` `SpellTypeMask` int(10) unsigned NOT NULL DEFAULT 0 AFTER `ProcFlags`,
    CHANGE `spellPhaseMask` `SpellPhaseMask` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellTypeMask`,
    CHANGE `hitMask` `HitMask` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellPhaseMask`,
    CHANGE `attributesMask` `AttributesMask` int(10) unsigned NOT NULL DEFAULT 0 AFTER `HitMask`,
    CHANGE `ratePerMinute` `ProcsPerMinute` float NOT NULL DEFAULT 0 AFTER `AttributesMask`,
    CHANGE `chance` `Chance` float NOT NULL DEFAULT 0 AFTER `ProcsPerMinute`,
    CHANGE `cooldown` `Cooldown` int(10) unsigned NOT NULL DEFAULT 0 AFTER `Chance`,
    CHANGE `charges` `Charges` tinyint(3) unsigned NOT NULL DEFAULT 0 AFTER `Cooldown`;

DELETE FROM `command` WHERE `name`='reload spell_proc_event';

DELETE FROM `spell_script_names` WHERE `ScriptName` IN
('spell_mage_blazing_speed','spell_pri_blessed_recovery','spell_dru_forms_trinket','spell_dru_t9_feral_relic',
'spell_sha_nature_guardian','spell_warl_nether_protection','spell_hun_piercing_shots','spell_hun_t9_4p_bonus',
'spell_sha_lightning_shield','spell_dk_acclimation','spell_dk_advantage_t10_4p',
'spell_rog_t10_2p_bonus','spell_pal_illumination','spell_item_soul_preserver','spell_item_death_choice',
'spell_item_lightning_capacitor','spell_item_thunder_capacitor','spell_item_toc25_normal_caster_trinket','spell_item_toc25_heroic_caster_trinket',
'spell_igb_battle_experience_check','spell_gen_blood_reserve','spell_item_darkmoon_card_greatness',
'spell_item_charm_witch_doctor','spell_item_mana_drain', 'spell_item_blood_draining_enchant', 'spell_anetheron_vampiric_aura', 'spell_uk_second_wind'
'spell_deathbringer_blood_beast_blood_link', 'spell_putricide_ooze_tank_protection', 'spell_mark_of_malice', 'spell_twisted_reflection'
'spell_pet_guard_dog', 'spell_pet_silverback', 'spell_pet_culling_the_herd');
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_proc_above_75' AND `spell_id` = 64568;

INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(-49200, 'spell_dk_acclimation'),                       -- DK Acclimation
(70656, 'spell_dk_advantage_t10_4p'),                   -- DK Advantage t10 4p melee
(37336, 'spell_dru_forms_trinket'),                     -- Druid Forms Trinket
(67353, 'spell_dru_t9_feral_relic'),                    -- Druid T9 Feral Relic (Idol of Mutilation)
(-53234, 'spell_hun_piercing_shots'),                   -- Hunter Piercing Shots
(-67151, 'spell_hun_t9_4p_bonus'),                      -- Hunter T9 Bonus
(71201, 'spell_igb_battle_experience_check'),           -- Battle Experience (Gunship - ICC)
(60510, 'spell_item_soul_preserver'),                   -- Soul Preserver
(67702, 'spell_item_death_choice'),                     -- Death Choice Trinket
(67771, 'spell_item_death_choice'),                     -- Death Choice Trinket
(37657, 'spell_item_lightning_capacitor'),              -- Lightning Capcitor
(54841, 'spell_item_thunder_capacitor'),                -- Thunder Capacitor
(67712, 'spell_item_toc25_normal_caster_trinket'),      -- Item - Coliseum 25 Normal Caster Trinket
(67758, 'spell_item_toc25_heroic_caster_trinket'),      -- Item - Coliseum 25 Heroic Caster Trinket
(57345, 'spell_item_darkmoon_card_greatness'),          -- Darkmoon Card: Greatness
(43820, 'spell_item_charm_witch_doctor'),               -- Charm of the Witch Doctor
(27522, 'spell_item_mana_drain'),                       -- Mana Drain
(40336, 'spell_item_mana_drain'),                       -- Mana Drain
(-31641, 'spell_mage_blazing_speed'),                   -- Mage Blazing Speed
(-20210, 'spell_pal_illumination'),                     -- Paladin Illumination (for Holy Shock)
(-27811, 'spell_pri_blessed_recovery'),                 -- Priest Blessed Recovery
(-30881, 'spell_sha_nature_guardian'),                  -- Shaman Nature's Guardian
(-324, 'spell_sha_lightning_shield'),                   -- Shaman Lightning Shield
(38196,  'spell_anetheron_vampiric_aura'),
(42770,  'spell_uk_second_wind'),
(72176,  'spell_deathbringer_blood_beast_blood_link'),
(71770,  'spell_putricide_ooze_tank_protection'),
(33493,  'spell_mark_of_malice'),
(21063,  'spell_twisted_reflection'),
(-53178, 'spell_pet_guard_dog'),
(-62764, 'spell_pet_silverback'),
(-61680, 'spell_pet_culling_the_herd'),
(-30299, 'spell_warl_nether_protection');               -- Warlock Nether protection

UPDATE `spell_proc` SET `SpellPhaseMask`=0x2 WHERE `SpellId` IN (
-61846, -- Aspect of the Dragonhawk
-13165, -- Aspect of the Hawk
7434,   -- Fate Rune of Unsurpassed Vigor
39958,  -- Skyfire Swiftness
55380,  -- Skyflare Swiftness
70727   -- Item - Hunter T10 2P Bonus
);

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_pain_and_suffering_dummy';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-47580, 'spell_pri_pain_and_suffering_dummy');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_item_argent_dawn_commission','spell_warr_victorious','spell_dk_rune_strike_proc','spell_pet_charge');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(17670, 'spell_item_argent_dawn_commission'),
(32216, 'spell_warr_victorious'),
(56817, 'spell_dk_rune_strike_proc'),
(57627, 'spell_pet_charge');

-- Item - Icecrown Reputation Ring Healer Trigger, spell should proc on cast
UPDATE `spell_proc` SET `SpellPhaseMask`=1 WHERE `SpellId`=72419;

-- Maelstrom Weapon
DELETE FROM `spell_proc` WHERE `SpellId`=53817;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(53817, 0, 11, 0x000001C3, 0x00008000, 0x00000000, 0, 0x0, 0x1, 0x0, 0x8, 0, 0, 0, 0);

-- Savage Combat
DELETE FROM `spell_proc` WHERE `SpellId`=-51682;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-51682, 0, 8, 0x00000000, 0x00080000, 0x00000000, 0, 0x4, 0x2, 0x0, 0x2, 0, 0, 0, 0);

-- DELETE FROM `spell_dbc` WHERE `Id`=45176;
-- INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `AttributesEx6`, `AttributesEx7`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectItemType1`, `EffectItemType2`, `EffectItemType3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
-- (45176, 0, 0, 0x00000000, 0x00000000, 0x00000000, 0x00010000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 29, 6, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 197, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 8, 'Master Poisoner Trigger');

-- Master Poisoner
DELETE FROM `spell_proc` WHERE `SpellId`=-31226;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-31226, 0, 8, 0x00000000, 0x00080000, 0x00000000, 0, 0x5, 0x2, 0x0, 0x2, 0, 0, 0, 0);

-- Seal Fate
UPDATE `spell_proc` SET `SpellFamilyMask0`=0x4200020E, `SpellFamilyMask1`=0x00000002, `AttributesMask`=0x2 WHERE `SpellId`=-14186;

-- Recklessness
UPDATE `spell_proc` SET `SpellTypeMask`=0x1, `SpellPhaseMask`=0x2, `AttributesMask`=0x8 WHERE `SpellId`=1719;

-- Sweeping Strikes
DELETE FROM `spell_proc` WHERE `SpellId`=12328;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(12328, 0, 4, 0x00000000, 0x00000000, 0x00000000, 0, 0x1, 0x2, 0x0, 0x2, 0, 0, 0, 0);

-- Lock and Load
UPDATE `spell_proc` SET `SpellPhaseMask`=0x2 WHERE `SpellId`=-56342;

-- Entrapment
UPDATE `spell_proc` SET `SpellPhaseMask`=0x4 WHERE `SpellId`=-19184;

-- Pet Healing
UPDATE `spell_proc` SET `AttributesMask`=0x2 WHERE `SpellId`=37381;

-- Inferno Flame aura stack drop
UPDATE `spell_proc` SET `SchoolMask`=0x4, `AttributesMask` = 0x2 WHERE `SpellId` IN (71756, 72782, 72783, 72784);

-- Fel Synergy
DELETE FROM `spell_proc` WHERE `SpellId`=-47230;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(-47230, 0, 0, 0x00000000, 0x00000000, 0x00000000, 0, 0x1, 0x2, 0x0, 0x2, 0, 0, 0, 0);

-- Entrapment
UPDATE `spell_proc` SET `AttributesMask`=0x2 WHERE `SpellId`=-19184;

-- Infusion of Light proc
UPDATE `spell_proc` SET `SpellFamilyMask0` = 0x00200000, `HitMask`=0x2, `AttributesMask`=0x2 WHERE `SpellId` = -53569;

-- Shadow Trance aura drop
UPDATE `spell_proc` SET `AttributesMask`=0x8 WHERE `SpellId`=17941;

-- Anger Capacitor
UPDATE `spell_proc` SET `AttributesMask`=`AttributesMask`|0x2 WHERE `SpellId` IN (71406,71545);

UPDATE `spell_proc` SET `AttributesMask`=(`AttributesMask` & ~0x40) WHERE `SpellId`=-1120;
UPDATE `spell_proc` SET `AttributesMask`=(`AttributesMask` | 0x20 | 0x40) WHERE `SpellId`=51209;
UPDATE `spell_proc` SET `AttributesMask`=(`AttributesMask` | 0x10) WHERE `SpellId`=56817;
UPDATE `spell_proc` SET `AttributesMask`=(`AttributesMask` | 0x20) WHERE `SpellId`=-44445;
UPDATE `spell_proc` SET `AttributesMask`=(`AttributesMask` | 0x10) WHERE `SpellId`=32216;

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_item_argent_dawn_commission', 'spell_dk_rune_strike_proc', 'spell_warr_victorious');

-- Paladin T8 Holy 2P Bonus proc
UPDATE `spell_proc` SET `AttributesMask`=0x2  WHERE `SpellId`=64890;
