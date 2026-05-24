-- ============================================================================
-- Black Rose: ship-blocker polish #2 - aggro, level, cadence, icon
--
--   1. Faegrim has no aggro radius. Root cause: creature_template
--      dynamicflags = 8 (UNIT_DYNFLAG_TAPPED_BY_PLAYER) was set as a
--      default, which marks him as already-tapped at spawn time. AC's
--      target acquisition treats tapped creatures as engaged-by-someone-
--      else and skips picking up new aggro until the tap clears, which
--      it never does because nobody actually tapped him. Clear it.
--
--   2. Festering Spawnlings just stand there. Root cause: SmartAI's
--      SUMMON_CREATURE action (12) takes attackInvoker as action_param5.
--      All five summon events (regular cadence + 60% HP burst) had it
--      at 0, so the summon function spawns them passive. Setting it to
--      1 calls AttackStart(invoker) on the spawnling so it engages the
--      boss's current threat target on appear.
--
--   3. Spawn rate too fast. Regular cadence was 25-32s -> 25-32s. Pull
--      apart so groups have breathing room: 60-90s repeat with the same
--      first-spawn-after-pull pacing. The 60% HP burst (events 8/9/10)
--      fires once and stays as-is (it's the "shit hits the fan" beat).
--
--   4. Buff Faegrim to level 30 (was 23). Quest still picks up at
--      level 20 (MinLevel) but the quest log will read "Level 30 (Elite)"
--      because we're bumping QuestLevel to 30 - that's the UI hint
--      players see for "recommended level", separate from the pickup
--      gate. So a level 20 player can grab the quest, see it's flagged
--      level 30 elite, and decide whether to come back later or bring
--      friends.
--
--   5. Black Rose buff icon. SpellIconID 209 (Spell_Shadow_ShadowBolt
--      swirl) reads more "mage projectile" than "ancient relic blessing".
--      Swapped to 125 (Spell_Shadow_Curse, the red/black raised-hand
--      curse icon) which looks unambiguously gothic, dark, and aura-y.
--      Matching client patch update lives in
--      tools/clientpatch/definitions/spell.json so a fresh patch ships
--      the same SpellIconID to the client tooltip/buff bar.
-- ============================================================================

SET @BR_BOSS                 := 900200;
SET @BR_BOSS_ADD             := 900201;
SET @BR_QUEST_ALLI           := 900100;
SET @BR_QUEST_HORDE          := 900101;
SET @BLACK_ROSE_AURA         := 900900;

-- ----------------------------------------------------------------------------
-- 1. Faegrim aggro fix + level 30 bump
-- ----------------------------------------------------------------------------
UPDATE `creature_template`
   SET `minlevel`     = 30,
       `maxlevel`     = 30,
       `dynamicflags` = 0
 WHERE `entry` = @BR_BOSS;

-- The spawn record had its dynamicflags column at 0 already so this is
-- defensive, but keep it explicit so a fresh deploy reading the row also
-- has nothing residual hanging off the spawn override.
UPDATE `creature`
   SET `dynamicflags` = 0
 WHERE `id1` = @BR_BOSS;

-- ----------------------------------------------------------------------------
-- 2. Spawnling aggro fix - flip attackInvoker on every summon action
-- ----------------------------------------------------------------------------
UPDATE `smart_scripts`
   SET `action_param5` = 1
 WHERE `entryorguid` = @BR_BOSS
   AND `source_type` = 0
   AND `action_type` = 12;

-- ----------------------------------------------------------------------------
-- 3. Slow regular spawnling cadence to 60-90s repeat
-- ----------------------------------------------------------------------------
UPDATE `smart_scripts`
   SET `event_param1` = 60000,
       `event_param2` = 90000,
       `event_param3` = 60000,
       `event_param4` = 90000
 WHERE `entryorguid` = @BR_BOSS
   AND `source_type` = 0
   AND `id` IN (3, 4);

-- ----------------------------------------------------------------------------
-- 4. Quest level: pickup at 20, recommended 30
-- ----------------------------------------------------------------------------
UPDATE `quest_template`
   SET `QuestLevel` = 30
 WHERE `ID` IN (@BR_QUEST_ALLI, @BR_QUEST_HORDE);

-- ----------------------------------------------------------------------------
-- 5. Trinket buff icon swap
-- ----------------------------------------------------------------------------
UPDATE `spell_dbc`
   SET `SpellIconID`  = 125,
       `ActiveIconID` = 125
 WHERE `ID` = @BLACK_ROSE_AURA;
