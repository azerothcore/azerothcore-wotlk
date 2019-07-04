INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562252728718185214');

-- Fix Dragonflayer Strategist throwing a throwing knife instead of a blue/white checkered cube when casting "Hurl Dagger"
UPDATE `creature_equip_template` SET `ItemID3` = 29010 WHERE `CreatureID` = 23956;
