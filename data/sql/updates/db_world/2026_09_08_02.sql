-- DB update 2026_09_08_01 -> 2026_09_08_02
--
-- Call to Arms banners stand on the wrong faction's side: both the Alterac Valley and
-- Arathi Basin sets in Dalaran, and the Alterac Valley set in Shattrath, where #20539
-- already corrected Arathi. The other holidays' banners at these spots are correct.
--
-- Dalaran
UPDATE `gameobject` SET `id` = 180399 WHERE `guid` IN (151504, 151505) AND `id` = 180395;
UPDATE `gameobject` SET `id` = 180398 WHERE `guid` IN (151508, 151509) AND `id` = 180396;
UPDATE `gameobject` SET `id` = 180396 WHERE `guid` IN (151510, 151511) AND `id` = 180398;
UPDATE `gameobject` SET `id` = 180395 WHERE `guid` IN (151506, 151507) AND `id` = 180399;

-- Shattrath
UPDATE `gameobject` SET `id` = 180399 WHERE `guid` IN (151480, 151481, 151482, 151483, 151484, 151485, 151486, 151487, 151488, 151489, 151490, 151491) AND `id` = 180395;
UPDATE `gameobject` SET `id` = 180395 WHERE `guid` IN (151469, 151470, 151471, 151472, 151473, 151474, 151475, 151476, 151477, 151478, 151479) AND `id` = 180399;
