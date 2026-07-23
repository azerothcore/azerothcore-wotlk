-- --------------------------------------------------------------------------------------------
-- Dragonblight (Northrend, map 571)
-- Dead Mage Hunter (26477): permanent, randomized corpse appearance
-- -------------------------------------------
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 26476 WHERE `ID` = 47090;
-- Add correct models for Dead Mage Hunter (26477)
DELETE FROM `creature_template_model` WHERE `CreatureID` = 26477;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(26477, 0, 16888, 1, 0, 51831),
(26477, 1, 11686, 1, 1, 51831);
-- Dead Mage Hunter (26477) - apply the permanent transform to itself on spawn/respawn
DELETE FROM `smart_scripts` WHERE `entryorguid` = 26477 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26477, 0, 0, 1, 8, 0, 100, 512, 61832, 0, 0, 0, 0, 11, 47096, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dead Mage Hunter - On Spellhit ''Rifle the Bodies: Create Magehunter Personal Effects Cover'' - Cast Spell'),
(26477, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead Mage Hunter - On Spellhit ''Rifle the Bodies: Create Magehunter Personal Effects Cover'' - Despawn Instant (No Repeat)'),
(26477, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 75, 47090, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead Mage Hunter - On Respawn - Add Aura Dead Mage Hunter Transform (47090) on self (permanent, random 1 of 4 corpse displays of 26476)');
