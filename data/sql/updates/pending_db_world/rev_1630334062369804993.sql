INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630334062369804993');

-- Remove Rethban and Underlight ores from non-specific area drops
DELETE FROM `gameobject_loot_template` WHERE `Entry` IN (1502, 1503) AND `Item` IN (2798, 22634);

-- Change Tirisfal outlier node to standard non-Redridge copper node 
UPDATE `gameobject` SET `id` = 1731 WHERE `id` = 2055 AND `guid` = 5483;

