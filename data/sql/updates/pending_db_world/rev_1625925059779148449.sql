INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625925059779148449');

-- Kregg Keelhaul
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 8203 AND `guid` = 51834;
-- Licillin
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 2191 AND `guid` = 52009;
-- Carnivous the Breaker
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5  WHERE `id` = 2186 AND `guid` = 51900;
-- Flagglemurk the Cruel
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 7015 AND `guid` = 51899;
-- Lord Sinslayer
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 7017 AND `guid` = 37089;
