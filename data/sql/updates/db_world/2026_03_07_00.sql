-- DB update 2026_03_06_00 -> 2026_03_07_00

-- Set Spawn Masks.
UPDATE `creature` SET `spawnMask` = `spawnMask` |2 WHERE (`id1` = 33059) AND (`guid` IN (136073, 136089, 136090));
UPDATE `creature` SET `spawnMask` = `spawnMask` |2 WHERE (`id1` = 33063) AND (`guid` IN (136246, 136249));
