-- DB update 2026_10_21_00 -> 2026_10_21_01
--
-- Copy of -286, removal of SILENCE and STUN immunities
SET @ID := -432;
DELETE FROM `creature_immunities` WHERE (`ID` = @ID);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(@ID, 0, 0, 1234595070, '98,124,144,145', '', 0, 0, 'mech=0x24CB367F(CHARM|DISORIENTED|DISARM|DISTRACT|FEAR|GRIP|ROOT|SLEEP|SNARE|FREEZE|KNOCKOUT|POLYMORPH|BANISH|SHACKLE|TURN|HORROR|DAZE|SAPPED), effects=98(KNOCK_BACK),124(PULL_TOWARDS),144(KNOCK_BACK_DEST),145(PULL_TOWARDS_DEST)');

UPDATE `creature_template` SET `CreatureImmunitiesId` = @ID WHERE (`entry` IN (33985, 33986));
