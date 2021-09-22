INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632332436826853639');

--Delete incorrect DisplayID for captain Halyndor
UPDATE `creature_model_info` SET `DisplayID_Other_Gender`= 0 WHERE `DisplayID`= 3494;
