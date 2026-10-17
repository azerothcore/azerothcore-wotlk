-- DB update 2025_07_24_02 -> 2025_07_24_03
-- Deletes 6 "Lordaeron Citizens" who shouldn't be in the Orb Room (Teleport from Undercity to Silvermon)
DELETE FROM `creature` WHERE `id1` = 3617 AND `guid` IN (132259, 132263, 132262, 132260, 132264, 132261);
