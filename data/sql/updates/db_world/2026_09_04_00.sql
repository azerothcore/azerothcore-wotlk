-- DB update 2026_09_03_07 -> 2026_09_04_00
--
-- P3Wx2 Laser Barrage (63293): drop SPELL_ATTR0_CU_CONE_LINE so the 10 degree spell_cone row applies.
-- The line check used VX-001's 8 yd combat reach as half-width, a 19 yd strip across the whole front half-plane.
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 63293;
