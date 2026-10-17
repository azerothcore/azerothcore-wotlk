-- DB update 2026_10_12_00 -> 2026_10_12_01
--
SET @ID := -431;
DELETE FROM `creature_immunities` WHERE (`ID` = @ID);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(@ID, 0, 0, 1090940070, '', '', 0, 0, 'mech=0x20833653(CHARM|DISORIENTED|FEAR|ROOT|SLEEP|SNARE|FREEZE|KNOCKOUT|POLYMORPH|BANISH|HORROR|SAPPED)');

UPDATE `creature_template` SET `CreatureImmunitiesId` = @ID WHERE (`entry` = 22006);
