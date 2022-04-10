INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649612333538339500');

DELETE FROM `spell_bonus_data` WHERE `entry`=18817;
INSERT INTO `spell_bonus_data` VALUES
(18817,1,0,0,0,'Skullflame Shield - Drain Life');
