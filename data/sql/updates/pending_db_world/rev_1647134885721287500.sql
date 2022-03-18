INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647134885721287500');

UPDATE `conditions` SET `ConditionTypeOrReference` = 8 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 2997;
UPDATE `conditions` SET `ConditionTypeOrReference` = 8 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 2999;
UPDATE `conditions` SET `ConditionTypeOrReference` = 8 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 3000;
UPDATE `conditions` SET `ElseGroup` = 1 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 2997;
UPDATE `conditions` SET `ElseGroup` = 2 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 2999;
UPDATE `conditions` SET `ElseGroup` = 3 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 3000;
