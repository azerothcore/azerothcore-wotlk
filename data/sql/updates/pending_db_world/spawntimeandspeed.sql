-- Terrowulf Packlord 
UPDATE `creature` SET `spawntimesecs`=75600 WHERE `guid`=51870 AND `id1`=3792;
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 3792);
-- Akkrilus
UPDATE `creature` SET `spawntimesecs`=75600 WHERE `guid`=51883 AND `id1`=3773;
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 3773);
-- Eck'alom
UPDATE `creature` SET `spawntimesecs`=75600 WHERE `guid`=32879 AND `id1`=10642;
-- Mugglefin
UPDATE `creature` SET `spawntimesecs`=30600 WHERE `guid`=51884 AND `id1`=10643;
-- Ursol lok
UPDATE `creature` SET `spawntimesecs`=37800 WHERE `guid`=51884 AND `id1`=12037;
