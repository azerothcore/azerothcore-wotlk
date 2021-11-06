INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635882514407659976');

-- Fix equipment for Southsea Swashbuckler
UPDATE `creature_equip_template` SET `ItemID1`=1897, `ItemID2`=0 WHERE `CreatureID`=7858;
