-- DB update 2026_06_10_00 -> 2026_06_10_01
-- Earthgrab is a hostile root and should reveal stealthed targets.
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 64695;
