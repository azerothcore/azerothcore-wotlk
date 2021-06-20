INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624172983045469393');

-- Relocate Wild Gryphon spawn
UPDATE `creature` 
SET `position_x` = -269.935, `position_y` = -1409.396, `position_z` = 91.607, `orientation` = 1.929 
WHERE `guid`= 14851;
