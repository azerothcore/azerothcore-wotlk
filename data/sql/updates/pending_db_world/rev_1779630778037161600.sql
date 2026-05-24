--
-- Fix quest 13133 "Find the Ancient Hero": Subjugated Iskalder (30886)
-- despawns when the player drags him onto the lower floors of the Halls of
-- the Ancestors. The OOC despawn rule (smart_scripts id=3) whitelists
-- AreaIds {4498, 4526} but the surrounding/lower area is 4496 (Jotunheim),
-- so any time the creature reports area 4496 the despawn fires.
-- Adding 4496 to the whitelist keeps the original "scoped to quest area"
-- intent while covering the full legitimate path:
--   4526 (Njorndar Village) -> 4496 (Jotunheim / Halls lower) -> 4498 (Halls upper)
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 4) AND (`SourceEntry` = 30886);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 4, 30886, 0, 0, 23, 1, 4526, 0, 0, 1, 0, 0, '', 'Despawn Subjugated Iskalder when outside quest areas'),
(22, 4, 30886, 0, 0, 23, 1, 4498, 0, 0, 1, 0, 0, '', 'Despawn Subjugated Iskalder when outside quest areas'),
(22, 4, 30886, 0, 0, 23, 1, 4496, 0, 0, 1, 0, 0, '', 'Despawn Subjugated Iskalder when outside quest areas');
