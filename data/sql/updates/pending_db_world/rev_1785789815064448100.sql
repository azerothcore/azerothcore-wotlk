--
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 25444);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(25444, 0, 0, 1, 1, 0, 0, 0);

-- Totems don't use SmartAI
UPDATE `creature_template` SET `AIName` = '' WHERE (`entry` = 25444);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25444);

-- They use template_spell
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 25444) AND (`Index` IN (0));
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(25444, 0, 45580, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25428);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25428, 0, 0, 0, 4, 0, 5, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magmoth Shaman - On Aggro - Say Line'),
(25428, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magmoth Shaman - Between 0-15% Health - Flee For Assist (No Repeat)'),
(25428, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45575, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magmoth Shaman - On Reset - Cast \'Magmoth Fire Totem\''),
-- So for the cosmetic cast, we use OnSummonedUnit->CrossCast, clever, no?
(25428, 0, 3, 0, 17, 0, 100, 0, 25444, 0, 0, 0, 0, 0, 86, 45576, 0, 7, 0, 0, 0, 19, 24021, 30, 0, 0, 0, 0, 0, 0, 'Magmoth Shaman - On Summoned Unit - Cross Cast \'Cosmetic - New Fire Beam Channel (Mouth)\'');
