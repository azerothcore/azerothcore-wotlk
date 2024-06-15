-- DB update 2022_11_09_00 -> 2022_11_12_00
-- Veil Reskk
DELETE FROM `gameobject` WHERE (`id` = 185200) AND (`guid` IN (27551));
UPDATE `gameobject` SET `spawntimesecs`=0 WHERE `guid`=26086 AND `id`=185200;
-- Veil Shienor
DELETE FROM `gameobject` WHERE (`id` = 182505) AND (`guid` IN (27550));
UPDATE `gameobject` SET `spawntimesecs`=0 WHERE `guid`=26087 AND `id`=185201;
