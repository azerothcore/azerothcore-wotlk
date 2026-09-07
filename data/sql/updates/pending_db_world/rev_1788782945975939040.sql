--
SET @ID := -429;
UPDATE `creature_template` SET `CreatureImmunitiesId` = @ID WHERE (`entry` IN (33116, 33052));

DELETE FROM `creature_immunities` WHERE `ID`=@ID;
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`)
VALUES(@ID, 0, 0, 0x4996763E, '', '', 0, 0, 'mech=0x4996763E(CHARM|DISORIENTED|DISARM|DISTRACT|FEAR|SILENCE|SLEEP|STUN|FREEZE|KNOCKOUT|POLYMORPH|BANISH|SHACKLE|TURN|HORROR|DAZE|SAPPED)');
