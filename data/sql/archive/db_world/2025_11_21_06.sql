-- DB update 2025_11_21_05 -> 2025_11_21_06
--
-- Warbear Matriarch
-- Disable AA
UPDATE `creature_template` SET `AIName` = 'VehicleAI' WHERE (`entry` = 29918);
-- Spells from 1,2,3 to 4,5,6
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 29918);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(29918, 3, 54459, 12340),
(29918, 4, 54458, 12340),
(29918, 5, 54460, 12340);
