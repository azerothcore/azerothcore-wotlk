-- DB update 2025_01_24_00 -> 2025_01_24_01
--
-- Remove extra Sanctum Planetarium
DELETE FROM `gameobject` WHERE (`id` = 188081) AND (`guid` IN (27809));
