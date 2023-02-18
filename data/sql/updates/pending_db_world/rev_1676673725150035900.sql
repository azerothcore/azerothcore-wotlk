-- Sha'ni Proudtusk - On summon, despawn others.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9136;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9136);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9136, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 9136, 5, 0, 0, 0, 0, 0, 0, 'Sha\'ni Proudtusk - On Just Summoned - Despawn Other Clones');

-- Sha'ni Proudtusk's Remains GO SmartAI - Add OR condition for _COMPLETE and _REWARDED.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=1 AND `SourceEntry`=160445 AND `ConditionValue1`=3821;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(22, 1, 160445, 1, 0, 28, 0, 3821, 0, 0, 0, 0, 0, '', '(OR) Execute SmartAI for gameobject 160445 only if player has completed quest 3821'),
(22, 1, 160445, 1, 1, 8, 0, 3821, 0, 0, 0, 0, 0, '', '(OR) Execute SmartAI for gameobject 160445 only if player has been rewarded quest 3821');
