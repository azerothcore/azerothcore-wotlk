INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616884299081820400');

-- Updated gossip_menu for Doctor Gregory Victor <Trauma Surgeon> 
UPDATE `creature_template` SET `gossip_menu_id`=5381 WHERE  `entry`=12920;

-- Condition for gossip before and after quest completion
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 5381);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 5381, 6573, 0, 0, 8, 0, 6622, 0, 0, 0, 0, 0, '', ''),
(14, 5381, 6413, 0, 0, 47, 0, 6622, 27, 0, 0, 0, 0, '', '');

-- Condition for gossip before and after quest completion
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 5382);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 5382, 6414, 0, 0, 8, 0, 6624, 0, 0, 0, 0, 0, '', ''),
(14, 5382, 6415, 0, 0, 47, 0, 6624, 27, 0, 0, 0, 0, '', '');
