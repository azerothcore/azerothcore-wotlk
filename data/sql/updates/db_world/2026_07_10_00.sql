-- DB update 2026_07_06_00 -> 2026_07_10_00
--
-- Higher Learning Dalaran books should despawn after the SmartAI read timer and then use their gameobject respawn timer.
UPDATE `gameobject_template`
SET `Data5` = 1
WHERE `entry` IN (
    192651, 192652, 192653, 192706, 192707, 192708, 192709, 192710, 192711, 192713,
    192865, 192866, 192867, 192868, 192869, 192870, 192871, 192872, 192874, 192880,
    192881, 192882, 192883, 192884, 192885, 192886, 192887, 192888, 192889, 192890,
    192891, 192894, 192895, 192896, 192905
)
AND `type` = 10;
