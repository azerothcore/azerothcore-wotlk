-- DB update 2026_08_08_01 -> 2026_08_08_02
-- Takk's Nest and Ravasaur Matriarch's Nest gameobject pools (map 1) reused
-- pool ids 7001/7002, which belong to the Webbed Crusader creature pools
-- (map 571). Pools are bound to a single map now, so the nests get own pools.
DELETE FROM `pool_template` WHERE `entry` IN (201213, 201214);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(201213, 1, 'Takk''s Nest'),
(201214, 1, 'Ravasaur Matriarch''s Nest');

UPDATE `pool_gameobject` SET `pool_entry` = 201213 WHERE `guid` IN (14990, 14991, 14992, 14993);
UPDATE `pool_gameobject` SET `pool_entry` = 201214 WHERE `guid` IN (14994, 14995, 14996, 14997, 14998);
