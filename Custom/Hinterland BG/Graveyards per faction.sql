-- Graveyards require DBC edit, that was also done - included into the REPO

-- INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES (1506, -581.244, -4577.71, 10.2148, 0.5484, 0, 'hinterlandbghorde');
-- INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES (1507, -17.7433, -4635.11, 12.933, 2.42161, 0, 'hinterlandbgalli');


INSERT INTO `game_graveyard` (`ID`, `Map`, `x`, `y`, `z`, `Comment`) VALUES (1724, 0, -581.244, -4577.71, 10.2148, 'HinterlandBG Horde');
INSERT INTO `game_graveyard` (`ID`, `Map`, `x`, `y`, `z`, `Comment`) VALUES (1725, 0, -17.7433, -4635.11, 12.933, 'HinterlandBG Alli');

-- Factions -> Horde 67, Alli 469
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES (1724, 47, 67, 'HinterlandBG Horde');
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES (1725, 47, 469, 'HinterlandBG Alli');