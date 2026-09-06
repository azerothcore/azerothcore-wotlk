-- DB update 2025_03_17_03 -> 2025_03_19_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 45034;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(45034, 'spell_kalecgos_curse_of_boundless_agony_aura');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (45032, 45034)) AND (`SourceId` = 0) AND (`ConditionValue1` IN (45032, 45034));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 45032, 0, 0, 1, 0, 45032, 0, 0, 1, 0, 0, '', 'Player does not have Curse of Boundless Agony'),
(13, 1, 45032, 0, 0, 1, 0, 45034, 0, 0, 1, 0, 0, '', 'Player does not have Curse of Boundless Agony'),
(13, 1, 45034, 0, 0, 1, 0, 45032, 0, 0, 1, 0, 0, '', 'Player does not have Curse of Boundless Agony'),
(13, 1, 45034, 0, 0, 1, 0, 45034, 0, 0, 1, 0, 0, '', 'Player does not have Curse of Boundless Agony');
