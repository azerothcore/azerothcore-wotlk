--
SET @ID := -428;

DELETE FROM `creature_immunities` WHERE `ID`=@ID;
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`)
VALUES(@ID, 0, 0, 0x4D96763E, '98,144', '', 0, 0, 'mech=0x4D96763E(CHARM|DISORIENTED|DISARM|DISTRACT|FEAR|SILENCE|SLEEP|STUN|FREEZE|KNOCKOUT|POLYMORPH|BANISH|SHACKLE|TURN|HORROR|INTERRUPT|DAZE|SAPPED), flags=IMMUNITY_KNOCKBACK, effects=98(KNOCK_BACK),144(KNOCK_BACK_DEST)');

UPDATE `creature_template` SET `CreatureImmunitiesId` = @ID WHERE (`entry` IN (33121, 33191));
