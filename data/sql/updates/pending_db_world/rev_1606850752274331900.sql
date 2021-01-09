INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606850752274331900');

DELETE FROM `gossip_menu_option` WHERE  `MenuID`=10120 AND `OptionID`=1;
UPDATE `conditions` SET `ElseGroup`=1, `ConditionTypeOrReference`=47, `ConditionValue2`=10 WHERE `SourceGroup`=10120 AND `ConditionValue1`=13373;
UPDATE `conditions` SET `SourceEntry`=0, `ElseGroup`=2, `ConditionTypeOrReference`=47, `ConditionValue2`=10 WHERE `SourceGroup`=10120 AND `ConditionValue1`=13374;
UPDATE `conditions` SET `SourceEntry`=0, `ElseGroup`=3, `ConditionTypeOrReference`=47, `ConditionValue2`=10 WHERE `SourceGroup`=10120 AND `ConditionValue1`=13376;
UPDATE `conditions` SET `ElseGroup`=4, `ConditionTypeOrReference`=47, `ConditionValue2`=10 WHERE `SourceGroup`=10120 AND `ConditionValue1`=13406;
