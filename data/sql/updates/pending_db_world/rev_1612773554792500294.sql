INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612773554792500294');

-- Lower respawn of items for quest Barov Family Fortune

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid` IN
(
43221, -- The Deed to Brill
43222, -- The Deed to Caer Darrow
43223, -- The Deed to Southshore
43224 -- The Deed to Tarren Mill
);

