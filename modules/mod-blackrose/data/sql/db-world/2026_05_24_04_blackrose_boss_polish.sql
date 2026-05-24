-- ============================================================================
-- Black Rose: ship-blocker polish - boss tuning + mount client polish
--
--   1. Drop the patrol entirely. SmartAI's WP_START kept moving Faegrim
--      mid-combat which made him strafe his target. Player wants him to
--      stand still at the spawn anchor (verified Fire Scar Shrine center)
--      and pull-and-stay. Removed:
--        - smart_scripts ids 13/14 (RESPAWN/RESET start-path triggers)
--        - all `waypoints` rows for entry 900200
--      Boss now idles at his spawn coords with no movement script.
--
--   2. Tune boss spell damage WAY down. The CUSTOM_CAST templates were
--      reusing real ICC raid spells (Rotface Slime Spray 71215, Festergut
--      Vile Gas 71218) with their bp0 left at raid-tier numbers, and the
--      boss has DamageModifier 2.5 on top, so a single Slime Spray was
--      hitting tanks for 4-5k. Reduced bp0 by ~7-9x so a level-23 group
--      gets pressured but not gibbed:
--        - Slime Spray (71215, victim cone)        : 699 -> 79
--        - Mutating Infection (172 Corruption DoT) : 139 -> 19
--        - Vile Gas (71218, AoE puddle)            : 199 -> 29
--      Auto-attacks are unchanged ("autos are fine" per playtest).
--
--   3. Mount spell (900903) client-window polish. As shipped:
--        - CastingTimeIndex = 1  -> instant cast, no cast bar
--        - SpellIconID      = 0  -> blank slot in the mount window,
--                                  un-draggable to action bars
--      Fixes:
--        - CastingTimeIndex -> 5  (SpellCastTimes.dbc index 5 = 1500ms,
--                                  the standard ground-mount cast time)
--        - SpellIconID/ActiveIconID -> 1487 (Spell_Shadow_AbominationExplosion,
--                                            a skull icon that matches the
--                                            Skull of Gul'dan item display
--                                            we use for the reins)
--      The matching client-side update lives in
--      tools/clientpatch/definitions/spell.json so a fresh patch rebuild
--      ships the same row to the client (otherwise the client tooltip
--      and cast bar still read the stock zeros from the patched DBC).
-- ============================================================================

SET @BR_BOSS                 := 900200;
SET @BLACK_ROSE_MAULER_MOUNT := 900903;

-- ----------------------------------------------------------------------------
-- 1. Strip the patrol
-- ----------------------------------------------------------------------------
DELETE FROM `smart_scripts`
 WHERE `entryorguid` = @BR_BOSS
   AND `source_type` = 0
   AND `id` IN (13, 14);

DELETE FROM `waypoints` WHERE `entry` = @BR_BOSS;

-- ----------------------------------------------------------------------------
-- 2. Tune the spell bp0 overrides
-- ----------------------------------------------------------------------------
UPDATE `smart_scripts`
   SET `action_param3` = 79
 WHERE `entryorguid` = @BR_BOSS
   AND `source_type` = 0
   AND `id` = 1
   AND `action_type` = 218;

UPDATE `smart_scripts`
   SET `action_param3` = 19
 WHERE `entryorguid` = @BR_BOSS
   AND `source_type` = 0
   AND `id` = 2
   AND `action_type` = 218;

UPDATE `smart_scripts`
   SET `action_param3` = 29
 WHERE `entryorguid` = @BR_BOSS
   AND `source_type` = 0
   AND `id` = 12
   AND `action_type` = 218;

-- ----------------------------------------------------------------------------
-- 3. Mount spell: 1.5s cast bar + skull icon for the mount window
-- ----------------------------------------------------------------------------
UPDATE `spell_dbc`
   SET `CastingTimeIndex` = 5,
       `SpellIconID`      = 1487,
       `ActiveIconID`     = 1487
 WHERE `ID` = @BLACK_ROSE_MAULER_MOUNT;
