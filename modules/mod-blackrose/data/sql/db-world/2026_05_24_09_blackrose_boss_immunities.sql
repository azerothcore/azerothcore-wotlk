-- ============================================================================
-- Black Rose: Faegrim hard-CC immunity profile (slow-able)
--
-- Goal: make Faegrim a level-30 elite that ignores hard CC (fear, stun,
-- polymorph, etc.) the way a real raid-tier mob does, but stays slow-able
-- so warrior Hamstring, frost spells, druid Cyclone snare, etc. still feel
-- impactful in the fight.
--
-- This fork stores creature CC immunity in `creature_immunities`, a row of
-- which is referenced by creature_template.CreatureImmunitiesId. Stock
-- raid-boss profiles like -286 (Patchwerk) include MECHANIC_SNARE in their
-- mask. We need a custom profile that omits SNARE specifically.
--
-- MechanicsMask bits (0-indexed; bit i == MECHANIC enum value i in
-- src/server/shared/SharedDefines.h::Mechanics):
--   bit  1  CHARM
--   bit  2  DISORIENTED          (confuse)
--   bit  4  DISTRACT
--   bit  5  FEAR
--   bit  7  ROOT
--   bit  9  SILENCE
--   bit 10  SLEEP
--   bit 11  SNARE                <-- explicitly NOT set, slows still land
--   bit 12  STUN
--   bit 13  FREEZE
--   bit 14  KNOCKOUT
--   bit 17  POLYMORPH
--   bit 18  BANISH
--   bit 20  SHACKLE              (Shackle Undead etc.)
--   bit 23  TURN
--   bit 24  HORROR
--   bit 27  DAZE
--   bit 30  SAPPED
--
-- Sum = 1234597558 (0x499676B6).
--
-- Custom row IDs in creature_immunities are conventionally negative (the
-- stock dataset ships with -1..-426). We use a positive ID equal to the
-- boss entry (900200) so it is unambiguously ours, and `INSERT ... ON
-- DUPLICATE KEY UPDATE` keeps re-runs idempotent.
-- ============================================================================

SET @BR_BOSS               := 900200;
SET @BR_BOSS_IMMUNITY_ID   := 900200;
SET @BR_BOSS_IMMUNITY_MASK := 1234597558;
SET @BR_BOSS_IMMUNITY_DESC := 'Faegrim, the Putrid Husk - hard CC immune (charm, disorient, distract, fear, root, silence, sleep, stun, freeze, knockout, polymorph, banish, shackle, turn, horror, daze, sapped). Slows (MECHANIC_SNARE) intentionally land.';

INSERT INTO `creature_immunities`
    (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`,
     `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`)
VALUES
    (@BR_BOSS_IMMUNITY_ID, 0, 0, @BR_BOSS_IMMUNITY_MASK,
     '', '', 0, 0, @BR_BOSS_IMMUNITY_DESC)
ON DUPLICATE KEY UPDATE
    `SchoolMask`     = VALUES(`SchoolMask`),
    `DispelTypeMask` = VALUES(`DispelTypeMask`),
    `MechanicsMask`  = VALUES(`MechanicsMask`),
    `Effects`        = VALUES(`Effects`),
    `Auras`          = VALUES(`Auras`),
    `ImmuneAoE`      = VALUES(`ImmuneAoE`),
    `ImmuneChain`    = VALUES(`ImmuneChain`),
    `Comment`        = VALUES(`Comment`);

UPDATE `creature_template`
   SET `CreatureImmunitiesId` = @BR_BOSS_IMMUNITY_ID
 WHERE `entry` = @BR_BOSS;
