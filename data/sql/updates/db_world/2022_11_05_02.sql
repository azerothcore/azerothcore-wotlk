-- DB update 2022_11_05_01 -> 2022_11_05_02
-- Quest: A Pilgrim's Plight
UPDATE `gameobject` SET `spawntimesecs`=1 WHERE `guid`=25340 AND `id`=184478;
-- Quest: The Dread Relic
UPDATE `gameobject` SET `spawntimesecs`=0 WHERE `guid`=26109 AND `id`=185220;
-- Quest: The Shadow Tomb
UPDATE `gameobject` SET `spawntimesecs`=0 WHERE `id` IN (185224, 185225, 185226) AND `guid` IN (26110, 26111, 47565);
-- Quest: A Damp Dark Place
UPDATE `gameobject` SET `spawntimesecs`=0 WHERE `guid`=22527 AND `id`=182122;
