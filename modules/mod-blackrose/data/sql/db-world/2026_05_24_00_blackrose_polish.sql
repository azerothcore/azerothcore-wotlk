-- ============================================================================
-- Black Rose: pre-launch polish pass
--
-- Five focused fixes on top of the 2026_05_22 / 2026_05_23 migrations:
--   1. Bag icon  -> Onyxia Hide Backpack (30271). Black scaled gothic bag.
--   2. Currency icons swapped to thematic stock displays:
--        Black Miasma -> Heart of Darkness (44851)
--        Black Petals -> Black Lotus       (24688)
--        Black Thorns -> Serrated Petal    (30601)
--   3. Mount item (900106) consumes itself on use. Sets spellcharges_1 = -1
--      to match the stock Mechano-Hog (41508) / Mekgineer's Chopper (44413)
--      pattern, where the Learning cast in slot 1 destroys the item once
--      the LEARN_SPELL_ID in slot 2 succeeds.
--   4. Mount spell (900903) goes 300% speed. Stock SPELL_AURA_MOUNTED (78)
--      with no speed effect produces a base mount that just walks; we add
--      Effect_2 = APPLY_AURA / SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED (32)
--      with EffectBasePoints_2 = 299 (engine adds 1 -> +300% mount speed).
--   5. Black Rose trinket (900105): blue socket removed. Now red + yellow,
--      matching the only two gem colours we actually craft.
--
-- Idempotent: every statement is an UPDATE / REPLACE on a known row, safe
-- to re-run.
-- ============================================================================

SET @BAG_26                     := 900102;
SET @BAG_28                     := 900120;
SET @BAG_30                     := 900121;
SET @BAG_32                     := 900122;
SET @BAG_34                     := 900123;
SET @BAG_36                     := 900124;

SET @BLACK_ROSE_TRINKET         := 900105;
SET @BLACK_ROSE_MAULER_REINS    := 900106;

SET @BLACK_MIASMA               := 900200;
SET @BLACK_PETALS               := 900201;
SET @BLACK_THORNS               := 900202;

SET @BLACK_ROSE_MAULER_MOUNT    := 900903;
SET @MECHANO_HOG_CREATURE       := 29929;

-- ----------------------------------------------------------------------------
-- 1. Bag icon: Onyxia Hide Backpack (30271)
-- ----------------------------------------------------------------------------
UPDATE `item_template`
   SET `displayid` = 30271
 WHERE `entry` IN (@BAG_26, @BAG_28, @BAG_30, @BAG_32, @BAG_34, @BAG_36);

-- ----------------------------------------------------------------------------
-- 2. Currency icons
-- ----------------------------------------------------------------------------
UPDATE `item_template` SET `displayid` = 44851 WHERE `entry` = @BLACK_MIASMA;
UPDATE `item_template` SET `displayid` = 24688 WHERE `entry` = @BLACK_PETALS;
UPDATE `item_template` SET `displayid` = 30601 WHERE `entry` = @BLACK_THORNS;

-- ----------------------------------------------------------------------------
-- 3. Mount item consumes itself on successful learn
-- ----------------------------------------------------------------------------
UPDATE `item_template`
   SET `spellcharges_1` = -1
 WHERE `entry` = @BLACK_ROSE_MAULER_REINS;

-- ----------------------------------------------------------------------------
-- 4. Trinket: drop the blue socket. Keeping red + yellow only.
-- ----------------------------------------------------------------------------
UPDATE `item_template`
   SET `socketColor_3`   = 0,
       `socketContent_3` = 0,
       `socketBonus`     = 0
 WHERE `entry` = @BLACK_ROSE_TRINKET;

-- ----------------------------------------------------------------------------
-- 5. Mount spell: 300% mounted speed
--
--   Effect_1: APPLY_AURA / SPELL_AURA_MOUNTED (78), miscvalue = creature id
--   Effect_2: APPLY_AURA / SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED (32),
--             EffectBasePoints_2 = 299 -> +300% mount speed
--
-- We REPLACE the whole row to keep both effects authoritative; this matches
-- the original insert in 2026_05_22_01_blackrose_dbc.sql and just appends
-- the Effect_2 columns.
-- ----------------------------------------------------------------------------
REPLACE INTO `spell_dbc`
    (`ID`, `Attributes`, `CastingTimeIndex`, `DurationIndex`, `RangeIndex`,
     `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`,
     `Effect_1`, `EffectDieSides_1`, `EffectBasePoints_1`,
     `ImplicitTargetA_1`, `EffectAura_1`, `EffectMiscValue_1`,
     `Effect_2`, `EffectDieSides_2`, `EffectBasePoints_2`,
     `ImplicitTargetA_2`, `EffectAura_2`,
     `SpellIconID`, `ActiveIconID`, `Name_Lang_enUS`, `Name_Lang_Mask`,
     `Description_Lang_enUS`, `Description_Lang_Mask`,
     `AuraDescription_Lang_enUS`, `AuraDescription_Lang_Mask`, `SchoolMask`)
VALUES
    (@BLACK_ROSE_MAULER_MOUNT, 0, 1, 21, 1,
     -1, 0, 0,
     6, 1, 59, 1, 78, @MECHANO_HOG_CREATURE,
     6, 1, 299, 1, 32,
     0, 0, 'Rurik''s Death Mobile', 1,
     'Summons and dismisses a rideable Rurik''s Death Mobile.', 1,
     'Mounted.', 1, 1);
