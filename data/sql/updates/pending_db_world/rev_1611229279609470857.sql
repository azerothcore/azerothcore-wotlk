INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611229279609470857');

-- Fix issue #4304, a cemetary for Horde in Darkshore
-- The graveyard is shared between Horde and Alliance, so remove the Horde specific one first

DELETE FROM `graveyard_zone` WHERE `ID`=512 AND `GhostZone`=148 AND `Faction`=67;
UPDATE `graveyard_zone` SET `Faction`=0 WHERE `ID`=469 AND `GhostZone`=148;
