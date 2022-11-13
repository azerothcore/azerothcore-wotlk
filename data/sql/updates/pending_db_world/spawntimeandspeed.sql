-- Terrowulf Packlord 
UPDATE `creature` SET `spawntimesecs`=75600 WHERE `guid`=51870 AND `id1`=3792;
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 3792);
-- Akkrilus
UPDATE `creature` SET `spawntimesecs`=75600 WHERE `guid`=51883 AND `id1`=3773;
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 3773);
