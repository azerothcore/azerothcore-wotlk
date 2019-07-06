INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561359418814877200');

-- Kargath Grunt should have axe equiped https://wow.gamepedia.com/Kargath_Grunt
UPDATE `creature_equip_template` SET `ItemID1`=5287 WHERE `CreatureID`=8155;
UPDATE `creature_addon` SET `bytes2`=1 WHERE `guid`=6898;
