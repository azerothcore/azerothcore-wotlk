-- ============================================================================
-- Black Rose module: world content snapshot
--
-- Items, NPCs, quest, vendor, and conditions for the Black Rose module.
-- DBC overrides (spell_dbc, gemproperties_dbc, itemextendedcost_dbc, etc.)
-- live in the companion file 2026_05_22_01_blackrose_dbc.sql.
--
-- This file is idempotent: every insert is REPLACE INTO, so re-running on
-- an already-populated database upserts to the canonical state without
-- disturbing player data.
-- ============================================================================

SET @QUEST_ALLIANCE             := 900100;
SET @QUEST_HORDE                := 900101;
SET @GRUFF_SWIFTBITE            := 100;
SET @BAG_26                     := 900102;
SET @NORAH_HORDE                := 900103;
SET @NORAH_ALLIANCE             := 900104;
SET @BLACK_ROSE_TRINKET         := 900105;
SET @BLACK_ROSE_MAULER_REINS    := 900106;
SET @BAG_28                     := 900120;
SET @BAG_30                     := 900121;
SET @BAG_32                     := 900122;
SET @BAG_34                     := 900123;
SET @BAG_36                     := 900124;
SET @UPGRADE_28                 := 900130;
SET @UPGRADE_30                 := 900131;
SET @UPGRADE_32                 := 900132;
SET @UPGRADE_34                 := 900133;
SET @UPGRADE_36                 := 900134;
SET @ROSY                       := 900140;
SET @NORAH_CGUID                := 900110;
SET @ROSY_CGUID                 := 900150;
SET @BLACK_MIASMA               := 900200;
SET @BLACK_PETALS               := 900201;
SET @BLACK_THORNS               := 900202;
SET @RED_GEM_BASE               := 900300;
SET @YELLOW_GEM_BASE            := 900400;
SET @RED_UPGRADE_BASE           := 900500;
SET @YELLOW_UPGRADE_BASE        := 900600;
SET @MIA_EXT_BASE               := 900700;
SET @PETAL_EXT_BASE             := 900710;
SET @BLACK_ROSE_AURA            := 900900;
SET @BLACK_ROSE_UPGRADE_USE     := 900901;
SET @BLACK_ROSE_BAG_UPGRADE_USE := 900902;
SET @BLACK_ROSE_MAULER_MOUNT    := 900903;
SET @BLACK_ROSE_SORT            := 9009;
SET @SPELL_GENERIC_LEARNING     := 483;

-- ----------------------------------------------------------------------------
-- Bags
-- ----------------------------------------------------------------------------

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `ContainerSlots`, `bonding`,
     `Material`, `VerifiedBuild`)
VALUES
    (@BAG_26, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 26, 1,
     8, 0),
    (@BAG_28, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 28, 1,
     8, 0),
    (@BAG_30, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 30, 1,
     8, 0),
    (@BAG_32, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 32, 1,
     8, 0),
    (@BAG_34, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 34, 1,
     8, 0),
    (@BAG_36, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 36, 1,
     8, 0);

-- ----------------------------------------------------------------------------
-- Bag upgrades (sold by Rosy)
-- ----------------------------------------------------------------------------

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `spellid_1`,
     `spelltrigger_1`, `spellcooldown_1`, `bonding`, `description`,
     `Material`, `ScriptName`, `VerifiedBuild`)
VALUES
    (@UPGRADE_28, 12, 0, -1, 'Black Rose Bag Upgrade I',
     8861, 1, 64, 1, 500, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 26-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_30, 12, 0, -1, 'Black Rose Bag Upgrade II',
     8861, 1, 64, 1, 50000, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 28-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_32, 12, 0, -1, 'Black Rose Bag Upgrade III',
     8861, 1, 64, 1, 500000, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 30-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_34, 12, 0, -1, 'Black Rose Bag Upgrade IV',
     8861, 1, 64, 1, 5000000, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 32-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_36, 12, 0, -1, 'Black Rose Bag Upgrade V',
     8861, 1, 64, 1, 500000000, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 34-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0);

-- ----------------------------------------------------------------------------
-- The Black Rose trinket (final stats: +20 to all five slots, founder lore)
-- ----------------------------------------------------------------------------

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `stat_type1`,
     `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`,
     `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
     `stat_value5`, `spellid_1`, `spelltrigger_1`, `spellcooldown_1`,
     `bonding`, `description`, `Material`, `socketColor_1`,
     `socketContent_1`, `socketColor_2`, `socketContent_2`,
     `socketColor_3`, `socketContent_3`, `socketBonus`, `VerifiedBuild`)
VALUES
    (@BLACK_ROSE_TRINKET, 4, 0, -1, 'The Black Rose',
     6483, 6, 1, 0, 0,
     12, -1, -1, 20,
     20, 0, 1, 5,
     20, 4, 20, 6,
     20, 3, 20, 7,
     20, @BLACK_ROSE_AURA, 0, 180000,
     1, 'Worn first by the founders. The Rose remembers.',
     -1, 2, 0, 4, 0,
     8, 0, 0, 0);

-- ----------------------------------------------------------------------------
-- Rurik's Death Mobile (mount item, two-slot Learning format)
--
-- Slot 1: spell 483 (Learning), ON_USE, mount cooldown category 330/3000ms
-- Slot 2: spell 900903 (mount aura), LEARN_SPELL_ID
--
-- This is the canonical AC-recognised pattern (matches stock 41508).
-- Anything else (single-slot LEARN_SPELL_ID, or slot 1 not 483/55884) is
-- silently rejected by ObjectMgr::LoadItemTemplate, leaving the item with
-- no usable spells.
-- ----------------------------------------------------------------------------

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `maxcount`,
     `stackable`, `spellid_1`, `spelltrigger_1`, `spellcooldown_1`,
     `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`,
     `spelltrigger_2`, `spellcooldown_2`, `bonding`, `description`,
     `Material`, `RequiredDisenchantSkill`, `VerifiedBuild`)
VALUES
    (@BLACK_ROSE_MAULER_REINS, 15, 5, -1, 'Rurik''s Death Mobile',
     45364, 4, 1, 0, 0,
     0, -1, -1, 20,
     20, 762, 75, 1,
     1, @SPELL_GENERIC_LEARNING, 0, -1,
     330, 3000, @BLACK_ROSE_MAULER_MOUNT,
     6, 0, 1, 'Teaches you how to summon this mount.',
     -1, -1, 0);

-- ----------------------------------------------------------------------------
-- Currency (Black Miasma, Black Petals, Black Thorns)
-- ----------------------------------------------------------------------------

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `bonding`, `description`,
     `Material`, `VerifiedBuild`)
VALUES
    (@BLACK_MIASMA, 12, 0, -1, 'Black Miasma',
     41375, 1, 1, 0, 0,
     0, -1, -1, 20,
     0, 0, 10000, 0, 'Used by Rosy to shape red Black Rose gems.',
     -1, 0),
    (@BLACK_PETALS, 12, 0, -1, 'Black Petals',
     41376, 1, 1, 0, 0,
     0, -1, -1, 20,
     0, 0, 10000, 0, 'Used by Rosy to shape yellow Black Rose gems.',
     -1, 0),
    (@BLACK_THORNS, 12, 0, -1, 'Black Thorns',
     41377, 1, 1, 0, 0,
     0, -1, -1, 20,
     0, 0, 10000, 0, 'Reserved for future Black Rose class gems.',
     -1, 0);

-- ----------------------------------------------------------------------------
-- Black Rose gems (red ribbons + yellow mists)
-- ----------------------------------------------------------------------------

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `bonding`, `description`,
     `Material`, `GemProperties`, `VerifiedBuild`)
VALUES
    (900300, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 strength when socketed.', -1, 900300, 0),
    (900301, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 strength when socketed.', -1, 900301, 0),
    (900302, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 strength when socketed.', -1, 900302, 0),
    (900303, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 strength when socketed.', -1, 900303, 0),
    (900304, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 strength when socketed.', -1, 900304, 0),
    (900305, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 strength when socketed.', -1, 900305, 0),
    (900306, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 strength when socketed.', -1, 900306, 0),
    (900310, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 intellect when socketed.', -1, 900310, 0),
    (900311, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 intellect when socketed.', -1, 900311, 0),
    (900312, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 intellect when socketed.', -1, 900312, 0),
    (900313, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 intellect when socketed.', -1, 900313, 0),
    (900314, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 intellect when socketed.', -1, 900314, 0),
    (900315, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 intellect when socketed.', -1, 900315, 0),
    (900316, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 intellect when socketed.', -1, 900316, 0),
    (900320, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 spirit when socketed.', -1, 900320, 0),
    (900321, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 spirit when socketed.', -1, 900321, 0),
    (900322, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 spirit when socketed.', -1, 900322, 0),
    (900323, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 spirit when socketed.', -1, 900323, 0),
    (900324, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 spirit when socketed.', -1, 900324, 0),
    (900325, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 spirit when socketed.', -1, 900325, 0),
    (900326, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 spirit when socketed.', -1, 900326, 0),
    (900330, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 agility when socketed.', -1, 900330, 0),
    (900331, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 agility when socketed.', -1, 900331, 0),
    (900332, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 agility when socketed.', -1, 900332, 0),
    (900333, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 agility when socketed.', -1, 900333, 0),
    (900334, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 agility when socketed.', -1, 900334, 0),
    (900335, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 agility when socketed.', -1, 900335, 0),
    (900336, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 agility when socketed.', -1, 900336, 0),
    (900340, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 stamina when socketed.', -1, 900340, 0),
    (900341, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 stamina when socketed.', -1, 900341, 0),
    (900342, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 stamina when socketed.', -1, 900342, 0),
    (900343, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 stamina when socketed.', -1, 900343, 0),
    (900344, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 stamina when socketed.', -1, 900344, 0),
    (900345, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 stamina when socketed.', -1, 900345, 0),
    (900346, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 stamina when socketed.', -1, 900346, 0),
    (900350, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +1 strength and +1 stamina when socketed.', -1, 900350, 0),
    (900351, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +11 strength and +11 stamina when socketed.', -1, 900351, 0),
    (900352, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +21 strength and +21 stamina when socketed.', -1, 900352, 0),
    (900353, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +31 strength and +31 stamina when socketed.', -1, 900353, 0),
    (900354, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +41 strength and +41 stamina when socketed.', -1, 900354, 0),
    (900355, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +51 strength and +51 stamina when socketed.', -1, 900355, 0),
    (900356, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +61 strength and +61 stamina when socketed.', -1, 900356, 0),
    (900360, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +1 intellect and +1 spirit when socketed.', -1, 900360, 0),
    (900361, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +11 intellect and +11 spirit when socketed.', -1, 900361, 0),
    (900362, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +21 intellect and +21 spirit when socketed.', -1, 900362, 0),
    (900363, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +31 intellect and +31 spirit when socketed.', -1, 900363, 0),
    (900364, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +41 intellect and +41 spirit when socketed.', -1, 900364, 0),
    (900365, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +51 intellect and +51 spirit when socketed.', -1, 900365, 0),
    (900366, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +61 intellect and +61 spirit when socketed.', -1, 900366, 0),
    (900370, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +1 strength and +1 agility when socketed.', -1, 900370, 0),
    (900371, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +11 strength and +11 agility when socketed.', -1, 900371, 0),
    (900372, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +21 strength and +21 agility when socketed.', -1, 900372, 0),
    (900373, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +31 strength and +31 agility when socketed.', -1, 900373, 0),
    (900374, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +41 strength and +41 agility when socketed.', -1, 900374, 0),
    (900375, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +51 strength and +51 agility when socketed.', -1, 900375, 0),
    (900376, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +61 strength and +61 agility when socketed.', -1, 900376, 0),
    (900380, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +1 intellect and +1 stamina when socketed.', -1, 900380, 0),
    (900381, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +11 intellect and +11 stamina when socketed.', -1, 900381, 0),
    (900382, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +21 intellect and +21 stamina when socketed.', -1, 900382, 0),
    (900383, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +31 intellect and +31 stamina when socketed.', -1, 900383, 0),
    (900384, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +41 intellect and +41 stamina when socketed.', -1, 900384, 0),
    (900385, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +51 intellect and +51 stamina when socketed.', -1, 900385, 0),
    (900386, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +61 intellect and +61 stamina when socketed.', -1, 900386, 0),
    (900400, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +6 spell power when socketed.', -1, 900400, 0),
    (900401, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +26 spell power when socketed.', -1, 900401, 0),
    (900402, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +86 spell power when socketed.', -1, 900402, 0),
    (900403, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +126 spell power when socketed.', -1, 900403, 0),
    (900404, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +166 spell power when socketed.', -1, 900404, 0),
    (900405, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +206 spell power when socketed.', -1, 900405, 0),
    (900406, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +246 spell power when socketed.', -1, 900406, 0),
    (900410, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +6 attack power when socketed.', -1, 900410, 0),
    (900411, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +26 attack power when socketed.', -1, 900411, 0),
    (900412, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +86 attack power when socketed.', -1, 900412, 0),
    (900413, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +126 attack power when socketed.', -1, 900413, 0),
    (900414, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +166 attack power when socketed.', -1, 900414, 0),
    (900415, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +206 attack power when socketed.', -1, 900415, 0),
    (900416, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +246 attack power when socketed.', -1, 900416, 0),
    (900420, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +6 crit rating when socketed.', -1, 900420, 0),
    (900421, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +26 crit rating when socketed.', -1, 900421, 0),
    (900422, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +86 crit rating when socketed.', -1, 900422, 0),
    (900423, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +126 crit rating when socketed.', -1, 900423, 0),
    (900424, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +166 crit rating when socketed.', -1, 900424, 0),
    (900425, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +206 crit rating when socketed.', -1, 900425, 0),
    (900426, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +246 crit rating when socketed.', -1, 900426, 0),
    (900430, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +6 haste rating when socketed.', -1, 900430, 0),
    (900431, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +26 haste rating when socketed.', -1, 900431, 0),
    (900432, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +86 haste rating when socketed.', -1, 900432, 0),
    (900433, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +126 haste rating when socketed.', -1, 900433, 0),
    (900434, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +166 haste rating when socketed.', -1, 900434, 0),
    (900435, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +206 haste rating when socketed.', -1, 900435, 0),
    (900436, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +246 haste rating when socketed.', -1, 900436, 0),
    (900440, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +10 mana per 5 seconds when socketed.', -1, 900440, 0),
    (900441, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +25 mana per 5 seconds when socketed.', -1, 900441, 0),
    (900442, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +50 mana per 5 seconds when socketed.', -1, 900442, 0),
    (900443, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +75 mana per 5 seconds when socketed.', -1, 900443, 0),
    (900444, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +200 mana per 5 seconds when socketed.', -1, 900444, 0),
    (900445, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +325 mana per 5 seconds when socketed.', -1, 900445, 0),
    (900446, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +525 mana per 5 seconds when socketed.', -1, 900446, 0);

-- ----------------------------------------------------------------------------
-- Gem upgrade items (sold by Rosy, gated by ownership of the previous tier)
-- ----------------------------------------------------------------------------

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `spellid_1`,
     `spelltrigger_1`, `spellcooldown_1`, `bonding`, `description`,
     `Material`, `ScriptName`, `VerifiedBuild`)
SELECT
    @RED_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2,
    12, 0, -1,
    CONCAT(`family`.`name`, ' Ribbon Upgrade Tier ', `rank`.`id`),
    58601, 4, 64, 1, 0, 0,
    0, -1, -1, 20,
    20, 0, 1, @BLACK_ROSE_UPGRADE_USE,
    0, 1000, 1,
    CONCAT('Use to empower ', `family`.`name`,
           ' Ribbon. Increases its bonus to +',
           IF(`family`.`stat2_name` = '', `rank`.`single`, `rank`.`split`),
           ' ', `family`.`stat1_name`,
           IF(`family`.`stat2_name` = '', '.',
              CONCAT(' and +', `rank`.`split`, ' ',
                     `family`.`stat2_name`, '.'))),
    -1, 'item_black_rose_gem_upgrade', 0
FROM
    (SELECT 0 AS `id`, 'Stark' AS `name`, 'strength' AS `stat1_name`,
            '' AS `stat2_name`
     UNION ALL SELECT 1, 'Klug', 'intellect', ''
     UNION ALL SELECT 2, 'Geist', 'spirit', ''
     UNION ALL SELECT 3, 'Schnell', 'agility', ''
     UNION ALL SELECT 4, 'Fett', 'stamina', ''
     UNION ALL SELECT 5, 'Gross', 'strength', 'stamina'
     UNION ALL SELECT 6, 'Spinnst', 'intellect', 'spirit'
     UNION ALL SELECT 7, 'Scharf', 'strength', 'agility'
     UNION ALL SELECT 8, 'Weise', 'intellect', 'stamina') AS `family`
JOIN
    (SELECT 2 AS `id`, 22 AS `single`, 11 AS `split`
     UNION ALL SELECT 3, 42, 21
     UNION ALL SELECT 4, 62, 31
     UNION ALL SELECT 5, 82, 41
     UNION ALL SELECT 6, 102, 51
     UNION ALL SELECT 7, 122, 61) AS `rank`;

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `spellid_1`,
     `spelltrigger_1`, `spellcooldown_1`, `bonding`, `description`,
     `Material`, `ScriptName`, `VerifiedBuild`)
SELECT
    @YELLOW_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2,
    12, 0, -1,
    CONCAT(`family`.`name`, ' Mist Upgrade Tier ', `rank`.`id`),
    54318, 4, 64, 1, 0, 0,
    0, -1, -1, 20,
    20, 0, 1, @BLACK_ROSE_UPGRADE_USE,
    0, 1000, 1,
    CONCAT('Use to empower ', `family`.`name`,
           ' Mist. Increases its bonus to +',
           IF(`family`.`id` = 4, `rank`.`mp5`, `rank`.`value`), ' ',
           `family`.`stat1_name`, '.'),
    -1, 'item_black_rose_gem_upgrade', 0
FROM
    (SELECT 0 AS `id`, 'Pouvoir' AS `name`,
            'spell power' AS `stat1_name`
     UNION ALL SELECT 1, 'Douleur', 'attack power'
     UNION ALL SELECT 2, 'Pointe', 'crit rating'
     UNION ALL SELECT 3, 'Vitesse', 'haste rating'
     UNION ALL SELECT 4, 'Restaurer', 'mana per 5 seconds') AS `family`
JOIN
    (SELECT 2 AS `id`, 26 AS `value`, 25 AS `mp5`
     UNION ALL SELECT 3, 86, 50
     UNION ALL SELECT 4, 126, 75
     UNION ALL SELECT 5, 166, 200
     UNION ALL SELECT 6, 206, 325
     UNION ALL SELECT 7, 246, 525) AS `rank`;

-- ----------------------------------------------------------------------------
-- Norah Rose (quest giver, both factions) and Rosy (vendor)
-- ----------------------------------------------------------------------------

REPLACE INTO `creature_template`
    (`entry`, `name`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`,
     `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`,
     `detection_range`, `rank`, `DamageModifier`, `BaseAttackTime`,
     `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
     `unit_flags`, `unit_flags2`, `type`, `MovementType`, `HoverHeight`,
     `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RegenHealth`,
     `ScriptName`, `VerifiedBuild`)
VALUES
    (@NORAH_HORDE, 'Norah Rose', 20, 20, 0, 35, 2,
     1, 1.14286, 1, 1,
     20, 0, 1, 2000,
     2000, 1, 1, 1,
     0, 2048, 7, 0, 1,
     1, 1, 1, 1,
     '', 0),
    (@NORAH_ALLIANCE, 'Norah Rose', 20, 20, 0, 35, 2,
     1, 1.14286, 1, 1,
     20, 0, 1, 2000,
     2000, 1, 1, 1,
     0, 2048, 7, 0, 1,
     1, 1, 1, 1,
     '', 0),
    (@ROSY, 'Rosy', 20, 20, 0, 35, 129,
     1, 1.14286, 1, 1,
     20, 0, 1, 2000,
     2000, 1, 1, 1,
     0, 2048, 7, 0, 1,
     1, 1, 1, 1,
     'npc_black_rose_rosy', 0);

REPLACE INTO `creature_template_model`
    (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`,
     `Probability`, `VerifiedBuild`)
VALUES
    (@NORAH_HORDE, 0, 16695, 1, 1, 0),
    (@NORAH_ALLIANCE, 0, 14615, 1, 1, 0),
    (@ROSY, 0, 617, 1, 1, 0);

REPLACE INTO `creature`
    (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`,
     `position_x`, `position_y`, `position_z`, `orientation`,
     `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`,
     `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`,
     `CreateObject`, `Comment`)
VALUES
    (@NORAH_CGUID + 0, @NORAH_HORDE, 1, 1, 1, 0,
     1566.3, -4396.58, 7.36, 3.316,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Orgrimmar'),
    (@NORAH_CGUID + 1, @NORAH_HORDE, 0, 1, 1, 0,
     1553.8, 246, -43.1, 6.269,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Undercity'),
    (@NORAH_CGUID + 2, @NORAH_HORDE, 1, 1, 1, 0,
     -1254.5, 67, 127.5, 0.747,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Thunder Bluff'),
    (@NORAH_CGUID + 3, @NORAH_HORDE, 530, 1, 1, 0,
     9402.9, -7261.7, 14.19, 3.94,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Silvermoon'),
    (@NORAH_CGUID + 4, @NORAH_ALLIANCE, 0, 1, 1, 0,
     -8875.28, 598, 93.5, 4.6,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Stormwind'),
    (@NORAH_CGUID + 5, @NORAH_ALLIANCE, 1, 1, 1, 0,
     9948.4, 2491.7, 1317.1, 4.72,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Darnassus'),
    (@NORAH_CGUID + 6, @NORAH_ALLIANCE, 0, 1, 1, 0,
     -4913.5, -976.3, 501.5, 2.09,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Ironforge'),
    (@NORAH_CGUID + 7, @NORAH_ALLIANCE, 530, 1, 1, 0,
     -4006.3, -11846, 0.175, 4.693,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Exodar'),
    (@ROSY_CGUID + 0, @ROSY, 1, 1, 1, 0,
     1567.5, -4395.4, 7.36, 3.316,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Orgrimmar'),
    (@ROSY_CGUID + 1, @ROSY, 0, 1, 1, 0,
     1555, 247.2, -43.1, 6.269,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Undercity'),
    (@ROSY_CGUID + 2, @ROSY, 1, 1, 1, 0,
     -1253.3, 68.2, 127.5, 0.747,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Thunder Bluff'),
    (@ROSY_CGUID + 3, @ROSY, 530, 1, 1, 0,
     9404.1, -7260.5, 14.19, 3.94,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Silvermoon'),
    (@ROSY_CGUID + 4, @ROSY, 0, 1, 1, 0,
     -8874.1, 599.2, 93.5, 4.6,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Stormwind'),
    (@ROSY_CGUID + 5, @ROSY, 1, 1, 1, 0,
     9949.6, 2492.9, 1317.1, 4.72,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Darnassus'),
    (@ROSY_CGUID + 6, @ROSY, 0, 1, 1, 0,
     -4912.3, -975.1, 501.5, 2.09,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Ironforge'),
    (@ROSY_CGUID + 7, @ROSY, 530, 1, 1, 0,
     -4005.1, -11844.8, 0.175, 4.693,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Exodar');

-- ----------------------------------------------------------------------------
-- The Black Rose quest (gothic flavour, sorted under custom QuestSort 9009)
--
-- QuestSortID = -9009 makes the client look up the sort name in
-- QuestSort.dbc (negative IDs => QuestSort, positive => AreaTable). The
-- matching server-side row in `questsort_dbc` is created in the companion
-- DBC migration so AC's in-memory store agrees with the client patch.
-- ----------------------------------------------------------------------------

REPLACE INTO `quest_template`
    (`ID`, `QuestType`, `QuestSortID`, `QuestLevel`, `MinLevel`,
     `RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`,
     `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`,
     `RewardItem3`, `RewardAmount3`, `AllowableRaces`, `LogTitle`,
     `LogDescription`, `QuestDescription`, `QuestCompletionLog`,
     `RequiredNpcOrGo1`, `RequiredNpcOrGoCount1`, `ObjectiveText1`,
     `VerifiedBuild`)
VALUES
    (@QUEST_ALLIANCE, 2, -@BLACK_ROSE_SORT, 20, 20,
     1, 50000, 0,
     @BAG_26, 1, @BLACK_ROSE_MAULER_REINS, 1,
     @BLACK_ROSE_TRINKET, 1, 1101, 'The Black Rose',
     'Slay Gruff Swiftbite. Bring word to Norah Rose. The Rose '
     'remembers all who walk this path.',
     '$N. The thorns have already tasted your blood, and the Rose has '
     'not turned away.$B$BFew tread this path. Fewer return. Those who '
     'do, return changed - quieter, sharper, with names they will not '
     'say aloud.$B$BAccept this charge, and the Rose will mark you as '
     'kin: a founder of the long vigil, named beside those who walked '
     'into the dark first and did not come back whole. We have not '
     'forgotten them. We will not forget you.$B$BSlay Gruff Swiftbite. '
     'Let his last sound be the one he gives the world. Then return '
     'to me, and the Rose will remember.',
     'Return to Norah Rose. The Rose has waited.',
     @GRUFF_SWIFTBITE, 1, 'Gruff Swiftbite slain', 0),
    (@QUEST_HORDE, 2, -@BLACK_ROSE_SORT, 20, 20,
     1, 50000, 0,
     @BAG_26, 1, @BLACK_ROSE_MAULER_REINS, 1,
     @BLACK_ROSE_TRINKET, 1, 690, 'The Black Rose',
     'Slay Gruff Swiftbite. Bring word to Norah Rose. The Rose '
     'remembers all who walk this path.',
     '$N. The thorns have already tasted your blood, and the Rose has '
     'not turned away.$B$BFew tread this path. Fewer return. Those who '
     'do, return changed - quieter, sharper, with names they will not '
     'say aloud.$B$BAccept this charge, and the Rose will mark you as '
     'kin: a founder of the long vigil, named beside those who walked '
     'into the dark first and did not come back whole. We have not '
     'forgotten them. We will not forget you.$B$BSlay Gruff Swiftbite. '
     'Let his last sound be the one he gives the world. Then return '
     'to me, and the Rose will remember.',
     'Return to Norah Rose. The Rose has waited.',
     @GRUFF_SWIFTBITE, 1, 'Gruff Swiftbite slain', 0);

REPLACE INTO `quest_template_addon` (`ID`, `SpecialFlags`)
VALUES
    (@QUEST_ALLIANCE, 0),
    (@QUEST_HORDE, 0);

REPLACE INTO `quest_request_items`
    (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`,
     `VerifiedBuild`)
VALUES
    (@QUEST_ALLIANCE, 1, 0,
     'Have you fed the Rose, $N? Or do you still hesitate at the '
     'threshold?', 0),
    (@QUEST_HORDE, 1, 0,
     'Have you fed the Rose, $N? Or do you still hesitate at the '
     'threshold?', 0);

REPLACE INTO `quest_offer_reward`
    (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`,
     `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`,
     `VerifiedBuild`)
VALUES
    (@QUEST_ALLIANCE, 1, 0, 0, 0, 0,
     0, 0, 0,
     'Then it is done.$B$BCarry these gifts, $N. They were given '
     'first to those who walked into the long dark before the Rose '
     'had a name - the founders, the wardens, the ones who went on '
     'when the world did not. You are counted now among them. The '
     'thorns know your blood. The path opens.$B$BWalk it well. We '
     'will see you on the other side, or we will not see you at all.',
     0),
    (@QUEST_HORDE, 1, 0, 0, 0, 0,
     0, 0, 0,
     'Then it is done.$B$BCarry these gifts, $N. They were given '
     'first to those who walked into the long dark before the Rose '
     'had a name - the founders, the wardens, the ones who went on '
     'when the world did not. You are counted now among them. The '
     'thorns know your blood. The path opens.$B$BWalk it well. We '
     'will see you on the other side, or we will not see you at all.',
     0);

REPLACE INTO `creature_queststarter` (`id`, `quest`)
VALUES
    (@NORAH_ALLIANCE, @QUEST_ALLIANCE),
    (@NORAH_HORDE, @QUEST_HORDE);

REPLACE INTO `creature_questender` (`id`, `quest`)
VALUES
    (@NORAH_ALLIANCE, @QUEST_ALLIANCE),
    (@NORAH_HORDE, @QUEST_HORDE);

-- ----------------------------------------------------------------------------
-- Rosy's vendor list: bag upgrades + red and yellow gem starter ranks
-- ----------------------------------------------------------------------------

DELETE FROM `npc_vendor` WHERE `entry` = @ROSY;

REPLACE INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`,
     `VerifiedBuild`)
VALUES
    (@ROSY, 1, @UPGRADE_28, 0, 0, 0, 0),
    (@ROSY, 2, @UPGRADE_30, 0, 0, 0, 0),
    (@ROSY, 3, @UPGRADE_32, 0, 0, 0, 0),
    (@ROSY, 4, @UPGRADE_34, 0, 0, 0, 0),
    (@ROSY, 5, @UPGRADE_36, 0, 0, 0, 0);

REPLACE INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`,
     `VerifiedBuild`)
SELECT
    @ROSY, 100 + `family`.`id`,
    @RED_GEM_BASE + `family`.`id` * 10, 0, 0, @MIA_EXT_BASE, 0
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) AS `family`
UNION ALL
SELECT
    @ROSY, 300 + `family`.`id`,
    @YELLOW_GEM_BASE + `family`.`id` * 10, 0, 0, @PETAL_EXT_BASE, 0
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4) AS `family`;

-- ----------------------------------------------------------------------------
-- Conditions: gate vendor entries by ownership
--   * Bag upgrade tier N+1 requires the player to already own bag tier N.
--   * All Black Rose gems require the player to own The Black Rose trinket.
-- ----------------------------------------------------------------------------

DELETE FROM `conditions`
WHERE `SourceTypeOrReferenceId` = 23 AND `SourceGroup` = @ROSY;

REPLACE INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
     `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
     `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
     `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`,
     `Comment`)
VALUES
    (23, @ROSY, @UPGRADE_28, 0, 0, 2, 0,
     @BAG_26, 1, 0, 0, 0, 0, '',
     'Rosy sells upgrade I if the player has the 26-slot bag'),
    (23, @ROSY, @UPGRADE_30, 0, 0, 2, 0,
     @BAG_28, 1, 0, 0, 0, 0, '',
     'Rosy sells upgrade II if the player has the 28-slot bag'),
    (23, @ROSY, @UPGRADE_32, 0, 0, 2, 0,
     @BAG_30, 1, 0, 0, 0, 0, '',
     'Rosy sells upgrade III if the player has the 30-slot bag'),
    (23, @ROSY, @UPGRADE_34, 0, 0, 2, 0,
     @BAG_32, 1, 0, 0, 0, 0, '',
     'Rosy sells upgrade IV if the player has the 32-slot bag'),
    (23, @ROSY, @UPGRADE_36, 0, 0, 2, 0,
     @BAG_34, 1, 0, 0, 0, 0, '',
     'Rosy sells upgrade V if the player has the 34-slot bag');

REPLACE INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
     `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
     `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
     `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`,
     `Comment`)
SELECT
    23, @ROSY, `vendor_items`.`item`, 0,
    0, 2, 0,
    @BLACK_ROSE_TRINKET, 1, 0,
    0, 0, 0, '',
    'Rosy sells Black Rose gems only to players with The Black Rose'
FROM
    (SELECT @RED_GEM_BASE + `family`.`id` * 10 AS `item`
     FROM
        (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
         UNION ALL SELECT 6 UNION ALL SELECT 7
         UNION ALL SELECT 8) AS `family`
     UNION ALL
     SELECT @YELLOW_GEM_BASE + `family`.`id` * 10
     FROM
        (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4) AS `family`)
    AS `vendor_items`;
