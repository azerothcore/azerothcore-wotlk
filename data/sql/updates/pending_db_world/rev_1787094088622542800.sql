-- Mimiron's Laser Barrage chain resolves its targets through spell implicit-target conditions:
-- Spinning Up (63414) EFFECT_0 carries the periodic trigger that fires the barrage and must land
-- on the DB Target (33576), which also becomes the channel object; EFFECT_1 force-casts 66490
-- (15s self root + pacify) on the Leviathan MK II (33432) so the chassis holds still through
-- phase 4 barrages. P3Wx2 Laser Barrage (63274) EFFECT_0 parks its dummy aura on the DB Target.
-- The two DB Target rows wrongly pointed at VX-001 (33651), collapsing the chain into
-- self-targeting and disabling the force-cast hold.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (63414, 63274);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 63414, 0, 0, 31, 0, 3, 33576, 0, 0, 0, 0, '', 'Spinning Up (Mimiron) - EFFECT_0 targets Mimiron DB Target'),
(13, 2, 63414, 0, 0, 31, 0, 3, 33432, 0, 0, 0, 0, '', 'Spinning Up (Mimiron) - EFFECT_1 targets Leviathan MK II'),
(13, 1, 63274, 0, 0, 31, 0, 3, 33576, 0, 0, 0, 0, '', 'P3Wx2 Laser Barrage (Mimiron) - EFFECT_0 targets Mimiron DB Target');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 66490;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 66490, 0, 0, 31, 0, 3, 33432, 0, 0, 0, 0, '', 'P3Wx2 Laser Barrage (66490) can only hit Leviathan MK II');
