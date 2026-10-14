-- DB update 2026_10_12_07 -> 2026_10_13_00
--
-- Lord Jaraxxus Hittin' Ya and its effect mark the melee target that Jaraxxus's tank-excluded spells skip
DELETE FROM `disables` WHERE (`sourceType` = 0) AND (`entry` IN (66326, 66327));
