-- DB update 2026_11_22_02 -> 2026_11_22_03
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 2 AND `SourceEntry` = 63618;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 2, 63618, 0, 0, 31, 0, 3, 33060, 0, 0, 0, 0, '', 'Overload - target Salvaged Siege Engine'),
(13, 2, 63618, 0, 1, 31, 0, 3, 33062, 0, 0, 0, 0, '', 'Overload - target Salvaged Chopper'),
(13, 2, 63618, 0, 2, 31, 0, 3, 33109, 0, 0, 0, 0, '', 'Overload - target Salvaged Demolisher'),
(13, 2, 63618, 0, 3, 31, 0, 3, 33067, 0, 0, 0, 0, '', 'Overload - target Salvaged Siege Turret'),
(13, 2, 63618, 0, 4, 31, 0, 3, 33167, 0, 0, 0, 0, '', 'Overload - target Salvaged Demolisher Mechanic Seat');
