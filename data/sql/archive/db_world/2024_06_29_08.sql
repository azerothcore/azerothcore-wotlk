-- DB update 2024_06_29_07 -> 2024_06_29_08
-- remove duplicate 25962 'Fire Eater' spawns
DELETE FROM `creature` WHERE (`id1` = 25962) AND (`guid` IN (25954, 25957));
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (25954, 25957));
