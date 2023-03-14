-- DB update 2023_03_04_10 -> 2023_03_04_11
--
-- Remove 1.X mobs that are not in wotlk
DELETE FROM creature where guid IN (80391, 80392, 80393, 80394, 80396, 80397, 80399, 80400, 80401, 80402, 80403, 80404, 80405) AND id1 IN(116, 94);
