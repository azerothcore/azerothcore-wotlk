-- DB update 2026_09_22_02 -> 2026_09_22_03
-- XE-321 Boombot: retain the model list while only selecting the walking bomb model in both raid difficulties.
UPDATE `creature_template_model` SET `Probability` = 0, `VerifiedBuild` = 51831 WHERE `CreatureID` = 33346 AND `Idx` IN (1, 2);
UPDATE `creature_template_model` SET `VerifiedBuild` = 51831 WHERE `CreatureID` = 33346 AND `Idx` = 0;
UPDATE `creature_template_model` SET `Probability` = 0 WHERE `CreatureID` = 33886 AND `Idx` IN (1, 2);
