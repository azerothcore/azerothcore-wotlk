INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631782029155380281');

-- Decreases the respawn time, so the quest chests are not despawning
UPDATE `gameobject` SET `spawntimesecs` = 0 WHERE `id` = 176344 AND `guid` IN (17201);
UPDATE `gameobject` SET `spawntimesecs` = 0 WHERE `id` = 190483 AND `guid` IN (17199);
UPDATE `gameobject` SET `spawntimesecs` = 0 WHERE `id` = 190484 AND `guid` IN (17200);
