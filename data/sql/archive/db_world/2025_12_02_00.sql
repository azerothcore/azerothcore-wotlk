-- DB update 2025_12_01_05 -> 2025_12_02_00

-- Remove double spawn point
DELETE FROM `creature` WHERE (`id1` = 32250) AND (`guid` IN (125031));
