INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630118063882922979');

-- Delete all items except Alterac Granite from Alterac Granite spawns
DELETE FROM `gameobject_loot_template` WHERE `Entry` = 2145 AND `Item` <> 4521;

