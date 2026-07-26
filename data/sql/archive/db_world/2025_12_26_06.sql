-- DB update 2025_12_26_05 -> 2025_12_26_06
-- Delete Duplicate
DELETE FROM `creature` WHERE (`id1` = 24439) AND (`guid` IN (142710));

DELETE FROM `creature_template_model` WHERE (`CreatureID` = 24439);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(24439, 0, 24780, 1, 1, 51831),
(24439, 1, 11686, 1, 0, 51831);
