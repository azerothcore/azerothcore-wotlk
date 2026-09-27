-- DB update 2026_09_04_01 -> 2026_09_04_02
-- Thunder Orb never enters combat; its charged zap and player AoE must not leave combat refs behind
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|8192 WHERE `entry` = 33378;
