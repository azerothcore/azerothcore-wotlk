INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635063079296632300');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry` IN (12139,11219);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19,0,12139,0,0,8,0,11361,0,0,0,0,0,'','"Let the Fires Come" available if "Fire Training" rewarded'),
(19,0,12139,0,1,8,0,11449,0,0,0,0,0,'','"Let the Fires Come" available if "Fire Training" rewarded'),
(19,0,12139,0,2,8,0,11450,0,0,0,0,0,'','"Let the Fires Come" available if "Fire Training" rewarded'),
(19,0,11219,0,0,8,0,11361,0,0,0,0,0,'','"Stop the Fires" available if "Fire Training" rewarded'),
(19,0,11219,0,1,8,0,11449,0,0,0,0,0,'','"Stop the Fires" available if "Fire Training" rewarded'),
(19,0,11219,0,2,8,0,11450,0,0,0,0,0,'','"Stop the Fires" available if "Fire Training" rewarded');
