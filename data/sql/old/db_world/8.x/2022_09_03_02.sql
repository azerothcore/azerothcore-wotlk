-- DB update 2022_09_03_01 -> 2022_09_03_02
-- General Angerforge
SET @BOSS=45954;
DELETE FROM `linked_respawn` WHERE `linkedGuid`=@BOSS AND `guid` IN (45955,45956,45958,45959);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(45955, @BOSS, 0),
(45956, @BOSS, 0),
(45958, @BOSS, 0),
(45959, @BOSS, 0);
