-- Add creature_immunities row for engineering target dummies (GRIP + knockback immunity)
SET @ID := -427;
DELETE FROM `creature_immunities` WHERE `ID` = @ID;
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(@ID, 0, 0, 64, '98,124,144,145', '', 0, 0, 'mech=0x20(GRIP), flags=IMMUNITY_KNOCKBACK, effects=98(KNOCK_BACK),124(PULL_TOWARDS),144(KNOCK_BACK_DEST),145(PULL_TOWARDS_DEST)');

-- Update target dummy creature templates to use the new immunity row
UPDATE `creature_template` SET `CreatureImmunitiesId` = @ID WHERE `entry` IN (2673, 2674, 12426);

-- Remove CREATURE_FLAG_EXTRA_CIVILIAN (0x2) from Masterwork Target Dummy (12426)
-- Current flags_extra = 262146 (0x40000 NO_SKILL_GAINS | 0x2 CIVILIAN)
-- New flags_extra = 262144 (0x40000 NO_SKILL_GAINS only)
UPDATE `creature_template` SET `flags_extra` = `flags_extra` & ~2 WHERE `entry` = 12426;
