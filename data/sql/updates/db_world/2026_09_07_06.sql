-- DB update 2026_09_07_05 -> 2026_09_07_06
--
SET @ID := -430;
UPDATE `creature_template` SET `CreatureImmunitiesId` = @ID WHERE (`entry` IN (33089, 34221, 34097, 34222));

DELETE FROM `creature_immunities` WHERE `ID`=@ID;
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`)
VALUES(@ID, 0, 0, 0x4D96663E, '', '', 0, 0, 'mech=0x4D96663E(CHARM|DISORIENTED|DISARM|DISTRACT|FEAR|SILENCE|SLEEP|FREEZE|KNOCKOUT|POLYMORPH|BANISH|SHACKLE|TURN|HORROR|INTERRUPT|DAZE|SAPPED)');
