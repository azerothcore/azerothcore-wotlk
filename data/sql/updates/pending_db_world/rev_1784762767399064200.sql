--
-- The ocean zones around the TBC starting isles live on map 530 (Outland) but have no
-- WorldMapArea entry, so GetVirtualMapForMapAndZone() falls back to map 530 and
-- GetContentLevelsForMapAndZone() classifies them as CONTENT_61_70 (base XP 235 instead
-- of 45). Killing a mob swimming in The Veiled Sea off Azuremyst Isle rewards nearly
-- 4x the XP of the same mob standing on shore.
-- Add server-side WorldMapArea entries mapping these zones to their virtual continents,
-- like the isles themselves (Azuremyst/Bloodmyst -> Kalimdor, Eversong/Ghostlands -> EK).
-- Coordinate extents are the bounding box of the surrounded isles (only used by GM
-- commands .gps / .go zonexy).
DELETE FROM `worldmaparea_dbc` WHERE `ID` IN (1000, 1001);
INSERT INTO `worldmaparea_dbc` (`ID`, `MapID`, `AreaID`, `AreaName`, `LocLeft`, `LocRight`, `LocTop`, `LocBottom`, `DisplayMapID`, `DefaultDungeonFloor`, `ParentWorldMapID`) VALUES
(1000, 530, 3479, 'TheVeiledSea', -10075, -14570.833, -758.3333, -5508.333, 1, 0, 0),
(1001, 530, 3455, 'TheNorthSea', -4487.5, -9412.5, 13568.75, 6066.6665, 0, 0, 0);
