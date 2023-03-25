--
UPDATE `creature_template` SET `faction`=1761 WHERE `entry`=19300;
UPDATE `creature_template` SET `faction`=1762 WHERE `entry`=19301;
UPDATE `creature_template` SET `faction`=1763 WHERE `entry`=19302;
UPDATE `creature_template` SET `faction`=1764 WHERE `entry`=19303;
UPDATE `creature_template` SET `faction`=1765 WHERE `entry`=19304;

DELETE FROM `creature` WHERE `id1` BETWEEN 19300 AND 19304;
