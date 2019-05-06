INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557180801797784400');

-- Healthy Dragon Scale https://www.wowdb.com/items/13920-healthy-dragon-scale
DELETE FROM `conditions` WHERE  `SourceGroup`=10678 AND `SourceEntry` IN (13920,5582) AND `ConditionValue1`=5529;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(1, 10678, 13920, 0, 0, 8, 0, 5529, 0, 0, 0, 0, 0, '', 'Healthy Dragon Scale drop if Quest 5529 rewarded');

UPDATE `creature_loot_template` SET `Chance`='100' WHERE `Entry`=10678 AND `Item`=13920;
