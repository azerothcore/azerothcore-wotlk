-- DB update 2026_03_26_00 -> 2026_03_26_01

-- Set Extra Flag Ignore Pathfinding
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |536871042 WHERE (`entry` = 30616);
