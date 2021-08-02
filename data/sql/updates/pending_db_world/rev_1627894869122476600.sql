INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627894869122476600');

-- Make the Egg of Onyxia (20359) dissapear after atacking for the quest Brood of Onyxia (1172)
UPDATE `gameobject_template` SET `Data3` = 1 WHERE (`entry` = 20359);

