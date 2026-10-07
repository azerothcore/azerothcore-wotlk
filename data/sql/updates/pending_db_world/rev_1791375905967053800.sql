-- Test content: two copies of the same teleport portal, to compare the old full-row `spell_dbc` format
-- with the new partial (NULL) format. Both teleport to (-14295.623, 532.61017, 9) on Eastern Kingdoms.
-- Safe spot for both factions, Booty Bay as the testing ground
-- .go xyz -14295.623 532.61017 9 0 5.9089246
SET @GO_NULL      := 935000;
SET @GO_FILLED    := @GO_NULL + 1;
SET @SPELL_NULL   := 250150;
SET @SPELL_FILLED := @SPELL_NULL + 1;
SET @GUID_NULL    := 5759525;
SET @GUID_FILLED  := @GUID_NULL + 1;

DELETE FROM `gameobject_template` WHERE `entry` IN (@GO_NULL, @GO_FILLED);
INSERT INTO `gameobject_template` (
    `entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`,
    `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`,
    `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`,
    `VerifiedBuild`
) VALUES
(@GO_NULL, 22, 6956, 'Portal Null DBC', '', '', '', 1, @SPELL_NULL,
    0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340),
(@GO_FILLED, 22, 6956, 'Portal filled DBC', '', '', '', 1, @SPELL_FILLED,
    0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);

-- Spawns next to the Booty Bay safe spot
DELETE FROM `gameobject` WHERE `id` IN (@GO_NULL, @GO_FILLED) AND `guid` IN (@GUID_NULL, @GUID_FILLED);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`,
    `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`,
    `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(@GUID_NULL, @GO_NULL, 0, 0, 0, 1, 1, -14291.9, 529.887, 8.93718, 2.76341, 0, 0, 0.982175, 0.187969, 300, 0, 1, '',
    NULL, 'Custom Pull Request Test'),
(@GUID_FILLED, @GO_FILLED, 0, 0, 0, 1, 1, -14290.2, 533.953, 8.93221, 2.74377, 0, 0, 0.980282, 0.197602, 300, 0, 1, '',
    NULL, 'Custom Pull Request Test');

-- New format: only the columns that are not 0 / empty, every other column is left NULL
DELETE FROM `spell_dbc` WHERE `ID` = @SPELL_NULL;
INSERT INTO `spell_dbc` (
    `ID`, `CastingTimeIndex`, `ProcChance`, `RangeIndex`, `EquippedItemClass`, `Effect_1`, `Effect_2`,
    `EffectDieSides_1`, `EffectBasePoints_1`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetB_1`,
    `SpellIconID`, `Name_Lang_enUS`, `Name_Lang_Mask`, `NameSubtext_Lang_Mask`, `Description_Lang_Mask`,
    `AuraDescription_Lang_Mask`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`, `SchoolMask`,
    `EffectBonusMultiplier_2`, `EffectBonusMultiplier_3`
) VALUES (
    @SPELL_NULL, 1, 101, 12, -1, 5, 77, 1, -1, 25, 25, 17, 1481, 'Portal Null DBC', 16712190, 16712172, 16712188,
    16712188, 1, 1, 1, 1, 1
);

-- Old format: every column filled
DELETE FROM `spell_dbc` WHERE `ID` = @SPELL_FILLED;
INSERT INTO `spell_dbc` (
    `ID`, `Category`, `DispelType`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`,
    `AttributesEx4`, `AttributesEx5`, `AttributesEx6`, `AttributesEx7`, `ShapeshiftMask`, `unk_320_2`,
    `ShapeshiftExclude`, `unk_320_3`, `Targets`, `TargetCreatureType`, `RequiresSpellFocus`, `FacingCasterFlags`,
    `CasterAuraState`, `TargetAuraState`, `ExcludeCasterAuraState`, `ExcludeTargetAuraState`, `CasterAuraSpell`,
    `TargetAuraSpell`, `ExcludeCasterAuraSpell`, `ExcludeTargetAuraSpell`, `CastingTimeIndex`, `RecoveryTime`,
    `CategoryRecoveryTime`, `InterruptFlags`, `AuraInterruptFlags`, `ChannelInterruptFlags`, `ProcTypeMask`,
    `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `PowerType`, `ManaCost`,
    `ManaCostPerLevel`, `ManaPerSecond`, `ManaPerSecondPerLevel`, `RangeIndex`, `Speed`, `ModalNextSpell`,
    `CumulativeAura`, `Totem_1`, `Totem_2`, `Reagent_1`, `Reagent_2`, `Reagent_3`, `Reagent_4`, `Reagent_5`,
    `Reagent_6`, `Reagent_7`, `Reagent_8`, `ReagentCount_1`, `ReagentCount_2`, `ReagentCount_3`, `ReagentCount_4`,
    `ReagentCount_5`, `ReagentCount_6`, `ReagentCount_7`, `ReagentCount_8`, `EquippedItemClass`, `EquippedItemSubclass`,
    `EquippedItemInvTypes`, `Effect_1`, `Effect_2`, `Effect_3`, `EffectDieSides_1`, `EffectDieSides_2`,
    `EffectDieSides_3`, `EffectRealPointsPerLevel_1`, `EffectRealPointsPerLevel_2`, `EffectRealPointsPerLevel_3`,
    `EffectBasePoints_1`, `EffectBasePoints_2`, `EffectBasePoints_3`, `EffectMechanic_1`, `EffectMechanic_2`,
    `EffectMechanic_3`, `ImplicitTargetA_1`, `ImplicitTargetA_2`, `ImplicitTargetA_3`, `ImplicitTargetB_1`,
    `ImplicitTargetB_2`, `ImplicitTargetB_3`, `EffectRadiusIndex_1`, `EffectRadiusIndex_2`, `EffectRadiusIndex_3`,
    `EffectAura_1`, `EffectAura_2`, `EffectAura_3`, `EffectAuraPeriod_1`, `EffectAuraPeriod_2`, `EffectAuraPeriod_3`,
    `EffectMultipleValue_1`, `EffectMultipleValue_2`, `EffectMultipleValue_3`, `EffectChainTargets_1`,
    `EffectChainTargets_2`, `EffectChainTargets_3`, `EffectItemType_1`, `EffectItemType_2`, `EffectItemType_3`,
    `EffectMiscValue_1`, `EffectMiscValue_2`, `EffectMiscValue_3`, `EffectMiscValueB_1`, `EffectMiscValueB_2`,
    `EffectMiscValueB_3`, `EffectTriggerSpell_1`, `EffectTriggerSpell_2`, `EffectTriggerSpell_3`,
    `EffectPointsPerCombo_1`, `EffectPointsPerCombo_2`, `EffectPointsPerCombo_3`, `EffectSpellClassMaskA_1`,
    `EffectSpellClassMaskA_2`, `EffectSpellClassMaskA_3`, `EffectSpellClassMaskB_1`, `EffectSpellClassMaskB_2`,
    `EffectSpellClassMaskB_3`, `EffectSpellClassMaskC_1`, `EffectSpellClassMaskC_2`, `EffectSpellClassMaskC_3`,
    `SpellVisualID_1`, `SpellVisualID_2`, `SpellIconID`, `ActiveIconID`, `SpellPriority`, `Name_Lang_enUS`,
    `Name_Lang_enGB`, `Name_Lang_koKR`, `Name_Lang_frFR`, `Name_Lang_deDE`, `Name_Lang_enCN`, `Name_Lang_zhCN`,
    `Name_Lang_enTW`, `Name_Lang_zhTW`, `Name_Lang_esES`, `Name_Lang_esMX`, `Name_Lang_ruRU`, `Name_Lang_ptPT`,
    `Name_Lang_ptBR`, `Name_Lang_itIT`, `Name_Lang_Unk`, `Name_Lang_Mask`, `NameSubtext_Lang_enUS`,
    `NameSubtext_Lang_enGB`, `NameSubtext_Lang_koKR`, `NameSubtext_Lang_frFR`, `NameSubtext_Lang_deDE`,
    `NameSubtext_Lang_enCN`, `NameSubtext_Lang_zhCN`, `NameSubtext_Lang_enTW`, `NameSubtext_Lang_zhTW`,
    `NameSubtext_Lang_esES`, `NameSubtext_Lang_esMX`, `NameSubtext_Lang_ruRU`, `NameSubtext_Lang_ptPT`,
    `NameSubtext_Lang_ptBR`, `NameSubtext_Lang_itIT`, `NameSubtext_Lang_Unk`, `NameSubtext_Lang_Mask`,
    `Description_Lang_enUS`, `Description_Lang_enGB`, `Description_Lang_koKR`, `Description_Lang_frFR`,
    `Description_Lang_deDE`, `Description_Lang_enCN`, `Description_Lang_zhCN`, `Description_Lang_enTW`,
    `Description_Lang_zhTW`, `Description_Lang_esES`, `Description_Lang_esMX`, `Description_Lang_ruRU`,
    `Description_Lang_ptPT`, `Description_Lang_ptBR`, `Description_Lang_itIT`, `Description_Lang_Unk`,
    `Description_Lang_Mask`, `AuraDescription_Lang_enUS`, `AuraDescription_Lang_enGB`, `AuraDescription_Lang_koKR`,
    `AuraDescription_Lang_frFR`, `AuraDescription_Lang_deDE`, `AuraDescription_Lang_enCN`, `AuraDescription_Lang_zhCN`,
    `AuraDescription_Lang_enTW`, `AuraDescription_Lang_zhTW`, `AuraDescription_Lang_esES`, `AuraDescription_Lang_esMX`,
    `AuraDescription_Lang_ruRU`, `AuraDescription_Lang_ptPT`, `AuraDescription_Lang_ptBR`, `AuraDescription_Lang_itIT`,
    `AuraDescription_Lang_Unk`, `AuraDescription_Lang_Mask`, `ManaCostPct`, `StartRecoveryCategory`,
    `StartRecoveryTime`, `MaxTargetLevel`, `SpellClassSet`, `SpellClassMask_1`, `SpellClassMask_2`, `SpellClassMask_3`,
    `MaxTargets`, `DefenseType`, `PreventionType`, `StanceBarOrder`, `EffectChainAmplitude_1`, `EffectChainAmplitude_2`,
    `EffectChainAmplitude_3`, `MinFactionID`, `MinReputation`, `RequiredAuraVision`, `RequiredTotemCategoryID_1`,
    `RequiredTotemCategoryID_2`, `RequiredAreasID`, `SchoolMask`, `RuneCostID`, `SpellMissileID`, `PowerDisplayID`,
    `EffectBonusMultiplier_1`, `EffectBonusMultiplier_2`, `EffectBonusMultiplier_3`, `SpellDescriptionVariableID`,
    `SpellDifficultyID`
) VALUES (
    @SPELL_FILLED, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
    101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 5,
    77, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 25, 25, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1481, 0, 0, 'Portal filled DBC', '', '', '',
    '', '', '', '', '', '', '', '', '', '', '', '', 16712190, '', '', '', '', '', '', '', '', '', '', '', '', '', '',
    '', '', 16712172, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712188, '', '', '', '', '', '',
    '', '', '', '', '', '', '', '', '', '', 16712188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 1, 1, 0, 0
);

DELETE FROM `spell_target_position` WHERE `ID` IN (@SPELL_NULL, @SPELL_FILLED);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`,
    `VerifiedBuild`) VALUES
(@SPELL_NULL, 0, 0, -14295.623, 532.61017, 9, 5.9089246, 0),
(@SPELL_FILLED, 0, 0, -14295.623, 532.61017, 9, 5.9089246, 0);
