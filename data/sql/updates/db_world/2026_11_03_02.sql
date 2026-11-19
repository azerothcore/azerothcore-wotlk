-- DB update 2026_11_03_01 -> 2026_11_03_02
-- remove Normal Trial of the Crusader achievement gate for Trial of the Grand Crusader (heroic) 10/25 instance access
DELETE FROM `dungeon_access_requirements` WHERE `dungeon_access_id` IN (110,111) AND `requirement_id` IN (3917,3916);
