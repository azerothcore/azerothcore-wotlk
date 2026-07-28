-- Issue #26753: "Orgrim's Hammer Scout" (32201) attacks players on approach even though
-- it should be neutral. Faction 714 is already correctly non-hostile to Alliance
-- (HostileMask 0 in FactionTemplate.dbc) - the trigger isn't proximity aggro, it's the
-- assist branch: SmartAI::MoveInLineOfSight (SmartAI.cpp:786-789) gates both plain
-- proximity aggro AND assisting a nearby ally already fighting the player behind the
-- same check, HasReactState(REACT_AGGRESSIVE). That matches the original report - the
-- player got pulled while already fighting unrelated mobs nearby.
-- REACT_DEFENSIVE (not PASSIVE) blocks both paths the same way passive would, but still
-- lets the Scout fight back if a player attacks it directly - passive never retaliates
-- (CreatureAI::UpdateVictim calls AttackStop() every tick while passive and in combat).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32201;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 32201 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32201, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrim''s Hammer Scout - On Reset - Set React Defensive');
