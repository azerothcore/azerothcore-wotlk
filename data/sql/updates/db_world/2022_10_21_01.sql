-- DB update 2022_10_21_00 -> 2022_10_21_01
-- https://github.com/azerothcore/azerothcore-wotlk/issues/13391
-- corrects alliance respawn in wrong zone
UPDATE `graveyard_zone` SET `ID`='1471' WHERE  `ID`=101 AND `GhostZone`=135;

-- we add a new ghost zone due to the second you revive in Iceflow Lake you go to another grave yard on resurrection
DELETE FROM `graveyard_zone` WHERE `ID`=1471 AND `GhostZone`=211;
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES (1471, 211, 469, 'Dun Morogh, Iceflow Lake - Dun Morogh');
