-- DB update 2026_09_21_03 -> 2026_09_21_04
-- Displacement Device (Ulduar): the dome the Chamber Overseer drops rendered half sunk into the
-- floor and never moved, because entry 34203 runs NullCreatureAI and has no movement template.
--
-- Without a `creature_template_movement` row the template defaults to `Ground` = Run and
-- `Flight` = None, so nothing ever applies MOVEMENTFLAG_HOVER and the sniffed `HoverHeight` = 5
-- stays unused. `Ground` = 2 (Hover) makes the core hover it on spawn and re-assert it afterwards.
-- `Flight` stays 0 (None): with flight allowed the creature can be read as airborne and
-- `Creature::UpdateMovementFlags()` strips the hover again.
--
-- Both entries need the row. `Creature::GetMovementTemplate()` reads `GetCreatureTemplate()`,
-- which is the difficulty template in 25 man, so 34227 would otherwise fall back to the defaults.
--
-- The script block sits on the base entry 34203 only: `Creature::GetAIName()` and
-- `SmartScript::GetScript()` both read `GetEntry()`, which stays 34203 in 25 man, so one block
-- drives both difficulties. The Displacement damage aura is not cast here, it already comes from
-- `creature_template_addon`.`auras` (64793 in 10 man, 64941 in 25 man).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 34203;

-- `creature_template_movement` only decides how the server moves the dome; the animation the
-- client plays comes from the anim tier in `creature_template_addon`.`bytes1`. Both entries
-- carried 50331648 (0x03000000 = UNIT_BYTE1_FLAG_FLY), which plays the flying animation and makes
-- the dome bob up and down while it travels. Sniffs have the tier at 2 (0x02000000 =
-- UNIT_BYTE1_FLAG_HOVER), which holds it steady.
UPDATE `creature_template_addon` SET `bytes1` = 33554432 WHERE (`entry` IN (34203, 34227));

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (34203, 34227);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(34203, 2, 0, 0, 0, 0, 0, NULL),
(34227, 2, 0, 0, 0, 0, 0, NULL);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 34203);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34203, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 64785, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Displacement Device - On Just Summoned - Cast \'Random Lightning Visual\''),
(34203, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Displacement Device - On Just Summoned - Set Reactstate Passive'),
(34203, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Displacement Device - On Just Summoned - Set Run Off'),
(34203, 0, 3, 0, 60, 0, 100, 0, 500, 500, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 1, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'Displacement Device - Every 1s - Move To Closest Player');
