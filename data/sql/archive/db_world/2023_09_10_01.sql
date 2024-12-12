-- DB update 2023_09_10_00 -> 2023_09_10_01
--
ALTER TABLE `creature`
	ADD COLUMN `CreateObject` TINYINT UNSIGNED NOT NULL DEFAULT '0' AFTER `VerifiedBuild`;

-- Haggle
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` = 53788 AND `id1` = 14041;

-- The Underbog
SET @CGUID := 138300;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+218;

-- The Steamvault
SET @CGUID := 142000;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID AND @CGUID+174;

-- The Shattered Halls
SET @CGUID := 151000;
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+4;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+5 AND @CGUID+18;
UPDATE `creature` SET `CreateObject` = 3 WHERE `guid` BETWEEN @CGUID+19 AND @CGUID+34;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+35 AND @CGUID+84;
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` BETWEEN @CGUID+85 AND @CGUID+88;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+89 AND @CGUID+282;

-- Sethekk Halls
SET @CGUID := 138600;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+187;

-- The Shadow Labyrinth
SET @CGUID := 146000;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+224;
UPDATE `creature` SET `CreateObject` = 2 WHERE `guid` BETWEEN @CGUID+225 AND @CGUID+229;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+230 AND @CGUID+235;

-- The Mechanar
SET @CGUID := 138800;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+93;
UPDATE `creature` SET `CreateObject` = 3 WHERE `guid` IN (138893, 138892, 138891, 138890, 138879, 138878, 138877, 138876, 138869, 138864, 138863, 138831, 138820, 138819, 138818, 138817);

-- The Botanica
SET @CGUID := 147000;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+187;

-- The Arcatraz
SET @CGUID := 138900;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+97;

-- The Deathforge
SET @CGUID := 83028;
UPDATE `creature` SET `CreateObject` = 1 WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+84;
