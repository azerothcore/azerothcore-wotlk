--
-- Razorscale: unit_flags 0x8200 (IMMUNE_TO_NPC, UNK_15) for the five interactive Expedition NPCs, and Flame Breath's
-- conditions so the breath can reach the Expedition NPCs
UPDATE `creature_template` SET `unit_flags` = 512 | 32768, `VerifiedBuild` = 49345 WHERE `entry` IN (33186, 33724, 33210, 34254, 33259, 34257, 33287, 34256, 33816, 34255);

-- cleaer `AIName` 'NullCreatureAI'
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` IN (33259, 33816);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 3 AND `SourceEntry` IN (63317, 64021) AND `ConditionTypeOrReference` = 31 AND `ConditionValue1` = 3 AND `ConditionValue2` IN (33259, 33816, 33287);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 63317, 0, 2, 31, 0, 3, 33259, 0, 0, 0, 0, '', 'Flame Breath - Expedition Trapper'),
(13, 3, 63317, 0, 3, 31, 0, 3, 33816, 0, 0, 0, 0, '', 'Flame Breath - Expedition Defender'),
(13, 3, 63317, 0, 4, 31, 0, 3, 33287, 0, 0, 0, 0, '', 'Flame Breath - Expedition Engineer'),
(13, 3, 64021, 0, 3, 31, 0, 3, 33259, 0, 0, 0, 0, '', 'Flame Breath - Expedition Trapper'),
(13, 3, 64021, 0, 4, 31, 0, 3, 33816, 0, 0, 0, 0, '', 'Flame Breath - Expedition Defender'),
(13, 3, 64021, 0, 5, 31, 0, 3, 33287, 0, 0, 0, 0, '', 'Flame Breath - Expedition Engineer');
