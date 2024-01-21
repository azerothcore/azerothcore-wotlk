-- DB update 2022_09_06_07 -> 2022_09_06_08
-- Kurinnaxx
SET @BOSS=144632;
SET @NPC=144521;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+9;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0),
(@NPC+9, @BOSS, 0);
SET @NPC=144490;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+19;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0),
(@NPC+9, @BOSS, 0),
(@NPC+10, @BOSS, 0),
(@NPC+11, @BOSS, 0),
(@NPC+12, @BOSS, 0),
(@NPC+13, @BOSS, 0),
(@NPC+14, @BOSS, 0),
(@NPC+15, @BOSS, 0),
(@NPC+16, @BOSS, 0),
(@NPC+17, @BOSS, 0),
(@NPC+18, @BOSS, 0),
(@NPC+19, @BOSS, 0);
SET @NPC=144604;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+5;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0);
SET @NPC=144482;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+3;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0);

-- General Rajaxx - Waves are already linked
SET @BOSS=144603;
SET @NPC=144486;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+3;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0);

-- Moam
SET @BOSS=144602;
SET @NPC=144592;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+8;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0);
SET @NPC=144748;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+29;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0),
(@NPC+9, @BOSS, 0),
(@NPC+10, @BOSS, 0),
(@NPC+11, @BOSS, 0),
(@NPC+12, @BOSS, 0),
(@NPC+13, @BOSS, 0),
(@NPC+14, @BOSS, 0),
(@NPC+15, @BOSS, 0),
(@NPC+16, @BOSS, 0),
(@NPC+17, @BOSS, 0),
(@NPC+18, @BOSS, 0),
(@NPC+19, @BOSS, 0),
(@NPC+20, @BOSS, 0),
(@NPC+21, @BOSS, 0),
(@NPC+22, @BOSS, 0),
(@NPC+23, @BOSS, 0),
(@NPC+24, @BOSS, 0),
(@NPC+25, @BOSS, 0),
(@NPC+26, @BOSS, 0),
(@NPC+27, @BOSS, 0),
(@NPC+28, @BOSS, 0),
(@NPC+29, @BOSS, 0);
SET @NPC=144706;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+24;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0),
(@NPC+9, @BOSS, 0),
(@NPC+10, @BOSS, 0),
(@NPC+11, @BOSS, 0),
(@NPC+12, @BOSS, 0),
(@NPC+13, @BOSS, 0),
(@NPC+14, @BOSS, 0),
(@NPC+15, @BOSS, 0),
(@NPC+16, @BOSS, 0),
(@NPC+17, @BOSS, 0),
(@NPC+18, @BOSS, 0),
(@NPC+19, @BOSS, 0),
(@NPC+20, @BOSS, 0),
(@NPC+21, @BOSS, 0),
(@NPC+22, @BOSS, 0),
(@NPC+23, @BOSS, 0),
(@NPC+24, @BOSS, 0);
SET @NPC=144681;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+24;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0),
(@NPC+9, @BOSS, 0),
(@NPC+10, @BOSS, 0),
(@NPC+11, @BOSS, 0),
(@NPC+12, @BOSS, 0),
(@NPC+13, @BOSS, 0),
(@NPC+14, @BOSS, 0),
(@NPC+15, @BOSS, 0),
(@NPC+16, @BOSS, 0),
(@NPC+17, @BOSS, 0),
(@NPC+18, @BOSS, 0),
(@NPC+19, @BOSS, 0),
(@NPC+20, @BOSS, 0),
(@NPC+21, @BOSS, 0),
(@NPC+22, @BOSS, 0),
(@NPC+23, @BOSS, 0),
(@NPC+24, @BOSS, 0);

-- Ossirian the Unscarred
SET @BOSS=144601;
SET @NPC=144633;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+7;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0);

-- Ayamiss the Hunter
SET @BOSS=144641;
SET @NPC=144540;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+40;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0),
(@NPC+9, @BOSS, 0),
(@NPC+10, @BOSS, 0),
(@NPC+11, @BOSS, 0),
(@NPC+12, @BOSS, 0),
(@NPC+13, @BOSS, 0),
(@NPC+14, @BOSS, 0),
(@NPC+15, @BOSS, 0),
(@NPC+16, @BOSS, 0),
(@NPC+17, @BOSS, 0),
(@NPC+18, @BOSS, 0),
(@NPC+19, @BOSS, 0),
(@NPC+20, @BOSS, 0),
(@NPC+21, @BOSS, 0),
(@NPC+22, @BOSS, 0),
(@NPC+23, @BOSS, 0),
(@NPC+24, @BOSS, 0),
(@NPC+25, @BOSS, 0),
(@NPC+26, @BOSS, 0),
(@NPC+27, @BOSS, 0),
(@NPC+28, @BOSS, 0),
(@NPC+29, @BOSS, 0),
(@NPC+30, @BOSS, 0),
(@NPC+31, @BOSS, 0),
(@NPC+32, @BOSS, 0),
(@NPC+33, @BOSS, 0),
(@NPC+34, @BOSS, 0),
(@NPC+35, @BOSS, 0),
(@NPC+36, @BOSS, 0),
(@NPC+37, @BOSS, 0),
(@NPC+38, @BOSS, 0),
(@NPC+39, @BOSS, 0),
(@NPC+40, @BOSS, 0);
SET @NPC=144452;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+11;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0),
(@NPC+9, @BOSS, 0),
(@NPC+10, @BOSS, 0),
(@NPC+11, @BOSS, 0);
SET @NPC=144586;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+5;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0);
SET @NPC=144531;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+8;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0);
SET @NPC=144510;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+10;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0),
(@NPC+9, @BOSS, 0),
(@NPC+10, @BOSS, 0);

-- Buru the Gorger
SET @BOSS=144642;
SET @NPC=144464;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+8;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0);
SET @NPC=144473;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+8;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0),
(@NPC+7, @BOSS, 0),
(@NPC+8, @BOSS, 0);

-- Flesh Hunters do not respawn
UPDATE `creature` SET `spawntimesecs`=259200 WHERE `id1`=15335 AND `map`=509;
