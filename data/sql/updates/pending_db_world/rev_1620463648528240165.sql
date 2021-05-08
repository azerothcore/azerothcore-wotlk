INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620463648528240165');

UPDATE `gameobject` SET `spawntimesecs`= 2700 WHERE FIND_IN_SET (`id`,'324,150082,176643,123848'); -- Small Thorium
UPDATE `gameobject` SET `spawntimesecs`= 2700 WHERE FIND_IN_SET (`id`,'175404,177388'); -- Rich Thorium
UPDATE `gameobject` SET `spawntimesecs`= 604800 WHERE FIND_IN_SET (`id`,'175404') AND `map` = 429; -- Rich Thorium in Uldaman

UPDATE `gameobject` SET `spawntimesecs`= 1800 WHERE FIND_IN_SET (`id`,'2040,150079,176645,123310'); -- Mithril
UPDATE `gameobject` SET `spawntimesecs`= 604800 WHERE FIND_IN_SET (`id`,'2040') AND `map` = 349; -- Mithril Mauradon

UPDATE `gameobject` SET `spawntimesecs`= 2700 WHERE FIND_IN_SET (`id`,'2047,150081,181108,123309'); -- Truesilver
UPDATE `gameobject` SET `spawntimesecs`= 604800 WHERE FIND_IN_SET (`id`,'2040') AND `map` = 349; -- Truesilver Mauradon

