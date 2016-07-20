
-- Azure Manashaper (31401), delete duplicate spawns
DELETE FROM creature WHERE id=31401 AND guid IN (111931, 111932, 111933, 111934, 111935) AND spawntimesecs=300 AND modelid=27586;
