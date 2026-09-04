-- DB update 2026_05_24_00 -> 2026_05_24_01
--
UPDATE `creature_template` SET `CreatureImmunitiesId` = -375 WHERE `entry` IN (30183, 16486);
