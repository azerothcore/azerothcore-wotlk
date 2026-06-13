-- DB update 2026_02_23_00 -> 2026_02_23_01
-- Malygos (10 and 25) - Add despawn on evade (CREATURE_FLAG_EXTRA_HARD_RESET)
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|0x80000000 WHERE `entry` IN (28859, 31734);
