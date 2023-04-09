-- DB update 2023_04_09_02 -> 2023_04_09_03
-- Shadowmoon Warlock
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17371);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17371, 0, 0, 0, 9, 0, 100, 2, 0, 40, 3300, 4900, 0, 11, 12739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - Within 0-40 Range - Cast \'Shadow Bolt\' (Normal Dungeon)'),
(17371, 0, 1, 0, 9, 0, 100, 4, 0, 40, 3300, 4900, 0, 11, 15472, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - Within 0-40 Range - Cast \'Shadow Bolt\' (Heroic Dungeon)'),
(17371, 0, 2, 0, 0, 0, 100, 2, 1100, 7800, 14800, 30100, 0, 11, 32197, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast \'Corruption\' (Normal Dungeon)'),
(17371, 0, 3, 0, 0, 0, 100, 4, 1100, 7800, 14800, 30100, 0, 11, 37113, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast \'Corruption\' (Heroic Dungeon)'),
(17371, 0, 4, 0, 0, 0, 100, 0, 6600, 10700, 14900, 14900, 0, 11, 13338, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast \'Curse of Tongues\''),
(17371, 0, 5, 0, 1, 0, 100, 0, 12600, 13700, 21900, 24900, 0, 11, 33111, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - Out of Combat - Cast \'Fel Power\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 6) AND (`SourceEntry` = 17371) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 18894) AND (`ConditionValue2` = 10) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 6, 17371, 0, 0, 29, 1, 18894, 10, 0, 0, 0, 0, '', 'Only cast Fel Power (33111) if a Felguard Brute (18894) is nearby');

-- Hellfire Imp
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17477);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17477, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 0, 11, 30540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - Out of Combat - Cast \'Summon Visual\' (No Repeat)'),
(17477, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 28, 30540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - On Aggro - Remove Aura \'Summon Visual\''),
(17477, 0, 2, 0, 0, 0, 100, 2, 1000, 3400, 3400, 4800, 0, 11, 15242, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - In Combat - Cast \'Fireball\' (Normal Dungeon)'),
(17477, 0, 3, 0, 0, 0, 100, 4, 1000, 3400, 3400, 4800, 0, 11, 17290, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - In Combat - Cast \'Fireball\' (Heroic Dungeon)'),
(17477, 0, 4, 0, 0, 0, 100, 4, 6000, 9000, 6000, 9000, 0, 11, 16144, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - In Combat - Cast \'Fire Blast\' (Heroic Dungeon)');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 17477) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 17397) AND (`ConditionValue2` = 10) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 17477, 0, 0, 29, 1, 17397, 10, 0, 0, 0, 0, '', 'Only cast Summon Visual (30540) if a Shadowmoon Adept (17397) is nearby');
