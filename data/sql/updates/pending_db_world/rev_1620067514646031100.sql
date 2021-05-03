INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620067514646031100');

UPDATE `creature` SET `spawntimesecs`=300 WHERE `id` IN (
877, -- Saltscale Forager
879, -- Saltscale Hunter
871, -- Saltscale Warrior
873, -- Saltscale Oracle
875); -- Saltscale Tide Lord

