-- Eclipsion Spellbinder
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 35190);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 35190, 0, 0, 31, 0, 3, 20431, 0, 0, 0, 0, '', 'Eclipsion Spellbinder\'s Crystal Channel implicit target Eclipse Point - Bloodcrystal Spell Orgin');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (22017,22022));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22017, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 0, 11, 34446, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Spellbinder - In Combat - Cast \'Arcane Missiles\''),
(22017, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 18000, 24000, 0, 0, 11, 18972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Spellbinder - In Combat - Cast \'Slow\''),
(22017, 0, 2, 0, 2, 0, 100, 0, 0, 40, 0, 0, 0, 0, 11, 38171, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Spellbinder - Between 0-40% Health - Cast \'Summon Arcane Bursts\''),
(22017, 0, 3, 0, 2, 0, 100, 0, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Spellbinder - Between 0-15% Health - Flee For Assist'),
(22017, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 35190, 0, 0, 0, 0, 0, 19, 20431, 20, 0, 0, 0, 0, 0, 0, 'Eclipsion Spellbinder - On Reset - Cast \'Crystal Channel\''),
(22022, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 6000, 12000, 0, 0, 11, 34517, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcane Burst - In Combat - Cast \'Arcane Explosion\''),
(22022, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Arcane Burst - On Just Summoned - Start Attacking');

DELETE FROM `creature` WHERE (`id1` = 20431 AND `guid` IN (73519,73520));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(73519, 20431, 0, 0, 530, 0, 0, 1, 1, 0, -4151.47, 1285.95, 66.784, 5.89921, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(73520, 20431, 0, 0, 530, 0, 0, 1, 1, 0, -4280.86, 1311.67, 66.6485, 0.733038, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0, 0, NULL);
