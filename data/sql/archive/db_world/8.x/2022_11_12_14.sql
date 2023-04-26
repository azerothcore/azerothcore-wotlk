-- DB update 2022_11_12_13 -> 2022_11_12_14
-- Delete the ores that survived the purge
DELETE FROM `gameobject` WHERE `guid` IN (40255, 40271, 42411, 61962) AND `id` IN (181555, 181556, 181557);
-- Ore spawn timers
UPDATE `gameobject` SET `spawntimesecs`=1200 WHERE `id` IN (181555, 181556, 181557, 181569) AND `map`=530;
-- Common herb spawn timers
UPDATE `gameobject` SET `spawntimesecs`=900 WHERE `id` IN (
181270, -- Felweed
183044, -- Felweed (Zangarmarsh)
176584, -- Dreamfoil
176583, -- Golden Sansam
176586, -- Mountain Silversage
183043, -- Ragveil
183045, -- Dreaming Glory (Zangarmarsh)
181271, -- Dreaming Glory
183046, -- Blindweed
142144, -- Ghost Mushroom
181276, -- Flame Cap
181277, -- Terocone
181279, -- Netherbloom
2041    -- Liferoot
 ) AND `map`=530;
-- Nightmare Vine
UPDATE `gameobject` SET `spawntimesecs`=360 WHERE `id` IN (181280) AND `map`=530;
-- Mana Thistle
UPDATE `gameobject` SET `spawntimesecs`=600 WHERE `id` IN (181281) AND `map`=530;

DELETE FROM `pool_gameobject` WHERE `guid` IN (34029, 40309, 42217, 42430, 86396, 87125, 87126);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(34029, 8080, 0, 'Felweed - Zangarmarsh'),
(40309, 8134, 0, 'Felweed - Terokkar Forest'),
(42217, 8086, 0, 'Ragveil - Zangarmarsh'),
(42430, 8086, 0, 'Ragveil - Zangarmarsh'),
(86396, 8042, 0, 'Golden Sansam - Hellfire Peninsula'),
(87125, 8086, 0, 'Ragveil - Zangarmarsh'),
(87126, 8086, 0, 'Ragveil - Zangarmarsh');

UPDATE `gameobject` SET `ZoneId`=3521 WHERE `guid` IN (34029, 42217, 42430, 87125, 87126);
UPDATE `gameobject` SET `ZoneId`=3519, `AreaId`=3961 WHERE `guid`=40309;
UPDATE `gameobject` SET `ZoneId`=3483 WHERE `guid`=86396;

-- Lower chances for Khorium to spawn on Fel Iron nodes from 2% to 1% I think it's even lower than that, actually.
UPDATE `pool_gameobject` SET `chance`=1 WHERE `description` LIKE '%Khorium for Fel Iron%';
