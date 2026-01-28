-- DB update 2026_01_27_05 -> 2026_01_28_00
--
SET @ENTRY := 24705;

UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 128 WHERE `entry` = @ENTRY;

DELETE FROM `creature_template_model` WHERE `CreatureID` = @ENTRY;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(@ENTRY, 0, 1126, 1, 0, 51831),
(@ENTRY, 1, 11686, 1, 1, 51831);
