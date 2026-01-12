-- DB update 2025_08_08_01 -> 2025_08_10_00

-- Remove Creature_addon tables from some Gargoyles.
DELETE FROM `creature_addon` WHERE (`guid` IN (100016, 100017, 100018, 100032, 100033, 100034, 100035, 100056, 100057, 100058, 100059, 100060, 100061));
