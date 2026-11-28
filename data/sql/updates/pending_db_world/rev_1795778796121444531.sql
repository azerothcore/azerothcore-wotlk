--
-- Razorscale: unit_flags 0x8200 (UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_SWIMMING) for the five interactive Expedition
-- NPCs, and Flame Breath's conditions so the breath can reach the Expedition Trappers and Defenders
UPDATE `creature_template` SET `unit_flags` = 512 | 32768, `VerifiedBuild` = 49345 WHERE `entry` IN (33186, 33724, 33210, 34254, 33259, 34257, 33287, 34256, 33816, 34255);

-- clear `AIName` 'NullCreatureAI'
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` IN (33259, 33816);

-- the Trapper and the Engineer never fight, and a creature that can enter combat keeps her in it after a wipe
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x2000 WHERE `entry` IN (33259, 34257, 33287, 34256);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 3 AND `SourceEntry` IN (63317, 64021) AND `ConditionTypeOrReference` = 31 AND `ConditionValue1` = 3 AND `ConditionValue2` IN (33259, 33816);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 63317, 0, 2, 31, 0, 3, 33259, 0, 0, 0, 0, '', 'Flame Breath - Expedition Trapper'),
(13, 3, 63317, 0, 3, 31, 0, 3, 33816, 0, 0, 0, 0, '', 'Flame Breath - Expedition Defender'),
(13, 3, 64021, 0, 3, 31, 0, 3, 33259, 0, 0, 0, 0, '', 'Flame Breath - Expedition Trapper'),
(13, 3, 64021, 0, 4, 31, 0, 3, 33816, 0, 0, 0, 0, '', 'Flame Breath - Expedition Defender');
