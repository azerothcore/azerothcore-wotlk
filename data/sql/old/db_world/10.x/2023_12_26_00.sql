-- DB update 2023_12_25_01 -> 2023_12_26_00
-- Spawn NPC 'Crown Apothecary' for event 'Love is in the Air' only
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 8) AND (`guid` = 146624);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(8, 146624);
