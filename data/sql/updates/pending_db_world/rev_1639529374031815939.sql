INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639529374031815939');

-- Fix Fel cone loot
DELETE FROM `gameobject_loot_template` WHERE `Entry`=1701 AND `Item`<>3418;
