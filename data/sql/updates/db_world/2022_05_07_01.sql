-- DB update 2022_05_07_00 -> 2022_05_07_01
-- Remove Orphan Matron Aria duplicate
DELETE FROM `creature` WHERE `id1` = 34365 AND `guid` = 245000;
DELETE FROM `game_event_creature` WHERE `guid` = 245000 AND `eventEntry` = 10;
