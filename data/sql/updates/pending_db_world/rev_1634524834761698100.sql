INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634524834761698100');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 182026;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 182026, 1, 0, 29, 1, 17886, 60, 0, 0, 0, 0, '', 'Sun Gate - Only run SAI IF trigger IN RANGE'),
(22, 2, 182026, 1, 0, 29, 1, 17886, 60, 1, 1, 0, 0, '', 'Sun Gate - Only run SAI IF NO trigger IN RANGE');

-- Increase respawn timer to two minutes
UPDATE `creature` SET `spawntimesecs` = 123 WHERE `id` = 17886;
UPDATE `gameobject` SET `spawntimesecs` = 120 WHERE `id` = 184850;

UPDATE `smart_scripts` SET `action_type` = 41, `comment` = 'Sunhawk Portal Controller - On Gameobject State Changed - Despawn Target' WHERE `entryorguid` IN (-12168, -12173, -12164, -12166) AND `source_type` = 1 AND `action_type` = 51;
