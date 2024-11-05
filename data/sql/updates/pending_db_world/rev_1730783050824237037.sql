DELETE FROM `smart_scripts` WHERE `entryorguid` = 21004 AND `id` = 1;

INSERT INTO `smart_scripts` (
    `entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
    `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`,
    `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`,
    `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`,
    `target_param2`, `target_param3`, `target_param4`, `comment`
) VALUES
(21004, 0, 1, 0, 0, 0, 100, 0, 3000, 3000, 3000, 3000, 53, 38778, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 'Lesser Nether Drake - In Combat - Check for Spirit Calling aura');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 21004 AND `SourceEntry` = 31656;

INSERT INTO `conditions` (
    `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
    `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
    `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
    `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`
) VALUES
(1, 21004, 31656, 0, 0, 1, 0, 38778, 0, 0, 0, 0, '', 'Require Spirit Calling aura to loot Lesser Nether Drake Spirit');
