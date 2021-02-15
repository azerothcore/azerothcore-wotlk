INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613390656721660682');

-- Tormek Stoneriver was removed in v3.3.0

DELETE FROM `creature` WHERE `guid`=244510;

-- Quests 'Dearest Colara,' should be marked as deprecated

DELETE FROM `disables` WHERE `sourceType`=1 AND `entry` IN (8897,8898,8899);

INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(1,8897,0,"","","Deprecated quest: Dearest Colara,"),
(1,8898,0,"","","Deprecated quest: Dearest Colara,"),
(1,8899,0,"","","Deprecated quest: Dearest Colara,");
