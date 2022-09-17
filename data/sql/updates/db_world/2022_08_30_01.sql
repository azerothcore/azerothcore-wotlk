-- DB update 2022_08_30_00 -> 2022_08_30_01
-- Skeram
SET @BOSS=88075;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` IN (87565,87567,87569,87571,87564,87566,87568,87570,88074,87652,87653);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(87565, @BOSS, 0),
(87567, @BOSS, 0),
(87569, @BOSS, 0),
(87571, @BOSS, 0),
(87564, @BOSS, 0),
(87566, @BOSS, 0),
(87568, @BOSS, 0),
(87570, @BOSS, 0),
(88074, @BOSS, 0),
(87652, @BOSS, 0),
(87653, @BOSS, 0);

-- Sartura
SET @BOSS=87648;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` IN (87595,87596,87597,87598,87599,87600,87608,87672,87673,87674,87604,87605,87609,87610,87611,87606,87607,87612,87613,87614,87615,87616,87617,87618,87619,87620,87675,87676,87677,87625,87628,87631,87633,87635,87636,87626,87624,87634,87630,87621,87627,87632,87629,87638,87623,87622,87637);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(87595, @BOSS, 0),
(87596, @BOSS, 0),
(87597, @BOSS, 0),
(87598, @BOSS, 0),
(87599, @BOSS, 0),
(87600, @BOSS, 0),
(87608, @BOSS, 0),
(87672, @BOSS, 0),
(87673, @BOSS, 0),
(87674, @BOSS, 0),
(87604, @BOSS, 0),
(87605, @BOSS, 0),
(87609, @BOSS, 0),
(87610, @BOSS, 0),
(87611, @BOSS, 0),
(87606, @BOSS, 0),
(87607, @BOSS, 0),
(87612, @BOSS, 0),
(87613, @BOSS, 0),
(87614, @BOSS, 0),
(87615, @BOSS, 0),
(87616, @BOSS, 0),
(87617, @BOSS, 0),
(87618, @BOSS, 0),
(87619, @BOSS, 0),
(87620, @BOSS, 0),
(87675, @BOSS, 0),
(87676, @BOSS, 0),
(87677, @BOSS, 0),
(87625, @BOSS, 0),
(87628, @BOSS, 0),
(87631, @BOSS, 0),
(87633, @BOSS, 0),
(87635, @BOSS, 0),
(87636, @BOSS, 0),
(87626, @BOSS, 0),
(87624, @BOSS, 0),
(87634, @BOSS, 0),
(87630, @BOSS, 0),
(87621, @BOSS, 0),
(87627, @BOSS, 0),
(87632, @BOSS, 0),
(87629, @BOSS, 0),
(87638, @BOSS, 0),
(87623, @BOSS, 0),
(87622, @BOSS, 0),
(87637, @BOSS, 0);

-- Princess Huhuran
SET @BOSS=88014;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` IN (87939,87940,87941,87942,87943,87944,87990,87991,87992,87993,87997,87998,87962,87963,87964,87965,87966,87967,87968,87969,87970,87971,87972,87973,87974,87975,87976,87994,87995,87996);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(87939, @BOSS, 0),
(87940, @BOSS, 0),
(87941, @BOSS, 0),
(87942, @BOSS, 0),
(87943, @BOSS, 0),
(87944, @BOSS, 0),
(87990, @BOSS, 0),
(87991, @BOSS, 0),
(87992, @BOSS, 0),
(87993, @BOSS, 0),
(87997, @BOSS, 0),
(87998, @BOSS, 0),
(87962, @BOSS, 0),
(87963, @BOSS, 0),
(87964, @BOSS, 0),
(87965, @BOSS, 0),
(87966, @BOSS, 0),
(87967, @BOSS, 0),
(87968, @BOSS, 0),
(87969, @BOSS, 0),
(87970, @BOSS, 0),
(87971, @BOSS, 0),
(87972, @BOSS, 0),
(87973, @BOSS, 0),
(87974, @BOSS, 0),
(87975, @BOSS, 0),
(87976, @BOSS, 0),
(87994, @BOSS, 0),
(87995, @BOSS, 0),
(87996, @BOSS, 0);

-- Twin Emperors
SET @BOSS=88077;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` IN (88015,88016,88017,88018,88019);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(88015, @BOSS, 0),
(88016, @BOSS, 0),
(88017, @BOSS, 0),
(88018, @BOSS, 0),
(88019, @BOSS, 0);

-- Critters in Twin Emperors room. Yes. All of them.
SET @NPC=144238;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+3;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0);
SET @NPC=144245;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+13;
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
(@NPC+13, @BOSS, 0);
SET @NPC=144260;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+30;
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
(@NPC+30, @BOSS, 0);
SET @NPC=144334;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+13;
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
(@NPC+13, @BOSS, 0);
SET @NPC=144349;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+6;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(@NPC, @BOSS, 0),
(@NPC+1, @BOSS, 0),
(@NPC+2, @BOSS, 0),
(@NPC+3, @BOSS, 0),
(@NPC+4, @BOSS, 0),
(@NPC+5, @BOSS, 0),
(@NPC+6, @BOSS, 0);
SET @NPC=144357;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` BETWEEN @NPC AND @NPC+27;
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
(@NPC+27, @BOSS, 0);
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` IN (144243, 144386);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(144243, @BOSS, 0),
(144386, @BOSS, 0);

-- Trash before C'Thun does not respawn

-- Update respawn timers
UPDATE `creature` SET `spawntimesecs`=7200 WHERE `map`=531 AND `id1` IN (15264, 15262, 15233, 15247, 15230, 15240, 15235, 15236, 15249, 15277);

-- Update Critter respawn timer
UPDATE `creature` SET `spawntimesecs`=1740 WHERE `map`=531 AND `id1` IN (15316, 15317);
