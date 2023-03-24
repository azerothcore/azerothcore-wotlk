-- DB update 2023_03_24_04 -> 2023_03_24_05
-- Remove (71) Darkmoon Faire Building (Mulgore) gameobjects from (24) Brewfest
DELETE FROM `game_event_gameobject` WHERE `eventEntry` = 24 AND `guid` IN (31919,31918,31916,31915,31914,31913,31912,31879,31878,31877,31876,31875,31874,31872);
