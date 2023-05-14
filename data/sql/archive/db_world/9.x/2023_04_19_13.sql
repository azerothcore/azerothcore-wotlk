-- DB update 2023_04_19_12 -> 2023_04_19_13
--
-- Quicker Respawn Timer on Corporal Keeshan
UPDATE `creature` SET `spawntimesecs`=120 WHERE `guid`=17874 AND `id1`=349;
