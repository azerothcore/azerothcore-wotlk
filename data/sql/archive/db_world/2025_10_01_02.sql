-- DB update 2025_10_01_01 -> 2025_10_01_02
UPDATE `creature_template_model` SET `VerifiedBuild` = 51831 WHERE `CreatureID` IN (33666, 33669);
UPDATE `creature_template_model` SET `Probability` = 0 WHERE `CreatureID` = 33669 AND `CreatureDisplayID` = 27343;
