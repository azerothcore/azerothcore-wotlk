INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635418346534500600');



UPDATE `broadcast_text` SET `MaleText`='prepares a Great Feast!', `FemaleText`='prepares a Great Feast!' WHERE `ID`=31843;

UPDATE `broadcast_text` SET `MaleText`='prepares a Small Feast!', `FemaleText`='prepares a Small Feast!' WHERE `ID`=31845;

UPDATE `broadcast_text` SET `MaleText`='prepares a Fish Feast!', `FemaleText`='prepares a Fish Feast!' WHERE `ID`=31844;

UPDATE `broadcast_text` SET `FemaleText`='prepares a Gigantic Feast!', `MaleText`='prepares a Gigantic Feast!' WHERE `ID`=31846;

UPDATE `broadcast_text` SET `VerifiedBuild`='0' WHERE `ID` IN (31843,31845,31844,31846);
