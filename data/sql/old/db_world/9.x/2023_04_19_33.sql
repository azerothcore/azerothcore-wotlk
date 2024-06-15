-- DB update 2023_04_19_32 -> 2023_04_19_33
-- Wickerman Guardian 15195
DELETE FROM `creature_template_addon` WHERE (`entry` = 15195);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(15195, 0, 0, 0, 0, 0, 0, '12187');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15195;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 15195);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15195, 0, 0, 0, 0, 0, 100, 0, 4000, 12000, 8000, 12000, 0, 11, 18368, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wickerman Guardian - In Combat - Cast \'Strike\''),
(15195, 0, 1, 0, 0, 0, 100, 0, 8000, 14000, 9000, 15000, 0, 11, 19128, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Wickerman Guardian - In Combat - Cast \'Knockdown\''),
(15195, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 25007, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wickerman Guardian - On Just Died - Cast \'Wickerman Guardian Ember\'');

-- Wickerman Guardian Ember 180574, unknown if it can be opened only by alliance.
DELETE FROM `gameobject_template` WHERE (`entry` = 180574);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(180574, 2, 6421, 'Wickerman Guardian Ember', '', 'Using', '', 5, 43, 0, 0, 6535, 0, 0, 19700, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartGameObjectAI', '', 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 180574);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(180574, 1, 0, 1, 62, 0, 100, 0, 6535, 0, 0, 0, 0, 134, 24705, 34, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wickerman Guardian Ember - On Gossip Option 0 Selected - Invoker Cast \'Invocation of the Wickerman\''),
(180574, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wickerman Guardian Ember - On Gossip Option 0 Selected - Close Gossip');
