-- ============================================================================
-- Black Rose: ship-blocker polish #3 - HP, spawnling level, trinket icon
--
--   1. Faegrim HP -> 7k. At level 30 / unit_class 1 the
--      creature_classlevelstats basehp0 row is 955, so
--      HealthModifier 7.33 lands at exactly 7,000 raw HP before
--      AutoBalance scaling. (Was 15, ~14.3k - too tanky for a
--      single-quest-target fight.)
--
--   2. Festering Spawnlings -> level 26-27. minlevel/maxlevel
--      become a range so each spawn rolls within it, giving the
--      adds some natural variation while keeping them noticeably
--      below the level-30 boss.
--
--   3. Trinket buff icon. SpellIconID 125 turned out to be Arcane
--      Intellect (verified by reading the stock client Spell.dbc:
--      Curse of Agony=544, Curse of Doom=91, etc.). Swapped to 91
--      (Curse of Doom's skull-and-crossbones) which is iconically
--      gothic and unmistakably not a mage spell. Matching client
--      patch update is in tools/clientpatch/definitions/spell.json
--      so the buff bar tooltip pulls the same SpellIconID once a
--      fresh patch-Z.MPQ ships.
-- ============================================================================

SET @BR_BOSS         := 900200;
SET @BR_BOSS_ADD     := 900201;
SET @BLACK_ROSE_AURA := 900900;

-- ----------------------------------------------------------------------------
-- 1. Faegrim HP target ~ 7,000 (basehp0 at L30/class1 = 955; 955*7.33 ~= 7000)
-- ----------------------------------------------------------------------------
UPDATE `creature_template`
   SET `HealthModifier` = 7.33
 WHERE `entry` = @BR_BOSS;

-- ----------------------------------------------------------------------------
-- 2. Festering Spawnling level range 26-27
-- ----------------------------------------------------------------------------
UPDATE `creature_template`
   SET `minlevel` = 26,
       `maxlevel` = 27
 WHERE `entry` = @BR_BOSS_ADD;

-- ----------------------------------------------------------------------------
-- 3. Black Rose buff icon -> Curse of Doom skull (SpellIconID 91)
-- ----------------------------------------------------------------------------
UPDATE `spell_dbc`
   SET `SpellIconID`  = 91,
       `ActiveIconID` = 91
 WHERE `ID` = @BLACK_ROSE_AURA;
