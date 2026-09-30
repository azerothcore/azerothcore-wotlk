-- Underbog heroic: match Lykul Wasp, Lykul Stinger and Underbog Lord models to their normal entries
UPDATE `creature_template_model` SET `CreatureDisplayID` = 18722 WHERE `CreatureID` = 20175 AND `Idx` = 0;
UPDATE `creature_template_model` SET `Probability` = 0 WHERE `CreatureID` IN (20174, 20175) AND `Idx` IN (1, 2, 3);
UPDATE `creature_template_model` SET `Probability` = 0 WHERE `CreatureID` = 20187 AND `Idx` = 1;
