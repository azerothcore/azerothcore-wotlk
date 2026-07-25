-- DB update 2025_01_05_00 -> 2025_01_05_01
-- Angered, Suffering & Hungering Soul Fragment respawn
UPDATE `creature` SET `spawntimesecs` = 15 WHERE (`guid` BETWEEN 148424 AND 148488) and `id1` in (23398, 23399, 23401);
