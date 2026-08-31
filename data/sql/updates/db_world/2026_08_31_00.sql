-- DB update 2026_08_30_05 -> 2026_08_31_00
-- Ulduar repair stations (Auto-Repair 62705) must also hit the Salvaged Siege Turret and the
-- Salvaged Demolisher Mechanic Seat: the seat is a separate vehicle with its own pyrite pool,
-- so without it the gunner's pyrite bar is never refueled (sniffed: one pulse hits both
-- demolisher and seat, energizing each to full).
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 7 AND `SourceEntry` = 62705;
INSERT INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
     `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`,
     `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
    (13, 7, 62705, 0, 0, 31, 0, 3, 33060, 0, 0, 0, 0, '', 'Auto-Repair targets Salvaged Siege Engine'),
    (13, 7, 62705, 0, 1, 31, 0, 3, 33062, 0, 0, 0, 0, '', 'Auto-Repair targets Salvaged Chopper'),
    (13, 7, 62705, 0, 2, 31, 0, 3, 33109, 0, 0, 0, 0, '', 'Auto-Repair targets Salvaged Demolisher'),
    (13, 7, 62705, 0, 3, 31, 0, 3, 33067, 0, 0, 0, 0, '', 'Auto-Repair targets Salvaged Siege Turret'),
    (13, 7, 62705, 0, 4, 31, 0, 3, 33167, 0, 0, 0, 0, '', 'Auto-Repair targets Salvaged Demolisher Mechanic Seat');
