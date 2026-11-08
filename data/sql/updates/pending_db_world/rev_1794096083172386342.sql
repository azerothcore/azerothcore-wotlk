--
-- Razorscale (#28381): broken harpoons come from the script cycle only
--
DELETE FROM `gameobject` WHERE `id` = 194565 AND `guid` IN (268562, 268563);
