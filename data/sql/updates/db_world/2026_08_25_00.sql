-- DB update 2026_08_22_03 -> 2026_08_25_00
--
-- Add 4 NO_PARRY - creature can't parry
-- 10m
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 4 WHERE (`entry` = 32930);
-- 25m
-- also add 2147483648 HARD_RESET to sync with 10m
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 2147483648 | 4 WHERE (`entry` = 33909);
