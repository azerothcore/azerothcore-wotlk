INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1582129218605106158');

-- Mirkfallon Keeper, Mirkfallon Dryad, Gatekeeper Kordurus, Rynthariel the Keymaster:
-- Use faction 124 instead of 79 (both Darnassus, but 79 has PvP flag)
UPDATE `creature_template` SET `faction` = 124 WHERE `entry` IN (4056,4061,4409,8518);
