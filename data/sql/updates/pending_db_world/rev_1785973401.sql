-- Omgorn the Lost (8201): the 'Eastmoon Ruins' and 'Southmoon Ruins' spawns of
-- pool 366 were placed on map 0 while both subzones are in Tanaris (map 1),
-- leaving the pool split across two maps.
UPDATE `creature` SET `map` = 1 WHERE `guid` IN (152280, 152281);
