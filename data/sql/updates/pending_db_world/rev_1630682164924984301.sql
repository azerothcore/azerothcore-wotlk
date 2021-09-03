INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630682164924984301');

--Removed one of the spawns of Razormaw Matriach's Nest because its on the same place as the guid 6245
DELETE FROM `gameobject` WHERE (`id` = 202083) AND (`guid` IN (14999));

