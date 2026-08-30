-- DB update 2026_08_30_04 -> 2026_08_30_05
-- Modern client builds exceed smallint unsigned (65535); align with the int VerifiedBuild used by other tables
ALTER TABLE `creature_template_model` MODIFY `VerifiedBuild` int DEFAULT NULL;

-- Ironwork Cannon (33264): sniff shows only display id 25723 is used (other models have 0% probability)
UPDATE `creature_template_model` SET `Probability` = 0, `VerifiedBuild` = 69497 WHERE `CreatureID` = 33264 AND `Idx` IN (0, 1, 3);
UPDATE `creature_template_model` SET `VerifiedBuild` = 69497 WHERE `CreatureID` = 33264 AND `Idx` = 2;
