INSERT INTO version_db_world (`sql_rev`) VALUES ('1490055987207415200');
-- DIFF `gameobject` of id 2040
DELETE FROM `gameobject` WHERE (id = 2040) AND (guid IN (7304, 7321));

-- DIFF `gameobject` of id 1732
DELETE FROM `gameobject` WHERE (id = 1732) AND (guid IN (5503, 5535, 5666));

-- DIFF `gameobject` of id 1734
DELETE FROM `gameobject` WHERE (id = 1734) AND (guid IN (5907));

-- DIFF `gameobject` of id 73941
DELETE FROM `gameobject` WHERE (id = 73941) AND (guid IN (14685));
