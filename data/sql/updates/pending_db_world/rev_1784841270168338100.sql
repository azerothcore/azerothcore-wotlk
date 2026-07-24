-- --------------------------------------------------------------------------------------------
-- Dragonblight (Northrend, map 571)
-- Dead Mage Hunter (26477): permanent, randomized corpse appearance
-- -------------------------------------------
-- Populate spell Serverside - Dead Mage Hunter Transform (47090) with transform effect to Dead Mage Hunter Transform (26476)
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 26476 WHERE `ID` = 47090;
-- Dead Mage Hunter (26477) - apply sniffed displayIDs
DELETE FROM `creature_template_model` WHERE `CreatureID` = 26477;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(26477, 0, 16888, 1, 0, 51831),
(26477, 1, 11686, 1, 1, 51831);
-- Dead Mage Hunter (26477) - apply blanket transform spell as aura
UPDATE `creature_template_addon` SET `auras` = '47090' WHERE (`entry` = 26477);
