-- DB update 2026_05_17_06 -> 2026_05_17_07

-- Remove Dead Alliance Soldier spawn point and creature addon
DELETE FROM `creature` WHERE `id1` = 31281 AND `guid` = 121653;
DELETE FROM `creature_addon` WHERE (`guid` IN (121653));
