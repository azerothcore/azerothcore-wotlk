-- DB update 2026_09_20_01 -> 2026_09_21_00
--
UPDATE `creature_template_model` SET `VerifiedBuild` = 51831
WHERE `CreatureID` = 27153 AND `Idx` = 0 AND `CreatureDisplayID` = 25958;
DELETE FROM `creature_template_model` WHERE `CreatureID` = 27153 AND `Idx` = 1 AND `CreatureDisplayID` = 25159;
