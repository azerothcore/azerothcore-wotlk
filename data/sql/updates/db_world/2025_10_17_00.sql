-- DB update 2025_10_16_05 -> 2025_10_17_00
--
UPDATE `gameobject` SET `state` = 0 WHERE `guid` IN (65573, 65585) AND `id` IN (191324, 191416);
