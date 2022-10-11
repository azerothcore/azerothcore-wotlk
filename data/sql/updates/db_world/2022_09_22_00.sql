-- DB update 2022_09_21_10 -> 2022_09_22_00
-- Update spawnpoints in Ghostlands for multispawn Shadowpine Catlord & Shadowpine Hexxer
UPDATE `creature` SET `id1`=16345, `id2`=16346 WHERE `guid` IN (85790,85835,85914,85826,85769,85933,85771,85763,85905,85833,85904,85846,85803,85931,85868,85929);

-- Update spawnpoints in Ghostlands for multispawn Shadowpine Headhunter & Shadowpine Shadowcaster
UPDATE `creature` SET `id1`=16344, `id2`=16469 WHERE `guid` IN (81945,81948,81949,81993,81980,81929,81955,81989,81990,81959,81966,81973,81972,81968,81985,81984,81961);
