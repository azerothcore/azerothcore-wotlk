-- DB update 2026_09_10_03 -> 2026_09_10_04
-- Mimiron DB Target anchors VX-001's P3Wx2 Laser Barrage. Without CREATURE_FLAG_EXTRA_TRIGGER and
-- CREATURE_FLAG_EXTRA_CANNOT_ENTER_COMBAT it is dragged into combat refs nothing releases, since
-- NullCreatureAI never evades.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 8320 WHERE `entry` = 33576;
