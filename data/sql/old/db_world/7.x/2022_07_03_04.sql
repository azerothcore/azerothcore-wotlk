-- DB update 2022_07_03_03 -> 2022_07_03_04
-- delete wrong game_graveyard link to graveyard_zone
DELETE FROM `graveyard_zone` WHERE `ID`=469 AND `GhostZone`=141;
DELETE FROM `graveyard_zone` WHERE `ID`=469 AND `GhostZone`=1657;

-- originally was faction 469 alliance and should be 0 ID originally 469
DELETE FROM `graveyard_zone` WHERE `ID`=91 AND `GhostZone`=141;
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES 
(91, 141, 0, 'Teldrassil, Dolanaar GY');

-- id originally 469
DELETE FROM `graveyard_zone` WHERE `ID`=91 AND `GhostZone`=1657;
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES 
(91, 1657, 67, 'Teldrassil, Dolanaar GY');
