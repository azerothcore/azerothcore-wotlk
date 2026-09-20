-- Zul'Farrak: TBC Classic Anniversary capture, build 69795.
-- Observed gossip pauses vary from 2.4 to 4.1 seconds; 3 seconds approximates them without disabling gossip.
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (7604, 7607);
INSERT INTO `creature_template_movement` (`CreatureId`, `InteractionPauseTimer`) VALUES
(7604, 3000),
(7607, 3000);

-- Weegli's barrel appears at 17:02:54.032; it and the door change to state 2 about two seconds later.
-- Record door completion separately from Bly's death so it survives instance reloads.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 141612 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`,
    `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
    `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`,
    `comment`) VALUES
(141612, 1, 0, 1, 60, 0, 100, 257, 2000, 2000, 0, 0, 118, 2, 0, 0, 0, 0, 0, 20, 146084, 30, 0, 0, 0, 0, 0,
    'Weegli\'s Armed Barrel - On Update - Open End Door'),
(141612, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
    'Weegli\'s Armed Barrel - On Link - Set Exploded State'),
(141612, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 2, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
    'Weegli\'s Armed Barrel - On Link - Set DATA_END_DOOR DONE');
