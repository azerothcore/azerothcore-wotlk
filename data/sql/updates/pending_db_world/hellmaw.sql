-- Ambassador Hellmaw Arena
-- Target Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (32958, 36220)) AND (`ConditionTypeOrReference` = 31) AND (`ConditionValue2` IN (21159, 18731, 18793));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 32958, 0, 0, 31, 0, 3, 18793, 0, 0, 0, 0, '', 'Spell Crystal Channel (32958) only targets Invisible Target (18793)'),
(13, 1, 36220, 0, 0, 31, 0, 3, 18731, 0, 0, 0, 0, '', 'Spell Containment Beam (36220) only targets Ambassador Hellmaw (18731)');

-- Containment Beam
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 21159;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21159) AND (`source_type` = 0);

-- Invisible Target
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18793);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18793, 0, 0, 0, 23, 0, 100, 0, 32958, 1, 3600, 3600, 0, 86, 36220, 0, 19, 21159, 10, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Invisible Target - On Aura \'Crystal Channel\' - Cross Cast \'Containment Beam\''),
(18793, 0, 1, 0, 23, 0, 100, 0, 32958, 0, 3600, 3600, 0, 28, 36220, 0, 0, 0, 0, 0, 19, 21159, 10, 0, 0, 0, 0, 0, 0, 'Invisible Target - On Aura \'Crystal Channel\' Missing - Remove Aura \'Containment Beam\'');

-- Cabal Ritualist
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18794) AND (`source_type` = 0) AND (`id` IN (16));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18794, 0, 16, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 146105, 18731, 0, 0, 0, 0, 0, 0, 'Cabal Ritualist - On Just Died - Do Action on \'Ambassador Hellmaw\'');

UPDATE `smart_scripts` SET `action_param2`=0 WHERE (`entryorguid` = 18794) AND (`source_type` = 0) AND (`id` IN (3, 4, 7, 8));

-- Targets
UPDATE `creature_template_addon` SET `visibilityDistanceType` = 5 WHERE (`entry` IN (18793, 21159));
