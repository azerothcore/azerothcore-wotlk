-- DB update 2026_09_26_00 -> 2026_09_26_01
-- Iron Roots / Strengthened Iron Roots (10 and 25 man): immune to knockback
UPDATE `creature_template` SET `CreatureImmunitiesId` = -3 WHERE `entry` IN (33088, 33168, 33396, 33397);
