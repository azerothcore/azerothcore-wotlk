INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629751870485899862');

-- Added roaming movement to Arcane Devourer
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16304) AND (`guid` IN (82405, 82411, 82417, 82424, 82434, 82466));
-- Added roaming movement to Mana Shifter
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16310) AND (`guid` IN (82399, 82409, 82432, 82462, 82465, 82695));

