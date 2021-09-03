INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630421521637477310');

-- Adds movements for Quel`dorei Ghost
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16325 AND `guid` IN (82177, 82178, 82180, 82183, 82184, 82185, 82186, 82187, 82189, 82190, 82193, 82198, 82200, 82205, 82208, 82241, 82254);

-- Adds movements for Quel`dorei Wraith
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16326 AND `guid` IN (82175, 82179, 82181, 82182, 82188, 82191, 82194, 82195, 82196, 82197, 82199, 82207, 82210, 82253);
