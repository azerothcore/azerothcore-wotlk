-- ============================================================================
-- Black Rose: Rosy's Magic Sticks.
--
-- Adds slot-specific consumables that recover one socketed Ribbon, Mist, or
-- Jewel from The Black Rose and place the matching gem item in the inventory.
-- ============================================================================

SET @ROSY := 900140;
SET @BLACK_ROSE_TRINKET := 900105;
SET @MAGIC_STICK_USE := 900904;

SET @BLACK_MIASMA := 900200;
SET @BLACK_PETALS := 900201;
SET @BLACK_THORNS := 900202;

SET @MIA_EXT_T2 := 900701;
SET @PETAL_EXT_T2 := 900711;
SET @THORN_EXT_T2 := 900721;

SET @RIBBON_STICK := 901300;
SET @MIST_STICK := 901301;
SET @JEWEL_STICK := 901302;
SET @STICK_DISPLAY := 901300;

-- ----------------------------------------------------------------------------
-- Spell row: a harmless on-use trigger intercepted by item_black_rose_magic_stick.
-- ----------------------------------------------------------------------------
DELETE FROM `spell_dbc` WHERE `ID` = @MAGIC_STICK_USE;
INSERT INTO `spell_dbc`
    (`ID`, `Attributes`, `CastingTimeIndex`, `DurationIndex`, `RangeIndex`,
     `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`,
     `Effect_1`, `EffectDieSides_1`, `EffectBasePoints_1`,
     `ImplicitTargetA_1`, `EffectAura_1`, `SpellIconID`, `ActiveIconID`,
     `Name_Lang_enUS`, `Name_Lang_Mask`,
     `Description_Lang_enUS`, `Description_Lang_Mask`,
     `AuraDescription_Lang_enUS`, `AuraDescription_Lang_Mask`, `SchoolMask`)
VALUES
    (@MAGIC_STICK_USE, 384, 1, 0, 1,
     -1, 0, 0,
     3, 1, 0, 1, 0, 0, 0,
     'Recover Black Rose Gem', 1,
     'Use to recover a socketed Black Rose gem.', 1,
     '', 0, 1);

-- ----------------------------------------------------------------------------
-- Shared item display row for all three sticks.
-- ----------------------------------------------------------------------------
DELETE FROM `itemdisplayinfo_dbc` WHERE `ID` = @STICK_DISPLAY;
INSERT INTO `itemdisplayinfo_dbc`
    (`ID`, `ModelName_1`, `ModelName_2`, `ModelTexture_1`,
     `ModelTexture_2`, `InventoryIcon_1`, `InventoryIcon_2`,
     `GeosetGroup_1`, `GeosetGroup_2`, `GeosetGroup_3`, `Flags`,
     `SpellVisualID`, `GroupSoundIndex`, `HelmetGeosetVis_1`,
     `HelmetGeosetVis_2`, `Texture_1`, `Texture_2`, `Texture_3`,
     `Texture_4`, `Texture_5`, `Texture_6`, `Texture_7`, `Texture_8`,
     `ItemVisual`, `ParticleColorID`)
VALUES
    (@STICK_DISPLAY, '', '', '', '', 'INV_BR_Misc_RosysMagicStick', '',
     0, 0, 0, 0,
     0, 0, 0,
     0, '', '', '',
     '', '', '', '', '',
     0, 0);

-- ----------------------------------------------------------------------------
-- Consumable sticks.
-- ----------------------------------------------------------------------------
DELETE FROM `item_template`
WHERE `entry` IN (@RIBBON_STICK, @MIST_STICK, @JEWEL_STICK);

INSERT INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `spellid_1`,
     `spelltrigger_1`, `spellcooldown_1`, `bonding`, `description`,
     `Material`, `ScriptName`, `VerifiedBuild`)
VALUES
    (@RIBBON_STICK, 12, 0, -1, 'Rosy''s Ribbon Stick',
     @STICK_DISPLAY, 3, 64, 1, 0, 0,
     0, -1, -1, 20,
     20, 0, 1, @MAGIC_STICK_USE,
     0, 1000, 1,
     'Use to recover the socketed Ribbon from The Black Rose.',
     -1, 'item_black_rose_magic_stick', 0),
    (@MIST_STICK, 12, 0, -1, 'Rosy''s Mist Stick',
     @STICK_DISPLAY, 3, 64, 1, 0, 0,
     0, -1, -1, 20,
     20, 0, 1, @MAGIC_STICK_USE,
     0, 1000, 1,
     'Use to recover the socketed Mist from The Black Rose.',
     -1, 'item_black_rose_magic_stick', 0),
    (@JEWEL_STICK, 12, 0, -1, 'Rosy''s Jewel Stick',
     @STICK_DISPLAY, 3, 64, 1, 0, 0,
     0, -1, -1, 20,
     20, 0, 1, @MAGIC_STICK_USE,
     0, 1000, 1,
     'Use to recover the socketed Jewel from The Black Rose.',
     -1, 'item_black_rose_magic_stick', 0);

-- ----------------------------------------------------------------------------
-- Rosy vendor entries and ownership gates.
-- ----------------------------------------------------------------------------
DELETE FROM `npc_vendor`
WHERE `entry` = @ROSY
  AND `item` IN (@RIBBON_STICK, @MIST_STICK, @JEWEL_STICK);

INSERT INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`,
     `VerifiedBuild`)
VALUES
    (@ROSY, 700, @RIBBON_STICK, 0, 0, @MIA_EXT_T2, 0),
    (@ROSY, 701, @MIST_STICK, 0, 0, @PETAL_EXT_T2, 0),
    (@ROSY, 702, @JEWEL_STICK, 0, 0, @THORN_EXT_T2, 0);

DELETE FROM `conditions`
WHERE `SourceTypeOrReferenceId` = 23
  AND `SourceGroup` = @ROSY
  AND `SourceEntry` IN (@RIBBON_STICK, @MIST_STICK, @JEWEL_STICK);

INSERT INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
     `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
     `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
     `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`,
     `Comment`)
VALUES
    (23, @ROSY, @RIBBON_STICK, 0,
     0, 2, 0,
     @BLACK_ROSE_TRINKET, 1, 0,
     0, 0, 0, '',
     'Rosy sells Ribbon Stick only to players with The Black Rose'),
    (23, @ROSY, @MIST_STICK, 0,
     0, 2, 0,
     @BLACK_ROSE_TRINKET, 1, 0,
     0, 0, 0, '',
     'Rosy sells Mist Stick only to players with The Black Rose'),
    (23, @ROSY, @JEWEL_STICK, 0,
     0, 2, 0,
     @BLACK_ROSE_TRINKET, 1, 0,
     0, 0, 0, '',
     'Rosy sells Jewel Stick only to players with The Black Rose');
